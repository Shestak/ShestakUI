local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_friendship_bar ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Friendship(by p3lim)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local friendships = {
	[GetFactionInfoByID(1273)] = 1273,
	[GetFactionInfoByID(1275)] = 1275,
	[GetFactionInfoByID(1276)] = 1276,
	[GetFactionInfoByID(1277)] = 1277,
	[GetFactionInfoByID(1278)] = 1278,
	[GetFactionInfoByID(1279)] = 1279,
	[GetFactionInfoByID(1280)] = 1280,
	[GetFactionInfoByID(1281)] = 1281,
	[GetFactionInfoByID(1282)] = 1282,
	[GetFactionInfoByID(1283)] = 1283,
	[GetFactionInfoByID(1357)] = 1357,
	[GetFactionInfoByID(1358)] = 1358,
}

local function GetFriendshipID()
	if(not UnitExists('target')) then return end
	if(UnitIsPlayer('target')) then return end

	return friendships[UnitName('target')]
end

for tag, func in pairs({
	['curfriendship'] = function()
		local id = GetFriendshipID()
		if(id) then
			local _, cur, _, _, _, _, threshold = GetFriendshipReputationByID(id)
			return cur - threshold
		end
	end,
	['currawfriendship'] = function()
		local id = GetFriendshipID()
		if(id) then
			local _, cur = GetFriendshipReputationByID(id)
			return cur
		end
	end,
	['perfriendship'] = function()
		local id = GetFriendshipID()
		if(id) then
			local _, cur, _, _, _, _, threshold = GetFriendshipReputationByID(id)
			return math.floor((cur - threshold) / 8400 * 100)
		end
	end,
	['perfullfriendship'] = function()
		local id = GetFriendshipID()
		if(id) then
			local _, cur = GetFriendshipReputationByID(id)
			return math.floor(cur / 42999 * 100)
		end
	end,
	['friendshipstanding'] = function()
		local id = GetFriendshipID()
		if(id) then
			local _, _, _, _, _, standing = GetFriendshipReputationByID(id)
			return standing
		end
	end,
}) do
	oUF.Tags[tag] = func
	oUF.TagEvents[tag] = 'PLAYER_TARGET_CHANGED'
end

local function OnEnter(self)
	local _, cur, _, details, _, standing, threshold = GetFriendshipReputationByID(GetFriendshipID())
	GameTooltip:SetOwner(self, 'ANCHOR_TOPRIGHT')
	GameTooltip:SetText(UnitName('target'), 1, 1, 1)
	GameTooltip:AddLine(details, nil, nil, nil, true)
	GameTooltip:AddLine((cur - threshold) .. ' / 8400 (' .. standing .. ')', 1, 1, 1, true)
	GameTooltip:Show()
end

local function Update(self)
	local friendship = self.Friendship

	local id = GetFriendshipID()
	if(id) then
		local _, cur, _, _, _, _, threshold = GetFriendshipReputationByID(id)
		friendship:SetMinMaxValues(0, 8400)
		friendship:SetValue(cur - threshold)
		friendship:Show()
	else
		friendship:Hide()
	end

	if(friendship.PostUpdate) then
		return friendship:PostUpdate(id)
	end
end

local function Path(self, ...)
	return (self.Friendship.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate')
end

local function Enable(self, unit)
	local friendship = self.Friendship
	if(friendship) then
		friendship.__owner = self
		friendship.ForceUpdate = ForceUpdate

		self:RegisterEvent('PLAYER_TARGET_CHANGED', Path)

		if(friendship.Tooltip) then
			friendship:EnableMouse(true)
			friendship:HookScript('OnEnter', OnEnter)
			friendship:HookScript('OnLeave', GameTooltip_Hide)
		end

		if(not friendship:GetStatusBarTexture()) then
			friendship:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
		end

		return true
	end
end

local function Disable(self)
	if(self.Friendship) then
		self:UnregisterEvent('PLAYER_TARGET_CHANGED', Path)
	end
end

oUF:AddElement('Friendship', Path, Enable, Disable)