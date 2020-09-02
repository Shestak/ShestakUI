local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Alt Click to Invite player
----------------------------------------------------------------------------------------
hooksecurefunc("SetItemRef", function(link) -- Secure hook to avoid taint
	if IsAltKeyDown() then
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		local player = link:match("^player:([^:]+)")
		local bplayer = link:match("^BNplayer:([^:]+)")
		if player then
			C_PartyInfo.InviteUnit(player)
		elseif bplayer then
			local _, value = strmatch(link, "(%a+):(.+)")
			local _, bnID = strmatch(value, "([^:]*):([^:]*):")
			if not bnID then return end
			local accountInfo = C_BattleNet.GetAccountInfoByID(bnID)
			if accountInfo.gameAccountInfo.clientProgram == BNET_CLIENT_WOW and CanCooperateWithGameAccount(accountInfo) then
				BNInviteFriend(accountInfo.gameAccountInfo.gameAccountID)
			end
		end
		ChatEdit_OnEscapePressed(ChatFrameEditBox) -- Secure hook opens whisper, so closing it.
	end
end)
