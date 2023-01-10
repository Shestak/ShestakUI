local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Options skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = SettingsPanel
	frame:StripTextures()
	frame:SetTemplate("Transparent")
	frame.Bg:Hide()

	local tabs = {
		frame.GameTab,
		frame.AddOnsTab
	}

	for i = 1, #tabs do
		local tab = tabs[i]
		tab:SkinButton(true)
		tab:SetHeight(25)
	end

	SettingsPanel.GameTab:SetPoint("TOPLEFT", 17, -40)

	T.SkinCloseButton(frame.ClosePanelButton)

	T.SkinEditBox(frame.SearchBox, nil, 20)
	frame.ApplyButton:SkinButton()
	frame.CloseButton:SkinButton()
	frame.Container.SettingsList.Header.DefaultsButton:SkinButton()

	T.SkinScrollBar(SettingsPanel.Container.SettingsList.ScrollBar)
	SettingsPanel.Container.SettingsList.ScrollBar.Back:SetSize(17, 15)
	SettingsPanel.Container.SettingsList.ScrollBar.Track.Thumb:SetWidth(17)
	SettingsPanel.Container.SettingsList.ScrollBar.Forward:SetSize(17, 15)

	SettingsPanel.CategoryList:CreateBackdrop("Overlay")
	SettingsPanel.Container.SettingsList:CreateBackdrop("Overlay")
	SettingsPanel.Container.SettingsList.backdrop:SetPoint("BOTTOMRIGHT", 6, -3)

	hooksecurefunc(SettingsPanel.CategoryList.ScrollBox, "Update", function(frame)
		for _, child in next, {frame.ScrollTarget:GetChildren()} do
			if not child.isSkinned then
				if child.Background then
					child.Background:SetAlpha(0)
				end

				local toggle = child.Toggle
				if toggle then
					toggle:GetPushedTexture():SetAlpha(0)
				end

				child.isSkinned = true
			end
		end
	end)

	local function UpdateKeybindButtons(self)
		if not self.bindingsPool then return end
		for panel in self.bindingsPool:EnumerateActive() do
			if not panel.isSkinned then
				panel.Button1:SkinButton()
				panel.Button2:SkinButton()
				panel.Button2:SetPoint("LEFT", panel.Button1, "RIGHT", 2, 0)
				if panel.CustomButton then
					panel.CustomButton:SkinButton()
				end
				local selected = panel.Button1.SelectedHighlight
				selected:SetPoint("TOPLEFT", 2, -2)
				selected:SetPoint("BOTTOMRIGHT", -2, 2)
				selected:SetColorTexture(1, 0.82, 0, 0.3)

				selected = panel.Button2.SelectedHighlight
				selected:SetPoint("TOPLEFT", 2, -2)
				selected:SetPoint("BOTTOMRIGHT", -2, 2)
				selected:SetColorTexture(1, 0.82, 0, 0.3)
				panel.isSkinned = true
			end
		end
	end

	local function UpdateHeaderExpand(self, expanded)
		self.collapseTex:SetAtlas(expanded and "Soulbinds_Collection_CategoryHeader_Collapse" or "Soulbinds_Collection_CategoryHeader_Expand", true)

		UpdateKeybindButtons(self)
	end

	hooksecurefunc(SettingsPanel.Container.SettingsList.ScrollBox, "Update", function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.isSkinned then
				if child.CheckBox then
					T.SkinCheckBoxAtlas(child.CheckBox)
				end

				if child.Button then
					if child.Button:GetWidth() < 250 then
						child.Button:SkinButton()
					else
						child.Button:StripTextures()
						child.Button.Right:SetAlpha(0)
						child.Button:CreateBackdrop("Overlay")
						child.Button.backdrop:SetPoint("TOPLEFT", 2, -1)
						child.Button.backdrop:SetPoint("BOTTOMRIGHT", -2, 3)
						child.Button.backdrop.overlay:SetVertexColor(0.08, 0.08, 0.08, 1)

						child.Button.hl = child.Button:CreateTexture(nil, "HIGHLIGHT")
						child.Button.hl:SetColorTexture(1, 1, 1, 0.3)
						child.Button.hl:SetInside(child.Button.backdrop)
						child.Button.hl:SetBlendMode("ADD")

						child.collapseTex = child.Button.backdrop:CreateTexture(nil, "OVERLAY")
						child.collapseTex:SetPoint("RIGHT", -10, 0)

						UpdateHeaderExpand(child, false)
						hooksecurefunc(child, "EvaluateVisibility", UpdateHeaderExpand)
					end
				end
				if child.ToggleTest then
					child.ToggleTest:SkinButton()
					child.VUMeter:StripTextures()
					child.VUMeter.NineSlice:Hide()
					child.VUMeter:CreateBackdrop("Overlay")
					child.VUMeter.backdrop:SetInside(4, 4)
					child.VUMeter.Status:SetStatusBarTexture(C.media.texture)
				end
				if child.PushToTalkKeybindButton then
					child.PushToTalkKeybindButton:SkinButton()
				end
				if child.SliderWithSteppers then
					T.SkinSliderStep(child.SliderWithSteppers)
				end
				if child.Button1 and child.Button2 then
					child.Button1:SkinButton()
					child.Button2:SkinButton()
				end

				child.isSkinned = true
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)