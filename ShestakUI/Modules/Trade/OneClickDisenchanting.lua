local T, C, L, _ = unpack(select(2, ...))
if C.trade.disenchanting ~= true then return end

----------------------------------------------------------------------------------------
--	One-click Milling, Prospecting and Disenchanting(Molinari by p3lim)
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "OneClickMPD", UIParent, "SecureActionButtonTemplate, AutoCastShineTemplate")
button:RegisterForClicks("AnyUp", "AnyDown")
button:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
button:RegisterEvent("PLAYER_LOGIN")

local enchantingItems = {
	-- Legion enchanting quest line
	[137195] = true, -- Highmountain Armor
	[137221] = true, -- Enchanted Raven Sigil
	[137286] = true, -- Fel-Crusted Rune

	-- Shadowlands profession world quests
	[182021] = true, -- Antique Kyrian Javelin
	[182043] = true, -- Antique Necromancer's Staff
	[182067] = true, -- Antique Duelist's Rapier
	[181991] = true, -- Antique Stalker's Bow

	-- Dragonflight profession items
	-- https://www.wowhead.com/items?filter=104;0;amount+of+magical+power+can+be+sensed+from+within
	[200939] = true, -- Chromatic Pocketwatch
	[200940] = true, -- Everflowing Inkwell
	[200941] = true, -- Seal of Order
	[200942] = true, -- Vibrant Emulsion
	[200943] = true, -- Whispering Band
	[200945] = true, -- Valiant Hammer
	[200946] = true, -- Thunderous Blade
	[200947] = true, -- Carving of Awakening
	-- https://www.wowhead.com/items?filter=104;0;Disenchant+to+gain+Enchanting+knowledge
	[198694] = true, -- Enriched Earthen Shard
	[198798] = true, -- Flashfrozen Scroll
	[198800] = true, -- Fractured Titanic Sphere
	[198689] = true, -- Stormbound Horn
	[198799] = true, -- Forgotten Arcane Tome
	[198675] = true, -- Lava-Infused Seed
	[201360] = true, -- Glimmer of Order
	[201358] = true, -- Glimmer of Air
	[201357] = true, -- Glimmer of Frost
	[201359] = true, -- Glimmer of Earth
	[201356] = true, -- Glimmer of Fire
}

function button:PLAYER_LOGIN()
	local disenchanter, rogue

	if IsSpellKnown(13262) then
		disenchanter = true
	end

	if IsSpellKnown(1804) then
		rogue = ITEM_MIN_SKILL:gsub("%%s", (T.client == "ruRU" and "Взлом замков" or GetSpellInfo(1809))):gsub("%%d", "%(.*%)")
	end

	local function OnTooltipSetUnit(self)
		if self ~= GameTooltip or self:IsForbidden() then return end
		local _, link = TooltipUtil.GetDisplayedItem(self)

		if link and not InCombatLockdown() and IsAltKeyDown() and not (AuctionHouseFrame and AuctionHouseFrame:IsShown()) then
			local itemID = GetItemInfoFromHyperlink(link)
			if not itemID then return end
			local spell, r, g, b
			if disenchanter then
				if enchantingItems[itemID] then
					spell, r, g, b = GetSpellInfo(13262), 0.5, 0.5, 1
				else
					local _, _, quality, _, _, _, _, _, _, _, _, class, subClass = GetItemInfo(link)
					if quality and ((quality >= Enum.ItemQuality.Uncommon and quality <= Enum.ItemQuality.Epic)
						and C_Item.GetItemInventoryTypeByID(itemID) ~= Enum.InventoryType.IndexBodyType
						and (class == Enum.ItemClass.Weapon
							or (class == Enum.ItemClass.Armor and subClass ~= Enum.ItemClass.Cosmetic)
							or (class == Enum.ItemClass.Gem and subClass == 11)
							or class == Enum.ItemClass.Profession)) then
						spell, r, g, b = GetSpellInfo(13262), 0.5, 0.5, 1
					end
				end
			elseif rogue then
				for index = 1, self:NumLines() do
					if string.match(_G["GameTooltipTextLeft"..index]:GetText() or "", rogue) then
						spell, r, g, b = GetSpellInfo(1804), 0, 1, 1
					end
				end
			end

			local bag, slot = GetMouseFocus():GetParent(), GetMouseFocus()
			if spell and C_Container.GetContainerItemLink(bag:GetID(), slot:GetID()) == link then
				button:SetAttribute("macrotext", string.format("/cast %s\n/use %s %s", spell, bag:GetID(), slot:GetID()))
				button:SetAllPoints(slot)
				button:Show()
				AutoCastShine_AutoCastStart(button, r, g, b)
			end
		end
	end

	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetUnit)

	self:SetFrameStrata("TOOLTIP")
	self:SetAttribute("*type1", "macro")
	self:SetScript("OnLeave", self.MODIFIER_STATE_CHANGED)

	self:RegisterEvent("MODIFIER_STATE_CHANGED")
	self:Hide()

	for _, sparks in pairs(self.sparkles) do
		sparks:SetHeight(sparks:GetHeight() * 3)
		sparks:SetWidth(sparks:GetWidth() * 3)
	end
end

function button:MODIFIER_STATE_CHANGED(key)
	if not self:IsShown() and not key and key ~= "LALT" and key ~= "RALT" then return end

	if InCombatLockdown() then
		self:SetAlpha(0)
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:ClearAllPoints()
		self:SetAlpha(1)
		self:Hide()
		AutoCastShine_AutoCastStop(self)
	end
end

function button:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:MODIFIER_STATE_CHANGED()
end