local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.adibags ~= true then return end

----------------------------------------------------------------------------------------
--	AdiBags skin(Not Ready)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("AdiBags") then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

	addon.BACKDROP = {
		bgFile = C.media.blank,
		edgeFile = C.media.blank,
		tile = false,
		tileSize = 0,
		edgeSize = T.mult,
		insets = {
			left = -T.mult,
			right = -T.mult,
			top = -T.mult,
			bottom = -T.mult,
		},
	}
	addon.db.profile.backgroundColors.Backpack = C.media.overlay_color
	addon.db.profile.backgroundColors.Bank = C.media.overlay_color
	addon.db.profile.scale = 1

	local buttonProto = addon:GetClass("ItemButton").prototype
	local stackProto = addon:GetClass("StackButton").prototype
	local containerProto = addon:GetClass("Container").prototype
	local ITEM_SIZE = addon.ITEM_SIZE

	function stackProto:OnCreate()
		self:SetWidth(ITEM_SIZE)
		self:SetHeight(ITEM_SIZE)
		self.slots = {}
		self:SetScript("OnShow", self.OnShow)
		self:SetScript("OnHide", self.OnHide)
		self.GetCountHook = function()
			return self.count
		end
	end

	local function reSkinItem(f)
		f:SetHeight(ITEM_SIZE)
		f:SetWidth(ITEM_SIZE)

		f:SetNormalTexture(nil)
		f:StyleButton()
		f:SetTemplate()

		f.skinned = true
		if f.section then
			f.section.Header:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			f.section.Header:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
		end
	end

	function buttonProto:Update()
		if not self:CanUpdate() then return end
		local icon = self.IconTexture
		local count = self.Count

		if not self.skinned then reSkinItem(self) end

		count:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
		count:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

		icon:ClearAllPoints()
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", self, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", self, -2, 2)
		---icon:SetWidth(ITEM_SIZE)
		---icon:SetHeight(ITEM_SIZE)

		---icon:SetPoint("CENTER", self, "CENTER", 0, 0)
		if self.texture then
			icon:SetTexture(self.texture)
		else
			icon:SetTexture(0.3, 0.3, 0.3, 1)
		end

		local tag = (not self.itemId or addon.db.profile.showBagType) and addon:GetFamilyTag(self.bagFamily)
		if tag then
			self.Stock:SetText(tag)
			self.Stock:Show()
		else
			self.Stock:Hide()
		end

		self:UpdateCount()
		self:UpdateBorder()
		self:UpdateCooldown()
		self:UpdateLock()
		addon:SendMessage("AdiBags_UpdateButton", self)
	end

	function buttonProto:UpdateBorder(isolatedEvent)
		if self.hasItem then
			local r, g, b, a = 1, 1, 1, 1
			local isQuestItem, questId, isActive = GetContainerItemQuestInfo(self.bag, self.slot)
			if addon.db.profile.questIndicator and (questId and not isActive) then
				r, g, b = 1, 0.3, 0.3
			elseif addon.db.profile.questIndicator and (questId or isQuestItem) then
				r, g, b = 1, 0.3, 0.3
			elseif addon.db.profile.qualityHighlight then
				local _, _, quality = GetItemInfo(self.itemId)
				if quality and quality >= ITEM_QUALITY_UNCOMMON then
					r, g, b = GetItemQualityColor(quality)
				elseif quality == ITEM_QUALITY_POOR and addon.db.profile.dimJunk then
					r, g, b = 0.5, 0.5, 0.5
				end
			end

			self:SetBackdropBorderColor(r, g, b, a)

			if isolatedEvent then
				addon:SendMessage("AdiBags_UpdateBorder", self)
			end
			return
		end
		self.IconQuestTexture:Hide()
		if isolatedEvent then
			addon:SendMessage("AdiBags_UpdateBorder", self)
		end
	end

	local _containerProto_OnCreate = containerProto.OnCreate
	function containerProto:OnCreate(name, bagIds, isBank)
		_containerProto_OnCreate(self, name, bagIds, isBank)

		local searchBoxFrame = _G[self:GetName().."SearchBox"]
		if searchBoxFrame then T.SkinEditBox(searchBoxFrame) end

		T.SkinCloseButton(self.CloseButton)

		for _, widget in ipairs(self.HeaderLeftRegion.widgets) do
			local button = widget.widget
			if button.SetNormalTexture then
				local texture = button:GetNormalTexture()
				if texture then
					texture:ClearAllPoints()
					texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					texture:SetPoint("TOPLEFT", 2, -2)
					texture:SetPoint("BOTTOMRIGHT", -2, 2)
					button:SetTemplate()
					button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				end
			end
		end
	end

	local _CreateBagSlotPanel = addon.CreateBagSlotPanel
	function addon:CreateBagSlotPanel(container, name, bags, isBank)
		local bagSlotPanel = _CreateBagSlotPanel(self, container, name, bags, isBank)
		for _, button in ipairs(bagSlotPanel.buttons) do
			local texture = _G[button:GetName().."IconTexture"]
			local count = _G[button:GetName().."Count"]

			count:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
			count:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)

			if texture then
				texture:ClearAllPoints()
				texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				texture:SetPoint("TOPLEFT", 2, -2)
				texture:SetPoint("BOTTOMRIGHT", -2, 2)
			end

			button:SetNormalTexture(nil)
			button:StyleButton()
			button:SetTemplate()
		end
		return bagSlotPanel
	end
end)