local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TalentFrame:StripTextures()
	TalentFrame:CreateBackdrop("Transparent")
	TalentFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	TalentFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	TalentFramePortrait:Hide()

	T.SkinCloseButton(TalentFrameCloseButton, TalentFrame.backdrop)

	TalentFrameTitleText:ClearAllPoints()
	TalentFrameTitleText:SetPoint("TOP", TalentFrame.backdrop, "TOP", 0, -6)

	TalentFrameSpentPoints:ClearAllPoints()
	TalentFrameSpentPoints:SetPoint("TOP", TalentFrame.backdrop, "TOP", 0, -30)

	TalentFrameCancelButton:Kill()

	TalentFrameTab1:ClearAllPoints()
	TalentFrameTab1:SetPoint("TOPLEFT", TalentFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 5 do
		T.SkinTab(_G["TalentFrameTab"..i])
	end

	TalentFrameScrollFrame:StripTextures()
	TalentFrameScrollFrame:CreateBackdrop("Default")
	TalentFrameScrollFrame.backdrop:SetPoint("TOPLEFT", -1, 1)
	TalentFrameScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 6, -1)

	T.SkinScrollBar(TalentFrameScrollFrameScrollBar)
	TalentFrameScrollFrameScrollBar:SetPoint("TOPLEFT", TalentFrameScrollFrame, "TOPRIGHT", 10, -16)

	-- TalentFrameSpentPoints:SetPoint("TOP", 0, -42)
	TalentFrameTalentPointsText:SetPoint("BOTTOMRIGHT", TalentFrame, "BOTTOMLEFT", 220, 84)

	for i = 1, MAX_NUM_TALENTS do
		local talent = _G["TalentFrameTalent"..i]
		local icon = _G["TalentFrameTalent"..i.."IconTexture"]
		local rank = _G["TalentFrameTalent"..i.."Rank"]

		if talent then
			talent:StripTextures()
			talent:SetTemplate("Default")
			talent:StyleButton()

			icon:SetInside()
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:SetDrawLayer("ARTWORK")

			rank:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		end
	end
end

T.SkinFuncs["Blizzard_TalentUI"] = LoadSkin