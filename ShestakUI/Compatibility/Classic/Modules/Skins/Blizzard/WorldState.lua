local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldStateScore skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	WorldStateScoreScrollFrame:StripTextures()
	WorldStateScoreFrame:StripTextures()
	WorldStateScoreFrame:CreateBackdrop("Transparent")
	WorldStateScoreFrame.backdrop:SetAllPoints()
	WorldStateScoreFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	WorldStateScoreFrame.backdrop:SetPoint("BOTTOMRIGHT", -38, 66)

	WorldStateScoreFrameLabel:ClearAllPoints()
	WorldStateScoreFrameLabel:SetPoint("TOP", WorldStateScoreFrame.backdrop, "TOP", 0, -6)

	T.SkinCloseButton(WorldStateScoreFrameCloseButton, WorldStateScoreFrame.backdrop)

	WorldStateScoreFrameLeaveButton:SkinButton()
	-- WorldStateScoreFrameQueueButton:SkinButton()
	T.SkinScrollBar(WorldStateScoreScrollFrameScrollBar)

	for i = 1, WorldStateScoreScrollFrameScrollChildFrame:GetNumChildren() do
		local b = _G["WorldStateScoreButton"..i]

		b:StripTextures()
		b:StyleButton()
		b:SetTemplate("Default")
	end

	WorldStateScoreFrameTab1:ClearAllPoints()
	WorldStateScoreFrameTab1:SetPoint("TOPLEFT", WorldStateScoreFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 3 do
		T.SkinTab(_G["WorldStateScoreFrameTab"..i])
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)