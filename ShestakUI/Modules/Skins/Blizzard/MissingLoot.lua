local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MissingLoot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	MissingLootFrame:SetTemplate("Transparent")
	MissingLootFrameCorner:Kill()

	T.SkinCloseButton(MissingLootFramePassButton)

	local function SkinButton()
		local number = GetNumMissingLootItems()
		for i = 1, number do
			local slot = _G["MissingLootFrameItem"..i]
			local icon = slot.icon

			if not slot.isSkinned then
				slot:StripTextures()
				slot:SetTemplate("Default")
				slot:StyleButton()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				icon:SetDrawLayer("ARTWORK")

				slot.isSkinned = true
			end

			local quality = select(4, GetMissingLootItemInfo(i))
			local color = (GetItemQualityColor(quality)) or (unpack(C.media.border_color))
			frame:SetBackdropBorderColor(color)
		end
	end
	hooksecurefunc("MissingLootFrame_Show", SkinButton)

	LootHistoryFrame:StripTextures()
	LootHistoryFrame:SetTemplate("Transparent")

	T.SkinCloseButton(LootHistoryFrame.CloseButton)
	T.SkinCloseButton(LootHistoryFrame.ResizeButton, nil, "v v v v")

	LootHistoryFrameScrollFrame:GetRegions():Hide()
	T.SkinScrollBar(LootHistoryFrameScrollFrameScrollBar)

	LootHistoryFrame.ResizeButton:SetTemplate("Default")
	LootHistoryFrame.ResizeButton:Width(LootHistoryFrame:GetWidth())
	LootHistoryFrame.ResizeButton:Height(19)
	LootHistoryFrame.ResizeButton:ClearAllPoints()
	LootHistoryFrame.ResizeButton:Point("TOP", LootHistoryFrame, "BOTTOM", 0, -1)

	local function UpdateLoots(self)
		local numItems = C_LootHistory.GetNumItems()
		for i = 1, numItems do
			local frame = self.itemFrames[i]

			if not frame.isSkinned then
				local Icon = frame.Icon:GetTexture()
				frame:StripTextures()
				frame.Icon:SetTexture(Icon)
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame.Icon, -2, 2)
				frame.backdrop:Point("BOTTOMRIGHT", frame.Icon, 2, -2)
				frame.backdrop:SetBackdropColor(0, 0, 0, 0)

				frame.isSkinned = true
			end
		end
	end
	hooksecurefunc("LootHistoryFrame_FullUpdate", UpdateLoots)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)