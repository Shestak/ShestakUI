local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GMSurveyUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GMSurveyHeader:StripTextures()
	GMSurveyFrame:StripTextures()
	GMSurveyFrame:CreateBackdrop("Transparent")
	GMSurveyFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	GMSurveyFrame.backdrop:SetPoint("BOTTOMRIGHT", -44, 10)

	GMSurveyCommentFrame:StripTextures()
	GMSurveyCommentFrame:SetTemplate("Transparent")

	GMSurveySubmitButton:SkinButton()
	GMSurveyCancelButton:SkinButton()

	T.SkinCloseButton(GMSurveyCloseButton, GMSurveyFrame.backdrop)
	T.SkinScrollBar(GMSurveyScrollFrame)

	for i = 1, 11 do
		_G["GMSurveyQuestion"..i]:StripTextures()
	end
end

T.SkinFuncs["Blizzard_GMSurveyUI"] = LoadSkin