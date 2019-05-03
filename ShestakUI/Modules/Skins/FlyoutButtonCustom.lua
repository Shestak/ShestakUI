local T, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true or C.skins.flyout_button ~= true then return end

----------------------------------------------------------------------------------------
--	FlyoutButtonCustom skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("FlyoutButtonCustom") then return end

	FlyoutButtonCustom_Settings.Highlight = false
	FlyoutButtonCustom_Settings.ShowBorders = false
	FlyoutButtonCustom_Settings.ButtonsScale = 1
	FBC_BUTTON_PLACE_SIZE = C.actionbar.button_size
	FBC_BUTTON_PLACE_OFFSET = C.actionbar.button_space
	FBC_FRAME_OFFSET = C.actionbar.button_space - 7

	local function CreateBorder(self)
		local button = self
		local icon = _G[btn:GetName().."Icon"]
		local border = _G[btn:GetName().."Border"]
		local count = _G[btn:GetName().."Count"]
		local btname = _G[btn:GetName().."Name"]
		local hotkey = _G[btn:GetName().."HotKey"]
		local normal = _G[btn:GetName().."NormalTexture"]

		button:StyleButton()
		button:SetNormalTexture("")

		if border then
			border:Hide()
			border = T.dummy
		end

		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 0, 2)
		count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		if btname then
			if C.actionbar.macro == true then
				btname:ClearAllPoints()
				btname:SetPoint("BOTTOM", 0, 0)
				btname:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
				btname:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
				--btname:SetWidth(C.actionbar.button_size - 1)
			else
				btname:Kill()
			end
		end

		if C.actionbar.hotkey == true then
			hotkey:ClearAllPoints()
			hotkey:SetPoint("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:SetWidth(C.actionbar.button_size - 1)
			hotkey.ClearAllPoints = T.dummy
			hotkey.SetPoint = T.dummy
		else
			hotkey:Kill()
		end

		if not button.isSkinned then
			if self:GetHeight() ~= C.actionbar.button_size and not InCombatLockdown() then
				self:SetSize(C.actionbar.button_size, C.actionbar.button_size)
			end

			button:CreateBackdrop("Transparent")
			button.backdrop:SetAllPoints()
			if C.actionbar.classcolor_border == true then
				button.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetPoint("TOPLEFT", button, 2, -2)
			icon:SetPoint("BOTTOMRIGHT", button, -2, 2)

			button.isSkinned = true
		end

		if normal then
			normal:ClearAllPoints()
			normal:SetPoint("TOPLEFT")
			normal:SetPoint("BOTTOMRIGHT")
		end
	end

	hooksecurefunc(FlyoutListButton, "UpdateButton", CreateBorder)
	hooksecurefunc(FlyoutListButton, "OnReceiveDrag", CreateBorder)
	hooksecurefunc(FlyoutListButton, "UpdateTexture", CreateBorder)
end)