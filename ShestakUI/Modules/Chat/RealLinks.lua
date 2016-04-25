local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Colors links in Battle.net whispers(RealLinks by p3lim)
----------------------------------------------------------------------------------------
local function GetLinkColor(data)
	local type, arg1, arg2, arg3 = string.match(data, "(%w+):(%d+):(%d+):(%d+)")
	if type == "item" then
		local _, _, quality = GetItemInfo(arg1)
		if quality then
			local _, _, _, hex = GetItemQualityColor(quality)
			return "|c"..hex
		else
			return "|cffffffff"
		end
	elseif type == "battlepet" then
		if arg3 ~= -1 then
			local _, _, _, hex = GetItemQualityColor(arg3)
			return "|c"..hex
		else
			return "|cffffd200"
		end
	elseif type == "garrfollower" then
		local _, _, _, color = GetItemQualityColor(arg2)
		return "|c"..color
	elseif type == "quest" then
		local color = GetQuestDifficultyColor(arg2)
		return format("|cff%2x%2x%2x", color.r * 255, color.g * 255, color.b * 255)
	elseif type == "spell" then
		return "|cff71d5ff"
	elseif type == "achievement" or type == "garrmission" then
		return "|cffffff00"
	elseif type == "trade" or type == "enchant" then
		return "|cffffd000"
	elseif type == "instancelock" then
		return "|cffff8000"
	elseif type == "glyph" or type == "journal" then
		return "|cff66bbff"
	elseif type == "talent" or type == "battlePetAbil" or type == "garrfollowerability" then
		return "|cff4e96f7"
	elseif type == "levelup" then
		return "|cffff4e00"
	else
		return "|cffffff00"
	end
end

local function AddLinkColors(self, event, msg, ...)
	local data = string.match(msg, "|H(.-)|h(.-)|h")
	if data then
		local newmsg = string.gsub(msg, "|H(.-)|h(.-)|h", GetLinkColor(data).."|H%1|h%2|h|r")
		return false, newmsg, ...
	else
		return false, msg, ...
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", AddLinkColors)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", AddLinkColors)