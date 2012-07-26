local T, C, L = unpack(ShestakUI)
if C.extra_general.item_level ~= true then return end

----------------------------------------------------------------------------------------
--	Item level on slot buttons in Character/InspectFrame(by Tukz)
----------------------------------------------------------------------------------------
local time = 3
local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot",
	"WristSlot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "HandsSlot", "WaistSlot",
	"LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot"
}

local function CreateButtonsText(frame)
	for _, slot in pairs(slots) do
		local button = _G[frame..slot]
		local font, _, flags = NumberFontNormal:GetFont()
		button.t = button:CreateFontString(nil, "OVERLAY")
		button.t:SetFont(font, 12, flags)
		button.t:SetPoint("TOP", button, "TOP", 0, -3)
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
			local ilevel = select(4, GetItemInfo(item))
			local heirloom = select(3, GetItemInfo(item))

			if ilevel then
				if ilevel ~= oldilevel then
					if heirloom == 7 then
						text:SetText("")
					else
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