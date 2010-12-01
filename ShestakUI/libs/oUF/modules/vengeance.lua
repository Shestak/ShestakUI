--[[
	Project.: oUF_Vengeance
	File....: oUF_Vengeance.lua
	Version.: 40000.1
	Rev Date: 24/11/2010
	Authors.: Shandrela [EU-Baelgun] <Bloodmoon>
]]

--[[
	Elements handled:
	 .Vengeance [frame]
	 .Vengeance.Text [fontstring]
		
	Code Example:
	 .Vengeance = CreateFrame("StatusBar", nil, self)
	 .Vengeance:SetWidth(400)
	 .Vengeance:SetHeight(20)
	 .Vengeance:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 100)
	 .Vengeance:SetStatusBarTexture(normTex)
	 .Vengeance:SetStatusBarColor(1,0,0)
	 
	Functions that can be overridden from within a layout:
	 - :OverrideText(value)
--]]
if SettingsCF.unitframe.plugins_vengeance_bar ~= true then return end

local _, class = UnitClass("player")
local vengeance = GetSpellInfo(93098)

local tooltip = CreateFrame("GameTooltip", "VengeanceTooltip", UIParent, "GameTooltipTemplate")
tooltip:SetOwner(UIParent, "ANCHOR_NONE")				

local function getTooltipText(...)
	local text = ""
	for i=1,select("#",...) do
		local rgn = select(i,...)
		if rgn and rgn:GetObjectType() == "FontString" then
			text = text .. (rgn:GetText() or "")
		end
	end
	return text
end

local function isTank(self, event)
	local masteryIndex = GetPrimaryTalentTree()
	local bar = self.Vengeance
	
	if masteryIndex then
		if class == "DRUID" and masteryIndex == 2 then
			local form = GetShapeshiftFormID()
			if form and form == BEAR_FORM then
				bar.isTank = true
			else
				bar.isTank = false
				bar:Hide()
			end
		elseif class == "DEATHKNIGHT" and masteryIndex == 1 then
			bar.isTank = true
		elseif class == "PALADIN" and masteryIndex == 2 then
			bar.isTank = true
		elseif class == "WARRIOR" and masteryIndex == 3 then
			bar.isTank = true
		else
			bar.isTank = false
			bar:Hide()
		end
	else
		bar.isTank = false
		bar:Hide()
	end
end

local function maxChanged(self, event, unit)
	if not unit == "player" then return end
	local bar = self.Vengeance
	
	bar:SetMinMaxValues(0, floor(UnitHealthMax("player") / 10))
end

local function valueChanged(self)
	local bar = self.Vengeance
	
	if not bar.isTank then
		bar:Hide()
		return
	end
	
	local name = UnitAura("player", vengeance)
	
	if name then
		tooltip:ClearLines()
		tooltip:SetUnitBuff("player", name)
		local text = getTooltipText(tooltip:GetRegions())
		local value = tonumber(string.match(text,"%d+"))
		
		bar:SetValue(value)
		bar:Show()
		
		if bar.Text then
			if bar.OverrideText then
				bar:OverrideText(value)
			else
				bar:SetText(value)
			end
		end
		
		if self.Debuffs then 
			self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(19)) 
		end
	else
		bar:Hide()
		
		if self.Debuffs then 
			self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(5))
		end
	end
end

local function Enable(self, unit)
	local bar = self.Vengeance
	
	if bar and unit == "player" then
		self:RegisterEvent("UNIT_AURA", valueChanged)
		self:RegisterEvent("PLAYER_LOGIN", valueChanged)
		
		self:RegisterEvent("UNIT_MAXHEALTH", maxChanged)
		self:RegisterEvent("PLAYER_LOGIN", maxChanged)
		
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", isTank)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", isTank)
		
		if class == "DRUID" then
			self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", isTank)
		end
		
		return true
	end
end

local function Disable(self)
	local bar = self.Vengeance
	
	if bar then
		self:UnregisterEvent("UNIT_AURA", valueChanged)
		self:UnregisterEvent("PLAYER_LOGIN", valueChanged)
		
		self:UnregisterEvent("UNIT_MAXHEALTH", maxChanged)
		self:UnregisterEvent("PLAYER_LOGIN", maxChanged)
		
		self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED", isTank)
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", isTank)
		
		if class == "DRUID" then
			self:UnregisterEvent("UPDATE_SHAPESHIFT_FORM", isTank)
		end
	end
end

oUF:AddElement("Vengeance", nil, Enable, Disable)