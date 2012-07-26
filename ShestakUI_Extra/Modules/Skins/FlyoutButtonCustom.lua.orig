local T, C, L = unpack(ShestakUI)
if C.actionbar.enable ~= true or C.extra_skins.flyout_button ~= true then return end

----------------------------------------------------------------------------------------
--	FlyoutButtonCustom skin
----------------------------------------------------------------------------------------
local FlyoutButtonSkin = CreateFrame("Frame")
FlyoutButtonSkin:RegisterEvent("PLAYER_LOGIN")
FlyoutButtonSkin:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("FlyoutButtonCustom") then return end

	FlyoutButtonCustom_Settings.Highlight = false
	FlyoutButtonCustom_Settings.ShowBorders = false
	FlyoutButtonCustom_Settings.ButtonsScale = 1
	FBC_BUTTON_PLACE_SIZE = T.buttonsize
	FBC_BUTTON_PLACE_OFFSET = T.buttonspacing
	FBC_FRAME_OFFSET = T.buttonspacing - 6

	local function CreateBorder(self)
		local name = self:GetName()
		local button = self
		local icon = _G[btn:GetName().."Icon"]
		local cooldown = _G[btn:GetName().."Cooldown"]
		local border = _G[btn:GetName().."Border"]
		local count = _G[btn:GetName().."Count"]
		local btname = _G[btn:GetName().."Name"]
		local hotkey = _G[btn:GetName().."HotKey"]
		local normal = _G[btn:GetName().."NormalTexture"]

		button:StyleButton(true)
		button:SetNormalTexture("")

		if border then
			border:Hide()
			border = T.dummy
		end

		count:ClearAllPoints()
		count:Point("BOTTOMRIGHT", 0, 2)
		count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
		count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)

		if btname then
			if C.actionbar.macro == true then
				btname:ClearAllPoints()
				btname:Point("BOTTOM", 0, 0)
				btname:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
				btname:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
				--btname:Width(T.buttonsize - 1)
			else
				btname:Kill()
			end
		end

		if C.actionbar.hotkey == true then
			hotkey:ClearAllPoints()
			hotkey:Point("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:Width(T.buttonsize - 1)
			hotkey.ClearAllPoints = T.dummy
			hotkey.SetPoint = T.dummy
		else
			hotkey:Kill()
		end

		if not _G[name.."Panel"] then
			if self:GetHeight() ~= T.buttonsize and not InCombatLockdown() then
				self:Size(T.buttonsize)
			end

			local panel = CreateFrame("Frame", name.."Panel", self)
			panel:CreatePanel("Transparent", button:GetWidth(), button:GetHeight(), "CENTER", self, "CENTER", 0, 0)

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetPoint("TOPLEFT", button, 2, -2)
			icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
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