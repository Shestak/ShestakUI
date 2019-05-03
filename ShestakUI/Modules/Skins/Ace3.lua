local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true or C.skins.ace3 ~= true then return end

----------------------------------------------------------------------------------------
--	Ace3 options skin
----------------------------------------------------------------------------------------
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI then return end

local oldRegisterAsWidget = AceGUI.RegisterAsWidget

AceGUI.RegisterAsWidget = function(self, widget)
	local TYPE = widget.type
	if TYPE == "CheckBox" then
		widget.highlight:Kill()

		if not widget.skinnedCheckBG then
			widget.skinnedCheckBG = CreateFrame("Frame", nil, widget.frame)
			widget.skinnedCheckBG:SetTemplate("Overlay")
			widget.skinnedCheckBG:SetPoint("TOPLEFT", widget.checkbg, "TOPLEFT", 4, -4)
			widget.skinnedCheckBG:SetPoint("BOTTOMRIGHT", widget.checkbg, "BOTTOMRIGHT", -4, 4)
		end

		if widget.skinnedCheckBG.oborder then
			widget.check:SetParent(widget.skinnedCheckBG.oborder)
		else
			widget.check:SetParent(widget.skinnedCheckBG)
		end
	elseif TYPE == "Dropdown" then
		local frame = widget.dropdown
		local button = widget.button
		local text = widget.text
		frame:StripTextures()

		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -20, 0)

		T.SkinNextPrevButton(button)

		if not frame.backdrop then
			frame:CreateBackdrop("Overlay")
			frame.backdrop:SetPoint("TOPLEFT", 20, -2)
			frame.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
		end
		button:SetParent(frame.backdrop)
		text:SetParent(frame.backdrop)
		button:HookScript("OnClick", function(this)
			local self = this.obj
			self.pullout.frame:SetTemplate("Transparent")
		end)
	elseif TYPE == "LSM30_Font" or TYPE == "LSM30_Sound" or TYPE == "LSM30_Border" or TYPE == "LSM30_Background" or TYPE == "LSM30_Statusbar" then
		local frame = widget.frame
		local button = frame.dropButton
		local text = frame.text
		frame:StripTextures()

		T.SkinNextPrevButton(button)
		frame.text:ClearAllPoints()
		frame.text:SetPoint("RIGHT", button, "LEFT", -2, 0)

		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -10, -6)

		if not frame.backdrop then
			frame:CreateBackdrop("Overlay")
			if TYPE == "LSM30_Font" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
			elseif TYPE == "LSM30_Sound" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
				widget.soundbutton:SetParent(frame.backdrop)
				widget.soundbutton:ClearAllPoints()
				widget.soundbutton:SetPoint("LEFT", frame.backdrop, "LEFT", 2, 0)
			elseif TYPE == "LSM30_Statusbar" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
				widget.bar:ClearAllPoints()
				widget.bar:SetPoint("TOPLEFT", frame.backdrop, "TOPLEFT", 2, -2)
				widget.bar:SetPoint("BOTTOMRIGHT", frame.backdrop, "BOTTOMRIGHT", -2, 2)
				widget.bar:SetParent(frame.backdrop)
			elseif TYPE == "LSM30_Border" or TYPE == "LSM30_Background" then
				frame.backdrop:SetPoint("TOPLEFT", 42, -16)
			end

			frame.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
		end
		button:SetParent(frame.backdrop)
		text:SetParent(frame.backdrop)
		button:HookScript("OnClick", function(this)
			local self = this.obj
			if self.dropdown then
				self.dropdown:SetTemplate("Transparent")
			end
		end)
	elseif TYPE == "EditBox" then
		local frame = widget.editbox
		local button = widget.button
		frame.Left:Kill()
		frame.Middle:Kill()
		frame.Right:Kill()
		frame:SetHeight(17)
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", -2, 0)
		frame.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)
		frame.backdrop:SetParent(widget.frame)
		frame:SetParent(frame.backdrop)
		button:SkinButton()
	elseif TYPE == "Button" then
		local frame = widget.frame
		frame:StripTextures(true)
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 2, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -2, 1)
		widget.text:SetParent(frame.backdrop)
		frame:HookScript("OnEnter", function()
			frame.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			if frame.backdrop.overlay then
				frame.backdrop.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
			end
		end)
		frame:HookScript("OnLeave", function()
			frame.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			if frame.backdrop.overlay then
				frame.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end)
	elseif TYPE == "Slider" then
		local frame = widget.slider
		local editbox = widget.editbox
		local lowtext = widget.lowtext
		local hightext = widget.hightext
		local HEIGHT = 12

		frame:StripTextures()
		frame:SetTemplate("Overlay")
		frame:SetHeight(HEIGHT)
		frame:SetThumbTexture(C.media.blank)
		frame:GetThumbTexture():SetVertexColor(unpack(C.media.border_color))
		frame:GetThumbTexture():SetSize(HEIGHT - 2, HEIGHT - 4)

		editbox:SetTemplate("Overlay")
		editbox:SetHeight(15)
		editbox:SetPoint("TOP", frame, "BOTTOM", 0, -1)

		lowtext:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -2)
		hightext:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -2, -2)
	end
	return oldRegisterAsWidget(self, widget)
end

local oldRegisterAsContainer = AceGUI.RegisterAsContainer

AceGUI.RegisterAsContainer = function(self, widget)
	local TYPE = widget.type
	if TYPE == "ScrollFrame" then
		local frame = widget.scrollbar
		T.SkinScrollBar(frame)
	elseif TYPE == "InlineGroup" or TYPE == "TreeGroup" or TYPE == "TabGroup" or TYPE == "DropdownGroup" then
		local frame = widget.content:GetParent()

		frame:SetTemplate("Overlay")

		if widget.treeframe then
			widget.treeframe:SetTemplate("Overlay")
			frame:SetPoint("TOPLEFT", widget.treeframe, "TOPRIGHT", 1, 0)
		end

		if TYPE == "TabGroup" then
			local oldCreateTab = widget.CreateTab
			widget.CreateTab = function(self, id)
				local tab = oldCreateTab(self, id)
				tab:StripTextures()
				return tab
			end
		end
	end

	return oldRegisterAsContainer(self, widget)
end