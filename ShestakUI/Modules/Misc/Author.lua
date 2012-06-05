local T, C, L = unpack(select(2, ...))
if T.author ~= true then return end

----------------------------------------------------------------------------------------
--	Force other warning
----------------------------------------------------------------------------------------
local ForceWarning = CreateFrame("Frame")
ForceWarning:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
ForceWarning:RegisterEvent("LFG_PROPOSAL_SHOW")
ForceWarning:RegisterEvent("PARTY_INVITE_REQUEST")
ForceWarning:SetScript("OnEvent", function(self, event)
	if event == "UPDATE_BATTLEFIELD_STATUS" and StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
		PlaySound("ReadyCheck", "Master")
	elseif event == "LFG_PROPOSAL_SHOW" or event == "PARTY_INVITE_REQUEST" then
		PlaySound("ReadyCheck", "Master")
	end
end)

----------------------------------------------------------------------------------------
--	Auto SetFilter for AchievementUI
----------------------------------------------------------------------------------------
local AchFilter = CreateFrame("Frame")
AchFilter:RegisterEvent("ADDON_LOADED")
AchFilter:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		AchievementFrame_SetFilter(3)
	end
end)

----------------------------------------------------------------------------------------
--	Force quit
----------------------------------------------------------------------------------------
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)

----------------------------------------------------------------------------------------
--	Delete Replace Enchant popup
----------------------------------------------------------------------------------------
local EnchantPopup = CreateFrame("Frame")
EnchantPopup:RegisterEvent("REPLACE_ENCHANT")
EnchantPopup:SetScript("OnEvent", function(...)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local popup = _G["StaticPopup"..i]
		if popup.which == "REPLACE_ENCHANT" then
			StaticPopup_OnClick(popup, 1)
		end
	end
end)

----------------------------------------------------------------------------------------
--	Block damage meter spam(Decount by Tekkub)
----------------------------------------------------------------------------------------
local filterstrings = {
	"^Recount - (.*)$",
	"%d+%. %S+%s*%d+ %([%d.]+, [%d.]+%%%)",			-- Recount
	--"^(%d+). (.*)$",								-- Also Recount
	"%d+%. - [%d.]+%%% %S+%s*%d+",					-- 
	"%d+%.%s+[%w%s]+%s+[%d.]+ %([%d.]+%)",			-- 10. Khal 2397.9 (5.8%)
	--"%d+%.%s+%S+%s+<%S+>%s+[%d.]+%s+%([%d.]+%)",	-- 2. Bonehead <Demante> 129.9 (3.9%)
	"%d+%.%s+%S+%s+[%d.]+",							-- 10. Khal 2397.9
}

local function filter(self, event, msg)
	for _, str in pairs(filterstrings) do if msg:match(str) then return true end end
end

for _,event in pairs{"CHAT_MSG_YELL", "CHAT_MSG_SAY", "CHAT_MSG_RAID", "CHAT_MSG_PARTY"} do
	ChatFrame_AddMessageEventFilter(event, filter)
end

----------------------------------------------------------------------------------------
--	Auto select current event boss from LFD tool(by Nathanyel)
----------------------------------------------------------------------------------------
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Check date
----------------------------------------------------------------------------------------
function T.DateCheck(m, d)
	local month = tonumber(date("%m"))
	local day = tonumber(date("%d"))
	if month == m and day == d then
		return true
	else
		return false
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if T.DateCheck(1, 1) == true then
		T.Delay(15, print, "|cffffff00Happy New Year. From Shestak.|r")
		T.Delay(16, T.InfoTextShow, "Happy New Year. From Shestak.")
	--elseif T.DateCheck(1, 8) == true then
	--	T.Delay(15, print, "|cffffff00Blah blah. From Shestak.|r")
	--	T.Delay(16, T.InfoTextShow, "Blah blah. From Shestak.")
	end
	self:UnregisterAllEvents()
end)

----------------------------------------------------------------------------------------
--	Remove realm from cross-realm player names in chat(NoRealm by Semlar)
----------------------------------------------------------------------------------------
local a, g = getmetatable(DEFAULT_CHAT_FRAME).__index.AddMessage, gsub
getmetatable(DEFAULT_CHAT_FRAME).__index.AddMessage = function(s, t, ...)
	if s == ChatFrame2 then return a(s, t, ...) end
	return a(s, g(t, "|Hplayer:(.-)|h(.-)|h", function(a, b)
		return "|Hplayer:"..a.."|h"..g(b, "-([^%]:]+)(.*)","%2|r").."|h"
	end), ...)
end

----------------------------------------------------------------------------------------
--	Enables Launcher to download Mist of Pandaria data files
----------------------------------------------------------------------------------------
if GetCVar("accounttype") ~= "MP" then
	SetCVar("accounttype", "MP")
end