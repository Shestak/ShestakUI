local T, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("yClassColor") then return end

----------------------------------------------------------------------------------------
--	Class color guild/friends/etc list(yClassColor by Yleaf)
----------------------------------------------------------------------------------------
local GUILD_INDEX_MAX = 12
local SMOOTH = {1, 0, 0, 1, 1, 0, 0, 1, 0}
local myName = UnitName("player")
local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	BC[v] = k
end
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	BC[v] = k
end
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local WHITE_HEX = "|cffffffff"

local function Hex(r, g, b)
	if type(r) == "table" then
		if (r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end

	if not r or not g or not b then
		r, g, b = 1, 1, 1
	end

	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select("#", ...) / 3

	local segment, relperc = math.modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)

	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

local guildRankColor = setmetatable({}, {
	__index = function(t, i)
		if i then
			local c = Hex(ColorGradient(i / GUILD_INDEX_MAX, unpack(SMOOTH)))
			if c then
				t[i] = c
				return c
			else
				t[i] = t[0]
			end
		end
	end
})
guildRankColor[0] = WHITE_HEX

local diffColor = setmetatable({}, {
	__index = function(t, i)
		local c = i and GetQuestDifficultyColor(i)
		t[i] = c and Hex(c) or t[0]
		return t[i]
	end
})
diffColor[0] = WHITE_HEX

local classColor = setmetatable({}, {
	__index = function(t, i)
		local c = i and RAID_CLASS_COLORS[BC[i] or i]
		if c then
			t[i] = Hex(c)
			return t[i]
		else
			return WHITE_HEX
		end
	end
})

local WHITE = {1, 1, 1}
local classColorRaw = setmetatable({}, {
	__index = function(t, i)
		local c = i and RAID_CLASS_COLORS[BC[i] or i]
		if not c then return WHITE end
		t[i] = c
		return c
	end
})

if CUSTOM_CLASS_COLORS then
	CUSTOM_CLASS_COLORS:RegisterCallback(function()
		wipe(classColorRaw)
		wipe(classColor)
	end)
end

-- WhoList
hooksecurefunc("WhoList_Update", function()
	local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)

	local playerZone = GetRealZoneText()
	local playerGuild = GetGuildInfo("player")
	local playerRace = UnitRace("player")

	for i = 1, WHOS_TO_DISPLAY, 1 do
		local index = whoOffset + i
		local nameText = _G["WhoFrameButton"..i.."Name"]
		local levelText = _G["WhoFrameButton"..i.."Level"]
		local variableText = _G["WhoFrameButton"..i.."Variable"]

		local info = C_FriendList.GetWhoInfo(index)
		if info then
			local guild = info.fullGuildName
			local level = info.level
			local race = info.raceStr
			local zone = info.area
			local classFileName = info.filename

			if zone == playerZone then
				zone = "|cff00ff00"..zone
			end
			if guild == playerGuild then
				guild = "|cff00ff00"..guild
			end
			if race == playerRace then
				race = "|cff00ff00"..race
			end
			local columnTable = {zone, guild, race}

			local c = classColorRaw[classFileName]
			nameText:SetTextColor(c.r, c.g, c.b)
			levelText:SetText(diffColor[level]..level)
			variableText:SetText(columnTable[UIDropDownMenu_GetSelectedID(WhoFrameDropDown)])
		end
	end
end)

-- LFRBrowseList
if not T.classic then
	hooksecurefunc("LFRBrowseFrameListButton_SetData", function(button, index)
		local name, level, _, className, _, _, _, class = SearchLFGGetResults(index)

		if index and class and name and level then
			button.name:SetText(classColor[class]..name)
			button.class:SetText(classColor[class]..className)
			button.level:SetText(diffColor[level]..level)
			button.level:SetWidth(30)
		end
	end)
end

-- WorldStateScoreList
hooksecurefunc("WorldStateScoreFrame_Update", function()
	local inArena = IsActiveBattlefieldArena()
	local offset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)

	for i = 1, GetNumBattlefieldScores() do
		local index = offset + i
		local name, _, _, _, _, faction, _, _, class = GetBattlefieldScore(index)
		if name then
			local n, r = strsplit("-", name, 2)
			n = classColor[class]..n.."|r"

			if name == myName then
				n = ">>> "..n.." <<<"
			end

			if r then
				local color
				if inArena then
					if faction == 1 then
						color = "|cffffd100"
					else
						color = "|cff19ff19"
					end
				else
					if faction == 1 then
						color = "|cff00adf0"
					else
						color = "|cffff1919"
					end
				end
				r = color..r.."|r"
				n = n.."|cffffffff - |r"..r
			end

			local button = _G["WorldStateScoreButton"..i]
			if button then
				button.name.text:SetText(n)
			end
		end
	end
end)

local _VIEW

local function viewChanged(view)
	_VIEW = view
end

-- GuildList
local function update()
	_VIEW = _VIEW or GetCVar("guildRosterView")
	local playerArea = GetRealZoneText()
	local buttons = GuildRosterContainer.buttons

	for _, button in ipairs(buttons) do
		if button:IsShown() and button.online and button.guildIndex then
			if _VIEW == "tradeskill" then
				local _, _, _, headerName, _, _, _, playerName, _, _, _, zone, _, classFileName, isMobile = GetGuildTradeSkillInfo(button.guildIndex)
				if not headerName and playerName then
					local c = classColorRaw[classFileName]
					button.string1:SetTextColor(c.r, c.g, c.b)
					if not isMobile and zone == playerArea then
						button.string2:SetText("|cff00ff00"..zone)
					elseif isMobile then
						button.string2:SetText("|cffa5a5a5"..REMOTE_CHAT)
					end
				end
			else
				local name, rank, rankIndex, level, _, zone, _, _, _, isAway, classFileName, _, _, isMobile = GetGuildRosterInfo(button.guildIndex)
				name = string.gsub(name, "-.*", "")
				local displayedName = classColor[classFileName]..name
				if isMobile then
					if isAway == 1 then
						displayedName = "|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat-AwayMobile:14:14:0:0:16:16:0:16:0:16|t"..displayedName.." |cffE7E716"..L_CHAT_AFK.."|r"
					elseif isAway == 2 then
						displayedName = "|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat-BusyMobile:14:14:0:0:16:16:0:16:0:16|t"..displayedName.." |cffff0000"..L_CHAT_DND.."|r"
					else
						displayedName = ChatFrame_GetMobileEmbeddedTexture(0.3, 1, 0.3)..displayedName
					end
				else
					if isAway == 1 then
						displayedName = displayedName.." |cffE7E716"..L_CHAT_AFK.."|r"
					elseif isAway == 2 then
						displayedName = displayedName.." |cffff0000"..L_CHAT_DND.."|r"
					else
						displayedName = displayedName
					end
				end
				if _VIEW == "playerStatus" then
					button.string1:SetText(diffColor[level]..level)
					button.string2:SetText(displayedName)
					if not isMobile and zone == playerArea then
						button.string3:SetText("|cff4cff4c"..zone)
					elseif isMobile then
						button.string3:SetText("|cffa5a5a5"..REMOTE_CHAT)
					end
				elseif _VIEW == "guildStatus" then
					button.string1:SetText(displayedName)
					if rankIndex and rank then
						button.string2:SetText(guildRankColor[rankIndex]..rank)
					end
				elseif _VIEW == "achievement" then
					button.string1:SetText(diffColor[level]..level)
					if classFileName and name then
						button.string2:SetText(displayedName)
					end
				elseif _VIEW == "reputation" then
					button.string1:SetText(diffColor[level]..level)
					button.string2:SetText(displayedName)
				end
			end
		end
	end
end

if not T.classic then
	local loaded = false
	hooksecurefunc("GuildFrame_LoadUI", function()
		if loaded then
			return
		else
			loaded = true
			hooksecurefunc("GuildRoster_SetView", viewChanged)
			hooksecurefunc("GuildRoster_Update", update)
			hooksecurefunc(GuildRosterContainer, "update", update)
		end
	end)
end

-- CommunitiesFrame
local function RefreshList(self)
	local playerArea = GetRealZoneText()
	local scrollFrame = self.ListScrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons

	local displayingProfessions

	if not T.classic then
		displayingProfessions = self:IsDisplayingProfessions()
	end

	local memberList = displayingProfessions and (self.sortedProfessionList) or (self.sortedMemberList or {})
	for i = 1, #buttons do
		local displayIndex = i + offset
		local button = buttons[i]
		if displayIndex <= #memberList then
			local memberInfo = memberList[displayIndex]
			if memberInfo.presence == Enum.ClubMemberPresence.Offline then return end

			if memberInfo.zone and memberInfo.zone == playerArea then
				button.Zone:SetText("|cff4cff4c"..memberInfo.zone)
			end

			if memberInfo.level then
				button.Level:SetText(diffColor[memberInfo.level]..memberInfo.level)
			end

			if memberInfo.guildRankOrder and memberInfo.guildRank then
				button.Rank:SetText(guildRankColor[memberInfo.guildRankOrder]..memberInfo.guildRank)
			end
		end
	end
end

local loaded = false
hooksecurefunc("Communities_LoadUI", function()
	if loaded then
		return
	else
		loaded = true
		hooksecurefunc(CommunitiesFrame.MemberList, "RefreshListDisplay", RefreshList)
	end
end)

-- FriendsList
local FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub("%%d", "%%s")
FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub("%$d", "%$s")
local function friendsFrame()
	local scrollFrame = FriendsFrameFriendsScrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons

	local playerArea = GetRealZoneText()

	for i = 1, #buttons do
		local nameText, infoText
		button = buttons[i]
		index = offset + i
		if button:IsShown() then
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local name, level, class, area, connected = GetFriendInfo(button.id)
				if connected then
					nameText = classColor[class]..name.."|r, "..format(FRIENDS_LEVEL_TEMPLATE, diffColor[level]..level.."|r", class)
					if area == playerArea then
						infoText = format("|cff00ff00%s|r", area)
					end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local _, presenceName, _, _, _, toonID, client, isOnline = BNGetFriendInfo(button.id)
				if isOnline and client == BNET_CLIENT_WOW then
					local _, toonName, _, _, _, _, _, class, _, zoneName = BNGetGameAccountInfo(toonID)
					if presenceName and toonName and class then
						nameText = format(BATTLENET_NAME_FORMAT, presenceName, "").." "..FRIENDS_WOW_NAME_COLOR_CODE.."("..classColor[class]..classColor[class]..toonName..FRIENDS_WOW_NAME_COLOR_CODE..")"
						if zoneName == playerArea then
							infoText = format("|cff00ff00%s|r", zoneName)
						end
					end
				end
			end
		end

		if nameText then
			button.name:SetText(nameText)
		end
		if infoText then
			button.info:SetText(infoText)
		end
	end
end
hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", friendsFrame)
hooksecurefunc("FriendsFrame_UpdateFriends", friendsFrame)