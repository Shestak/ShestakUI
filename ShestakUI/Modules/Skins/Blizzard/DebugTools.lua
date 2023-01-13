local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DebugTools skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	FrameStackTooltip:HookScript("OnShow", function(self)
		self.NineSlice:SetTemplate("Transparent")
	end)

	local function SkinTableAttributeDisplay(frame)
		if frame.isSkinned then return end
		T.SkinFrame(frame)
		frame.ScrollFrameArt.NineSlice:SetTemplate("Overlay")

		T.SkinNextPrevButton(frame.OpenParentButton, nil, "Up")
		T.SkinNextPrevButton(frame.NavigateBackwardButton, true, "Any")
		T.SkinNextPrevButton(frame.NavigateForwardButton, nil, "Any")
		T.SkinNextPrevButton(frame.DuplicateButton, nil, "Down")

		T.SkinCheckBox(frame.VisibilityButton, 26)
		T.SkinCheckBox(frame.HighlightButton, 26)
		T.SkinCheckBox(frame.DynamicUpdateButton, 26)

		frame.OpenParentButton:ClearAllPoints()
		frame.OpenParentButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
		frame.OpenParentButton:SetSize(17, 17)
		frame.NavigateBackwardButton:ClearAllPoints()
		frame.NavigateBackwardButton:SetPoint("LEFT", frame.OpenParentButton, "RIGHT", 3, 0)
		frame.NavigateForwardButton:ClearAllPoints()
		frame.NavigateForwardButton:SetPoint("LEFT", frame.NavigateBackwardButton, "RIGHT", 3, 0)
		frame.DuplicateButton:ClearAllPoints()
		frame.DuplicateButton:SetPoint("LEFT", frame.NavigateForwardButton, "RIGHT", 3, 0)
		frame.DuplicateButton:SetSize(17, 17)

		T.SkinEditBox(frame.FilterBox)
		T.SkinScrollBar(frame.LinesScrollFrame.ScrollBar)

		frame.isSkinned = true
	end

	SkinTableAttributeDisplay(TableAttributeDisplay)
	hooksecurefunc(TableInspectorMixin, "InspectTable", SkinTableAttributeDisplay)
end

T.SkinFuncs["Blizzard_DebugTools"] = LoadSkin

local function LoadSecondarySkin()
	ScriptErrorsFrame:SetParent(UIParent)
	ScriptErrorsFrame:SetSize(400, 280)
	ScriptErrorsFrame:StripTextures()
	ScriptErrorsFrame:SetTemplate("Transparent")
	ScriptErrorsFrame.Reload:SkinButton()
	ScriptErrorsFrame.Close:SkinButton()

	T.SkinNextPrevButton(ScriptErrorsFrame.PreviousError, true)
	T.SkinNextPrevButton(ScriptErrorsFrame.NextError)
	T.SkinScrollBar(ScriptErrorsFrameScrollBar)
	T.SkinCloseButton(ScriptErrorsFrameClose)

	ScriptErrorsFrame.ScrollFrame:CreateBackdrop("Overlay")
	ScriptErrorsFrame.ScrollFrame:SetSize(ScriptErrorsFrame:GetWidth() - 45, ScriptErrorsFrame:GetHeight() - 72)
	ScriptErrorsFrame.ScrollFrame.Text:SetFont(C.media.normal_font, 12, "")
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSecondarySkin)