local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalkingHeadUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:CreateBackdrop("Transparent")
	TalkingHeadFrame.backdrop:SetPoint("TOPLEFT", 13, -13)
	TalkingHeadFrame.backdrop:SetPoint("BOTTOMRIGHT", -35, 11)

	TalkingHeadFrame.BackgroundFrame.TextBackground:SetAtlas(nil)
	TalkingHeadFrame.PortraitFrame.Portrait:SetAtlas(nil)
	TalkingHeadFrame.MainFrame.Model.PortraitBg:SetAtlas(nil)
	TalkingHeadFrame.BackgroundFrame.TextBackground.SetAtlas = T.dummy
	TalkingHeadFrame.PortraitFrame.Portrait.SetAtlas = T.dummy
	TalkingHeadFrame.MainFrame.Model.PortraitBg.SetAtlas = T.dummy

	TalkingHeadFrame.MainFrame.Model:CreateBackdrop("Default")
	TalkingHeadFrame.MainFrame.Model.backdrop:SetPoint("TOPLEFT", -2, 2)
	TalkingHeadFrame.MainFrame.Model.backdrop:SetPoint("BOTTOMRIGHT", 3, -3)

	T.SkinCloseButton(TalkingHeadFrame.MainFrame.CloseButton)
	TalkingHeadFrame.MainFrame.CloseButton:SetPoint("TOPRIGHT", -39, -17)

	hooksecurefunc(TalkingHeadFrame.TextFrame.Text, "SetTextColor", function(self, r)
		if r == 0 then
			self:SetTextColor(1, 1, 1)
		end
	end)
end

T.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin