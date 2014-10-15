local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GlyphUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Glyph Tab
	GlyphFrame:CreateBackdrop("Default")
	GlyphFrame.backdrop:SetPoint("TOPLEFT", GlyphFrame, "TOPLEFT", 3, 2)
	GlyphFrame.backdrop:SetPoint("BOTTOMRIGHT", GlyphFrame, "BOTTOMRIGHT", -3, 0)
	T.SkinEditBox(GlyphFrameSearchBox)
	T.SkinDropDownBox(GlyphFrameFilterDropDown, 212)

	GlyphFrameBackground:SetDrawLayer("OVERLAY")
	GlyphFrameBackground:SetPoint("TOPLEFT", 5, 0)
	GlyphFrameBackground:SetPoint("BOTTOMRIGHT", -5, 2)

	for i = 1, 6 do
		_G["GlyphFrameGlyph"..i]:SetFrameLevel(_G["GlyphFrameGlyph"..i]:GetFrameLevel() + 5)
	end

	for i = 1, 2 do
		_G["GlyphFrameHeader"..i]:StripTextures()
	end

	local function Glyphs(self, first, i)
		local button = _G["GlyphFrameScrollFrameButton"..i]
		local icon = _G["GlyphFrameScrollFrameButton"..i.."Icon"]

		if first then
			button:StripTextures()
		end

		if icon then
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button:SkinButton()
		end
	end

	for i = 1, 10 do
		Glyphs(nil, true, i)
	end

	GlyphFrameClearInfoFrame:SetTemplate("Default")
	GlyphFrameClearInfoFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	GlyphFrameClearInfoFrameIcon:SetPoint("TOPLEFT", 2, -2)
	GlyphFrameClearInfoFrameIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	GlyphFrameClearInfoFrameCount:SetFont(C.media.normal_font, 11, "OUTLINE")
	GlyphFrameClearInfoFrameCount:SetPoint("BOTTOMRIGHT", 2, 0)

	GlyphFrameLevelOverlay1:SetParent(GlyphFrame.backdrop)
	GlyphFrameLevelOverlayText1:SetParent(GlyphFrame.backdrop)
	GlyphFrameLevelOverlay2:SetParent(GlyphFrame.backdrop)
	GlyphFrameLevelOverlayText2:SetParent(GlyphFrame.backdrop)

	T.SkinScrollBar(GlyphFrameScrollFrameScrollBar)

	local StripAllTextures = {
		"GlyphFrameScrollFrame",
		"GlyphFrameSideInset",
		"GlyphFrameScrollFrameScrollChild"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end
end

T.SkinFuncs["Blizzard_GlyphUI"] = LoadSkin