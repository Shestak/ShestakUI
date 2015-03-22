local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Alt Click to Invite player
----------------------------------------------------------------------------------------
hooksecurefunc("SetItemRef", function(link) --Secure hook to avoid taint
	if IsAltKeyDown() then
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		local player = link:match("^player:([^:]+)")
		InviteToGroup(player)
		ChatEdit_OnEscapePressed(ChatFrameEditBox) -- Secure hook opens whisper, so closing it.
	end
end)
