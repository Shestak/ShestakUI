local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MacClient panel skin(by Affli)
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsMacClient() then
		-- Skin main frame and reposition the header
		MacOptionsFrame:SetTemplate("Transparent")
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)

		-- Skin internal frames
		MacOptionsFrameMovieRecording:SetTemplate("Overlay")
		MacOptionsITunesRemote:SetTemplate("Overlay")

		-- Skin buttons
		_G["MacOptionsFrameCancel"]:SkinButton()
		_G["MacOptionsFrameOkay"]:SkinButton()
		_G["MacOptionsButtonKeybindings"]:SkinButton()
		_G["MacOptionsFrameDefaults"]:SkinButton()
		_G["MacOptionsButtonCompress"]:SkinButton()

		-- Skin DropDown
		T.SkinDropDownBox(_G["MacOptionsFrameResolutionDropDown"])
		T.SkinDropDownBox(_G["MacOptionsFrameFramerateDropDown"])
		T.SkinDropDownBox(_G["MacOptionsFrameCodecDropDown"])

		-- Skin CheckBox
		for i = 1, 11 do
			T.SkinCheckBox(_G["MacOptionsFrameCheckButton"..i])
		end

		-- Reposition and resize buttons
		local tPoint, tRTo, tRP, tX, tY = _G["MacOptionsButtonCompress"]:GetPoint()
		_G["MacOptionsButtonCompress"]:SetWidth(136)
		_G["MacOptionsButtonCompress"]:ClearAllPoints()
		_G["MacOptionsButtonCompress"]:SetPoint(tPoint, tRTo, tRP, 4, tY)

		_G["MacOptionsFrameCancel"]:SetWidth(96)
		_G["MacOptionsFrameCancel"]:SetHeight(22)
		tPoint, tRTo, tRP, tX, tY = _G["MacOptionsFrameCancel"]:GetPoint()
		_G["MacOptionsFrameCancel"]:ClearAllPoints()
		_G["MacOptionsFrameCancel"]:SetPoint(tPoint, tRTo, tRP, -14, tY)

		_G["MacOptionsFrameOkay"]:ClearAllPoints()
		_G["MacOptionsFrameOkay"]:SetWidth(96)
		_G["MacOptionsFrameOkay"]:SetHeight(22)
		_G["MacOptionsFrameOkay"]:SetPoint("LEFT", _G["MacOptionsFrameCancel"], -99, 0)

		_G["MacOptionsButtonKeybindings"]:ClearAllPoints()
		_G["MacOptionsButtonKeybindings"]:SetWidth(96)
		_G["MacOptionsButtonKeybindings"]:SetHeight(22)
		_G["MacOptionsButtonKeybindings"]:SetPoint("LEFT", _G["MacOptionsFrameOkay"], -99, 0)

		_G["MacOptionsFrameDefaults"]:SetWidth(96)
		_G["MacOptionsFrameDefaults"]:SetHeight(22)

		T.SkinSlider(_G["MacOptionsFrameQualitySlider"])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)