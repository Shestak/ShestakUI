local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Covenant Preview skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frame = CovenantPreviewFrame

	frame.InfoPanel.Name:SetTextColor(1, 1, 1)
	frame.InfoPanel.Location:SetTextColor(1, 1, 1)
	frame.InfoPanel.Description:SetTextColor(1, 1, 1)
	frame.InfoPanel.AbilitiesFrame.AbilitiesLabel:SetTextColor(1, .8, 0)
	frame.InfoPanel.SoulbindsFrame.SoulbindsLabel:SetTextColor(1, .8, 0)
	frame.InfoPanel.CovenantFeatureFrame.Label:SetTextColor(1, .8, 0)

	hooksecurefunc(frame, "TryShow", function(covenantInfo)
		if covenantInfo and not frame.IsSkinned then
			frame:CreateBackdrop("Transparent")

			frame.ModelSceneContainer.ModelSceneBorder:SetAlpha(0)
			frame.InfoPanel:CreateBackdrop("Overlay")
			frame.InfoPanel.backdrop:SetPoint("TOPLEFT", 0, 1)
			frame.InfoPanel.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)

			frame.ModelSceneContainer:CreateBackdrop("Default")

			frame.Title:DisableDrawLayer("BACKGROUND")
			frame.Title.Text:SetTextColor(1, 0.8, 0)
			frame.Background:SetAlpha(0)
			frame.BorderFrame:SetAlpha(0)
			frame.InfoPanel.Parchment:SetAlpha(0)

			frame.CloseButton.Border:Kill()
			T.SkinCloseButton(frame.CloseButton)
			frame.SelectButton:SkinButton()

			frame.IsSkinned = true
		end
		frame.CloseButton:SetPoint("TOPRIGHT", -4, -4)
	end)

	frame.ModelSceneContainer.Background:SetTexCoord(0.00970873786408, 0.97109826589595, 0.0092807424594, 0.97109826589595)

	T.SkinCheckBox(TransmogAndMountDressupFrame.ShowMountCheckButton)
end

T.SkinFuncs["Blizzard_CovenantPreviewUI"] = LoadSkin