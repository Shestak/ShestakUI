----------------------------------------------------------------------------------------
--	Based on Stuffing by Hungtar, editor Tukz
----------------------------------------------------------------------------------------
if not SettingsCF["bag"].enable == true then return end

local bags_BACKPACK = {0, 1, 2, 3, 4}
local bags_BANK = {-1, 5, 6, 7, 8, 9, 10, 11}
local BAGSFONT = SettingsCF["media"].pixel_font
local BAGSFONTSIZE = SettingsCF["media"].pixel_font_size
local BAGSFONTSTYLE = SettingsCF["media"].pixel_font_style
local ST_NORMAL = 1
local ST_SPECIAL = 3
local bag_bars = 0

-- Hide bags options in default interface
InterfaceOptionsDisplayPanelShowFreeBagSpace:Hide()

Stuffing = CreateFrame ("Frame", nil, UIParent)
Stuffing:RegisterEvent("ADDON_LOADED")
Stuffing:RegisterEvent("PLAYER_ENTERING_WORLD")
Stuffing:SetScript("OnEvent", function(this, event, ...)
	Stuffing[event](this, ...)
end)

-- Stub for localization
local L = setmetatable({}, {
	__index = function (t, v)
		t[v] = v
		return v
	end
})

local function Print (x)
	DEFAULT_CHAT_FRAME:AddMessage("|cffC495DDShestakUI:|r " .. x)
end

local function Stuffing_Sort(args)
	if not args then
		args = ""
	end

	Stuffing.itmax = 0
	Stuffing:SetBagsForSorting(args)
	Stuffing:SortBags()
end

local function Stuffing_OnShow()
	Stuffing:PLAYERBANKSLOTS_CHANGED(29)	-- XXX: hack to force bag frame update

	Stuffing:Layout()
	Stuffing:SearchReset()
end

local function StuffingBank_OnHide()
	CloseBankFrame()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	end
end

local function Stuffing_OnHide()
	if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		Stuffing.bankFrame:Hide()
	end
end

local function Stuffing_Open()
	Stuffing.frame:Show()
end

local function Stuffing_Close()
	Stuffing.frame:Hide()
end

local function Stuffing_Toggle()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	else
		Stuffing.frame:Show()
	end
end

local function Stuffing_ToggleBag(id)
	if id == -2 then
		ToggleKeyRing()
		return
	end
	Stuffing_Toggle()
end

-- Bag slot stuff
local trashParent = CreateFrame("Frame", nil, UIParent)
local trashButton = {}
local trashBag = {}

-- Mostly from carg.bags_Aurora
local QUEST_ITEM_STRING = nil

function Stuffing:SlotUpdate(b)
	if not StuffingFrameBags:IsShown() then return end -- don't do any slot update if bags are not show
	local texture, count, locked = GetContainerItemInfo (b.bag, b.slot)
	local clink = GetContainerItemLink(b.bag, b.slot)
	
	-- Set all slot color to default ShestakUI on update
	if not b.frame.lock then
		b.frame:SetBackdropBorderColor(unpack(SettingsCF.media.border_color))
	end
	
	if b.Cooldown then
		local cd_start, cd_finish, cd_enable = GetContainerItemCooldown(b.bag, b.slot)
		CooldownFrame_SetTimer(b.Cooldown, cd_start, cd_finish, cd_enable)
	end

	if(clink) then
		local iType
		b.name, _, b.rarity, _, _, iType = GetItemInfo(clink)
		
		-- Color slot according to item quality
		if not b.frame.lock and b.rarity and b.rarity > 1 then
			b.frame:SetBackdropBorderColor(GetItemQualityColor(b.rarity))
		end

			if QUEST_ITEM_STRING == nil then
				-- GetItemInfo returns a localized item type.
				-- this is to figure out what that string is.
				local t = {GetAuctionItemClasses()}
				QUEST_ITEM_STRING = t[#t]	-- #t == 12
			end

			if iType and iType == QUEST_ITEM_STRING then
				b.qitem = true
				-- color quest item red
				if not b.frame.lock then b.frame:SetBackdropBorderColor(1, 1, 0) end
			else
				b.qitem = nil
			end
	else
		b.name, b.rarity, b.qitem = nil, nil, nil
	end
	
	SetItemButtonTexture(b.frame, texture)
	SetItemButtonCount(b.frame, count)
	SetItemButtonDesaturated(b.frame, locked, 0.5, 0.5, 0.5)
	
	b.frame:Show()
end

function Stuffing:BagSlotUpdate(bag)
	if not self.buttons then
		return
	end

	for _, v in ipairs (self.buttons) do
		if v.bag == bag then
			self:SlotUpdate(v)
		end
	end
end

function Stuffing:BagFrameSlotNew (slot, p)
	for _, v in ipairs(self.bagframe_buttons) do
		if v.slot == slot then
			return v, false
		end
	end

	local ret = {}
	local tpl

	if slot > 3 then
		ret.slot = slot
		slot = slot - 4
		tpl = "BankItemButtonBagTemplate"
		ret.frame = CreateFrame("CheckButton", "StuffingBBag" .. slot, p, tpl)
		ret.frame:SetID(slot + 4)
		table.insert(self.bagframe_buttons, ret)

		BankFrameItemButton_Update(ret.frame)
		BankFrameItemButton_UpdateLocked(ret.frame)

		if not ret.frame.tooltipText then
			ret.frame.tooltipText = ""
		end
	else
		tpl = "BagSlotButtonTemplate"
		ret.frame = CreateFrame("CheckButton", "StuffingFBag" .. slot .. "Slot", p, tpl)
		ret.slot = slot
		table.insert(self.bagframe_buttons, ret)
	end

	return ret
end

function Stuffing:SlotNew (bag, slot)
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			return v, false
		end
	end

	local tpl = "ContainerFrameItemButtonTemplate"

	if bag == -1 then
		tpl = "BankItemButtonGenericTemplate"
	end

	local ret = {}

	if #trashButton > 0 then
		local f = -1
		for i, v in ipairs(trashButton) do
			local b, s = v:GetName():match("(%d+)_(%d+)")

			b = tonumber(b)
			s = tonumber(s)

			if b == bag and s == slot then
				f = i
				break
			end
		end

		if f ~= -1 then
			ret.frame = trashButton[f]
			table.remove(trashButton, f)
		end
	end

	if not ret.frame then
		ret.frame = CreateFrame("Button", "StuffingBag" .. bag .. "_" .. slot, self.bags[bag], tpl)
	end

	ret.bag = bag
	ret.slot = slot
	ret.frame:SetID(slot)

	ret.Cooldown = _G[ret.frame:GetName() .. "Cooldown"]
	ret.Cooldown:Show()

	self:SlotUpdate (ret)

	return ret, true
end


-- From OneBag
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400

function Stuffing:BagType(bag)
	local bagType = select(2, GetContainerNumFreeSlots(bag))

	if bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return ST_SPECIAL
	end

	return ST_NORMAL
end

function Stuffing:BagNew (bag, f)
	for i, v in pairs(self.bags) do
		if v:GetID() == bag then
			v.bagType = self:BagType(bag)
			return v
		end
	end

	local ret

	if #trashBag > 0 then
		local f = -1
		for i, v in pairs(trashBag) do
			if v:GetID() == bag then
				f = i
				break
			end
		end

		if f ~= -1 then
			ret = trashBag[f]
			table.remove(trashBag, f)
			ret:Show()
			ret.bagType = self:BagType(bag)
			return ret
		end
	end
	
	ret = CreateFrame("Frame", "StuffingBag" .. bag, f)
	ret.bagType = self:BagType(bag)

	ret:SetID(bag)
	return ret
end

function Stuffing:SearchUpdate(str)
	str = string.lower(str)

	for _, b in ipairs(self.buttons) do
		if b.frame and not b.name then
			b.frame:SetAlpha(.2)
		end
		if b.name then
			if not string.find (string.lower(b.name), str) then
				SetItemButtonDesaturated(b.frame, 1, 1, 1, 1)
				b.frame:SetAlpha(.2)
			else
				SetItemButtonDesaturated(b.frame, 0, 1, 1, 1)
				b.frame:SetAlpha(1)
			end
		end
	end
end

function Stuffing:SearchReset()
	for _, b in ipairs(self.buttons) do
		b.frame:SetAlpha(1)
		SetItemButtonDesaturated(b.frame, 0, 1, 1, 1)
	end
end

-- Drop down menu stuff from Postal
local Stuffing_DDMenu = CreateFrame("Frame", "Stuffing_DropDownMenu")
Stuffing_DDMenu.displayMode = "MENU"
Stuffing_DDMenu.info = {}
Stuffing_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == Stuffing_DDMenu then
		CloseDropDownMenus()
	end
end

function Stuffing:CreateBagFrame(w)
	local n = "StuffingFrame"  .. w
	local f = CreateFrame ("Frame", n, UIParent)
	f:EnableMouse(1)
	f:SetMovable(1)
	f:SetToplevel(1)
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(5)
	f:SetScript("OnMouseDown", f.StartMoving)
	f:SetScript("OnMouseUp", f.StopMovingOrSizing)
	
	if w == "Bank" then
		f:SetPoint(unpack(SettingsCF["position"].bank))
	else
		f:SetPoint(SettingsCF["position"].bag[1], SettingsCF["position"].bag[2], SettingsCF["position"].bag[3], SettingsCF["position"].bag[4]+3, SettingsCF["position"].bag[5]-3)
	end
	
	-- Close button
	f.b_close = CreateFrame("Button", "Stuffing_CloseButton" .. w, f, "UIPanelCloseButton")
	f.b_close:SetWidth(SettingsDB.Scale(25))
	f.b_close:SetHeight(SettingsDB.Scale(25))
	f.b_close:SetPoint("TOPRIGHT", SettingsDB.Scale(-3), SettingsDB.Scale(-1))
	f.b_close:SetScript("OnClick", function(self, btn)
		if self:GetParent():GetName() == "StuffingFrameBags" and btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(1, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		end
		self:GetParent():Hide()
	end)
	f.b_close:RegisterForClicks("AnyUp")
	
	-- Create the bags frame
	local fb = CreateFrame ("Frame", n .. "BagsFrame", f)
	fb:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, SettingsDB.Scale(3))
	fb:SetFrameStrata("HIGH")
	f.bags_frame = fb

	return f
end

function Stuffing:InitBank()
	if self.bankFrame then
		return
	end

	local f = self:CreateBagFrame("Bank")
	f:SetScript("OnHide", StuffingBank_OnHide)
	self.bankFrame = f
end

function Stuffing:InitBags()
	if self.frame then
		return
	end

	self.buttons = {}
	self.bags = {}
	self.bagframe_buttons = {}

	local f = self:CreateBagFrame("Bags")
	f:SetScript("OnShow", Stuffing_OnShow)
	f:SetScript("OnHide", Stuffing_OnHide)
	f:RegisterForDrag("LeftButton")

	-- Search editbox (tekKonfigAboutPanel.lua)
	local editbox = CreateFrame("EditBox", nil, f)
	editbox:Hide()
	editbox:SetAutoFocus(true)
	editbox:SetHeight(SettingsDB.Scale(32))
	SettingsDB.CreateTemplate(editbox)

	local resetAndClear = function (self)
		self:GetParent().detail:Show()
		self:ClearFocus()
		Stuffing:SearchReset()
	end

	local updateSearch = function(self, t)
		if t == true then
			Stuffing:SearchUpdate(self:GetText())
		end
	end

	editbox:SetScript("OnEscapePressed", resetAndClear)
	editbox:SetScript("OnEnterPressed", resetAndClear)
	editbox:SetScript("OnEditFocusLost", editbox.Hide)
	editbox:SetScript("OnEditFocusGained", editbox.HighlightText)
	editbox:SetScript("OnTextChanged", updateSearch)
	editbox:SetText(SEARCH)

	local detail = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	detail:SetPoint("TOPLEFT", f, SettingsDB.Scale(12), SettingsDB.Scale(-10))
	detail:SetPoint("RIGHT", SettingsDB.Scale(-140), SettingsDB.Scale(-10))
	detail:SetHeight(SettingsDB.Scale(13))
	detail:SetShadowColor(0, 0, 0, 0)
	detail:SetJustifyH("LEFT")
	detail:SetText("|cff9999ff" .. SEARCH)
	editbox:SetAllPoints(detail)

	local OpenEditbox = function(self)
		self:GetParent().detail:Hide()
		self:GetParent().editbox:Show()
		self:GetParent().editbox:HighlightText()
	end

	local button = CreateFrame("Button", nil, f)
	button:EnableMouse(1)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAllPoints(detail)
	button:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			OpenEditbox(self)
		else
			if self:GetParent().editbox:IsShown() then
				self:GetParent().editbox:Hide()
				self:GetParent().editbox:ClearFocus()
				self:GetParent().detail:Show()
				Stuffing:SearchReset()
			end
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function (self)
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_SEARCH)
	end

	button:SetScript("OnEnter", tooltip_show)
	button:SetScript("OnLeave", tooltip_hide)

	f.editbox = editbox
	f.detail = detail
	f.button = button
	self.frame = f
	f:Hide()
end

function Stuffing:Layout(lb)
	local slots = 0
	local rows = 0
	local off = 20
	local cols
	local f
	local bs

	if lb then
		bs = bags_BANK
		cols = SettingsCF["bag"].bank_columns
		f = self.bankFrame
	else
		bs = bags_BACKPACK
		cols = SettingsCF["bag"].bag_columns
		f = self.frame

		f.editbox:SetFont(SettingsCF["media"].normal_font, BAGSFONTSIZE+3)
		f.detail:SetFont(BAGSFONT, BAGSFONTSIZE, BAGSFONTSTYLE)

		f.detail:ClearAllPoints()
		f.detail:SetPoint("TOPLEFT", f, SettingsDB.Scale(12), SettingsDB.Scale(-10))
		f.detail:SetPoint("RIGHT", SettingsDB.Scale(-140), 0)
	end

	f:SetClampedToScreen(1)
	SettingsDB.SkinFadedPanel(f)

	-- Bag frame stuff
	local fb = f.bags_frame
	if bag_bars == 1 then
		fb:SetClampedToScreen(1)
		SettingsDB.SkinFadedPanel(fb)
		
		local bsize = 30
		if lb then bsize = 37 end

		local w = 2 * 10
		w = w + ((#bs - 1) * bsize)
		w = w + (10 * (#bs - 2))

		fb:SetHeight(SettingsDB.Scale(2 * 10 + bsize))
		fb:SetWidth(SettingsDB.Scale(w))
		fb:Show()
	else
		fb:Hide()
	end

	local idx = 0
	for _, v in ipairs(bs) do
		if (not lb and v <= 3 ) or (lb and v ~= -1) then
			local bsize = 30
			if lb then bsize = 37 end
			local b = self:BagFrameSlotNew(v, fb)
			local xoff = 10

			xoff = xoff + (idx * bsize)
			xoff = xoff + (idx * 4)

			b.frame:ClearAllPoints()
			b.frame:SetPoint("LEFT", fb, "LEFT", SettingsDB.Scale(xoff), 0)
			b.frame:Show()


			idx = idx + 1
		end
	end

	for _, i in ipairs(bs) do
		local x = GetContainerNumSlots(i)
		if x > 0 then
			if not self.bags[i] then
				self.bags[i] = self:BagNew(i, f)
			end

			slots = slots + GetContainerNumSlots(i)
		end
	end

	rows = floor (slots / cols)
	if (slots % cols) ~= 0 then
		rows = rows + 1
	end

	f:SetWidth(SettingsDB.Scale(cols * SettingsCF["bag"].button_size + (cols - 1) * SettingsCF["bag"].button_space + 10 * 2)) 
	f:SetHeight(SettingsDB.Scale(rows * SettingsCF["bag"].button_size + (rows - 1) * SettingsCF["bag"].button_space + off + 10 * 2))

	local idx = 0
	for _, i in ipairs(bs) do
		local bag_cnt = GetContainerNumSlots(i)

		if bag_cnt > 0 then
			self.bags[i] = self:BagNew(i, f)
			local bagType = self.bags[i].bagType

			self.bags[i]:Show()
			for j = 1, bag_cnt do
				local b, isnew = self:SlotNew (i, j)
				local xoff
				local yoff
				local x = (idx % cols)
				local y = floor(idx / cols)

				if isnew then
					table.insert(self.buttons, idx + 1, b)
				end

				xoff = 10 + (x * SettingsCF["bag"].button_size)	+ (x * SettingsCF["bag"].button_space)
				yoff = off + 10 + (y * SettingsCF["bag"].button_size) + ((y - 1) * SettingsCF["bag"].button_space)
				yoff = yoff * -1

				b.frame:ClearAllPoints()
				b.frame:SetPoint("TOPLEFT", f, "TOPLEFT", SettingsDB.Scale(xoff), SettingsDB.Scale(yoff))
				b.frame:SetHeight(SettingsDB.Scale(SettingsCF["bag"].button_size))
				b.frame:SetWidth(SettingsDB.Scale(SettingsCF["bag"].button_size))
				b.frame:SetPushedTexture("")
				b.frame:SetNormalTexture("")
				b.frame:Show()
				SettingsDB.CreateTemplate(b.frame)
				b.frame:SetBackdropColor(0, 0, 0, 0.5) -- we just need border with SetTemplate, not the backdrop. Hopefully this will fix invisible item that some users have.
				SettingsDB.StyleButton(b.frame, false)
				
				-- Color profession bag slot border ~yellow
				if bagType == ST_SPECIAL then b.frame:SetBackdropBorderColor(1, 0.9, 0.3) b.frame.lock = true end
				
				self:SlotUpdate(b)
				
				local iconTex = _G[b.frame:GetName() .. "IconTexture"]
				iconTex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				iconTex:SetPoint("TOPLEFT", b.frame, SettingsDB.Scale(2), SettingsDB.Scale(-2))
				iconTex:SetPoint("BOTTOMRIGHT", b.frame, SettingsDB.Scale(-2), SettingsDB.Scale(2))
				
				local ButCount = _G[b.frame:GetName().."Count"]
				ButCount:SetFont(SettingsCF["media"].pixel_font, SettingsCF["media"].pixel_font_size, SettingsCF["media"].pixel_font_style)
				ButCount:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(1), SettingsDB.Scale(1))

				iconTex:Show()
				b.iconTex = iconTex
				
				idx = idx + 1
			end
		end
	end
end

function Stuffing:SetBagsForSorting(c)
	Stuffing_Open()

	self.sortBags = {}

	local cmd = ((c == nil or c == "") and {"d"} or {strsplit("/", c)})

	for _, s in ipairs(cmd) do
		if s == "c" then
			self.sortBags = {}
		elseif s == "d" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(bags_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(bags_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		elseif s == "p" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(bags_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(bags_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		else
			if tonumber(s) == nil then
				Print(string.format(L["Error: don't know what \"%s\" means."], s))
			end

			table.insert(self.sortBags, tonumber(s))
		end
	end

	local bids = L_BAG_BAGS_BIDS
	for _, i in ipairs(self.sortBags) do
		bids = bids .. i .. " "
	end

	Print(bids)
end

-- Slash command handler
local function StuffingSlashCmd(Cmd)
	local cmd, args = strsplit(" ", Cmd:lower(), 2)

	if cmd == "config" then
		Stuffing_OpenConfig()
	elseif cmd == "sort" then
		Stuffing_Sort(args)
	elseif cmd == "psort" then
		Stuffing_Sort("c/p")
	elseif cmd == "stack" then
		Stuffing:SetBagsForSorting(args)
		Stuffing:Restack()
	elseif cmd == "test" then
		Stuffing:SetBagsForSorting(args)
	elseif cmd == "purchase" then
		-- XXX
		if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			local cnt, full = GetNumBankSlots()
			if full then
				Print(L_BAG_NO_SLOTS)
				return
			end

			if args == "yes" then
				PurchaseSlot()
				return
			end

			Print(string.format(L_BAG_COSTS, GetBankSlotCost() / 10000))
			Print(L_BAG_BUY_SLOTS)
		else
			Print(L_BAG_OPEN_BANK)
		end
	else
		Print("sort - " .. L_BAG_SORT)
		Print("stack - " .. L_BAG_STACK)
		Print("purchase - " .. L_BAG_BUY_BANKS_SLOT)
	end
end

function Stuffing:ADDON_LOADED(addon)
	if addon ~= "ShestakUI" then
		return nil
	end

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("ITEM_LOCK_CHANGED")

	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")

	self:RegisterEvent("BAG_CLOSED")

	SlashCmdList["STUFFING"] = StuffingSlashCmd
	SLASH_STUFFING1 = "/bags"

	self:InitBags()
	
	tinsert(UISpecialFrames,"StuffingFrameBags")

	ToggleBackpack = Stuffing_Toggle
	ToggleBag = Stuffing_ToggleBag
	OpenAllBags = Stuffing_Toggle
	OpenBackpack = Stuffing_Open
	CloseAllBags = Stuffing_Close
	CloseBackpack = Stuffing_Close

	BankFrame:UnregisterAllEvents()
end

function Stuffing:PLAYER_ENTERING_WORLD()
	-- please don't do anything after 1 player_entering_world event.
	Stuffing:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- hooking and setting key ring bag
	-- this is just a reskin of Blizzard key bag to fit Tukui
	-- hooking OnShow because sometime key max slot changes.
	ContainerFrame1:HookScript("OnShow", function(self)
		local keybackdrop = CreateFrame("Frame", nil, self)
		keybackdrop:SetPoint("TOPLEFT", SettingsDB.Scale(9), SettingsDB.Scale(-40))
		keybackdrop:SetPoint("BOTTOMLEFT", 0, 0)
		keybackdrop:SetSize(SettingsDB.Scale(179),SettingsDB.Scale(215))
		SettingsDB.CreateTemplate(keybackdrop)
		ContainerFrame1CloseButton:Hide()
		ContainerFrame1Portrait:Hide()
		ContainerFrame1Name:Hide()
		ContainerFrame1BackgroundTop:SetAlpha(0)
		ContainerFrame1BackgroundMiddle1:SetAlpha(0)
		ContainerFrame1BackgroundMiddle2:SetAlpha(0)
		ContainerFrame1BackgroundBottom:SetAlpha(0)
		for i=1, GetKeyRingSize() do
			local slot = _G["ContainerFrame1Item"..i]
			local t = _G["ContainerFrame1Item"..i.."IconTexture"]
			slot:SetPushedTexture("")
			slot:SetNormalTexture("")
			t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			t:SetPoint("TOPLEFT", slot, SettingsDB.Scale(2), SettingsDB.Scale(-2))
			t:SetPoint("BOTTOMRIGHT", slot, SettingsDB.Scale(-2), SettingsDB.Scale(2))
			SettingsDB.CreateTemplate(slot)
			slot:SetBackdropColor(0, 0, 0, 0.5)
			SettingsDB.StyleButton(slot, false)
		end
		self:ClearAllPoints()
		self:SetPoint("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", SettingsDB.Scale(4), SettingsDB.Scale(5))
	end)
end

function Stuffing:PLAYERBANKSLOTS_CHANGED(id)
	if id > 28 then
		for _, v in ipairs(self.bagframe_buttons) do
			if v.frame and v.frame.GetInventorySlot then

				BankFrameItemButton_Update(v.frame)
				BankFrameItemButton_UpdateLocked(v.frame)

				if not v.frame.tooltipText then
					v.frame.tooltipText = ""
				end
			end
		end
	end

	if self.bankFrame and self.bankFrame:IsShown() then
		self:BagSlotUpdate(-1)
	end
end

function Stuffing:BAG_UPDATE(id)
	self:BagSlotUpdate(id)
end

function Stuffing:ITEM_LOCK_CHANGED(bag, slot)
	if slot == nil then
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			self:SlotUpdate(v)
			break
		end
	end
end

function Stuffing:BANKFRAME_OPENED()
	Stuffing_Open()
	
	if not self.bankFrame then
		self:InitBank()
	end

	self:Layout(true)
	for _, x in ipairs(bags_BANK) do
		self:BagSlotUpdate(x)
	end
	self.bankFrame:Show()
end

function Stuffing:BANKFRAME_CLOSED()
	if not self.bankFrame then
		return
	end

	self.bankFrame:Hide()
end

function Stuffing:BAG_CLOSED(id)
	local b = self.bags[id]
	if b then
		table.remove(self.bags, id)
		b:Hide()
		table.insert (trashBag, #trashBag + 1, b)
	end

	while true do
		local changed = false

		for i, v in ipairs(self.buttons) do
			if v.bag == id then
				v.frame:Hide()
				v.iconTex:Hide()

				table.insert (trashButton, #trashButton + 1, v.frame)
				table.remove(self.buttons, i)

				v = nil
				changed = true
			end
		end

		if not changed then
			break
		end
	end
end

function Stuffing:SortOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	if not self.itmax then
		self.itmax = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then
		return
	end

	self.elapsed = 0
	self.itmax = self.itmax + 1

	local changed, blocked  = false, false

	if self.sortList == nil or next(self.sortList, nil) == nil then
		-- wait for all item locks to be released.
		local locks = false

		for i, v in pairs(self.buttons) do
			local _, _, l = GetContainerItemInfo(v.bag, v.slot)
			if l then
				locks = true
			else
				v.block = false
			end
		end

		if locks then
			-- something still locked. wait some more.
			return
		else
			-- all unlocked. get a new table.
			self:SetScript("OnUpdate", nil)
			self:SortBags()

			if self.sortList == nil then
				return
			end
		end
	end

	-- go through the list and move stuff if we can.
	for i, v in ipairs (self.sortList) do
		repeat
			if v.ignore then
				blocked = true
				break
			end

			if v.srcSlot.block then
				changed = true
				break
			end

			if v.dstSlot.block then
				changed = true
				break
			end

			local _, _, l1 = GetContainerItemInfo(v.dstSlot.bag, v.dstSlot.slot)
			local _, _, l2 = GetContainerItemInfo(v.srcSlot.bag, v.srcSlot.slot)

			if l1 then
				v.dstSlot.block = true
			end

			if l2 then
				v.srcSlot.block = true
			end

			if l1 or l2 then
				break
			end

			if v.sbag ~= v.dbag or v.sslot ~= v.dslot then
				if v.srcSlot.name ~= v.dstSlot.name then
					v.srcSlot.block = true
					v.dstSlot.block = true
					PickupContainerItem (v.sbag, v.sslot)
					PickupContainerItem (v.dbag, v.dslot)
					changed = true
					break
				end
			end
		until true
	end

	self.sortList = nil

	if (not changed and not blocked) or self.itmax > 250 then
		self:SetScript("OnUpdate", nil)
		self.sortList = nil
		Print (L_BAG_SORTING_BAGS)
	end
end

local function InBags(x)
	if not Stuffing.bags[x] then
		return false
	end

	for _, v in ipairs(Stuffing.sortBags) do
		if x == v then
			return true
		end
	end
	return false
end

function Stuffing:SortBags()
	if (UnitAffectingCombat("player")) then return end
	local bs = self.sortBags
	if #bs < 1 then
		Print (L_BAG_NOTHING_SORT)
		return
	end

	local st = {}
	local bank = false

	Stuffing_Open()

	for i, v in pairs(self.buttons) do
		if InBags(v.bag) then
			self:SlotUpdate(v)

			if v.name then
				local tex, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
				local n, _, q, iL, rL, c1, c2, _, Sl = GetItemInfo(clink)
				table.insert(st, {
					srcSlot = v,
					sslot = v.slot,
					sbag = v.bag,
					sort = q .. c1 .. c2 .. rL .. n .. iL .. Sl .. (#self.buttons - i),
				})
			end
		end
	end

	-- Sort them
	table.sort (st, function(a, b)
		return a.sort > b.sort
	end)

	-- For each button we want to sort, get a destination button
	local st_idx = #bs
	local dbag = bs[st_idx]
	local dslot = GetContainerNumSlots(dbag)
 
	for i, v in ipairs (st) do
		v.dbag = dbag
		v.dslot = dslot
		v.dstSlot = self:SlotNew(dbag, dslot)
 
		dslot = dslot - 1
 
		if dslot == 0 then
			while true do
				st_idx = st_idx - 1
 
				if st_idx < 0 then
					break
				end
 
				dbag = bs[st_idx]
 
				if Stuffing:BagType(dbag) == ST_NORMAL or Stuffing:BagType(dbag) == ST_SPECIAL or dbag < 1 then
					break
				end
			end
 
			dslot = GetContainerNumSlots(dbag)
		end
	end

	-- throw various stuff out of the search list
	local changed = true
	while changed do
		changed = false
		-- XXX why doesn't this remove all x->x moves in one pass?

		for i, v in ipairs (st) do

			-- source is same as destination
			if (v.sslot == v.dslot) and (v.sbag == v.dbag) then
				table.remove (st, i)
				changed = true
			end
		end
	end

	-- kick off moving of stuff, if needed.
	if st == nil or next(st, nil) == nil then
		Print(L_BAG_SORTING_BAGS)
		self:SetScript("OnUpdate", nil)
	else
		self.sortList = st
		self:SetScript("OnUpdate", Stuffing.SortOnUpdate)
	end
end

function Stuffing:RestackOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then
		return
	end

	self.elapsed = 0
	self:Restack()
end

function Stuffing:Restack()
	local st = {}

	Stuffing_Open()

	for i, v in pairs(self.buttons) do
		if InBags(v.bag) then
			local tex, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
			if clink then
				local n, _, _, _, _, _, _, s = GetItemInfo(clink)

				if cnt ~= s then
					if not st[n] then
						st[n] = {{
							item = v,
							size = cnt,
							max = s
						}}
					else
						table.insert(st[n], {
							item = v,
							size = cnt,
							max = s
						})
					end
				end
			end
		end
	end

	local did_restack = false

	for i, v in pairs(st) do
		if #v > 1 then
			for j = 2, #v, 2 do
				local a, b = v[j - 1], v[j]
				local _, _, l1 = GetContainerItemInfo(a.item.bag, a.item.slot)
				local _, _, l2 = GetContainerItemInfo(b.item.bag, b.item.slot)

				if l1 or l2 then
					did_restack = true
				else
					PickupContainerItem (a.item.bag, a.item.slot)
					PickupContainerItem (b.item.bag, b.item.slot)
					did_restack = true
				end
			end
		end
	end

	if did_restack then
		self:SetScript("OnUpdate", Stuffing.RestackOnUpdate)
	else
		self:SetScript("OnUpdate", nil)
		Print (L_BAG_STACK_END)
	end
end

function Stuffing.Menu(self, level)
	if not level then
		return
	end

	local info = self.info

	wipe(info)

	if level ~= 1 then
		return
	end

	wipe(info)
	info.text = L_BAG_SORT_MENU
	info.notCheckable = 1
	info.func = function()
		Stuffing_Sort("d")
	end
	UIDropDownMenu_AddButton(info, level)
	
	wipe(info)
	info.text = L_BAG_SORT_SPECIAL
	info.notCheckable = 1
	info.func = function()
		Stuffing_Sort("c/p")
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_STACK_MENU
	info.notCheckable = 1
	info.func = function()
		Stuffing:SetBagsForSorting("d")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)
	
	wipe(info)
	info.text = L_BAG_STACK_SPECIAL
	info.notCheckable = 1
	info.func = function()
		Stuffing:SetBagsForSorting("c/p")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_SHOW_BAGS
	info.checked = function()
		return bag_bars == 1
	end

	info.func = function()
		if bag_bars == 1 then
			bag_bars = 0
		else
			bag_bars = 1
		end
		Stuffing:Layout()
		if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			Stuffing:Layout(true)
		end

	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.disabled = nil
	info.notCheckable = 1
	info.text = CLOSE
	info.func = self.HideMenu
	info.tooltipTitle = CLOSE
	UIDropDownMenu_AddButton(info, level)
end