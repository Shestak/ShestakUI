local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Character skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local magicResTextureCords = {
		{0.21875, 0.78125, 0.25, 0.3203125},		-- Arcane
		{0.21875, 0.78125, 0.0234375, 0.09375},		-- Fire
		{0.21875, 0.78125, 0.13671875, 0.20703125},	-- Nature
		{0.21875, 0.78125, 0.36328125, 0.43359375},	-- Frost
		{0.21875, 0.78125, 0.4765625, 0.546875}		-- Shadow
	}

	CharacterFrame:StripTextures(true)
	CharacterFrame:CreateBackdrop("Transparent")
	CharacterFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	CharacterFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(CharacterFrameCloseButton, CharacterFrame.backdrop)

	CharacterNameText:ClearAllPoints()
	CharacterNameText:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 0, -6)

	CharacterFrameTab1:ClearAllPoints()
	CharacterFrameTab1:SetPoint("TOPLEFT", CharacterFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, #CHARACTERFRAME_SUBFRAMES do
		local tab = _G["CharacterFrameTab"..i]
		T.SkinTab(tab)
	end

	-- Character Frame
	PaperDollFrame:StripTextures()
	CharacterAttributesFrame:StripTextures()
	CharacterResistanceFrame:StripTextures()

	CharacterModelFrame:SetPoint("TOPLEFT", 66, -74)

	T.SkinRotateButton(CharacterModelFrameRotateLeftButton)
	CharacterModelFrameRotateLeftButton:SetPoint("TOPLEFT", 2, -2)

	T.SkinRotateButton(CharacterModelFrameRotateRightButton)
	CharacterModelFrameRotateRightButton:SetPoint("TOPLEFT", CharacterModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

	local function HandleResistanceFrame(frameName)
		for i, coords in pairs(magicResTextureCords) do
			local frame = _G[frameName..i]

			frame:SetSize(24, 24)
			frame:SetTemplate("Default")

			if i ~= 1 then
				frame:ClearAllPoints()
				frame:SetPoint("TOP", _G[frameName..i-1], "BOTTOM", 0, -3)
			end

			select(1, _G[frameName..i]:GetRegions()):SetInside()
			select(1, _G[frameName..i]:GetRegions()):SetDrawLayer("ARTWORK")
			select(2, _G[frameName..i]:GetRegions()):SetDrawLayer("OVERLAY")
			select(1, _G[frameName..i]:GetRegions()):SetTexCoord(coords[1], coords[2], coords[3], coords[4])
		end
	end

	HandleResistanceFrame("MagicResFrame")

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot",
		"RangedSlot",
		"AmmoSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["Character"..slot.."IconTexture"]
		local cooldown = _G["Character"..slot.."Cooldown"]

		slot = _G["Character"..slot]
		slot:StripTextures()
		slot:StyleButton(false)
		slot:SetTemplate("Default", true, true)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetInside()

		slot:SetFrameLevel(PaperDollFrame:GetFrameLevel() + 2)

		if(cooldown) then
			T.CreateAuraWatch(cooldown)
		end
	end

	local function ColorItemBorder()
		if event == "UNIT_INVENTORY_CHANGED" and unit ~= "player" then return end

		for _, slot in pairs(slots) do
			local target = _G["Character"..slot]
			local slotId = GetInventorySlotInfo(slot)
			local itemId = GetInventoryItemTexture("player", slotId)

			if itemId then
				local rarity = GetInventoryItemQuality("player", slotId)
				if rarity and rarity > 1 then
					target:SetBackdropBorderColor(GetItemQualityColor(rarity))
				else
					target:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			else
				target:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end

	local CheckItemBorderColor = CreateFrame("Frame")
	CheckItemBorderColor:RegisterEvent("UNIT_INVENTORY_CHANGED")
	CheckItemBorderColor:SetScript("OnEvent", ColorItemBorder)
	CharacterFrame:HookScript("OnShow", ColorItemBorder)
	ColorItemBorder()

	-- Pet Frame
	PetNameText:ClearAllPoints()
	PetNameText:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 0, -4)

	PetPaperDollFrame:StripTextures()
	
	PetPaperDollCloseButton:StripTextures()
	PetPaperDollCloseButton:SkinButton()

	T.SkinRotateButton(PetModelFrameRotateLeftButton)
	PetModelFrameRotateLeftButton:ClearAllPoints()
	PetModelFrameRotateLeftButton:SetPoint("TOPLEFT", 3, -3)

	T.SkinRotateButton(PetModelFrameRotateRightButton)
	PetModelFrameRotateRightButton:ClearAllPoints()
	PetModelFrameRotateRightButton:SetPoint("TOPLEFT", PetModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

	PetAttributesFrame:StripTextures()

	HandleResistanceFrame("PetMagicResFrame")

	PetPaperDollFrameExpBar:StripTextures()
	PetPaperDollFrameExpBar:CreateBackdrop("Default")
	PetPaperDollFrameExpBar:SetStatusBarTexture(C.media.blank)

	local function updHappiness(self)
		local happiness = GetPetHappiness()
		local _, isHunterPet = HasPetUI()
		if not happiness or not isHunterPet then return end

		local texture = self:GetRegions()
		if happiness == 1 then
			texture:SetTexCoord(0.41, 0.53, 0.06, 0.30)
		elseif happiness == 2 then
			texture:SetTexCoord(0.22, 0.345, 0.06, 0.30)
		elseif happiness == 3 then
			texture:SetTexCoord(0.04, 0.15, 0.06, 0.30)
		end
	end

	PetPaperDollPetInfo:CreateBackdrop("Default")
	PetPaperDollPetInfo:SetPoint("TOPLEFT", PetModelFrameRotateLeftButton, "BOTTOMLEFT", 9, -3)
	PetPaperDollPetInfo:GetRegions():SetTexCoord(0.04, 0.15, 0.06, 0.30)
	PetPaperDollPetInfo:SetFrameLevel(PetModelFrame:GetFrameLevel() + 2)
	PetPaperDollPetInfo:SetSize(24, 24)

	updHappiness(PetPaperDollPetInfo)
	PetPaperDollPetInfo:RegisterEvent("UNIT_HAPPINESS")
	PetPaperDollPetInfo:SetScript("OnEvent", updHappiness)
	PetPaperDollPetInfo:SetScript("OnShow", updHappiness)

	-- Reputation Frame
	ReputationFrame:StripTextures()

	for i = 1, NUM_FACTIONS_DISPLAYED do
		local bar = _G["ReputationBar"..i]
		local header = _G["ReputationHeader"..i]
		local name = _G["ReputationBar"..i.."FactionName"]
		local war = _G["ReputationBar"..i.."AtWarCheck"]

		bar:StripTextures()
		bar:CreateBackdrop("Default")
		bar:SetStatusBarTexture(C.media.blank)
		bar:SetSize(108, 13)

		if i == 1 then
			bar:SetPoint("TOPLEFT", 190, -86)
		end
		
		name:SetPoint("LEFT", bar, "LEFT", -150, 0)
		name:SetWidth(140)

		header:StripTextures(true)
		header:SetNormalTexture(nil)
		header:SetPoint("TOPLEFT", bar, "TOPLEFT", -170, 0)
		
		header.Text = header:CreateFontString(nil, "OVERLAY")
		header.Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		header.Text:SetPoint("LEFT", header, "LEFT", 10, 1)
		header.Text:SetText("-")

		war:StripTextures()
		war:SetPoint("LEFT", bar, "RIGHT", 0, 0)

		war.icon = war:CreateTexture(nil, "OVERLAY")
		war.icon:SetPoint("LEFT", 3, -6)
		war.icon:SetTexture("Interface\\Buttons\\UI-CheckBox-SwordCheck")
	end

	local function UpdateFaction()
		local numFactions = GetNumFactions()
		local offset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
		local index, header

		for i = 1, NUM_FACTIONS_DISPLAYED, 1 do
			header = _G["ReputationHeader"..i]
			index = offset + i

			if index <= numFactions then
				header:SetSize(16, 16)
				header:StripTextures()
				header:SetTemplate("Overlay")
				header:SetPoint("CENTER")
				header:SetHitRectInsets(1, 1, 1, 1)

				header.Text:ClearAllPoints()
				header.Text:SetPoint("LEFT", header, "RIGHT", 8, 0)

				header.minus = header:CreateTexture(nil, "OVERLAY")
				header.minus:SetSize(7, 1)
				header.minus:SetPoint("CENTER")
				header.minus:SetTexture(C.media.blank)

				if header.isCollapsed then
					header.plus = header:CreateTexture(nil, "OVERLAY")
					header.plus:SetSize(1, 7)
					header.plus:SetPoint("CENTER")
					header.plus:SetTexture(C.media.blank)
				end
			end
		end
	end
	hooksecurefunc("ReputationFrame_Update", UpdateFaction)

	ReputationFrameStandingLabel:SetPoint("TOPLEFT", 223, -59)
	ReputationFrameFactionLabel:SetPoint("TOPLEFT", 55, -59)

	ReputationListScrollFrame:StripTextures()
	T.SkinScrollBar(ReputationListScrollFrameScrollBar)

	ReputationDetailFrame:StripTextures()
	ReputationDetailFrame:SetTemplate("Transparent")
	ReputationDetailFrame:SetPoint("TOPLEFT", ReputationFrame, "TOPRIGHT", -32, -12)

	T.SkinCloseButton(ReputationDetailCloseButton)
	ReputationDetailCloseButton:SetPoint("TOPRIGHT", -4, -4)

	T.SkinCheckBox(ReputationDetailAtWarCheckBox)
	ReputationDetailAtWarCheckBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-SwordCheck")
	T.SkinCheckBox(ReputationDetailInactiveCheckBox)
	T.SkinCheckBox(ReputationDetailMainScreenCheckBox)

	-- Skill Frame
	SkillFrame:StripTextures()

	SkillFrameExpandButtonFrame:DisableDrawLayer("BACKGROUND")
	SkillFrameCollapseAllButton:SetPoint("LEFT", SkillFrameExpandTabLeft, "RIGHT", -60, -3)

	SkillFrameCollapseAllButtonText:ClearAllPoints()
	SkillFrameCollapseAllButtonText:SetPoint("LEFT", SkillFrameCollapseAllButton, "RIGHT", 6, 0)

	SkillFrameCollapseAllButton:SetSize(14, 14)
	SkillFrameCollapseAllButton:SetPoint("CENTER")
	SkillFrameCollapseAllButton:SetHitRectInsets(1, 1, 1, 1)

	hooksecurefunc(SkillFrameCollapseAllButton, "SetNormalTexture", function(self, texture)
		self:StripTextures()
		self:SetTemplate("Overlay")

		self.minus = self:CreateTexture(nil, "OVERLAY")
		self.minus:SetSize(7, 1)
		self.minus:SetPoint("CENTER")
		self.minus:SetTexture(C.media.blank)

		if not string.find(texture, "MinusButton") then
			self.plus = self:CreateTexture(nil, "OVERLAY")
			self.plus:SetSize(1, 7)
			self.plus:SetPoint("CENTER")
			self.plus:SetTexture(C.media.blank)
		end
	end)

	SkillFrameCancelButton:SkinButton()

	for i = 1, SKILLS_TO_DISPLAY do
		local bar = _G["SkillRankFrame"..i]
		local label = _G["SkillTypeLabel"..i]
		local text = _G["SkillTypeLabel"..i.."Text"]
		local border = _G["SkillRankFrame"..i.."Border"]
		local background = _G["SkillRankFrame"..i.."Background"]

		bar:CreateBackdrop("Default")
		bar:SetStatusBarTexture(C.media.blank)

		border:StripTextures()
		background:SetTexture(nil)

		label:SetPoint("TOPLEFT", bar, "TOPLEFT", -20, 0)
		label:SetSize(14, 14)
		label:SetPoint("CENTER")
		label:SetHitRectInsets(1, 1, 1, 1)

		text:SetPoint("LEFT", label, "RIGHT", 6, 0)

		hooksecurefunc(label, "SetNormalTexture", function(self, texture)
			self:StripTextures()
			self:SetTemplate("Overlay")

			self.minus = self:CreateTexture(nil, "OVERLAY")
			self.minus:SetSize(7, 1)
			self.minus:SetPoint("CENTER")
			self.minus:SetTexture(C.media.blank)

			if not string.find(texture, "MinusButton") then
				self.plus = self:CreateTexture(nil, "OVERLAY")
				self.plus:SetSize(1, 7)
				self.plus:SetPoint("CENTER")
				self.plus:SetTexture(C.media.blank)
			end
		end)
	end

	SkillListScrollFrame:StripTextures()
	T.SkinScrollBar(SkillListScrollFrameScrollBar)

	SkillDetailScrollFrame:StripTextures()
	T.SkinScrollBar(SkillDetailScrollFrameScrollBar)

	SkillDetailStatusBar:StripTextures()
	SkillDetailStatusBar:CreateBackdrop("Default")
	SkillDetailStatusBar:SetParent(SkillDetailScrollFrame)
	SkillDetailStatusBar:SetStatusBarTexture(C.media.blank)

	T.SkinNextPrevButton(SkillDetailStatusBarUnlearnButton)
	SkillDetailStatusBarUnlearnButton:SetSize(24, 24)
	SkillDetailStatusBarUnlearnButton:SetPoint("LEFT", SkillDetailStatusBarBorder, "RIGHT", 5, 0)
	SkillDetailStatusBarUnlearnButton:SetHitRectInsets(0, 0, 0, 0)

	-- Honor Frame
	HonorFrame:StripTextures(true)

	HonorFrameProgressBar:ClearAllPoints()
	HonorFrameProgressBar:SetPoint("TOP", CharacterFrame.backdrop, "TOP", 1, -65)
	
	HonorFrameProgressBar:CreateBackdrop("Default")
	HonorFrameProgressBar:SetHeight(24)
end

table.insert(T.SkinFuncs["ShestakUI"], LoadSkin)