local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Loot skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	-- Loot History frame
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

	-- Master Looter frame
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

	-- Loot frame
	if C.loot.lootframe == true or (IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag")) then return end

	LootFrame:StripTextures(true)
	LootFrameInset:StripTextures()
	LootFrame:SetTemplate("Transparent")

	T.SkinNextPrevButton(LootFrameDownButton)
	T.SkinNextPrevButton(LootFrameUpButton, true)

	T.SkinCloseButton(LootFrameCloseButton)

	for i = 1, LOOTFRAME_NUMBUTTONS do
		local slot = _G["LootButton"..i]
		local icon = _G["LootButton"..i.."IconTexture"]
		local name = _G["LootButton"..i.."NameFrame"]
		_G["LootButton"..i.."IconQuestTexture"]:SetAlpha(0)

		slot:StyleButton()
		slot:SetNormalTexture("")
		slot:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		name:Hide()
		name.border = CreateFrame("Frame", nil, slot)
		name.border:CreateBackdrop("Overlay")
		name.border.backdrop:SetPoint("TOPLEFT", name, 11, -13)
		name.border.backdrop:SetPoint("BOTTOMRIGHT", name, -8, 12)
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)