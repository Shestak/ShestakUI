local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_reputation_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Reputation(by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF Reputation was unable to locate oUF install')

local function GetReputation()
	local pendingReward
	local name, standingID, min, max, cur, factionID = GetWatchedFactionInfo()

	local friendID, _, _, _, _, _, standingText, _, nextThreshold = GetFriendshipReputation(factionID)
	if(friendID) then
		if(not nextThreshold) then
			min, max, cur = 0, 1, 1 -- force a full bar when maxed out
		end
		standingID = 5 -- force friends' color
	elseif not IsClassicBuild() then
		local value, nextThreshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
		if(value) then
			cur = value % nextThreshold
			min = 0
			max = nextThreshold
			pendingReward = hasRewardPending
			standingID = MAX_REPUTATION_REACTION + 1 -- force paragon's color
			standingText = PARAGON
		end
	end

	max = max - min
	cur = cur - min
	-- cur and max are both 0 for maxed out factions
	if(cur == max) then
		cur, max = 1, 1
	end
	standingText = standingText or GetText('FACTION_STANDING_LABEL' .. standingID, UnitSex('player'))

	return cur, max, name, factionID, standingID, standingText, pendingReward
end

for tag, func in next, {
	['reputation:cur'] = function()
		return (GetReputation())
	end,
	['reputation:max'] = function()
		local _, max = GetReputation()
		return max
	end,
	['reputation:per'] = function()
		local cur, max = GetReputation()
		return math.floor(cur / max * 100 + 1/2)
	end,
	['reputation:standing'] = function()
		local _, _, _, _, _, standingText = GetReputation()
		return standingText
	end,
	['reputation:faction'] = function()
		local _, _, name = GetReputation()
		return name
	end,
} do
	oUF.Tags.Methods[tag] = func
	oUF.Tags.Events[tag] = 'UPDATE_FACTION'
end

oUF.Tags.SharedEvents.UPDATE_FACTION = true
oUF.colors.reaction[MAX_REPUTATION_REACTION + 1] = {0, 0.5, 0.9} -- paragon color

-- Changed tooltip for ShestakUI
local function UpdateTooltip(element)
	local cur, max, name, _, standingID, standingText, pendingReward = GetReputation()
	local rewardAtlas = pendingReward and "|A:ParagonReputation_Bag:0:0:0:0|a" or ""
	local color = element.__owner.colors.reaction[standingID]

	GameTooltip:SetText(format("%s (%s)", name, standingText), color[1], color[2], color[3])
	if(cur ~= max) then
		GameTooltip:AddLine(format("%s / %s (%d%%) %s", BreakUpLargeNumbers(cur), BreakUpLargeNumbers(max), (cur) / (max) * 100, rewardAtlas), 0.75, 0.9, 1)
	end
	GameTooltip:Show()
end

local function OnEnter(element)
	element:SetAlpha(element.inAlpha)
	GameTooltip:SetOwner(element, "ANCHOR_BOTTOM", 0, -5)	-- ShestakUI
	element:UpdateTooltip()
end

local function OnLeave(element)
	GameTooltip:Hide()
	element:SetAlpha(element.outAlpha)
end

local function OnMouseUp(element, btn)
	if btn == "MiddleButton" then
		if element.outAlpha == 0 then
			element.outAlpha = 1
			SavedOptions.Reputation = true
		else
			element.outAlpha = 0
			SavedOptions.Reputation = false
		end
	else
		ToggleCharacter("ReputationFrame")
	end
end

local function CheckAlpha(element)
	if SavedOptions and SavedOptions.Reputation == true then
		element.outAlpha = 1
		element:SetAlpha(element.outAlpha or 1)
	end
end

local function Update(self, event, unit)
	local element = self.Reputation
	if(element.PreUpdate) then element:PreUpdate(unit) end

	local cur, max, name, factionID, standingID, standingText, pendingReward = GetReputation()
	if(name) then
		element:SetMinMaxValues(0, max)
		element:SetValue(cur)

		if(element.colorStanding) then
			local colors = self.colors.reaction[standingID]
			element:SetStatusBarColor(colors[1], colors[2], colors[3])
			element.bg:SetVertexColor(colors[1], colors[2], colors[3], 0.2)	-- ShestakUI
		end

		if(element.Reward) then
			-- no idea what this function actually does, but Blizzard uses it as well
			C_Reputation.RequestFactionParagonPreloadRewardData(factionID)
			element.Reward:SetShown(pendingReward)
		end
	end

	if(element.PostUpdate) then
		return element:PostUpdate(unit, cur, max, name, factionID, standingID, standingText, pendingReward)
	end
end

local function Path(self, ...)
	return (self.Reputation.Override or Update) (self, ...)
end

local function ElementEnable(self)
	local element = self.Reputation
	self:RegisterEvent('UPDATE_FACTION', Path, true)

	element:Show()
	element:SetAlpha(element.outAlpha or 1)

	Path(self, 'ElementEnable', 'player')
end

local function ElementDisable(self)
	self:UnregisterEvent('UPDATE_FACTION', Path)

	self.Reputation:Hide()

	Path(self, 'ElementDisable', 'player')
end

local function Visibility(self, event, unit, selectedFactionIndex)
	local shouldEnable
	if(selectedFactionIndex ~= nil) then
		if(selectedFactionIndex > 0) then
			shouldEnable = true
		end
	elseif(not not (GetWatchedFactionInfo())) then
		shouldEnable = true
	end

	if(shouldEnable) then
		ElementEnable(self)
	else
		ElementDisable(self)
	end
end

local function VisibilityPath(self, ...)
	return (self.Reputation.OverrideVisibility or Visibility)(self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.Reputation
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		hooksecurefunc('SetWatchedFactionIndex', function(selectedFactionIndex)
			if(self:IsElementEnabled('Reputation')) then
				VisibilityPath(self, 'SetWatchedFactionIndex', 'player', selectedFactionIndex or 0)
			end
		end)

		if(not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		if(element.Reward and element.Reward:IsObjectType('Texture') and not element.Reward:GetTexture()) then
			element.Reward:SetAtlas('ParagonReputation_Bag')
		end

		if(element:IsMouseEnabled()) then
			element.UpdateTooltip = element.UpdateTooltip or UpdateTooltip
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
	if(self.Reputation) then
		ElementDisable(self)
	end
end

oUF:AddElement('Reputation', VisibilityPath, Enable, Disable)