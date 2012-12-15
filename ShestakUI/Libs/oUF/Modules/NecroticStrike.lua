local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_necro_strike ~= true or T.class ~= "DEATHKNIGHT" then return end

----------------------------------------------------------------------------------------
--	Based on oUF_NecroStrike(by pvtschlag)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local NecroticStrikeTooltip

local function GetNecroticAbsorb(unit)
	local i = 1
	while true do
		local _, _, texture, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, "HARMFUL")
		if not texture then break end
		if spellId == 73975 then
			if not NecroticStrikeTooltip then
				NecroticStrikeTooltip = CreateFrame("GameTooltip", "NecroticStrikeTooltip", nil, "GameTooltipTemplate")
				NecroticStrikeTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
			end
			NecroticStrikeTooltip:ClearLines()
			NecroticStrikeTooltip:SetUnitDebuff(unit, i)
			return tonumber(string.match(_G[NecroticStrikeTooltip:GetName().."TextLeft2"]:GetText(), "%d+"))
		end
		i = i + 1
	end
	return 0
end

local function UpdateOverlay(healthFrame)
	local amount = 0
	if healthFrame.NecroAbsorb then
		amount = healthFrame.NecroAbsorb
	end
	if amount > 0 then
		local currHealth = healthFrame:GetValue()
		local maxHealth = select(2, healthFrame:GetMinMaxValues())
		local lOfs = (healthFrame:GetWidth() * (currHealth / maxHealth)) - (healthFrame:GetWidth() * (amount / maxHealth))
		local rOfs = (healthFrame:GetWidth() * (currHealth / maxHealth)) - healthFrame:GetWidth()
		if lOfs < 0 then lOfs = 0 end
		if rOfs > 0 then rOfs = 0 end
		healthFrame.NecroticOverlay:ClearAllPoints()
		healthFrame.NecroticOverlay:SetPoint("LEFT", lOfs, 0)
		healthFrame.NecroticOverlay:SetPoint("RIGHT", rOfs, 0)
		healthFrame.NecroticOverlay:SetPoint("TOP", 0, 0)
		healthFrame.NecroticOverlay:SetPoint("BOTTOM", 0, 0)
		if healthFrame.colorClass then
			healthFrame.NecroticOverlay:SetVertexColor(0, 0, 0, 0.4)
		else
			local r, g, b = healthFrame:GetStatusBarColor()
			healthFrame.NecroticOverlay:SetVertexColor(1 - r, 1 - g, 1 - b, 0.4)
		end
		healthFrame.NecroticOverlay:Show()
	else
		healthFrame.NecroticOverlay:Hide()
	end
end

local function UpdateHealthValue(self, value)
	self:SetValue__(value)
	UpdateOverlay(self)
end

local function Update(object, event, unit)
	if object.unit ~= unit then return end
	object.Health.NecroAbsorb = GetNecroticAbsorb(unit)
	UpdateOverlay(object.Health)
end

local function Enable(object)
	if not object.Health then return end
	if not object.Health.NecroticOverlay then
		object.Health.NecroticOverlay = object.Health:CreateTexture(nil, "OVERLAY", object.Health)
		object.Health.NecroticOverlay:SetAllPoints(object.Health)
		object.Health.NecroticOverlay:SetTexture(1, 1, 1, 1)
		object.Health.NecroticOverlay:SetBlendMode("BLEND")
		object.Health.NecroticOverlay:SetVertexColor(0, 0, 0, 0.4)
		object.Health.NecroticOverlay:Hide()
	end
	if object.Health.SetValue_ then
		object.Health.SetValue__ = object.Health.SetValue_
		object.Health.SetValue_ = UpdateHealthValue
	else
		object.Health.SetValue__ = object.Health.SetValue
		object.Health.SetValue = UpdateHealthValue
	end
	object:RegisterEvent("UNIT_AURA", Update)
	return true
end

local function Disable(object)
	if not object.Health then return end
	if object.Health.NecroticOverlay then
		object.Health.NecroticOverlay:Hide()
	end
	if object.Health.SetValue__ then
		if object.Health.SetValue_ then
			object.Health.SetValue_ = object.Health.SetValue__
			object.Health.SetValue__ = nil
		else
			object.Health.SetValue = object.Health.SetValue__
			object.Health.SetValue__ = nil
		end
	end
	object:UnregisterEvent("UNIT_AURA", Update)
end

oUF:AddElement("NecroStrike", Update, Enable, Disable)

for i, frame in ipairs(oUF.objects) do Enable(frame) end