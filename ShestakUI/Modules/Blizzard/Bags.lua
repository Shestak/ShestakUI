local T, C, L, _ = unpack(select(2, ...))
if C.bag.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on Stuffing(by Hungtar, editor Tukz)
----------------------------------------------------------------------------------------
local BAGS_BACKPACK = {0, 1, 2, 3, 4}
local BAGS_BANK = {-1, 5, 6, 7, 8, 9, 10, 11}
local ST_NORMAL = 1
local ST_FISHBAG = 2
local ST_SPECIAL = 3
local bag_bars = 0
local unusable

if T.class == "DEATHKNIGHT" then
	unusable = {{3, 4, 10, 11, 13, 14, 15, 16}, {6}}
elseif T.class == "DRUID" then
	unusable = {{1, 2, 3, 4, 8, 9, 14, 15, 16}, {4, 5, 6}, true}
elseif T.class == "HUNTER" then
	unusable = {{5, 6, 16}, {5, 6}}
elseif T.class == "MAGE" then
	unusable = {{1, 2, 3, 4, 5, 6, 7, 9, 11, 14, 15}, {3, 4, 5, 6}, true}
elseif T.class == "MONK" then
	unusable = {{2, 3, 4, 6, 9, 13, 14, 15, 16}, {4, 5, 6}}
elseif T.class == "PALADIN" then
	unusable = {{3, 4, 10, 11, 13, 14, 15, 16}, {}, true}
elseif T.class == "PRIEST" then
	unusable = {{1, 2, 3, 4, 6, 7, 8, 9, 11, 14, 15}, {3, 4, 5, 6}, true}
elseif T.class == "ROGUE" then
	unusable = {{2, 6, 7, 9, 10, 16}, {4, 5, 6}}
elseif T.class == "SHAMAN" then
	unusable = {{3, 4, 7, 8, 9, 14, 15, 16}, {5}}
elseif T.class == "WARLOCK" then
	unusable = {{1, 2, 3, 4, 5, 6, 7, 9, 11, 14, 15}, {3, 4, 5, 6}, true}
elseif T.class == "WARRIOR" then
	unusable = {{16}, {}}
end

for class = 1, 2 do
	local subs = {GetAuctionItemSubClasses(class)}
	for i, subclass in ipairs(unusable[class]) do
		unusable[subs[subclass]] = true
	end
	unusable[class] = nil
	subs = nil
end

local function IsClassUnusable(subclass, slot)
	if subclass then
		return unusable[subclass] or slot == "INVTYPE_WEAPONOFFHAND" and unusable[3]
	end
end

local function IsItemUnusable(...)
	if ... then
		local subclass, _, slot = select(7, GetItemInfo(...))
		return IsClassUnusable(subclass, slot)
	end
end

-- Hide bags options in default interface
InterfaceOptionsDisplayPanelShowFreeBagSpace:Hide()

Stuffing = CreateFrame("Frame", nil, UIParent)
Stuffing:RegisterEvent("ADDON_LOADED")
Stuffing:RegisterEvent("PLAYER_ENTERING_WORLD")
Stuffing:SetScript("OnEvent", function(this, event, ...)
	if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") or IsAddOnLoaded("BaudBag") then return end
	Stuffing[event](this, ...)
end)

-- Drop down menu stuff from Postal
local Stuffing_DDMenu = CreateFrame("Frame", "StuffingDropDownMenu")
Stuffing_DDMenu.displayMode = "MENU"
Stuffing_DDMenu.info = {}
Stuffing_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == Stuffing_DDMenu then
		CloseDropDownMenus()
	end
end

local function Stuffing_OnShow()
	Stuffing:PLAYERBANKSLOTS_CHANGED(29)

	for i = 0, #BAGS_BACKPACK - 1 do
		Stuffing:BAG_UPDATE(i)
	end

	Stuffing:Layout()
	Stuffing:SearchReset()
	PlaySound("igBackPackOpen")
	collectgarbage("collect")
end

local function StuffingBank_OnHide()
	CloseBankFrame()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	end
	PlaySound("igBackPackClose")
end

local function Stuffing_OnHide()
	if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		Stuffing.bankFrame:Hide()
	end
	PlaySound("igBackPackClose")
end

local function Stuffing_Open()
	if not Stuffing.frame:IsShown() then
		Stuffing.frame:Show()
	end
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

-- Bag slot stuff
local trashButton = {}
local trashBag = {}

function Stuffing:SlotUpdate(b)
	local texture, count, locked = GetContainerItemInfo(b.bag, b.slot)
	local clink = GetContainerItemLink(b.bag, b.slot)
	local isQuestItem, questId = GetContainerItemQuestInfo(b.bag, b.slot)

	-- Set all slot color to default ShestakUI on update
	if not b.frame.lock then
		b.frame:SetBackdropBorderColor(unpack(C.media.border_color))
	end

	if b.cooldown and StuffingFrameBags and StuffingFrameBags:IsShown() then
		local start, duration, enable = GetContainerItemCooldown(b.bag, b.slot)
		CooldownFrame_SetTimer(b.cooldown, start, duration, enable)
	end

	if clink then
		b.name, _, b.rarity, _, b.level = GetItemInfo(clink)

		if (IsItemUnusable(clink) or b.level and b.level > T.level) and not locked then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		else
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 1, 1)
		end

		-- Color slot according to item quality
		if not b.frame.lock and b.rarity and b.rarity > 1 and not (isQuestItem or questId) then
			b.frame:SetBackdropBorderColor(GetItemQualityColor(b.rarity))
		elseif isQuestItem or questId then
			b.frame:SetBackdropBorderColor(1, 1, 0)
		end
	else
		b.name, b.rarity, b.level = nil, nil, nil
	end

	SetItemButtonTexture(b.frame, texture)
	SetItemButtonCount(b.frame, count)
	SetItemButtonDesaturated(b.frame, locked)

	b.frame:Show()
end

function Stuffing:BagSlotUpdate(bag)
	if not self.buttons then
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.bag == bag then
			self:SlotUpdate(v)
		end
	end
end

function CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame("Frame", "StuffingFrameReagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((C.bag.button_size + C.bag.button_space) * C.bag.bank_columns) + 17)
	Reagent:SetPoint("TOPLEFT", _G["StuffingFrameBank"], "TOPLEFT", 0, 0)
	Reagent:SetTemplate("Transparent")
	Reagent:SetFrameStrata(_G["StuffingFrameBank"]:GetFrameStrata())
	Reagent:SetFrameLevel(_G["StuffingFrameBank"]:GetFrameLevel() + 5)
	Reagent:EnableMouse(true)
	Reagent:SetMovable(true)
	Reagent:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and button == "LeftButton" then
			self:StartMoving()
		end
	end)
	Reagent:SetScript("OnMouseUp", Reagent.StopMovingOrSizing)

	SwitchBankButton:SetSize(80, 20)
	SwitchBankButton:SkinButton()
	SwitchBankButton:SetPoint("TOPLEFT", 10, -4)
	SwitchBankButton:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
	SwitchBankButton.text:SetPoint("CENTER")
	SwitchBankButton.text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		_G["StuffingFrameBank"]:Show()
		_G["StuffingFrameBank"]:SetAlpha(1)
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		PlaySound("igBackPackOpen")
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:SetSize(170, 20)
	Deposit:SetPoint("TOPLEFT", SwitchBankButton, "TOPRIGHT", 3, 0)
	Deposit:SkinButton()
	Deposit:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
	Deposit.text:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
	Deposit.text:SetTextColor(1, 1, 1)
	Deposit.text:SetText(REAGENTBANK_DEPOSIT)
	Deposit:SetFontString(Deposit.text)

	-- Close button
	local Close = CreateFrame("Button", "StuffingCloseButtonReagent", Reagent, "UIPanelCloseButton")
	T.SkinCloseButton(Close, nil, nil, true)
	Close:SetSize(15, 15)
	Close:RegisterForClicks("AnyUp")
	Close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		else
			StuffingBank_OnHide()
		end
	end)

	for i = 1, 98 do
		local button = _G["ReagentBankFrameItem" .. i]
		local icon = _G[button:GetName() .. "IconTexture"]
		local count = _G[button:GetName().."Count"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		button:StyleButton()
		button:SetTemplate("Default")
		button:SetNormalTexture(nil)
		button.IconBorder:SetAlpha(0)

		button:ClearAllPoints()
		button:SetSize(C.bag.button_size, C.bag.button_size)

		if i == 1 then
			button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -27)
			LastRowButton = button
			LastButton = button
		elseif NumButtons == C.bag.bank_columns then
			button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C.bag.button_space + C.bag.button_size))
			button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C.bag.button_space + C.bag.button_size))
			LastRowButton = button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C.bag.button_space + C.bag.button_size), 0)
			button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C.bag.button_space + C.bag.button_size), 0)
			NumButtons = NumButtons + 1
		end

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		count:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		count:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
		count:SetPoint("BOTTOMRIGHT", 1, 1)

		LastButton = button
	end
	Reagent:SetHeight(((C.bag.button_size + C.bag.button_space) * (NumRows + 1) + 40) - C.bag.button_space)

	MoneyFrame_Update(ReagentBankFrame.UnlockInfo.CostMoneyFrame, GetReagentBankCost())
	ReagentBankFrameUnlockInfo:StripTextures()
	ReagentBankFrameUnlockInfo:SetAllPoints(Reagent)
	ReagentBankFrameUnlockInfo:SetTemplate("Overlay")
	ReagentBankFrameUnlockInfoPurchaseButton:SkinButton()
end

function Stuffing:BagFrameSlotNew(p, slot)
	for _, v in ipairs(self.bagframe_buttons) do
		if v.slot == slot then
			return v, false
		end
	end

	local ret = {}

	if slot > 3 then
		ret.slot = slot
		slot = slot - 4
		ret.frame = CreateFrame("CheckButton", "StuffingBBag"..slot.."Slot", p, "BankItemButtonBagTemplate")
		ret.frame:StripTextures()
		ret.frame:SetID(slot)
		table.insert(self.bagframe_buttons, ret)

		BankFrameItemButton_Update(ret.frame)
		BankFrameItemButton_UpdateLocked(ret.frame)

		if not ret.frame.tooltipText then
			ret.frame.tooltipText = ""
		end
	else
		ret.frame = CreateFrame("CheckButton", "StuffingFBag"..slot.."Slot", p, "BagSlotButtonTemplate")
		ret.frame:StripTextures()
		ret.slot = slot
		table.insert(self.bagframe_buttons, ret)
	end

	ret.frame:SetTemplate("Default")
	ret.frame:StyleButton()
	ret.frame:SetNormalTexture("")
	ret.frame:SetCheckedTexture("")

	ret.icon = _G[ret.frame:GetName().."IconTexture"]
	ret.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	ret.icon:SetPoint("TOPLEFT", ret.frame, 2, -2)
	ret.icon:SetPoint("BOTTOMRIGHT", ret.frame, -2, 2)

	return ret
end

function Stuffing:SlotNew(bag, slot)
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			v.lock = false
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
			else
				v:Hide()
			end
		end

		if f ~= -1 then
			ret.frame = trashButton[f]
			table.remove(trashButton, f)
			ret.frame:Show()
		end
	end

	if not ret.frame then
		ret.frame = CreateFrame("Button", "StuffingBag"..bag.."_"..slot, self.bags[bag], tpl)
		ret.frame:StyleButton()
		ret.frame:SetTemplate("Default")
		ret.frame:SetNormalTexture(nil)

		ret.icon = _G[ret.frame:GetName().."IconTexture"]
		ret.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		ret.icon:SetPoint("TOPLEFT", ret.frame, 2, -2)
		ret.icon:SetPoint("BOTTOMRIGHT", ret.frame, -2, 2)

		ret.count = _G[ret.frame:GetName().."Count"]
		ret.count:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		ret.count:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
		ret.count:SetPoint("BOTTOMRIGHT", 1, 1)

		local Battlepay = _G[ret.frame:GetName()].BattlepayItemTexture
		if Battlepay then
			Battlepay:SetAlpha(0)
		end
	end

	ret.bag = bag
	ret.slot = slot
	ret.frame:SetID(slot)

	ret.cooldown = _G[ret.frame:GetName().."Cooldown"]
	ret.cooldown:Show()

	self:SlotUpdate(ret)

	return ret, true
end

-- From OneBag
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400 + 0x10000
local BAGTYPE_FISHING = 32768

function Stuffing:BagType(bag)
	local bagType = select(2, GetContainerNumFreeSlots(bag))

	if bagType and bit.band(bagType, BAGTYPE_FISHING) > 0 then
		return ST_FISHBAG
	elseif bagType and bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return ST_SPECIAL
	end

	return ST_NORMAL
end

function Stuffing:BagNew(bag, f)
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

	ret = CreateFrame("Frame", "StuffingBag"..bag, f)
	ret.bagType = self:BagType(bag)

	ret:SetID(bag)
	return ret
end

function Stuffing:SearchUpdate(str)
	str = string.lower(str)

	for _, b in ipairs(self.buttons) do
		if b.frame and not b.name then
			b.frame:SetAlpha(0.2)
		end
		if b.name then
			local _, setName = GetContainerItemEquipmentSetInfo(b.bag, b.slot)
			setName = setName or ""
			local ilink = GetContainerItemLink(b.bag, b.slot)
			local class, subclass, _, equipSlot = select(6, GetItemInfo(ilink))
			local minLevel = select(5, GetItemInfo(ilink))
			equipSlot = _G[equipSlot] or ""
			if not string.find(string.lower(b.name), str) and not string.find(string.lower(setName), str) and not string.find(string.lower(class), str) and not string.find(string.lower(subclass), str) and not string.find(string.lower(equipSlot), str) then
				if IsItemUnusable(b.name) or minLevel > T.level then
					_G[b.frame:GetName().."IconTexture"]:SetVertexColor(0.5, 0.5, 0.5)
				end
				SetItemButtonDesaturated(b.frame, true)
				b.frame:SetAlpha(0.2)
			else
				if IsItemUnusable(b.name) or minLevel > T.level then
					_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
				end
				SetItemButtonDesaturated(b.frame, false)
				b.frame:SetAlpha(1)
			end
		end
	end
end

function Stuffing:SearchReset()
	for _, b in ipairs(self.buttons) do
		if IsItemUnusable(b.name) or (b.level and b.level > T.level) then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		end
		b.frame:SetAlpha(1)
		SetItemButtonDesaturated(b.frame, false)
	end
end

function Stuffing:CreateBagFrame(w)
	local n = "StuffingFrame"..w
	local f = CreateFrame("Frame", n, UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetFrameStrata("DIALOG")
	f:SetFrameLevel(5)
	f:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and button == "LeftButton" then
			self:StartMoving()
		end
	end)
	f:SetScript("OnMouseUp", f.StopMovingOrSizing)

	if w == "Bank" then
		f:SetPoint(unpack(C.position.bank))
	else
		f:SetPoint(unpack(C.position.bag))
	end

	if w == "Bank" then
		-- Reagent button
		f.b_reagent = CreateFrame("Button", "StuffingReagentButton"..w, f)
		f.b_reagent:SetSize(105, 20)
		f.b_reagent:SetPoint("TOPLEFT", 10, -4)
		f.b_reagent:RegisterForClicks("AnyUp")
		f.b_reagent:SkinButton()
		f.b_reagent:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			PlaySound("igBackPackOpen")
			if not ReagentBankFrame.isMade then
				CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				_G["StuffingFrameReagent"]:Show()
			end
			_G["StuffingFrameBank"]:SetAlpha(0)
		end)
		f.b_reagent:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		f.b_reagent.text:SetPoint("CENTER")
		f.b_reagent.text:SetText(REAGENT_BANK)
		f.b_reagent:SetFontString(f.b_reagent.text)

		-- Buy button
		f.b_purchase = CreateFrame("Button", "StuffingPurchaseButton"..w, f)
		f.b_purchase:SetSize(80, 20)
		f.b_purchase:SetPoint("TOPLEFT", f.b_reagent, "TOPRIGHT", 3, 0)
		f.b_purchase:RegisterForClicks("AnyUp")
		f.b_purchase:SkinButton()
		f.b_purchase:SetScript("OnClick", function(self) StaticPopup_Show("CONFIRM_BUY_BANK_SLOT") end)
		f.b_purchase:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		f.b_purchase.text:SetPoint("CENTER")
		f.b_purchase.text:SetText(BANKSLOTPURCHASE)
		f.b_purchase:SetFontString(f.b_purchase.text)
		local _, full = GetNumBankSlots()
		if full then
			f.b_purchase:Hide()
		else
			f.b_purchase:Show()
		end
	end

	-- Close button
	f.b_close = CreateFrame("Button", "StuffingCloseButton"..w, f, "UIPanelCloseButton")
	T.SkinCloseButton(f.b_close, nil, nil, true)
	f.b_close:SetSize(15, 15)
	f.b_close:RegisterForClicks("AnyUp")
	f.b_close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		end
		self:GetParent():Hide()
	end)

	-- Create the bags frame
	local fb = CreateFrame("Frame", n.."BagsFrame", f)
	fb:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 3)
	fb:SetFrameStrata("MEDIUM")
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
	if self.frame then return end

	self.buttons = {}
	self.bags = {}
	self.bagframe_buttons = {}

	local f = self:CreateBagFrame("Bags")
	f:SetScript("OnShow", Stuffing_OnShow)
	f:SetScript("OnHide", Stuffing_OnHide)

	-- Search editbox (tekKonfigAboutPanel.lua)
	local editbox = CreateFrame("EditBox", nil, f)
	editbox:Hide()
	editbox:SetAutoFocus(true)
	editbox:SetHeight(32)
	editbox:CreateBackdrop("Default")
	editbox.backdrop:SetPoint("TOPLEFT", -2, 1)
	editbox.backdrop:SetPoint("BOTTOMRIGHT", 2, -1)

	local resetAndClear = function(self)
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
	detail:SetPoint("TOPLEFT", f, 11, -10)
	detail:SetPoint("RIGHT", f, -140, -10)
	detail:SetHeight(13)
	detail:SetShadowColor(0, 0, 0, 0)
	detail:SetJustifyH("LEFT")
	detail:SetText("|cff9999ff"..SEARCH.."|r")
	editbox:SetAllPoints(detail)

	local button = CreateFrame("Button", nil, f)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAllPoints(detail)
	button:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			self:GetParent().detail:Hide()
			self:GetParent().editbox:Show()
			self:GetParent().editbox:HighlightText()
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

	local tooltip_show = function(self)
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

function Stuffing:Layout(isBank)
	local slots = 0
	local rows = 0
	local off = 20
	local cols, f, bs

	if isBank then
		bs = BAGS_BANK
		cols = C.bag.bank_columns
		f = self.bankFrame
		f:SetAlpha(1)
	else
		bs = BAGS_BACKPACK
		cols = C.bag.bag_columns
		f = self.frame

		f.editbox:SetFont(C.media.normal_font, C.font.bags_font_size + 3)
		f.detail:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		f.detail:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)

		f.detail:ClearAllPoints()
		f.detail:SetPoint("TOPLEFT", f, 12, -8)
		f.detail:SetPoint("RIGHT", f, -140, 0)
	end

	f:SetClampedToScreen(1)
	f:SetTemplate("Transparent")

	-- Bag frame stuff
	local fb = f.bags_frame
	if bag_bars == 1 then
		fb:SetClampedToScreen(1)
		fb:SetTemplate("Transparent")

		local bsize = C.bag.button_size

		local w = 2 * 10
		w = w + ((#bs - 1) * bsize)
		w = w + ((#bs - 2) * 4)

		fb:SetHeight(2 * 10 + bsize)
		fb:SetWidth(w)
		fb:Show()
	else
		fb:Hide()
	end

	local idx = 0
	for _, v in ipairs(bs) do
		if (not isBank and v <= 3 ) or (isBank and v ~= -1) then
			local bsize = C.bag.button_size
			local b = self:BagFrameSlotNew(fb, v)
			local xoff = 10

			xoff = xoff + (idx * bsize)
			xoff = xoff + (idx * 4)

			b.frame:ClearAllPoints()
			b.frame:SetPoint("LEFT", fb, "LEFT", xoff, 0)
			b.frame:SetSize(bsize, bsize)

			local btns = self.buttons
			b.frame:HookScript("OnEnter", function(self)
				local bag
				if isBank then bag = v else bag = v + 1 end

				for ind, val in ipairs(btns) do
					if val.bag == bag then
						val.frame:SetAlpha(1)
					else
						val.frame:SetAlpha(0.2)
					end
				end
			end)

			b.frame:HookScript("OnLeave", function(self)
				for _, btn in ipairs(btns) do
					btn.frame:SetAlpha(1)
				end
			end)

			b.frame:SetScript("OnClick", nil)

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

	rows = floor(slots / cols)
	if (slots % cols) ~= 0 then
		rows = rows + 1
	end

	f:SetWidth(cols * C.bag.button_size + (cols - 1) * C.bag.button_space + 10 * 2)
	f:SetHeight(rows * C.bag.button_size + (rows - 1) * C.bag.button_space + off + 10 * 2)

	local idx = 0
	for _, i in ipairs(bs) do
		local bag_cnt = GetContainerNumSlots(i)
		local specialType = select(2, GetContainerNumFreeSlots(i))
		if bag_cnt > 0 then
			self.bags[i] = self:BagNew(i, f)
			local bagType = self.bags[i].bagType

			self.bags[i]:Show()
			for j = 1, bag_cnt do
				local b, isnew = self:SlotNew(i, j)
				local xoff
				local yoff
				local x = (idx % cols)
				local y = floor(idx / cols)

				if isnew then
					table.insert(self.buttons, idx + 1, b)
				end

				xoff = 10 + (x * C.bag.button_size) + (x * C.bag.button_space)
				yoff = off + 10 + (y * C.bag.button_size) + ((y - 1) * C.bag.button_space)
				yoff = yoff * -1

				b.frame:ClearAllPoints()
				b.frame:SetPoint("TOPLEFT", f, "TOPLEFT", xoff, yoff)
				b.frame:SetSize(C.bag.button_size, C.bag.button_size)
				b.frame.lock = false
				b.frame:SetAlpha(1)

				if bagType == ST_FISHBAG then
					b.frame:SetBackdropBorderColor(1, 0, 0)	-- Tackle
					b.frame.lock = true
				elseif bagType == ST_SPECIAL then
					if specialType == 0x0008 then			-- Leatherworking
						b.frame:SetBackdropBorderColor(0.8, 0.7, 0.3)
					elseif specialType == 0x0010 then		-- Inscription
						b.frame:SetBackdropBorderColor(0.3, 0.3, 0.8)
					elseif specialType == 0x0020 then		-- Herbs
						b.frame:SetBackdropBorderColor(0.3, 0.7, 0.3)
					elseif specialType == 0x0040 then		-- Enchanting
						b.frame:SetBackdropBorderColor(0.6, 0, 0.6)
					elseif specialType == 0x0080 then		-- Engineering
						b.frame:SetBackdropBorderColor(0.9, 0.4, 0.1)
					elseif specialType == 0x0200 then		-- Gems
						b.frame:SetBackdropBorderColor(0, 0.7, 0.8)
					elseif specialType == 0x0400 then		-- Mining
						b.frame:SetBackdropBorderColor(0.4, 0.3, 0.1)
					elseif specialType == 0x10000 then		-- Cooking
						b.frame:SetBackdropBorderColor(0.9, 0, 0.1)
					end
					b.frame.lock = true
				end

				idx = idx + 1
			end
		end
	end
end

function Stuffing:ADDON_LOADED(addon)
	if addon ~= "ShestakUI" then return nil end

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("GUILDBANKFRAME_OPENED")
	self:RegisterEvent("GUILDBANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	--self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
	self:RegisterEvent("BAG_CLOSED")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	--self:RegisterEvent("REAGENTBANK_UPDATE")

	self:InitBags()

	tinsert(UISpecialFrames, "StuffingFrameBags")
	tinsert(UISpecialFrames, "StuffingFrameReagent")

	ToggleBackpack = Stuffing_Toggle
	ToggleBag = Stuffing_Toggle
	ToggleAllBags = Stuffing_Toggle
	OpenAllBags = Stuffing_Open
	OpenBackpack = Stuffing_Open
	CloseAllBags = Stuffing_Close
	CloseBackpack = Stuffing_Close

	--BankFrame:UnregisterAllEvents()
	BankFrame:SetScale(0.00001)
	BankFrame:SetAlpha(0)
	BankFrame:SetPoint("TOPLEFT")
end

function Stuffing:PLAYER_ENTERING_WORLD()
	Stuffing:UnregisterEvent("PLAYER_ENTERING_WORLD")
	ToggleBackpack()
	ToggleBackpack()
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
	if slot == nil then return end
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			self:SlotUpdate(v)
			break
		end
	end
end

function Stuffing:BANKFRAME_OPENED()
	if not self.bankFrame then
		self:InitBank()
	end

	self:Layout(true)
	for _, x in ipairs(BAGS_BANK) do
		self:BagSlotUpdate(x)
	end

	self.bankFrame:Show()
	Stuffing_Open()
end

function Stuffing:BANKFRAME_CLOSED()
	if StuffingFrameReagent then
		StuffingFrameReagent:Hide()
	end
	if self.bankFrame then
		self.bankFrame:Hide()
	end
end

function Stuffing:GUILDBANKFRAME_OPENED()
	Stuffing_Open()
end

function Stuffing:GUILDBANKFRAME_CLOSED()
	Stuffing_Close()
end

function Stuffing:BAG_CLOSED(id)
	local b = self.bags[id]
	if b then
		table.remove(self.bags, id)
		b:Hide()
		table.insert(trashBag, #trashBag + 1, b)
	end

	while true do
		local changed = false

		for i, v in ipairs(self.buttons) do
			if v.bag == id then
				v.frame:Hide()
				v.frame.lock = false

				table.insert(trashButton, #trashButton + 1, v.frame)
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

function Stuffing:BAG_UPDATE_COOLDOWN()
	for i, v in pairs(self.buttons) do
		self:SlotUpdate(v)
	end
end

function Stuffing:PLAYERBANKBAGSLOTS_CHANGED()
	if not StuffingPurchaseButtonBank then return end
	local _, full = GetNumBankSlots()
	if full then
		StuffingPurchaseButtonBank:Hide()
	else
		StuffingPurchaseButtonBank:Show()
	end
end

function Stuffing.Menu(self, level)
	if not level then return end

	local info = self.info

	wipe(info)

	if level ~= 1 then return end

	wipe(info)
	info.text = BAG_FILTER_CLEANUP
	info.notCheckable = 1
	info.func = function()
		SortBags()
		SortBankBags()
		SortReagentBankBags()
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