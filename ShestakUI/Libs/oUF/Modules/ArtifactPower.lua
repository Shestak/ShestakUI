local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_artifact_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_ArtifactPower(by Rainrider)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF

local function OnEnter(element)
	element:SetAlpha(element.onAlpha)
	GameTooltip:SetOwner(element, element.tooltipAnchor)
	GameTooltip:SetText(element.name, HIGHLIGHT_FONT_COLOR:GetRGB())
	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_TITLE:format(T.ShortValue(element.totalPower), T.ShortValue(element.power), T.ShortValue(element.powerForNextTrait)), nil, nil, nil, true)
	GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_BODY:format(element.numTraitsLearnable), nil, nil, nil, true)
	GameTooltip:Show()
end

local function OnLeave(element)
	element:SetAlpha(element.offAlpha)
	GameTooltip:Hide()
end

local function OnMouseUp()
	SocketInventoryItem(INVSLOT_MAINHAND)
end

local function UpdateColor(element, isUsable)
	local color = isUsable and element.color or element.unusableColor
	element:SetStatusBarColor(unpack(color))
end

local function Update(self, event, unit)
	if (unit and unit ~= self.unit) then return end

	local element = self.ArtifactPower
	if (element.PreUpdate) then element:PreUpdate(event) end

	local isUsable = false
	local show = HasArtifactEquipped() and not UnitHasVehicleUI('player')
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

		isUsable = not GetInventoryItemEquippedUnusable('player', INVSLOT_MAINHAND)
		element:UpdateColor(isUsable)

		element:Show()
	else
		element:Hide()
	end

	if (element.PostUpdate) then
		return element:PostUpdate(event, show, isUsable)
	end
end

local function Path(self, ...)
	return (self.ArtifactPower.Override or Update)(self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.ArtifactPower
	if (not element or unit ~= 'player') then return end

	element.__owner = self
	element.ForceUpdate = ForceUpdate

	if (element:IsObjectType('StatusBar')) then
		if (not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end
	end

	element.color = element.color or {.901, .8, .601}
	element.unusableColor = element.unusableColor or {1, 0, 0}
	element.UpdateColor = element.UpdateColor or UpdateColor

	if (element:IsMouseEnabled()) then
		element.tooltipAnchor = element.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'
		element.onAlpha = element.onAlpha or 1
		element.offAlpha = element.offAlpha or 1
		element:SetAlpha(element.offAlpha)
		if (not element:GetScript('OnEnter')) then
			element:SetScript('OnEnter', element.OnEnter or OnEnter)
		end
		if (not element:GetScript('OnLeave')) then
			element:SetScript('OnLeave', element.OnLeave or OnLeave)
		end
		if (not element:GetScript('OnMouseUp')) then
			element:SetScript('OnMouseUp', element.OnMouseUp or OnMouseUp)
		end
	end

	self:RegisterEvent('ARTIFACT_XP_UPDATE', Path, true)
	self:RegisterEvent('UNIT_INVENTORY_CHANGED', Path)

	return true
end

local function Disable(self)
	local element = self.ArtifactPower
	if (not element) then return end

	self:UnregisterEvent('ARTIFACT_XP_UPDATE', Path)
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', Path)
	element:Hide()
end

oUF:AddElement('ArtifactPower', Path, Enable, Disable)