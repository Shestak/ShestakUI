local T, C, L, _ = unpack(select(2, ...))
if C.misc.item_level ~= true then return end

----------------------------------------------------------------------------------------
--	Item level on slot buttons in Character/InspectFrame(by Tukz)
----------------------------------------------------------------------------------------
local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot",
	"WristSlot", "MainHandSlot", "SecondaryHandSlot", "HandsSlot", "WaistSlot",
	"LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot"
}

local upgrades = {
	["1"] = 8, ["373"] = 4, ["374"] = 8, ["375"] = 4, ["376"] = 4, ["377"] = 4,
	["379"] = 4, ["380"] = 4, ["446"] = 4, ["447"] = 8, ["452"] = 8, ["454"] = 4,
	["455"] = 8, ["457"] = 8, ["459"] = 4, ["460"] = 8, ["461"] = 12, ["462"] = 16,
	["466"] = 4, ["467"] = 8, ["469"] = 4, ["470"] = 8, ["471"] = 12, ["472"] = 16,
	["477"] = 4, ["478"] = 8, ["480"] = 8, ["492"] = 4, ["493"] = 8, ["495"] = 4,
	["496"] = 8, ["497"] = 12, ["498"] = 16, ["504"] = 12, ["505"] = 16, ["506"] = 20,
	["507"] = 24, ["530"] = 5, ["531"] = 10, ["535"] = 15, ["536"] = 30, ["537"] = 45
}

local function BOALevel(level, id)
	if level > 97 then
		if id == 133585 or id == 133595 or id == 133596 or id == 133597 or id == 133598 then
			level = 815 - (110 - level) * 10
		else
			level = 605 - (100 - level) * 5
		end
	elseif level > 90 then
		level = 590 - (97 - level) * 10
	elseif level > 85 then
		level = 463 - (90 - level) * 19.75
	elseif level > 80 then
		level = 333 - (85 - level) * 13.5
	elseif level > 67 then
		level = 187 - (80 - level) * 4
	elseif level > 57 then
		level = 105 - (67 - level) * 2.88
	elseif level > 5 then
		level = level + 5
	else
		level = 10
	end

	return floor(level + 0.5)
end

local timewarped = {
	["615"] = 660, -- Dungeon drops
	["692"] = 675, -- Timewarped badge vendors
	["656"] = 675, -- Warforged Dungeon drops
}

local function CreateButtonsText(frame)
	for _, slot in pairs(slots) do
		local button = _G[frame..slot]
		button.t = button:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
		button.t:SetPoint("TOP", button, "TOP", 0, -2)
		button.t:SetText("")
	end
end

local function UpdateButtonsText(frame)
	if frame == "Inspect" and not InspectFrame:IsShown() then return end

	for _, slot in pairs(slots) do
		local id = GetInventorySlotInfo(slot)
		local text = _G[frame..slot].t
		local itemLink
		local ulvl

		if frame == "Inspect" then
			itemLink = GetInventoryItemLink("target", id)
			ulvl = UnitLevel("target")
		else
			itemLink = GetInventoryItemLink("player", id)
			ulvl = UnitLevel("player")
		end

		if slot == "ShirtSlot" or slot == "TabardSlot" then
			text:SetText("")
		elseif itemLink then
			local oldlevel = text:GetText()
			local _, _, quality, level = GetItemInfo(itemLink)
			if level then
				if level ~= oldlevel then
					if quality == 7 and level == 1 then
						local id = tonumber(strmatch(itemLink, "item:(%d+)"))
						text:SetText("|cFFFFFF00"..BOALevel(ulvl, id))
					elseif level == 1 then
						text:SetText("")
					else
						local tid = strmatch(itemLink, ".+:512:22.+:(%d+):100")
						if timewarped[tid] then
							level = timewarped[tid]
						end

						local upgradeTypeID = select(12, strsplit(":", itemLink))
						if upgradeTypeID and upgradeTypeID ~= "" then
							local uid = itemLink:match("[-:%d]+:([-%d]+)")
							if upgrades[uid] then
								level = level + upgrades[uid]
							end
						end

						local numBonusIDs = tonumber(strmatch(itemLink, ".+:%d+:512:%d*:(%d+).+"))
						if numBonusIDs then
							if GetDetailedItemLevelInfo then
								local effectiveLevel, previewLevel, origLevel = GetDetailedItemLevelInfo(itemLink)
								level = effectiveLevel or level
							end
						end

						if quality == 6 then
							if id == 17 then
								if frame == "Inspect" then
									itemLink = GetInventoryItemLink("target", 16)
								else
									itemLink = GetInventoryItemLink("player", 16)
								end
								level = GetDetailedItemLevelInfo(itemLink) or level
							else
								level = GetDetailedItemLevelInfo(itemLink) or level
							end
						end

						text:SetText("|cFFFFFF00"..level)
					end
				end
			else
				text:SetText("")
			end
		else
			text:SetText("")
		end
	end
end

local OnEvent = CreateFrame("Frame")
OnEvent:RegisterEvent("PLAYER_LOGIN")
OnEvent:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
OnEvent:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		CreateButtonsText("Character")
		UpdateButtonsText("Character")
		self:UnregisterEvent("PLAYER_LOGIN")
		CharacterFrame:HookScript("OnShow", function(self) UpdateButtonsText("Character") end)
	elseif event == "PLAYER_EQUIPMENT_CHANGED" then
		UpdateButtonsText("Character")
	else
		UpdateButtonsText("Inspect")
	end
end)

local OnLoad = CreateFrame("Frame")
OnLoad:RegisterEvent("ADDON_LOADED")
OnLoad:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_InspectUI" then
		CreateButtonsText("Inspect")
		InspectFrame:HookScript("OnShow", function(self) UpdateButtonsText("Inspect") end)
		OnEvent:RegisterEvent("UNIT_INVENTORY_CHANGED")
		OnEvent:RegisterEvent("PLAYER_TARGET_CHANGED")
		OnEvent:RegisterEvent("INSPECT_READY")
		self:UnregisterEvent("ADDON_LOADED")
	end
end)
