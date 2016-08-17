local T, C, L, _ = unpack(select(2, ...))
if C.skins.skada ~= true then return end

----------------------------------------------------------------------------------------
--	Skada skin
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("Skada") then return end

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
		options.baroptions.args.reversegrowth = nil
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
	barmod.ApplySettings_ = barmod.ApplySettings
	barmod.ApplySettings = function(self, win)
		barmod.ApplySettings_(self, win)

		local skada = win.bargroup

		local titlefont = CreateFont("TitleFont"..win.db.name)
		titlefont:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		titlefont:SetShadowColor(0, 0, 0, C.font.stylization_font_shadow and 1 or 0)

		if win.db.enabletitle then
			skada.button:SetNormalFontObject(titlefont)
			skada.button:SetBackdrop(nil)
			skada.button:GetFontString():SetPoint("TOPLEFT", skada.button, "TOPLEFT", 2, -2)
			skada.button:SetHeight(19)

			if not skada.button.backdrop then
				skada.button:CreateBackdrop("Transparent")
				skada.button.backdrop:SetPoint("TOPLEFT", win.bargroup.button, "TOPLEFT", -2, 2)
				skada.button.backdrop:SetPoint("BOTTOMRIGHT", win.bargroup.button, "BOTTOMRIGHT", 2, 5)
			end

			skada.button.bg = skada.button:CreateTexture(nil, "BACKGROUND")
			skada.button.bg:SetTexture(C.media.texture)
			skada.button.bg:SetVertexColor(unpack(C.media.border_color))
			skada.button.bg:SetPoint("TOPLEFT", win.bargroup.button, "TOPLEFT", 0, 0)
			skada.button.bg:SetPoint("BOTTOMRIGHT", win.bargroup.button, "BOTTOMRIGHT", 0, 7)
		end

		skada:SetTexture(C.media.texture)
		skada:SetSpacing(7)
		skada:SetBackdrop(nil)
		skada.borderFrame:SetBackdrop(nil)
	end

	hooksecurefunc(Skada, "UpdateDisplay", function(self)
		for _, win in ipairs(self:GetWindows()) do
			for i, v in pairs(win.bargroup:GetBars()) do
				if not v.BarStyled then
					if not v.backdrop then
						v:CreateBackdrop("Transparent")
					end

					v:SetHeight(12)

					v.label:ClearAllPoints()
					v.label.ClearAllPoints = T.dummy
					v.label:SetPoint("LEFT", v, "LEFT", 2, 0)
					v.label.SetPoint = T.dummy

					v.label:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
					v.label.SetFont = T.dummy
					v.label:SetShadowOffset(0, 0)
					v.label.SetShadowOffset = T.dummy

					v.timerLabel:ClearAllPoints()
					v.timerLabel.ClearAllPoints = T.dummy
					v.timerLabel:SetPoint("RIGHT", v, "RIGHT", 0, 0)
					v.timerLabel.SetPoint = T.dummy

					v.timerLabel:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
					v.timerLabel.SetFont = T.dummy
					v.timerLabel:SetShadowOffset(0, 0)
					v.timerLabel.SetShadowOffset = T.dummy

					v.BarStyled = true
				end
				if v.icon and v.icon:IsShown() then
					v.backdrop:SetPoint("TOPLEFT", -14, 2)
					v.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
				else
					v.backdrop:SetPoint("TOPLEFT", -2, 2)
					v.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end)

	hooksecurefunc(Skada, "OpenReportWindow", function(self)
		if not self.ReportWindow.frame.reskinned then
			self.ReportWindow.frame:StripTextures()
			self.ReportWindow.frame:SetTemplate("Transparent")
			T.SkinCloseButton(self.ReportWindow.frame:GetChildren())
			self.ReportWindow.frame.reskinned = true
		end
	end)

	-- Update pre-existing displays
	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
	end
end)