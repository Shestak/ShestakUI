local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	WorldStateScore skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	WorldStateScoreScrollFrame:StripTextures()
	WorldStateScoreFrame:StripTextures()
	WorldStateScoreFrame:SetTemplate("Transparent")

	T.SkinCloseButton(WorldStateScoreFrameCloseButton)

	WorldStateScoreFrameLeaveButton:SkinButton()
	-- WorldStateScoreFrameQueueButton:SkinButton()
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