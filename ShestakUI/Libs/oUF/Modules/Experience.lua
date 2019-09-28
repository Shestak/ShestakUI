local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_experience_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Experience(by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF Experience was unable to locate oUF install')

local math_floor = math.floor

oUF.colors.experience = {
	{0.58, 0, 0.55}, -- Normal
	{0, 0.39, 0.88}, -- Rested
}

oUF.colors.honor = {
	{1, 0.71, 0}, -- Normal
}

local function IsPlayerMaxLevel()
	local maxLevel = GetRestrictedAccountData()
	if(maxLevel == 0) then
		maxLevel = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]
	end

	return maxLevel == UnitLevel('player')
end

local function IsPlayerMaxHonorLevel()
	return not C_PvP.GetNextHonorLevelForReward(UnitHonorLevel('player'))
end

local function ShouldShowHonor()
	return IsPlayerMaxLevel() and (IsWatchingHonorAsXP() or InActiveBattlefield() or IsInActiveWorldPVP())
end

local function GetValues()
	local isHonor = ShouldShowHonor()
	local cur = (isHonor and UnitHonor or UnitXP)('player')
	local max = (isHonor and UnitHonorMax or UnitXPMax)('player')
	local level = (isHonor and UnitHonorLevel or UnitLevel)('player')
	local rested = not isHonor and (GetXPExhaustion() or 0) or 0

	local perc = math_floor(cur / max * 100 + 0.5)
	local restedPerc = math_floor(rested / max * 100 + 0.5)

	return cur, max, perc, rested, restedPerc, level, isHonor
end

-- Changed tooltip for ShestakUI
local function UpdateTooltip()
	local cur, max, perc, rested, restedPerc, level, isHonor = GetValues()

	GameTooltip:SetText(isHonor and HONOR_LEVEL_LABEL:format(level) or COMBAT_XP_GAIN.." "..format(LEVEL_GAINED, T.level), 0.40, 0.78, 1)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(format(L_STATS_CURRENT_XP..": %s / %s (%d%%)", BreakUpLargeNumbers(cur), BreakUpLargeNumbers(max), perc), 0.75, 0.9, 1)
	GameTooltip:AddLine(format(L_STATS_REMAINING_XP..": %s (%d%%)", BreakUpLargeNumbers(max - cur), (max - cur) / max * 100 + 0.5), 0.75, 0.9, 1)

	if(rested > 0) then
		GameTooltip:AddLine(format('%s: %s (%d%%)', L_STATS_RESTED_XP, BreakUpLargeNumbers(rested), restedPerc), 0.75, 0.9, 1)
	end

	GameTooltip:Show()
end

local function OnEnter(element)
	element:SetAlpha(element.inAlpha)
	GameTooltip:SetOwner(element, "ANCHOR_BOTTOM", 0, -5)	-- ShestakUI
	UpdateTooltip(element)
end

local function OnLeave(element)
	GameTooltip:Hide()
	element:SetAlpha(element.outAlpha)
end

local function OnMouseUp(element, btn)
	if btn == "MiddleButton" then
		if element.outAlpha == 0 then
			element.outAlpha = 1
			SavedOptions.Experience = true
		else
			element.outAlpha = 0
			SavedOptions.Experience = false
		end
	end
end

local function CheckAlpha(element)
	if SavedOptions and SavedOptions.Experience == true then
		element.outAlpha = 1
		element:SetAlpha(element.outAlpha or 1)
	end
end

local function UpdateColor(element, isHonor, isRested)
	local colors = element.__owner.colors
	if(isHonor) then
		colors = colors.honor
	else
		colors = colors.experience
	end

	local r, g, b = unpack(colors[isRested and 2 or 1])
	element:SetStatusBarColor(r, g, b)
	element.bg:SetVertexColor(r, g, b, 0.2) -- ShestakUI
	if(element.SetAnimatedTextureColors) then
		element:SetAnimatedTextureColors(r, g, b)
	end

	if(element.Rested) then
		element.Rested:SetStatusBarColor(r, g, b, element.restedAlpha)
	end
end

local function Update(self, event, unit)
	if(self.unit ~= unit or unit ~= 'player') then return end

	local element = self.Experience
	if(element.PreUpdate) then element:PreUpdate(unit) end

	local cur, max, _, rested, _, level, isHonor = GetValues()
	if(element.SetAnimatedValues) then
		element:SetAnimatedValues(cur, 0, max, level)
	else
		element:SetMinMaxValues(0, max)
		element:SetValue(cur)
	end

	if(element.Rested) then
		element.Rested:SetMinMaxValues(0, max)
		element.Rested:SetValue(math.min(cur + rested, max))
	end

	(element.OverrideUpdateColor or UpdateColor)(element, isHonor, rested > 0)

	if(element.PostUpdate) then
		return element:PostUpdate(unit, cur, max, rested, level, isHonor)
	end
end

local function Path(self, ...)
	return (self.Experience.Override or Update) (self, ...)
end

local function ElementEnable(self)
	local element = self.Experience
	self:RegisterEvent('PLAYER_XP_UPDATE', Path, true)
	self:RegisterEvent('HONOR_XP_UPDATE', Path, true)
	self:RegisterEvent('ZONE_CHANGED', Path, true)
	self:RegisterEvent('ZONE_CHANGED_NEW_AREA', Path, true)

	if(element.Rested) then
		self:RegisterEvent('UPDATE_EXHAUSTION', Path, true)
	end

	element:Show()
	element:SetAlpha(element.outAlpha or 1)

	Path(self, 'ElementEnable', 'player')
end

local function ElementDisable(self)
	self:UnregisterEvent('PLAYER_XP_UPDATE', Path)
	self:UnregisterEvent('HONOR_XP_UPDATE', Path)
	self:UnregisterEvent('ZONE_CHANGED', Path)
	self:UnregisterEvent('ZONE_CHANGED_NEW_AREA', Path)

	if(self.Experience.Rested) then
		self:UnregisterEvent('UPDATE_EXHAUSTION', Path)
	end

	self.Experience:Hide()

	Path(self, 'ElementDisable', 'player')
end

local function Visibility(self, event, unit)
	local shouldEnable

	if(not UnitHasVehicleUI('player')) then
		if(not IsPlayerMaxLevel() and not IsXPUserDisabled()) then
			shouldEnable = true
		elseif(ShouldShowHonor() and not IsPlayerMaxHonorLevel()) then
			shouldEnable = true
		end
	end

	if(shouldEnable) then
		ElementEnable(self)
	else
		ElementDisable(self)
	end
end

local function VisibilityPath(self, ...)
	return (self.Experience.OverrideVisibility or Visibility)(self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.Experience
	if(element and unit == 'player') then
		element.__owner = self

		element.ForceUpdate = ForceUpdate
		element.restedAlpha = element.restedAlpha or 0.15

		self:RegisterEvent('PLAYER_LEVEL_UP', VisibilityPath, true)
		self:RegisterEvent('HONOR_LEVEL_UPDATE', VisibilityPath, true)
		self:RegisterEvent('DISABLE_XP_GAIN', VisibilityPath, true)
		self:RegisterEvent('ENABLE_XP_GAIN', VisibilityPath, true)
		self:RegisterEvent('UPDATE_EXPANSION_LEVEL', VisibilityPath, true)

		hooksecurefunc('SetWatchingHonorAsXP', function()
			if(self:IsElementEnabled('Experience')) then
				VisibilityPath(self, 'SetWatchingHonorAsXP', 'player')
			end
		end)

		local child = element.Rested
		if(child) then
			child:SetFrameLevel(element:GetFrameLevel() - 1)

			if(not child:GetStatusBarTexture()) then
				child:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
			end
		end

		if(not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		if(element:IsMouseEnabled()) then
			element.tooltipAnchor = element.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'
			element.inAlpha = element.inAlpha or 1
			element.outAlpha = element.outAlpha or 1

			if(not element:GetScript('OnEnter')) then
				element:SetScript('OnEnter', OnEnter)
			end

			if(not element:GetScript('OnLeave')) then
				element:SetScript('OnLeave', OnLeave)
			end

			if(not element:GetScript('OnMouseUp')) then
				element:SetScript('OnMouseUp', OnMouseUp)
			end

			element.hadler = CreateFrame("Frame", nil, element)
			element.hadler:RegisterEvent("PLAYER_LOGIN")
			element.hadler:SetScript("OnEvent", function() CheckAlpha(element) end)
		end

		return true
	end
end

local function Disable(self)
	local element = self.Experience
	if(element) then
		self:UnregisterEvent('PLAYER_LEVEL_UP', VisibilityPath)
		self:UnregisterEvent('HONOR_LEVEL_UPDATE', VisibilityPath)
		self:UnregisterEvent('DISABLE_XP_GAIN', VisibilityPath)
		self:UnregisterEvent('ENABLE_XP_GAIN', VisibilityPath)
		self:UnregisterEvent('UPDATE_EXPANSION_LEVEL', VisibilityPath)

		ElementDisable(self)
	end
end

oUF:AddElement('Experience', VisibilityPath, Enable, Disable)