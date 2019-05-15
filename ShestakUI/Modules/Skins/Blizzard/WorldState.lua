local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldStateScore skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	WorldStateScoreScrollFrame:StripTextures()
	WorldStateScoreFrame:StripTextures()
	WorldStateScoreFrame:SetTemplate("Transparent")

	WorldStateScoreFrame.XPBar:StripTextures()
	WorldStateScoreFrame.XPBar.Bar:CreateBackdrop("Default")

	WorldStateScoreFrame.XPBar.Bar.Spark:SetAlpha(0)

	WorldStateScoreFrame.XPBar.NextAvailable:ClearAllPoints()
	WorldStateScoreFrame.XPBar.NextAvailable:SetPoint("LEFT", WorldStateScoreFrame.XPBar.Bar, "RIGHT", -2, -2)

	WorldStateScoreFrame.XPBar.NextAvailable:StripTextures()
	WorldStateScoreFrame.XPBar.NextAvailable:CreateBackdrop("Default")
	WorldStateScoreFrame.XPBar.NextAvailable.backdrop:SetPoint("TOPLEFT", WorldStateScoreFrame.XPBar.NextAvailable.Icon, -2, 2)
	WorldStateScoreFrame.XPBar.NextAvailable.backdrop:SetPoint("BOTTOMRIGHT", WorldStateScoreFrame.XPBar.NextAvailable.Icon, 2, -2)

	WorldStateScoreFrame.XPBar.NextAvailable.Icon:SetDrawLayer("ARTWORK")
	WorldStateScoreFrame.XPBar.NextAvailable.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	WorldStateScoreFrame.XPBar.NextAvailable.Icon.SetTexCoord = T.dummy
	WorldStateScoreFrame.XPBar.NextAvailable.Icon:SetSize(17, 17)

	T.SkinCloseButton(WorldStateScoreFrameCloseButton)
	WorldStateScoreFrameInset:SetAlpha(0)
	WorldStateScoreFrameLeaveButton:SkinButton()
	WorldStateScoreFrameQueueButton:SkinButton()
	T.SkinScrollBar(WorldStateScoreScrollFrameScrollBar)

	for i = 1, WorldStateScoreScrollFrameScrollChildFrame:GetNumChildren() do
		local b = _G["WorldStateScoreButton"..i]

		b:StripTextures()
		b:StyleButton()
		b:SetTemplate("Default")
	end

	for i = 1, 3 do
		T.SkinTab(_G["WorldStateScoreFrameTab"..i])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)