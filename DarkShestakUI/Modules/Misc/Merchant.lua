local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Alt+Click to buy a stack
----------------------------------------------------------------------------------------
hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
	if MerchantFrame.selectedTab == 1 then
		if IsAltKeyDown() then
			local id = self:GetID()
			local _, _, _, quantity, _, _, extracost = GetMerchantItemInfo(id)
			if not extracost then
				local stack
				if quantity > 1 then
					stack = quantity * GetMerchantItemMaxStack(id)
				else
					stack = GetMerchantItemMaxStack(id)
				end
				local amount = 1
				if self.count < stack then
					amount = stack / self.count
				end
				if self.numInStock ~= -1 and self.numInStock < amount then
					amount = self.numInStock
				end
				local money = GetMoney()
				if (self.price * amount) > money then
					amount = floor(money / self.price)
				end
				if amount > 0 then
					BuyMerchantItem(id, amount)
				end
			end
		end
	end
end)

local function IsMerchantButtonOver()
	return GetMouseFocus():GetName() and GetMouseFocus():GetName():find("MerchantItem%d")
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if MerchantFrame:IsShown() and IsMerchantButtonOver() then
		for i = 2, GameTooltip:NumLines() do
			if _G["GameTooltipTextLeft"..i]:GetText():find(ITEM_VENDOR_STACK_BUY) then
				GameTooltip:AddLine("|cff00ff00<"..L_MISC_BUY_STACK..">|r")
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	Automatically buy grocery bags(GroceryList by Durcyn)
----------------------------------------------------------------------------------------
local items = {
	[74833] = {bag = 87658, count = 20},	-- Raw Tiger Steak
	[74834] = {bag = 87659, count = 20},	-- Mushan Ribs
	[74837] = {bag = 87660, count = 20},	-- Raw Turtle Meat
	[74838] = {bag = 87661, count = 20},	-- Raw Crab Meat
	[74839] = {bag = 87662, count = 20},	-- Wildfowl Breast
	[74840] = {bag = 87663, count = 100},	-- Green Cabbage
	[74841] = {bag = 87664, count = 100},	-- Juicycrunch Carrot
	[74842] = {bag = 87665, count = 100},	-- Mogu Pumpkin
	[74843] = {bag = 87666, count = 100},	-- Scallions
	[74844] = {bag = 87667, count = 100},	-- Red Blossom Leek
	[74846] = {bag = 87669, count = 100},	-- Witchberries
	[74847] = {bag = 87670, count = 100},	-- Jade Squash
	[74848] = {bag = 87671, count = 100},	-- Striped Melon
	[74849] = {bag = 87672, count = 100},	-- Pink Turnip
	[74850] = {bag = 87673, count = 100},	-- White Turnip
	[74856] = {bag = 87678, count = 20},	-- Jade Lungfish
	[74857] = {bag = 87679, count = 20},	-- Giant Mantis Shrimp
	[74859] = {bag = 87680, count = 20},	-- Emperor Salmon
	[74860] = {bag = 87681, count = 20},	-- Rebelly Mandarin
	[74861] = {bag = 87682, count = 20},	-- Tiger Gourami
	[74863] = {bag = 87683, count = 20},	-- Jewel Danio
	[74864] = {bag = 87684, count = 20},	-- Reef Octopus
	[74865] = {bag = 87685, count = 20},	-- Krasarang Paddlefish
	[74866] = {bag = 87686, count = 60},	-- Golden Carp
	[75014] = {bag = 87687, count = 20},	-- Raw Crocolisk Belly
}

local throttle = false

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(f, event, ...) if frame[event] then frame[event](f, event, ...) end end)
frame:RegisterEvent("MERCHANT_SHOW")
frame:RegisterEvent("MERCHANT_CLOSED")

local button = CreateFrame("Button", "GroceryListFrame", MerchantFrame, "UIPanelButtonTemplate")
button:SetText(L_MISC_GROCERY_BUY)
if C.skins.blizzard_frames == true then
	button:SetSize(button:GetTextWidth() + 15, 18)
	button:SetPoint("TOPRIGHT", MerchantFrameCloseButton, "TOPLEFT", -3, 0)
	button:SkinButton()
else
	button:SetSize(button:GetTextWidth() + 15, 19)
	button:SetPoint("TOPRIGHT", MerchantFrameCloseButton, "TOPLEFT", 3, -6)
end
button:Hide()

button:HookScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltip:SetText(L_MISC_GROCERY_DESC)
	GameTooltip:Show()
end)

button:HookScript("OnLeave", function() GameTooltip:Hide() end)

button:SetScript("OnClick", function()
	if throttle then return end
	local groceries = {}
	local havebags = {}
	for bag = 0, 4 do
		local slots = GetContainerNumSlots(bag)
		for i = 1, slots do
			local id = GetContainerItemID(bag, i)
			local _, count = GetContainerItemInfo(bag, i)
			if id and count then
				for k, v in pairs(items) do
					if k == id then groceries[id] = groceries[id] and groceries[id] + count or count end
					if v.bag == id then havebags[id] = havebags[id] and havebags[id] + count or count end
				end
			end
		end
	end

	local shopping = {}
	for id, count in pairs(groceries) do
		for grocery, data in pairs(items) do
			if id == grocery and count >= data.count then
				local need = floor(count / data.count)
				local have = havebags[data.bag] or 0
				shopping[data.bag] = need - have
			end
		end
	end

	local merchitems = GetMerchantNumItems()
	for i = 1, merchitems do
		local link = GetMerchantItemLink(i)
		local id = tonumber(string.match(link, "item:(%d+):"))
		for bag, count in pairs(shopping) do
			if id == bag and count > 0 then
				if count > 20 then
					while count > 20 do
						BuyMerchantItem(i, 20)
						count = count - 20
					end
				end
				BuyMerchantItem(i, count)
			end
		end
	end
	throttle = true
end)

function frame:MERCHANT_SHOW()
	local name, _, price = GetMerchantItemInfo(1)
	if (price == 13500 or price == 15000) and name == GetItemInfo(87658) then button:Show() end
end

function frame:MERCHANT_CLOSED()
	button:Hide()
	throttle = false
end