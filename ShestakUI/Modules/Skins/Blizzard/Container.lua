local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Bank/Container skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if C.bag.enable == true or (IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag")) then return end

	-- Container Frame
	BagItemSearchBox:StripTextures(true)
	BagItemSearchBox:CreateBackdrop("Overlay")
	BagItemSearchBox.backdrop:SetPoint("TOPLEFT", 13, 0)
	BagItemSearchBox.backdrop:SetPoint("BOTTOMRIGHT", -2, 0)
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("TOPRIGHT", BagItemAutoSortButton, "TOPLEFT", -3, 0)
	BagItemSearchBox.SetPoint = T.dummy

	BagItemAutoSortButton:SetSize(18, 18)
	BagItemAutoSortButton:StyleButton()
	BagItemAutoSortButton:SetTemplate("Default")
	BagItemAutoSortButton:GetNormalTexture():SetTexture("Interface\\Icons\\inv_pet_broom")
	BagItemAutoSortButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BagItemAutoSortButton:GetNormalTexture():ClearAllPoints()
	BagItemAutoSortButton:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	BagItemAutoSortButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)

	ContainerFrameCombinedBags:StripTextures(true)
	ContainerFrameCombinedBags:CreateBackdrop("Transparent")
	ContainerFrameCombinedBags.Bg:Hide()
	T.SkinCloseButton(ContainerFrameCombinedBags.CloseButton)

	-- ContainerFrameCombinedBags:ClearAllPoints()
	-- ContainerFrameCombinedBags:SetPoint(unpack(C.position.bag))
	-- ContainerFrameCombinedBags.SetPoint = T.dummy

	ContainerFrameCombinedBags.MoneyFrame.Border:Hide()
	ContainerFrame1MoneyFrame.Border:Hide()

	ContainerFrameCombinedBagsPortrait:SetAlpha(0)
	ContainerFrameCombinedBagsPortraitButton.Highlight:SetAlpha(0)
	ContainerFrameCombinedBagsPortraitButtonTexture = ContainerFrameCombinedBagsPortraitButton:CreateTexture(nil, "OVERLAY")
	ContainerFrameCombinedBagsPortraitButtonTexture:SetSize(30, 30)
	ContainerFrameCombinedBagsPortraitButtonTexture:SetPoint("CENTER", 2, 1)
	ContainerFrameCombinedBagsPortraitButtonTexture:SetTexture("Interface\\Icons\\inv_misc_bag_08")
	ContainerFrameCombinedBagsPortraitButtonTexture:SkinIcon()

	local function updateQuestItems(self)
		for _, button in self:EnumerateValidItems() do
			if button.IconQuestTexture:IsShown() then
				button:SetBackdropBorderColor(1, 1, 0)
			else
				button:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end

	for i = 1, NUM_CONTAINER_FRAMES do
		local frame = _G["ContainerFrame"..i]
		local close = _G["ContainerFrame"..i].CloseButton

		frame:StripTextures(true)
		frame:CreateBackdrop("Transparent")
		frame.backdrop:SetPoint("TOPLEFT", 4, -2)
		frame.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
		frame.Bg:Hide()

		local portrait = _G["ContainerFrame"..i.."Portrait"]
		portrait:SetSize(30, 30)
		portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -8)
		portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)

		frame.b = CreateFrame("Frame", nil, frame)
		frame.b:SetTemplate("Default")
		frame.b:SetOutside(portrait)

		T.SkinCloseButton(close, frame.backdrop)

		for j = 1, 36 do
			local item = _G["ContainerFrame"..i.."Item"..j]
			local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]
			local quest = _G["ContainerFrame"..i.."Item"..j.."IconQuestTexture"]
			local border = _G["ContainerFrame"..i.."Item"..j].IconBorder

			border:SetAlpha(0)

			item:SetNormalTexture(0)
			item:StyleButton()
			item:SetTemplate("Default")

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)

			quest:SetAlpha(0)
		end

		-- Color QuestItem
		hooksecurefunc(frame, "UpdateItems", function(self)
			updateQuestItems(self)
		end)
	end

	BackpackTokenFrame:StripTextures(true)
	hooksecurefunc(_G.BackpackTokenFrame, "Update", function (container)
		for _, token in next, container.Tokens do
			if not token.Icon.styled then
				token.Icon:SkinIcon()
				token.Count:ClearAllPoints()
				token.Count:SetPoint("RIGHT", token.Icon, "LEFT", -5, 0)
				token.Icon.styled = true
			end
		end
	end)

	-- Bank Frame
	BankFrame:StripTextures(true)
	BankFrame:CreateBackdrop("Transparent")
	BankFrame.backdrop:SetAllPoints()

	BankItemSearchBox:StripTextures(true)
	BankItemSearchBox:CreateBackdrop("Overlay")
	BankItemSearchBox.backdrop:SetPoint("TOPLEFT", 13, 0)
	BankItemSearchBox.backdrop:SetPoint("BOTTOMRIGHT", -2, 0)

	BankItemAutoSortButton:StyleButton()
	BankItemAutoSortButton:SetTemplate("Default")
	BankItemAutoSortButton:SetSize(20, 20)
	BankItemAutoSortButton:SetPoint("TOPLEFT", BankItemSearchBox, "TOPRIGHT", 3, 0)
	BankItemAutoSortButton:GetNormalTexture():SetTexture("Interface\\Icons\\inv_pet_broom")
	BankItemAutoSortButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	BankItemAutoSortButton:GetNormalTexture():ClearAllPoints()
	BankItemAutoSortButton:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	BankItemAutoSortButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)

	BankFrameMoneyFrameInset:StripTextures()
	BankFrameMoneyFrameBorder:StripTextures()

	BankFramePurchaseButton:SkinButton()
	T.SkinCloseButton(BankFrameCloseButton, BankFrame.backdrop)

	BankSlotsFrame:StripTextures()

	for i = 1, 28 do
		local item = _G["BankFrameItem"..i]
		local icon = _G["BankFrameItem"..i.."IconTexture"]
		local quest = _G["BankFrameItem"..i].IconQuestTexture
		local border = _G["BankFrameItem"..i].IconBorder

		border:SetAlpha(0)

		item:SetNormalTexture(0)
		item:StyleButton()
		item:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		if quest then
			quest:SetAlpha(0)
		end
	end

	for i = 1, 7 do
		local bag = BankSlotsFrame["Bag"..i]
		local icon = bag.icon

		bag.IconBorder:Kill()

		bag:StripTextures()
		bag:StyleButton()
		bag:SetTemplate("Default")

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	-- Tabs
	for i = 1, 2 do
		T.SkinTab(_G["BankFrameTab"..i])
	end

	-- ReagentBank
	ReagentBankFrame:StripTextures()
	ReagentBankFrame:DisableDrawLayer("BACKGROUND")
	ReagentBankFrame:DisableDrawLayer("ARTWORK")

	ReagentBankFrameUnlockInfo:StripTextures()
	ReagentBankFrameUnlockInfo:CreateBackdrop("Overlay")
	ReagentBankFrameUnlockInfo.backdrop:SetPoint("TOPLEFT", 4, -2)
	ReagentBankFrameUnlockInfo.backdrop:SetPoint("BOTTOMRIGHT", -4, 2)
	ReagentBankFrameUnlockInfo.backdrop:SetFrameLevel(ReagentBankFrameUnlockInfo.backdrop:GetFrameLevel() + 1)

	ReagentBankFrameUnlockInfoPurchaseButton:SkinButton()
	ReagentBankFrameUnlockInfoPurchaseButton:SetFrameLevel(ReagentBankFrameUnlockInfo:GetFrameLevel() + 3)
	ReagentBankFrame.DespositButton:SkinButton()

	ReagentBankFrame:HookScript("OnShow", function()
		for i = 1, 98 do
			local item = _G["ReagentBankFrameItem"..i]
			local icon = _G["ReagentBankFrameItem"..i].icon
			local border = _G["ReagentBankFrameItem"..i].IconBorder

			border:Kill()

			item:SetNormalTexture(0)
			item:StyleButton()
			item:SetTemplate("Default")

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end)

	-- Color QuestItem
	hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", function(self)
		updateQuestItems(self)
	end)

	hooksecurefunc("BankFrameItemButton_Update", function(frame)
		if not frame.isBag and frame.IconQuestTexture:IsShown() then
			frame:SetBackdropBorderColor(1, 1, 0)
		else
			frame:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end)

	-- Frame Anchors
	hooksecurefunc("UpdateContainerFrameAnchors", function()
		local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
		local screenWidth = GetScreenWidth()
		local containerScale = 1
		local leftLimit = 0

		if BankFrame:IsShown() then
			leftLimit = BankFrame:GetRight() - 25
		end

		while containerScale > 0.75 do
			screenHeight = GetScreenHeight() / containerScale
			xOffset = CONTAINER_OFFSET_X / containerScale
			yOffset = CONTAINER_OFFSET_Y / containerScale
			freeScreenHeight = screenHeight - yOffset
			leftMostPoint = screenWidth - xOffset
			column = 1
			local frameHeight
			-- for _, frameName in ipairs(ContainerFrame1.bags) do
				-- frameHeight = _G[frameName]:GetHeight()
				-- if freeScreenHeight < frameHeight then
					-- column = column + 1
					-- leftMostPoint = screenWidth - (column * 192 * containerScale) - xOffset
					-- freeScreenHeight = screenHeight - yOffset
				-- end
				-- freeScreenHeight = freeScreenHeight - frameHeight - 3
			-- end
			if leftMostPoint < leftLimit then
				containerScale = containerScale - 0.01
			else
				break
			end
		end

		if containerScale < 0.75 then
			containerScale = 0.75
		end

		screenHeight = GetScreenHeight() / containerScale
		xOffset = CONTAINER_OFFSET_X / containerScale
		yOffset = CONTAINER_OFFSET_Y / containerScale
		freeScreenHeight = screenHeight - yOffset
		column = 0

		-- local bagsPerColumn = 0
		-- for index, frameName in ipairs(ContainerFrame1.bags) do
			-- frame = _G[frameName]
			-- frame:SetScale(1)
			-- if index == 1 then
				-- frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 22)
				-- bagsPerColumn = bagsPerColumn + 1
			-- elseif freeScreenHeight < frame:GetHeight() then
				-- column = column + 1
				-- freeScreenHeight = screenHeight - yOffset
				-- if column > 1 then
					-- frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[(index - bagsPerColumn) - 1], "BOTTOMLEFT", 0, 0)
				-- else
					-- frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - bagsPerColumn], "BOTTOMLEFT", 0, 0)
				-- end
				-- bagsPerColumn = 0
			-- else
				-- frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, 0)
				-- bagsPerColumn = bagsPerColumn + 1
			-- end
			-- freeScreenHeight = freeScreenHeight - frame:GetHeight() - 3
		-- end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)