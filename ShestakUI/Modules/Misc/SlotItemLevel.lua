local T, C, L, _ = unpack(select(2, ...))
if C.misc.item_level ~= true then return end

----------------------------------------------------------------------------------------
--	Item level on slot buttons in Character/InspectFrame(by Tukz)
----------------------------------------------------------------------------------------
local time = 3
local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot",
	"WristSlot", "MainHandSlot", "SecondaryHandSlot", "HandsSlot", "WaistSlot",
	"LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot"
}

-- iLevel retrieval
local S_ITEM_LEVEL = "^"..gsub(ITEM_LEVEL, "%%d", "(%%d+)")
local scantip = CreateFrame("GameTooltip", "ItemLevelScanTooltip", nil, "GameTooltipTemplate")
scantip:SetOwner(UIParent, "ANCHOR_NONE")

local function GetItemLevel(itemLink)
	scantip:SetOwner(UIParent, "ANCHOR_NONE")
	scantip:SetHyperlink(itemLink)
	for i = 2, scantip:NumLines() do -- Line 1 = name so skip
		local text = _G["ItemLevelScanTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			local currentLevel = strmatch(text, S_ITEM_LEVEL)
			if currentLevel then
				return currentLevel
			end
		end
	end
	scantip:Hide()
end

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
		local item
		local text = _G[frame..slot].t

		if frame == "Inspect" then
			item = GetInventoryItemLink("target", id)
		else
			item = GetInventoryItemLink("player", id)
		end

		if slot == "ShirtSlot" or slot == "TabardSlot" then
			text:SetText("")
		elseif item then
			local oldilevel = text:GetText()
			local _, _, _, ilevel = GetItemInfo(item)
			local upgrade = item:match(":(%d+)\124h%[")

			if ilevel then
				if ilevel ~= oldilevel then
					if ilevel == 1 then
						text:SetText("")
					else
						local currentLevel = GetItemLevel(item)
						ilevel = currentLevel and currentLevel or ilevel
						text:SetText("|cFFFFFF00"..ilevel)
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
	elseif event == "PLAYER_TARGET_CHANGED" or event == "INSPECT_READY" then
		UpdateButtonsText("Inspect")
	else
		UpdateButtonsText("Character")
	end
end)
OnEvent:SetScript("OnUpdate", function(self, elapsed)
	time = time + elapsed
	if time >= 3 then
		if InspectFrame and InspectFrame:IsShown() then
			UpdateButtonsText("Inspect")
		else
			UpdateButtonsText("Character")
		end
	end
end)

local OnLoad = CreateFrame("Frame")
OnLoad:RegisterEvent("ADDON_LOADED")
OnLoad:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_InspectUI" then
		CreateButtonsText("Inspect")
		InspectFrame:HookScript("OnShow", function(self) UpdateButtonsText("Inspect") end)
		OnEvent:RegisterEvent("PLAYER_TARGET_CHANGED")
		OnEvent:RegisterEvent("INSPECT_READY")
		self:UnregisterEvent("ADDON_LOADED")
	end
end)
