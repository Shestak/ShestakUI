local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Accept invites from guild members or friend list(by ALZA)
----------------------------------------------------------------------------------------
if C.misc.auto_accept_invite == true then
	local CheckFriend = function(name)
		for i = 1, GetNumFriends() do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		for i = 1, select(2, BNGetNumFriends()) do
			local _, _, _, toonName, _, client = BNGetFriendInfo(i)
			if client == "WoW" and toonName == name then
				return true
			end
		end
		if IsInGuild() then
			for i = 1, GetNumGuildMembers() do
				if GetGuildRosterInfo(i) == name then
					return true
				end
			end
		end
	end

	local ai = CreateFrame("Frame")
	ai:RegisterEvent("PARTY_INVITE_REQUEST")
	ai:SetScript("OnEvent", function(self, event, name)
		if MiniMapLFGFrame:IsShown() or GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0 then return end
		if CheckFriend(name) then
			T.InfoTextShow(L_INFO_INVITE..name)
			print(format("|cffffff00"..L_INFO_INVITE..name.."."))
			AcceptGroup()
			for i = 1, 4 do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				end
			end
		else
			SendWho(name)
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto invite by whisper(by Tukz)
----------------------------------------------------------------------------------------
if not SavedOptionsPerChar then SavedOptionsPerChar = {} end
if SavedOptionsPerChar.AutoInvite == nil then SavedOptionsPerChar.AutoInvite = false end
local ainvkeyword = C.misc.invite_keyword

local autoinvite = CreateFrame("Frame")
autoinvite:RegisterEvent("CHAT_MSG_WHISPER")
autoinvite:SetScript("OnEvent", function(self, event, arg1, arg2)
	if ((not UnitExists("party1") or IsGroupLeader("player") or IsGroupAssistant("player") or IsGroupLeader("player")) and arg1:lower():match(ainvkeyword)) and SavedOptionsPerChar.AutoInvite == true then
		InviteUnit(arg2)
	end
end)

SlashCmdList.AUTOINVITE = function(msg, editbox)
	if msg == "off" then
		SavedOptionsPerChar.AutoInvite = false
		print("|cffffff00"..L_INVITE_DISABLE..".")
	elseif msg == "" then
		SavedOptionsPerChar.AutoInvite = true
		print("|cffffff00"..L_INVITE_ENABLE..ainvkeyword..".")
		ainvkeyword = C.misc.invite_keyword
	else
		SavedOptionsPerChar.AutoInvite = true
		print("|cffffff00"..L_INVITE_ENABLE..msg..".")
		ainvkeyword = msg
	end
end
SLASH_AUTOINVITE1 = "/ainv"
SLASH_AUTOINVITE2 = "/фштм"