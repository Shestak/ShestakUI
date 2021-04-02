local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	New Player Experience Guide skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = GuideFrame
	T.SkinCloseButton(frame.CloseButton)

	frame:StripTextures()
	frame:CreateBackdrop("Transparent")

	frame.Title:SetTextColor(1, 1, 1)
	frame.ScrollFrame.Child.Text:SetTextColor(1, 1, 1)

	frame.ScrollFrame.Child.ObjectivesFrame:StripTextures()
	frame.ScrollFrame.Child.ObjectivesFrame:CreateBackdrop("Overlay")

	T.SkinScrollBar(GuideFrame.ScrollFrame.ScrollBar)
	frame.ScrollFrame.ConfirmationButton:SkinButton()
end

T.SkinFuncs["Blizzard_NewPlayerExperienceGuide"] = LoadSkin