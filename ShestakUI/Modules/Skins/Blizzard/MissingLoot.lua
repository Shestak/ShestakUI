local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	MissingLoot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	MissingLootFrameCorner:Kill()
	MissingLootFrame:StripTextures()
	MissingLootFrame:CreateBackdrop("Transparent")
	MissingLootFrame.backdrop:SetPoint("TOPLEFT", 2, -8)
	MissingLootFrame.backdrop:SetPoint("BOTTOMRIGHT", -2, 6)

	T.SkinCloseButton(MissingLootFramePassButton, MissingLootFrame.backdrop)

	local function SkinButton()
		for i = 1, GetNumMissingLootItems() do
			local slot = _G["MissingLootFrameItem"..i]
			local icon = slot.icon

			if not slot.isSkinned then
				slot:StripTextures()
				slot:SetTemplate("Default")
				slot:StyleButton()

				icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				icon:ClearAllPoints()
				icon:SetPoint("TOPLEFT", 2, -2)
				icon:SetPoint("BOTTOMRIGHT", -2, 2)
				icon:SetDrawLayer("ARTWORK")

				slot.isSkinned = true
			end

			local texture, name, count, quality = GetMissingLootItemInfo(i)
			local color = ITEM_QUALITY_COLORS[quality] or unpack(C.media.border_color)
			icon:SetTexture(texture)
			slot:SetBackdropBorderColor(color.r, color.g, color.b)
		end
	end
	hooksecurefunc("MissingLootFrame_Show", SkinButton)

	LootHistoryFrame:StripTextures()
	LootHistoryFrame:SetTemplate("Transparent")

	T.SkinCloseButton(LootHistoryFrame.CloseButton)
	T.SkinCloseButton(LootHistoryFrame.ResizeButton, nil, " ")

	LootHistoryFrameScrollFrame:GetRegions():Hide()
	T.SkinScrollBar(LootHistoryFrameScrollFrameScrollBar)

	LootHistoryFrame.ResizeButton:SetTemplate("Default")
	LootHistoryFrame.ResizeButton:SetWidth(LootHistoryFrame:GetWidth())
	LootHistoryFrame.ResizeButton:ClearAllPoints()
	LootHistoryFrame.ResizeButton:SetPoint("TOP", LootHistoryFrame, "BOTTOM", 0, -1)

	local function UpdateLoots(self)
		local numItems = C_LootHistory.GetNumItems()
		for i = 1, numItems do
			local frame = self.itemFrames[i]

			if not frame.isSkinned then
				local Icon = frame.Icon:GetTexture()

				frame:StripTextures()

				frame:CreateBackdrop("Default")
				frame.backdrop:SetPoint("TOPLEFT", frame.Icon, -2, 2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", frame.Icon, 2, -2)

				frame.Icon:SetTexture(Icon)
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.Icon:SetParent(frame.backdrop)

				frame.isSkinned = true
			end
		end
	end
	hooksecurefunc("LootHistoryFrame_FullUpdate", UpdateLoots)
	LootHistoryFrame:HookScript("OnShow", UpdateLoots)

	-- Master loot frame
	MasterLooterFrame:StripTextures()
	MasterLooterFrame:SetTemplate("Transparent")

	hooksecurefunc("MasterLooterFrame_Show", function()
		local button = MasterLooterFrame.Item
		if button then
			local icon = button.Icon
			local texture = icon:GetTexture()
			local color = ITEM_QUALITY_COLORS[LootFrame.selectedQuality]

			button:StripTextures()

			icon:SetTexture(texture)
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			button:CreateBackdrop("Default")
			button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
			button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)
			button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		end

		for i = 1, MasterLooterFrame:GetNumChildren() do
			local child = select(i, MasterLooterFrame:GetChildren())
			if child and not child.isSkinned and not child:GetName() then
				if child:GetObjectType() == "Button" then
					if child:GetPushedTexture() then
						T.SkinCloseButton(child)
					else
						child:StripTextures()
						child:SkinButton()
					end
					child.isSkinned = true
				end
			end
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)