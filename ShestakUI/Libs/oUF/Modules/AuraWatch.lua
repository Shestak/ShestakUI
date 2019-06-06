local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.raidframe.plugins_aura_watch ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_AuraWatch(by Astromech)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local GUIDs = {}

local PLAYER_UNITS = {
	player = true,
	vehicle = true,
	pet = true,
}

local setupGUID
do
	local cache = setmetatable({}, {__type = "k"})

	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", function(self, event)
		for k,t in pairs(GUIDs) do
			GUIDs[k] = nil
			for a in pairs(t) do
				t[a] = nil
			end
			cache[t] = true
		end
	end)
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")

	function setupGUID(guid)
		local t = next(cache)
		if t then
			cache[t] = nil
		else
			t = {}
		end
		GUIDs[guid] = t
	end
end

local function resetIcon(icon, count, duration, remaining)
	icon:Show()
	if icon.cd then
		if duration and duration > 0 then
			icon.cd:SetCooldown(remaining - duration, duration)
			icon.cd:Show()
		else
			icon.cd:Hide()
		end
	end
	if icon.count then
		icon.count:SetText((count > 1 and count))
	end
	if icon.overlay then
		icon.overlay:Hide()
	end
	icon:SetAlpha(1)
end

local function expireIcon(icon)
	if icon.cd then icon.cd:Hide() end
	if icon.count then icon.count:SetText() end
	icon:SetAlpha(0)
	if icon.overlay then
		icon.overlay:Show()
	end
	icon:Show()
end

local found = {}
local function Update(frame, event, unit)
	if frame.unit ~= unit then return end
	local watch = frame.AuraWatch
	local index, icons = 1, watch.watched
	local _, name, count, duration, remaining, caster, key, icon, spellID
	local filter = "HELPFUL"
	local guid = UnitGUID(unit)
	if not guid then return end
	if not GUIDs[guid] then setupGUID(guid) end

	for _, icon in pairs(icons) do
		icon:Hide()
	end

	while true do
		name, _, count, _, duration, remaining, caster, _, _, spellID = UnitAura(unit, index, filter)
		if not name then
			if filter == "HELPFUL" then
				filter = "HARMFUL"
				index = 1
			else
				break
			end
		else
			if watch.strictMatching then
				key = spellID
			else
				key = name
			end
			icon = icons[key]
			if icon and not T.RaidBuffsIgnore[spellID] and (icon.anyUnit or (caster and icon.fromUnits and icon.fromUnits[caster])) then
				if IsClassicBuild() and LibClassicDurations then
					local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellID, caster)

					if duration == 0 and durationNew then
						duration = durationNew
						expirationTime = expirationTimeNew
					end
				end
				resetIcon(icon, count, duration, remaining)
				GUIDs[guid][key] = true
				found[key] = true
			end
			index = index + 1
		end
	end

	for key in pairs(GUIDs[guid]) do
		if icons[key] and not found[key] then
			expireIcon(icons[key])
		end
	end

	for k in pairs(found) do
		found[k] = nil
	end
end

local function setupIcons(self)
	local watch = self.AuraWatch
	local icons = watch.icons
	watch.watched = {}

	for _, icon in pairs(icons) do

		local name, _, image = GetSpellInfo(icon.spellID)
		if name then
			icon.name = name

			if not icon.cd and not (watch.hideCooldown or icon.hideCooldown) then
				local cd = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
				cd:SetAllPoints(icon)
				cd:SetDrawEdge(false)
				icon.cd = cd
			end

			if not icon.icon then
				local tex = icon:CreateTexture(nil, "BACKGROUND")
				tex:SetAllPoints(icon)
				tex:SetTexture(image)
				icon.icon = tex
				if not icon.overlay then
					local overlay = icon:CreateTexture(nil, "OVERLAY")
					overlay:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
					overlay:SetAllPoints(icon)
					overlay:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
					overlay:SetVertexColor(1, 0, 0)
					icon.overlay = overlay
				end
			end

			if not icon.count and not (watch.hideCount or icon.hideCount) then
				local count = icon:CreateFontString(nil, "OVERLAY")
				count:SetFontObject(NumberFontNormal)
				count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, 0)
				icon.count = count
			end

			if icon.fromUnits == nil then
				icon.fromUnits = watch.fromUnits or PLAYER_UNITS
			end
			if icon.anyUnit == nil then
				icon.anyUnit = watch.anyUnit
			end

			if watch.strictMatching then
				watch.watched[icon.spellID] = icon
			else
				watch.watched[name] = icon
			end

			if watch.PostCreateIcon then watch:PostCreateIcon(icon, icon.spellID, name, self) end
		else
			if not T.classic then
				print("|cffff0000WARNING: spell ID ["..tostring(icon.spellID).."] no longer exists! Report this to Shestak.|r")
			else
				print("|cffff0000WARNING: spell ID ["..tostring(icon.spellID).."] no longer exists! Report this to EsreverWoW.|r")
			end
		end
	end
end

local function Enable(self)
	if self.AuraWatch then
		self:RegisterEvent("UNIT_AURA", Update)
		setupIcons(self)
		return true
	else
		return false
	end
end

local function Disable(self)
	if self.AuraWatch then
		self:UnregisterEvent("UNIT_AURA", Update)
		for _, icon in pairs(self.AuraWatch.icons) do
			icon:Hide()
		end
	end
end

oUF:AddElement("AuraWatch", Update, Enable, Disable)