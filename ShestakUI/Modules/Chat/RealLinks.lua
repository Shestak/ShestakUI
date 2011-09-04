local T, C, L = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Colors links in Battle.net whispers(RealLinks by p3lim)
----------------------------------------------------------------------------------------
local function GetLinkColor(data)
	local type, id, arg1 = string.match(data, "(%w+):(%d+):(%d+)")
	if type == "item" then
		local _, _, quality = GetItemInfo(id)
		if quality then
			local _, _, _, hex = GetItemQualityColor(quality)
			return "|c"..hex
		else
			return "|cffffffff"
		end
	elseif type == "quest" then
		local color = GetQuestDifficultyColor(arg1)
		return format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
	elseif type == "spell" then
		return "|cff71d5ff"
	elseif type == "achievement" then
		return "|cffffff00"
	elseif type == "trade" or type == "enchant" then
		return "|cffffd000"
	elseif type == "instancelock" then
		return "|cffff8000"
	elseif type == "glyph" then
		return "|cff66bbff"
	elseif type == "talent" then
		return "|cff4e96f7"
	elseif type == "levelup" then
		return "|cffFF4E00"
	else
		return "|cffffff00"
	end
end

local function AddLinkColors(self, event, msg, ...)
	local data = string.match(msg, "|H(.-)|h(.-)|h")
	if data then
		return false, msg:gsub("|H(.-)|h(.-)|h", GetLinkColor(data) .. "|H%1|h%2|h|r"), ...
	else
		return false, msg, ...
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", AddLinkColors)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", AddLinkColors)