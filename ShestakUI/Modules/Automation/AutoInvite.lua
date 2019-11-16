local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Accept invites from guild members or friend list(by ALZA)
----------------------------------------------------------------------------------------
if C.automation.accept_invite == true then
	local function CheckFriend(inviterGUID)
		if C_BattleNet.GetAccountInfoByGUID(inviterGUID) or C_FriendList.IsFriend(inviterGUID) or IsGuildMember(inviterGUID) then
			return true
		end
	end

	local ai = CreateFrame("Frame")
	ai:RegisterEvent("PARTY_INVITE_REQUEST")
	ai:SetScript("OnEvent", function(_, _, name, _, _, _, _, _, inviterGUID)
		if QueueStatusMinimapButton:IsShown() or GetNumGroupMembers() > 0 then return end
		if CheckFriend(inviterGUID) then
			RaidNotice_AddMessage(RaidWarningFrame, L_INFO_INVITE..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
			print(format("|cffffff00"..L_INFO_INVITE..name..".|r"))
			AcceptGroup()
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				elseif frame:IsVisible() and frame.which == "PARTY_INVITE_XREALM" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE_XREALM")
					return
				end
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto invite by whisper(by Tukz)
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	C.automation.invite_keyword = "инв"
end

local autoinvite = CreateFrame("Frame")
autoinvite:RegisterEvent("CHAT_MSG_WHISPER")
autoinvite:RegisterEvent("CHAT_MSG_BN_WHISPER")
autoinvite:SetScript("OnEvent", function(_, event, arg1, arg2, ...)
	if ((not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and arg1:lower():match(C.automation.invite_keyword)) and SavedOptionsPerChar.AutoInvite == true and not QueueStatusMinimapButton:IsShown() then
		if event == "CHAT_MSG_WHISPER" then
			InviteUnit(arg2)
		elseif event == "CHAT_MSG_BN_WHISPER" then
			local bnetIDAccount = select(11, ...)
			local accountInfo = C_BattleNet.GetAccountInfoByID(bnetIDAccount)
			BNInviteFriend(accountInfo.gameAccountInfo.gameAccountID)
		end
	end
end)

SlashCmdList.AUTOINVITE = function(msg)
	if msg == "" then
		if SavedOptionsPerChar.AutoInvite == true then
			SavedOptionsPerChar.AutoInvite = false
			print("|cffffff00"..L_INVITE_DISABLE..".|r")
		else
			SavedOptionsPerChar.AutoInvite = true
			print("|cffffff00"..L_INVITE_ENABLE..C.automation.invite_keyword..".|r")
			C.automation.invite_keyword = C.automation.invite_keyword
		end
	else
		SavedOptionsPerChar.AutoInvite = true
		print("|cffffff00"..L_INVITE_ENABLE..msg..".|r")
		C.automation.invite_keyword = msg
	end
end
SLASH_AUTOINVITE1 = "/ainv"
SLASH_AUTOINVITE2 = "/фштм"