local T, C, L = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true then return end

----------------------------------------------------------------------------------------
--	AutoButton for used items(by Elv22)
----------------------------------------------------------------------------------------
local Items = T.ABItems
local EquipedItems = T.ABEquipedItems

local function AutoButtonHide()
	AutoButton:SetAlpha(0)
	if not InCombatLockdown() then
		AutoButton:EnableMouse(false)
	else
		AutoButton:RegisterEvent("PLAYER_REGEN_ENABLED")
		AutoButton:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_ENABLED" then
				AutoButton:EnableMouse(false)
				AutoButton:UnregisterEvent("PLAYER_REGEN_ENABLED")
			end
		end)
	end
end

local function AutoButtonShow(item)
	AutoButton:SetAlpha(1)
	if not InCombatLockdown() then
		AutoButton:EnableMouse(true)
		if item then
			AutoButton:SetAttribute("item", item)
		end
	else
		AutoButton:RegisterEvent("PLAYER_REGEN_ENABLED")
		AutoButton:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_ENABLED" then
				AutoButton:EnableMouse(true)
				if item then
					AutoButton:SetAttribute("item", item)
				end
				AutoButton:UnregisterEvent("PLAYER_REGEN_ENABLED")
			end
		end)
	end
end

-- Create anchor
local AutoButtonAnchor = CreateFrame("Frame", "AutoButtonAnchor", UIParent)
AutoButtonAnchor:Point("BOTTOMLEFT", Minimap, "TOPLEFT", -2, 27)
AutoButtonAnchor:Size(40)

-- Create button
local AutoButton = CreateFrame("Button", "AutoButton", UIParent, "SecureActionButtonTemplate")
AutoButton:Size(40)
AutoButton:Point("CENTER", AutoButtonAnchor, "CENTER", 0, 0)
AutoButton:SetTemplate("Default")
AutoButton:StyleButton()
AutoButton:SetAttribute("type", "item")
AutoButtonHide()

-- Texture for our button
AutoButton.t = AutoButton:CreateTexture(nil, "OVERLAY", nil)
AutoButton.t:Point("TOPLEFT", AutoButton, "TOPLEFT", 2, -2)
AutoButton.t:Point("BOTTOMRIGHT", AutoButton, "BOTTOMRIGHT", -2, 2)
AutoButton.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)

-- Count text for our button
AutoButton.c = AutoButton:CreateFontString(nil, "OVERLAY", f)
AutoButton.c:SetFont(C.media.pixel_font, C.media.pixel_font_size * 2, C.media.pixel_font_style)
AutoButton.c:SetTextColor(1, 1, 1, 1)
AutoButton.c:Point("BOTTOMRIGHT", AutoButton, "BOTTOMRIGHT", 0.5, 0)
AutoButton.c:SetJustifyH("CENTER")

-- Cooldown
AutoButton.Cooldown = CreateFrame("Cooldown", nil, AutoButton)
AutoButton.Cooldown:Point("TOPLEFT", AutoButton, "TOPLEFT", 2, -2)
AutoButton.Cooldown:Point("BOTTOMRIGHT", AutoButton, "BOTTOMRIGHT", -2, 2)

local Scanner = CreateFrame("Frame")
Scanner:RegisterEvent("BAG_UPDATE")
Scanner:RegisterEvent("UNIT_INVENTORY_CHANGED")
Scanner:SetScript("OnEvent", function()
	AutoButtonHide()
	-- Scan bags for Item matchs
	for b = 0, NUM_BAG_SLOTS do
		for s = 1, GetContainerNumSlots(b) do
			local itemID = GetContainerItemID(b, s)
			itemID = tonumber(itemID)
			for i, Items in pairs(Items) do
				if itemID == Items then
					local itemName = GetItemInfo(itemID)
					local count = GetItemCount(itemID)
					local itemIcon = GetItemIcon(itemID)

					-- Set our texture to the item found in bags
					AutoButton.t:SetTexture(itemIcon)

					-- Get the count if there is one
					if count and count ~= 1 then
						AutoButton.c:SetText(count)
					else
						AutoButton.c:SetText("")
					end

					AutoButton:SetScript("OnUpdate", function(self, elapsed)
						local cd_start, cd_finish, cd_enable = GetContainerItemCooldown(b, s)
						CooldownFrame_SetTimer(AutoButton.Cooldown, cd_start, cd_finish, cd_enable)
					end)
					AutoButtonShow(itemName)
				end
			end
		end
	end

	-- Scan inventory for Equipment matches
	for w = 1, 19 do
		for e, EquipedItems in pairs(EquipedItems) do
			if GetInventoryItemID("player", w) == EquipedItems then
				local itemName = GetItemInfo(EquipedItems)
				local itemIcon = GetInventoryItemTexture("player", w)

				-- Set our texture to the item found in bags
				AutoButton.t:SetTexture(itemIcon)
				AutoButton.c:SetText("")

				AutoButton:SetScript("OnUpdate", function(self, elapsed)
					local cd_start, cd_finish, cd_enable = GetInventoryItemCooldown("player", w)
					CooldownFrame_SetTimer(AutoButton.Cooldown, cd_start, cd_finish, cd_enable)
				end)
				AutoButtonShow(itemName)
			end
		end
	end
end)