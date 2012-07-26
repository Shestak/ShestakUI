local T, C, L = unpack(ShestakUI)
if C.nameplate.enable ~= true or C.extra_general.healer_icon ~= true then return end

----------------------------------------------------------------------------------------
--	Show healer icon on all enemy healers nameplate in battlegrounds(KillTheHealer by Kraftman)
----------------------------------------------------------------------------------------
local heallist = {}
local exclass = {}
local testing = false

exclass.WARRIOR = true
exclass.DEATHKNIGHT = true
exclass.MAGE = true
exclass.WARLOCK = true
exclass.ROGUE = true

local function UpdatePlate(self)
	if testing then
		self.HPHeal:Show()
	else
		if heallist[self.HPname:GetText()] then
			if exclass[heallist[self.HPname:GetText()]] then
				self.HPHeal:Hide()
			else
				self.HPHeal:Show()
			end
		else
			self.HPHeal:Hide()
		end
	end
end

local function IsValidFrame(frame)
	if not (frame:GetName() and strsub(frame:GetName(), 1, 9 ) == "NamePlate") then
		return
	end
	--if frame.aloftData then
	--	return true
	--end
	--if frame.done then
	--	return true
	--end
	if frame.HPHeal then
		return true
	end
	local overlayRegion = select(2, frame:GetRegions())
	return overlayRegion and overlayRegion:GetObjectType() == "Texture" --and overlayRegion:GetTexture() == "Interface\\Tooltips\\Nameplate-Border"
end

local function CreatePlate(frame)
	if frame.HPHeal then
		return
	end

	local nameTextRegion = select(4, frame:GetRegions())

	frame.HPname = nameTextRegion

	--[[frame.HPHeal = frame:CreateTexture()
	frame.HPHeal:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-Roles")
	frame.HPHeal:SetTexCoord(0.26171875, 0.5234375, 0, 0.26171875)
	frame.HPHeal:SetHeight(40)
	frame.HPHeal:SetWidth(40)
	if C.nameplate.track_auras == true then
		frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 13)
	else
		frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 0)
	end]]

	frame.HPHeal = frame:CreateFontString(nil, "OVERLAY")
	frame.HPHeal:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
	frame.HPHeal:SetText("|cFFD53333+|r")
	if C.nameplate.track_auras == true then
		frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 13)
	else
		frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 0)
	end

	UpdatePlate(frame)
	frame:HookScript("OnShow", UpdatePlate)
end

local numKids = 0
local lastUpdate = 0

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(self, elapsed)
	lastUpdate = lastUpdate + elapsed

	if lastUpdate > 5 then
		lastUpdate = 0
		local newNumKids = WorldFrame:GetNumChildren()
		if newNumKids ~= numKids then
			for i = numKids + 1, newNumKids do
				local frame = select(i, WorldFrame:GetChildren())
				if IsValidFrame(frame) then
					CreatePlate(frame)
				end
			end
			numKids = newNumKids
		end
	end
end)

local lastcheck = 0
local t = CreateFrame("Frame")
t.factionOpposites = {
	["Horde"] = 1,
	["Alliance"] = 0,
}

local function CheckHealers(self, elapsed)
	lastcheck = lastcheck + elapsed
	if lastcheck > 30 then
		lastcheck = 0
		heallist = {}
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, _, _, classToken, damageDone, healingDone = GetBattlefieldScore(i)
			if (healingDone > damageDone * 1.2) and t.factionOpposites[UnitFactionGroup("player")] == faction then
				name = name:match("(.+)%-.+") or name
				heallist[name] = classToken
			end
		end
	end
end

local function CheckLoc(self, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ENTERING_BATTLEGROUND" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and instanceType == "pvp" then
			t:SetScript("OnUpdate", CheckHealers)
		else
			heallist = {}
			t:SetScript("OnUpdate", nil)
		end
	end
end

t:RegisterEvent("PLAYER_ENTERING_WORLD")
t:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
t:SetScript("OnEvent", CheckLoc)