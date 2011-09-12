local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GlyphUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Glyph Tab
	GlyphFrameSparkleFrame:CreateBackdrop("Default")
	GlyphFrameSparkleFrame.backdrop:Point("TOPLEFT", GlyphFrameSparkleFrame, "TOPLEFT", 3, -3)
	GlyphFrameSparkleFrame.backdrop:Point("BOTTOMRIGHT", GlyphFrameSparkleFrame, "BOTTOMRIGHT", -3, 3)
	T.SkinEditBox(GlyphFrameSearchBox)
	T.SkinDropDownBox(GlyphFrameFilterDropDown, 212)

	GlyphFrameBackground:SetParent(GlyphFrameSparkleFrame)
	GlyphFrameBackground:SetPoint("TOPLEFT", 5, -5)
	GlyphFrameBackground:SetPoint("BOTTOMRIGHT", -5, 5)

	for i = 1, 9 do
		_G["GlyphFrameGlyph"..i]:SetFrameLevel(_G["GlyphFrameGlyph"..i]:GetFrameLevel() + 5)
	end

	for i = 1, 3 do
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

	GlyphFrameClearInfoFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	GlyphFrameClearInfoFrameIcon:ClearAllPoints()
	GlyphFrameClearInfoFrameIcon:Point("TOPLEFT", 2, -2)
	GlyphFrameClearInfoFrameIcon:Point("BOTTOMRIGHT", -2, 2)

	GlyphFrameClearInfoFrame:CreateBackdrop("Default", true)
	GlyphFrameClearInfoFrame.backdrop:SetAllPoints()
	GlyphFrameClearInfoFrame:StyleButton()
	GlyphFrameClearInfoFrame:Size(25)

	GlyphFrame.levelOverlay1:SetParent(GlyphFrameSparkleFrame)
	GlyphFrame.levelOverlayText1:SetParent(GlyphFrameSparkleFrame)
	GlyphFrame.levelOverlay2:SetParent(GlyphFrameSparkleFrame)
	GlyphFrame.levelOverlayText2:SetParent(GlyphFrameSparkleFrame)

	T.SkinScrollBar(GlyphFrameScrollFrameScrollBar)

	local StripAllTextures = {
		"GlyphFrameScrollFrame",
		"GlyphFrameSideInset",
		"GlyphFrameScrollFrameScrollChild",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end
end

T.SkinFuncs["Blizzard_GlyphUI"] = LoadSkin