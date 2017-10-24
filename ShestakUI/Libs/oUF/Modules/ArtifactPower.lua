local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_artifact_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_ArtifactPower(by Rainrider)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF

local function ShowTooltip(element)
	element:SetAlpha(element.onAlpha)
	GameTooltip:SetOwner(element)
	GameTooltip:SetText(element.name, HIGHLIGHT_FONT_COLOR:GetRGB())
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_TITLE:format(element.totalPower, element.power, element.powerForNextTrait), nil, nil, nil, true)
	GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_BODY:format(element.numTraitsLearnable), nil, nil, nil, true)
	GameTooltip:Show()
end

local function HideTooltip(element)
	element:SetAlpha(element.offAlpha)
	GameTooltip_Hide()
end

local function Update(self, event, unit)
	if (unit and unit ~= self.unit) then return end

	local element = self.ArtifactPower
	if (element.PreUpdate) then element:PreUpdate(event) end

	local show = HasArtifactEquipped() and not UnitHasVehicleUI("player")
	if (show) then
		local _, _, name, _, totalPower, traitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
		local numTraitsLearnable, power, powerForNextTrait = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(traitsLearned, totalPower, tier)

		element:SetMinMaxValues(0, powerForNextTrait)
		element:SetValue(power)

		element.name = name
		element.power = power
		element.powerForNextTrait = powerForNextTrait
		element.totalPower = totalPower
		element.numTraitsLearnable = numTraitsLearnable
		element.traitsLearned = traitsLearned
		element.tier = tier

		element:Show()
	else
		element:Hide()
	end

	if (element.PostUpdate) then
		return element:PostUpdate(event, show)
	end
end

local function Path(self, ...)
	return (self.ArtifactPower.Override or Update)(self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.ArtifactPower
	if (not element or unit ~= "player") then return end

	element.__owner = self
	element.ForceUpdate = ForceUpdate

	if (not element:GetStatusBarTexture()) then
		element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		element:SetStatusBarColor(.901, .8, .601)
	end

	if (element:IsMouseEnabled()) then
		element.onAlpha = element.onAlpha or 1
		element.offAlpha = element.offAlpha or 1
		element:SetAlpha(element.offAlpha)
		element:SetScript("OnEnter", element.OnEnter or ShowTooltip)
		element:SetScript("OnLeave", element.OnLeave or HideTooltip)
	end

	self:RegisterEvent("ARTIFACT_XP_UPDATE", Path, true)
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", Path)

	return true
end

local function Disable(self)
	local element = self.ArtifactPower
	if (not element) then return end

	self:UnregisterEvent("ARTIFACT_XP_UPDATE", Path)
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED", Path)
	element:Hide()
end

oUF:AddElement("ArtifactPower", Path, Enable, Disable)