----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[hooksecurefunc("WatchFrame_Update", function()
	local nextline = 1
	WatchFrameTitle:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
	WatchFrameTitle:SetJustifyH("RIGHT")
	WatchFrameTitle:SetShadowColor(0,0,0,0)
	for i = nextline, 50 do
		line = _G["WatchFrameLine"..i]
		if line then
			line.text:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
			line.dash:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
			line.text:SetShadowColor(0,0,0,0)
			line.dash:SetShadowColor(0,0,0,0)
		else
			nextline = ik
			break
		end
	end
end)]]