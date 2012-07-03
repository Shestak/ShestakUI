local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Bank/Container skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if C.bag.enable == true or (IsAddOnLoaded("cargBags") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("Bagnon")) then return end
	-- Container Frame
	BagItemSearchBox:StripTextures(true)
	BagItemSearchBox:CreateBackdrop("Overlay")
	BagItemSearchBox.backdrop:Point("TOPLEFT", 13, -2)
	BagItemSearchBox.backdrop:Point("BOTTOMRIGHT", -2, 2)

	for i = 1, NUM_CONTAINER_FRAMES do
		local frame = _G["ContainerFrame"..i]
		local close = _G["ContainerFrame"..i.."CloseButton"]
		frame:StripTextures(true)
		frame:CreateBackdrop("Transparent")
		frame.backdrop:Point("TOPLEFT", 4, -2)
		frame.backdrop:Point("BOTTOMRIGHT", 0, 2)

		T.SkinCloseButton(close, frame.backdrop)

		for j = 1, MAX_CONTAINER_ITEMS do
			local item = _G["ContainerFrame"..i.."Item"..j]
			local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]
			local quest = _G["ContainerFrame"..i.."Item"..j.."IconQuestTexture"]
			item:SetNormalTexture(nil)
			item:StyleButton()
			item:SetTemplate()

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", -2, 2)

			quest:SetAlpha(0)
		end

		if i == 1 then
			BackpackTokenFrame:StripTextures(true)
			for i = 1, MAX_WATCHED_TOKENS do
				_G["BackpackTokenFrameToken"..i].icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["BackpackTokenFrameToken"..i]:CreateBackdrop("Default")
				_G["BackpackTokenFrameToken"..i].backdrop:Point("TOPLEFT", _G["BackpackTokenFrameToken"..i].icon, "TOPLEFT", -2, 2)
				_G["BackpackTokenFrameToken"..i].backdrop:Point("BOTTOMRIGHT", _G["BackpackTokenFrameToken"..i].icon, "BOTTOMRIGHT", 2, -2)
				_G["BackpackTokenFrameToken"..i].icon:Point("LEFT", _G["BackpackTokenFrameToken"..i].count, "RIGHT", 2, 0)
			end
		end
	end

	-- Bank Frame
	BankFrame:StripTextures(true)
	BankFrame:CreateBackdrop("Transparent")
	BankFrame.backdrop:Point("TOPLEFT", 0, 0)
	BankFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	BankItemSearchBox:StripTextures(true)
	BankItemSearchBox:CreateBackdrop("Overlay")
	BankItemSearchBox.backdrop:Point("TOPLEFT", 13, -2)
	BankItemSearchBox.backdrop:Point("BOTTOMRIGHT", -2, 2)

	BankFrameMoneyFrameInset:StripTextures()
	BankFrameMoneyFrameBorder:StripTextures()

	BankFramePurchaseButton:SkinButton()
	T.SkinCloseButton(BankFrameCloseButton, BankFrame.backdrop)

	for i = 1, 28 do
		local item = _G["BankFrame".."Item"..i]
		local icon = _G["BankFrame".."Item"..i.."IconTexture"]
		local quest = _G["BankFrame".."Item"..i.."IconQuestTexture"]
		item:SetNormalTexture(nil)
		item:StyleButton()
		item:SetTemplate()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)

		quest:SetAlpha(0)
	end

	for i = 1, 7 do
		local bag = _G["BankFrameBag"..i]
		local icon = _G["BankFrameBag"..i.."IconTexture"]
		local highlight = _G["BankFrameBag"..i.."HighlightFrameTexture"]

		bag:SetNormalTexture(nil)
		bag:StyleButton()
		bag:SetTemplate()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)

		if highlight and not highlight.skinned then
			highlight:SetTexture(1, 1, 1, 0.3)
			highlight.SetTexture = T.dummy
			highlight:ClearAllPoints()
			highlight:Point("TOPLEFT", 2, -2)
			highlight:Point("BOTTOMRIGHT", -2, 2)
			highlight.skinned = true
		end
	end

	-- Color QuestItem
	hooksecurefunc("ContainerFrame_Update", function(frame)
		local name = frame:GetName()
		local item
		for i = 1, MAX_CONTAINER_ITEMS do
			item = _G[name.."Item"..i]
			if _G[name.."Item"..i.."IconQuestTexture"]:IsShown() then
				item:SetBackdropBorderColor(1, 1, 0)
			else
				item:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	hooksecurefunc("BankFrameItemButton_Update", function(item)
		if not item.isBag then
			if _G[item:GetName().."IconQuestTexture"]:IsShown() then
				item:SetBackdropBorderColor(1, 1, 0)
			else
				item:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	-- Frame Anchors
	hooksecurefunc("updateContainerFrameAnchors", function()
		local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
		local screenWidth = GetScreenWidth()
		local containerScale = 1
		local leftLimit = 0

		if BankFrame:IsShown() then
			leftLimit = BankFrame:GetRight() - 25
		end

		while containerScale > CONTAINER_SCALE do
			screenHeight = GetScreenHeight() / containerScale
			xOffset = CONTAINER_OFFSET_X / containerScale
			yOffset = CONTAINER_OFFSET_Y / containerScale
			freeScreenHeight = screenHeight - yOffset
			leftMostPoint = screenWidth - xOffset
			column = 1
			local frameHeight
			for index, frameName in ipairs(ContainerFrame1.bags) do
				frameHeight = _G[frameName]:GetHeight()
				if freeScreenHeight < frameHeight then
					column = column + 1
					leftMostPoint = screenWidth - (column * CONTAINER_WIDTH * containerScale) - xOffset
					freeScreenHeight = screenHeight - yOffset
				end
				freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING
			end
			if leftMostPoint < leftLimit then
				containerScale = containerScale - 0.01
			else
				break
			end
		end

		if containerScale < CONTAINER_SCALE then
			containerScale = CONTAINER_SCALE
		end

		screenHeight = GetScreenHeight() / containerScale
		xOffset = CONTAINER_OFFSET_X / containerScale
		yOffset = CONTAINER_OFFSET_Y / containerScale
		freeScreenHeight = screenHeight - yOffset
		column = 0

		local bagsPerColumn = 0
		for index, frameName in ipairs(ContainerFrame1.bags) do
			frame = _G[frameName]
			frame:SetScale(1)
			if index == 1 then
				frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 22)
				bagsPerColumn = bagsPerColumn + 1
			elseif freeScreenHeight < frame:GetHeight() then
				column = column + 1
				freeScreenHeight = screenHeight - yOffset
				if column > 1 then
					frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[(index - bagsPerColumn) - 1], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
				else
					frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - bagsPerColumn], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
				end
				bagsPerColumn = 0
			else
				frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, CONTAINER_SPACING)
				bagsPerColumn = bagsPerColumn + 1
			end
			freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING
		end
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)