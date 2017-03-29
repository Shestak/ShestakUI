local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MacClient panel skin(by Affli)
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsMacClient() then
		--BETA Skin buttons
		-- _G["MovieRecordingOptionsButtonCompress"]:SkinButton()

		-- Skin DropDown
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameResolutionDropDown"])
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameFramerateDropDown"])
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameCodecDropDown"])
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameResolutionDropDown"])
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameFramerateDropDown"])
		-- T.SkinDropDownBox(_G["MovieRecordingOptionsFrameCodecDropDown"])

		-- Skin CheckBox
		-- for i = 1, 6 do
			-- T.SkinCheckBox(_G["MovieRecordingOptionsFrameCheckButton"..i])
		-- end
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton9"])
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton10"])
		T.SkinCheckBox(_G["MacKeyboardOptionsFrameCheckButton11"])
		-- T.SkinSlider(_G["MovieRecordingOptionsFrameQualitySlider"])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)