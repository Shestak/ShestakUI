local T, C, L = unpack(select(2, ...))
if C.skins.dominos ~= true then return end

----------------------------------------------------------------------------------------
--	Dominos skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not IsAddOnLoaded("Dominos") then return end

	local function StyleNormalButton(self)
		local name = self:GetName()
		if name:match("ExtraActionButton") then return end
		local button = self
		local icon = _G[name.."Icon"]
		local count = _G[name.."Count"]
		local flash = _G[name.."Flash"]
		local hotkey = _G[name.."HotKey"]
		local border = _G[name.."Border"]
		local btname = _G[name.."Name"]
		local normal = _G[name.."NormalTexture"]

		flash:SetTexture("")
		button:SetNormalTexture("")

		if border then
			border:Hide()
			border = T.dummy
		end

		if count then
			count:ClearAllPoints()
			count:Point("BOTTOMRIGHT", 0, 2)
			count:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			count:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		end

		if btname then
			btname:ClearAllPoints()
			btname:Point("BOTTOM", 0, 0)
			btname:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			btname:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
		end

		if hotkey then
			hotkey:ClearAllPoints()
			hotkey:Point("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:Width(button:GetWidth() - 1)
		end

		if not button.isSkinned then
			button:CreateBackdrop("Transparent")
			button.backdrop:SetAllPoints()

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

	local function StyleSmallButton(button, icon, name, hotkey, pet)
		if not button then return end
		local flash = _G[name.."Flash"]
		button:StyleButton()
		button:SetNormalTexture("")

		if flash then
			flash:SetTexture(0.8, 0.8, 0.8, 0.5)
			flash:Point("TOPLEFT", button, 2, -2)
			flash:Point("BOTTOMRIGHT", button, -2, 2)
		end

		if hotkey then
			hotkey:ClearAllPoints()
			hotkey:Point("TOPRIGHT", 0, 0)
			hotkey:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
			hotkey:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
			hotkey:Width(button:GetWidth() - 1)
		end

		if not button.isSkinned then
			button:CreateBackdrop("Transparent")
			button.backdrop:SetAllPoints()

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", button, 2, -2)
			icon:Point("BOTTOMRIGHT", button, -2, 2)

			if pet then
				local autocast = _G[name.."AutoCastable"]
				autocast:Size((button:GetWidth() * 2) - 10)
				autocast:ClearAllPoints()
				autocast:Point("CENTER", button, 0, 0)

				local shine = _G[name.."Shine"]
				shine:Size(button:GetWidth())

				local cooldown = _G[name.."Cooldown"]
				cooldown:Size(button:GetWidth() - 2)
			end

			button.isSkinned = true
		end
	end

	do
		for i = 1, 60 do
			_G["DominosActionButton"..i]:StyleButton()
		end

		for i = 1, 12 do
			_G["ActionButton"..i]:StyleButton()
			_G["MultiBarBottomLeftButton"..i]:StyleButton()
			_G["MultiBarBottomRightButton"..i]:StyleButton()
			_G["MultiBarLeftButton"..i]:StyleButton()
			_G["MultiBarRightButton"..i]:StyleButton()
		end

		for i = 1, NUM_STANCE_SLOTS do
			local name = "DominosClassButton"..i
			local button = _G[name]
			local icon = _G[name.."Icon"]
			local hotkey = _G[name.."HotKey"]
			StyleSmallButton(button, icon, name, hotkey)
		end

		for i = 1, NUM_PET_ACTION_SLOTS do
			local name = "PetActionButton"..i
			local button = _G[name]
			local icon = _G[name.."Icon"]
			local hotkey = _G[name.."HotKey"]
			StyleSmallButton(button, icon, name, hotkey, true)
		end
	end

	hooksecurefunc("ActionButton_Update", StyleNormalButton)
end)