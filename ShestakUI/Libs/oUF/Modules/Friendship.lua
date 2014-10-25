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
	[GetFactionInfoByID(1358)] = 1358,
}

local function GetFriendshipID()
	if not UnitExists("target") then return end
	if UnitIsPlayer("target") then return end

	return friendships[UnitName("target")]
end

for tag, func in pairs({
	["maxfriendship"] = function()
		local id = GetFriendshipID()
		if id then
			local _, rep, _, _, _, _, _, threshold, nextThreshold = GetFriendshipReputation(id)
			if nextThreshold then
				return nextThreshold - threshold
			else
				return rep - threshold
			end
		end
	end,
	["curfriendship"] = function()
		local id = GetFriendshipID()
		if id then
			local _, rep, _, _, _, _, _, threshold = GetFriendshipReputation(id)
			return rep - threshold
		end
	end,
	["friendshipstanding"] = function()
		local id = GetFriendshipID()
		if id then
			local _, _, _, _, _, _, reaction = GetFriendshipReputation(id)
			return reaction
		end
	end,
}) do
	oUF.Tags[tag] = func
	oUF.TagEvents[tag] = "PLAYER_TARGET_CHANGED"
end

local function OnEnter(self)
	local id, rep, _, name, text, _, reaction, threshold, nextThreshold = GetFriendshipReputation(GetFriendshipID())
	local currentRank, maxRank = GetFriendshipReputationRanks(id)
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	if maxRank > 0 then
		GameTooltip:SetText(name.." ("..currentRank.." / "..maxRank..")", 1, 1, 1, true)
	else
		GameTooltip:SetText(name, 1, 1, 1, true)
	end
	GameTooltip:AddLine(text, nil, nil, nil, true)
	if nextThreshold then
		local current = rep - threshold
		local max = nextThreshold - threshold
		GameTooltip:AddLine(reaction.." ("..current.." / "..max..")", 1, 1, 1, true)
	else
		GameTooltip:AddLine(reaction)
	end
	GameTooltip:Show()
end

local function Update(self)
	local friendship = self.Friendship

	local id = GetFriendshipID()
	if id then
		local _, cur, max = GetFriendshipReputation(id)
		friendship:SetMinMaxValues(0, max)
		friendship:SetValue(cur)
		friendship:Show()
		if self.Auras then
			self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 19)
		end
	else
		friendship:Hide()
		if self.Auras then
			self.Auras:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -2, 5)
		end
	end

	if friendship.PostUpdate then
		return friendship:PostUpdate(id)
	end
end

local function Path(self, ...)
	return (self.Friendship.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate")
end

local function Enable(self, unit)
	local friendship = self.Friendship
	if friendship then
		friendship.__owner = self
		friendship.ForceUpdate = ForceUpdate

		self:RegisterEvent("PLAYER_TARGET_CHANGED", Path)

		if friendship.Tooltip then
			friendship:EnableMouse(true)
			friendship:HookScript("OnEnter", OnEnter)
			friendship:HookScript("OnLeave", GameTooltip_Hide)
		end

		return true
	end
end

local function Disable(self)
	if self.Friendship then
		self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)
	end
end

oUF:AddElement("Friendship", Path, Enable, Disable)