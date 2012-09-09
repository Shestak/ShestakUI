local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.skada ~= true then return end

----------------------------------------------------------------------------------------
--	Skada skin(Not Ready)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("Skada") then return end

	local Skada = Skada
	local barSpacing = T.Scale(1)
	local barmod = Skada.displays["bar"]

	-- Used to strip unecessary options from the in-game config
	local function StripOptions(options)
		options.baroptions.args.barspacing = nil
		options.titleoptions.args.texture = nil
		options.titleoptions.args.bordertexture = nil
		options.titleoptions.args.thickness = nil
		options.titleoptions.args.margin = nil
		options.titleoptions.args.color = nil
		options.windowoptions = nil
		options.baroptions.args.barfont = nil
		options.titleoptions.args.font = nil
	end

	barmod.AddDisplayOptions_ = barmod.AddDisplayOptions
	barmod.AddDisplayOptions = function(self, win, options)
		self:AddDisplayOptions_(win, options)
		StripOptions(options)
	end

	for k, options in pairs(Skada.options.args.windows.args) do
		if options.type == "group" then
			StripOptions(options.args)
		end
	end

	-- Override settings from in-game GUI
	local titleBG = {
		bgFile = C.media.texture,
		tile = false,
		tileSize = 0
	}

	barmod.ApplySettings_ = barmod.ApplySettings
	barmod.ApplySettings = function(self, win)
		barmod.ApplySettings_(self, win)

		local skada = win.bargroup

		local titlefont = CreateFont("TitleFont"..win.db.name)
		titlefont:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		titlefont:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)

		if win.db.enabletitle then
			skada.button:SetNormalFontObject(titlefont)
			skada.button:SetBackdrop(titleBG)
			skada.button:SetBackdropColor(unpack(C.media.border_color))
		end

		skada:SetTexture(C.media.texture)
		skada:SetSpacing(barSpacing)
		skada:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		--skada:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)
		skada:SetFrameLevel(5)

		skada:SetBackdrop(nil)
		if not skada.backdrop then
			skada:CreateBackdrop("Transparent")
		end
		skada.backdrop:ClearAllPoints()
		if win.db.enabletitle then
			skada.backdrop:Point("TOPLEFT", win.bargroup.button, "TOPLEFT", -2, 2)
		else
			skada.backdrop:Point("TOPLEFT", win.bargroup, "TOPLEFT", -2, 2)
		end
		skada.backdrop:Point("BOTTOMRIGHT", win.bargroup, "BOTTOMRIGHT", 2, -2)
	end

	-- Update pre-existing displays
	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
	end
end)