local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_artifact_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_ArtifactPower(by Rainrider)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF

local ARTIFACT_BAR_COLOR = ARTIFACT_BAR_COLOR or CreateColor(0.901, 0.8, 0.601, 1)

local ItemDataLoadedCancelFunc, azeriteItemLocation

local function GetNumTraitsLearnable(numTraitsLearned, power, tier)
	local numPoints = 0;
	local powerForNextTrait = C_ArtifactUI.GetCostForPointAtRank(numTraitsLearned, tier)
	while power >= powerForNextTrait and powerForNextTrait > 0 do
		power = power - powerForNextTrait

		numTraitsLearned = numTraitsLearned + 1
		numPoints = numPoints + 1

		powerForNextTrait = C_ArtifactUI.GetCostForPointAtRank(numTraitsLearned, tier)
	end
	return numPoints, power, powerForNextTrait
end

for tag, func in next, {
	['artifactpower:name'] = function()
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				local link = GetInventoryItemLink('player', azeriteItemLocation.equipmentSlotIndex)
				return link and link:match('%[(.+)%]')
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local _, power = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return power
			end
		end
	end,
	['artifactpower:power'] = function()
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				local power = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
				return power
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local _, power = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return power
			end
		end
	end,
	['artifactpower:until_next'] = function()
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				local power, max = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
				return max - power
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local _, power, powerForNextTrait = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return powerForNextTrait - power
			end
		end
	end,
	['artifactpower:until_next_per'] = function()
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				local power, max = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
				return math.floor(power / max * 100 + 0.5)
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local _, power, powerForNextTrait = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return math.floor(power / powerForNextTrait * 100 + 0.5)
			end
		end
	end,
	['artifactpower:total_until_next'] = function() -- was next_trait_cost
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				local _, max = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
				return max
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local _, _, powerForNextTrait = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return powerForNextTrait
			end
		end
	end,
	['artifactpower:unspent_power'] = function() -- was total
		if (not HasArtifactEquipped() or UnitHasVehicleUI('player') or C_ArtifactUI.IsEquippedArtifactDisabled()) then return end
		local _, _, _, _, unspentPower = C_ArtifactUI.GetEquippedArtifactInfo()
		return unspentPower
	end,
	['artifactpower:traits_learnable'] = function()
		if (not HasArtifactEquipped() or UnitHasVehicleUI('player') or C_ArtifactUI.IsEquippedArtifactDisabled()) then return end
		local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
		local numTraitsLearnable = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
		return numTraitsLearnable
	end,
	['artifactpower:traits_learned'] = function()
		if (not HasArtifactEquipped() or UnitHasVehicleUI('player') or C_ArtifactUI.IsEquippedArtifactDisabled()) then return end
		local _, _, _, _, _, numTraitsLearned = C_ArtifactUI.GetEquippedArtifactInfo()
		return numTraitsLearned
	end,
	['artifactpower:tier'] = function()
		if (not HasArtifactEquipped() or UnitHasVehicleUI('player') or C_ArtifactUI.IsEquippedArtifactDisabled()) then return end
		local _, _, _, _, _, _, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
		return tier
	end,
	['artifactpower:level'] = function()
		if (not UnitHasVehicleUI('player')) then
			local azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
			if (azeriteItemLocation) then
				return C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
			elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
				local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
				local numTraitsLearnable = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
				return numTraitsLearnable + numTraitsLearned
			end
		end
	end,
} do
	oUF.Tags.Methods[tag] = func
	oUF.Tags.Events[tag] = 'AZERITE_ITEM_EXPERIENCE_CHANGED ARTIFACT_XP_UPDATE UNIT_INVENTORY_CHANGED'
end
oUF.Tags.SharedEvents.AZERITE_ITEM_EXPERIENCE_CHANGED = true
oUF.Tags.SharedEvents.ARTIFACT_XP_UPDATE = true

--[[ Override: ArtifactPower:OnEnter()
Called when the mouse cursor enters the widget's interactive area.

* self - the ArtifactPower widget
--]]
local function OnEnter(element)
	element:SetAlpha(element.onAlpha)

	if (azeriteItemLocation) then
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		ItemDataLoadedCancelFunc = azeriteItem:ContinueWithCancelOnItemLoad(function()
			GameTooltip:SetOwner(element, "ANCHOR_BOTTOM", 0, -5)	-- ShestakUI
			GameTooltip:SetText(AZERITE_POWER_TOOLTIP_TITLE:format(element.level, element.max - element.current), HIGHLIGHT_FONT_COLOR:GetRGB())
			GameTooltip:AddLine(AZERITE_POWER_TOOLTIP_BODY:format(azeriteItem:GetItemName()))
			GameTooltip:Show()
		end)
	elseif (HasArtifactEquipped()) then
		local _, _, name = C_ArtifactUI.GetEquippedArtifactInfo()
		GameTooltip:SetOwner(element, "ANCHOR_BOTTOM", 0, -5)	-- ShestakUI
		GameTooltip:SetText(name, HIGHLIGHT_FONT_COLOR:GetRGB())
		GameTooltip:AddLine(
			ARTIFACT_POWER_TOOLTIP_TITLE:format(
				T.ShortValue(element.unspentPower),
				T.ShortValue(element.current),
				T.ShortValue(element.max)
			),
			nil, nil, nil, true
		)
		GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_BODY:format(element.numTraitsLearnable), nil, nil, nil, true)
		GameTooltip:Show()
	end
end

--[[ Override: ArtifactPower:OnLeave()
Called when the mouse cursor leaves the widget's interactive area.

* self - the ArtifactPower widget
--]]
local function OnLeave(element)
	if (ItemDataLoadedCancelFunc) then
		ItemDataLoadedCancelFunc()
		ItemDataLoadedCancelFunc = nil
	end
	GameTooltip:Hide()
	element:SetAlpha(element.offAlpha)
end

--[[ Override: ArtifactPower:OnMouseUp()
Used to show the artifact UI if the widget is mouse-enabled and has been clicked.
Only functions when a Legion artifact is equipped.

* self - the ArtifactPower widget
--]]
local function OnMouseUp(element, btn)
	if btn == "MiddleButton" then
		if element.offAlpha == 0 then
			element.offAlpha = 1
			SavedOptions.ArtifactPower = true
		else
			element.offAlpha = 0
			SavedOptions.ArtifactPower = false
		end
	else
		if (HasArtifactEquipped()) then
			SocketInventoryItem(INVSLOT_MAINHAND)
		end
	end
end

local function CheckAlpha(element)
	if SavedOptions and SavedOptions.ArtifactPower == true then
		element.outAlpha = 1
		element:SetAlpha(element.outAlpha or 1)
	end
end

--[[ Override: ArtifactPower:UpdateColor(isUsable)
Used to update the widget's color based on whether the equipped artifact is usable.

* self     - the ArtifactPower widget
* isUsable - indicates whether the equipped artifact is usable (boolean)
--]]
local function UpdateColor(element, isUsable)
	local color = isUsable and element.color or element.unusableColor
	element:SetStatusBarColor(unpack(color))
end

local function Update(self, event, arg)
	local unit = type(arg) == 'string' and arg
	if (unit and unit ~= self.unit) then return end
	local element = self.ArtifactPower

	--[[ Callback: ArtifactPower:PreUpdate(event)
	Called before the element has been updated.

	* self  - the ArtifactPower widget
	* event - the event that triggered the update (string)
	--]]
	if (element.PreUpdate) then
		element:PreUpdate(event)
	end

	local current, max, level, show
	local isUsable = true
	if (not UnitHasVehicleUI('player')) then
		azeriteItemLocation = C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()
		if (azeriteItemLocation) then
			element.numTraitsLearnable = nil
			element.unspentPower = nil

			current, max = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
			level = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
			show = true
		elseif (HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()) then
			local _, _, _, _, unspentPower, numTraitsLearned, _, _, _, _, _, _, tier = C_ArtifactUI.GetEquippedArtifactInfo()
			local numTraitsLearnable, power, powerForNextTrait = GetNumTraitsLearnable(numTraitsLearned, unspentPower, tier)
			current = power
			max = powerForNextTrait
			level = numTraitsLearnable + numTraitsLearned
			isUsable = not GetInventoryItemEquippedUnusable('player', INVSLOT_MAINHAND)

			element.numTraitsLearnable = numTraitsLearnable
			element.unspentPower = unspentPower
			show = true
		end
	end

	element.current = current
	element.max = max
	element.level = level

	if (show) then
		element:UpdateColor(isUsable)

		if (element.SetAnimatedValues) then
			element:SetAnimatedValues(current, 0, max, level)
		else
			element:SetMinMaxValues(0, max)
			element:SetValue(current)
		end
		element:Show()
	else
		element:Hide()
	end

	--[[ Callback: ArtifactPower:PostUpdate(event, current, max, level, isUsable)
	Called after the element has been updated.

	* self     - the ArtifactPower widget
	* event    - the event that triggered the update (string)
	* current  - the amount of artifact power gained towards the next artifact level/trait (number)
	* max      - the total amount of artifact power needed for the next artifact level/trait (number)
	* level    - the current artifact level or the sum of learned and learnable traits (number)
	* isUsable - indicates whether the equipped artifact is usable (boolean)
	--]]
	if (element.PostUpdate) then
		return element:PostUpdate(event, current, max, level, isUsable)
	end
end

local function Path(self, ...)
	--[[ Override: ArtifactPower.Override(event, ...)
	Used to override the element's update process.

	* self  - the parent of the ArtifactPower widget
	* event - the event that triggered the update (string)
	* ...   - the arguments accompanying the event
	--]]
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

	element.color = element.color or { ARTIFACT_BAR_COLOR:GetRGB() }
	element.unusableColor = element.unusableColor or { 1, 0, 0 }
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

		element.hadler = CreateFrame("Frame", nil, element)
		element.hadler:RegisterEvent("PLAYER_LOGIN")
		element.hadler:SetScript("OnEvent", function() CheckAlpha(element) end)
	end

	self:RegisterEvent('ARTIFACT_XP_UPDATE', Path, true)
	self:RegisterEvent('AZERITE_ITEM_EXPERIENCE_CHANGED', Path, true)
	self:RegisterEvent('UNIT_INVENTORY_CHANGED', Path)

	return true
end

local function Disable(self)
	local element = self.ArtifactPower
	if (not element) then return end

	if (ItemDataLoadedCancelFunc) then
		ItemDataLoadedCancelFunc()
		ItemDataLoadedCancelFunc = nil
	end

	self:UnregisterEvent('ARTIFACT_XP_UPDATE', Path)
	self:UnregisterEvent('AZERITE_ITEM_EXPERIENCE_CHANGED', Path)
	self:UnregisterEvent('UNIT_INVENTORY_CHANGED', Path)
	element:Hide()
end

oUF:AddElement('ArtifactPower', Path, Enable, Disable)
