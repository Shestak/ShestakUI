----------------------------------------------------------------------------------------
--	GM ticket position
----------------------------------------------------------------------------------------
TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint(unpack(SettingsCF.position.ticket))

----------------------------------------------------------------------------------------
--	GM toggle command
----------------------------------------------------------------------------------------
SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end