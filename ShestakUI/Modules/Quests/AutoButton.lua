local T, C, L, _ = unpack(select(2, ...))
if C.misc.quest_auto_button ~= true or IsAddOnLoaded("ExtraQuestButton") then return end

----------------------------------------------------------------------------------------
--	AutoButton for used items(by Elv22) (use macro /click AutoButton)
----------------------------------------------------------------------------------------
local function AutoButtonHide()
	AutoButton:SetAlpha(0)
	if not InCombatLockdown() then
		AutoButton:EnableMouse(false)
	else
		AutoButton:RegisterEvent("PLAYER_REGEN_ENABLED")
		AutoButton:SetScript("OnEvent", function(_, event)
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
		AutoButton:SetScript("OnEvent", function(_, event)
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
AutoButtonAnchor:SetPoint(unpack(C.position.auto_button))
AutoButtonAnchor:SetSize(40, 40)

-- Create button
local AutoButton = CreateFrame("Button", "AutoButton", UIParent, "SecureActionButtonTemplate")
AutoButton:SetSize(40, 40)
AutoButton:SetPoint("CENTER", AutoButtonAnchor, "CENTER", 0, 0)
AutoButton:SetTemplate("Default")
AutoButton:StyleButton()
AutoButton:RegisterForClicks("AnyUp", "AnyDown")
AutoButton:SetAttribute("type1", "item")
AutoButton:SetAttribute("type2", "item")
AutoButton:SetAttribute("type3", "macro")
AutoButtonHide()

-- Texture for our button
AutoButton.t = AutoButton:CreateTexture(nil, "BORDER")
AutoButton.t:SetPoint("TOPLEFT", 2, -2)
AutoButton.t:SetPoint("BOTTOMRIGHT", -2, 2)
AutoButton.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)

-- Count text for our button
AutoButton.c = AutoButton:CreateFontString(nil, "OVERLAY")
AutoButton.c:SetFont(C.font.cooldown_timers_font, C.font.cooldown_timers_font_size, C.font.cooldown_timers_font_style)
AutoButton.c:SetShadowOffset(C.font.cooldown_timers_font_shadow and 1 or 0, C.font.cooldown_timers_font_shadow and -1 or 0)
AutoButton.c:SetPoint("BOTTOMRIGHT", 1, -2)

-- Hotkey text for our button
AutoButton.k = AutoButton:CreateFontString(nil, "OVERLAY")
AutoButton.k:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
AutoButton.k:SetShadowOffset(C.font.action_bars_font_shadow and 1 or 0, C.font.action_bars_font_shadow and -1 or 0)
AutoButton.k:SetTextColor(0.7, 0.7, 0.7)
AutoButton.k:SetPoint("TOPRIGHT", 0, -2)
AutoButton.k:SetJustifyH("RIGHT")
AutoButton.k:SetWidth(AutoButton:GetWidth() - 1)
AutoButton.k:SetWordWrap(false)

local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_BINDINGS")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	local bind = GetBindingKey("QUEST_BUTTON")
	if bind then
		SetOverrideBinding(AutoButton, false, bind, "CLICK AutoButton:LeftButton")

		bind = gsub(bind, "(ALT%-)", "A")
		bind = gsub(bind, "(CTRL%-)", "C")
		bind = gsub(bind, "(SHIFT%-)", "S")
		bind = gsub(bind, "(Mouse Button )", "M")
		bind = gsub(bind, "(Кнопка мыши )", "M")
		bind = gsub(bind, KEY_BUTTON3, "M3")
		bind = gsub(bind, KEY_PAGEUP, "PU")
		bind = gsub(bind, KEY_PAGEDOWN, "PD")
		bind = gsub(bind, KEY_SPACE, "SpB")
		bind = gsub(bind, KEY_INSERT, "Ins")
		bind = gsub(bind, KEY_HOME, "Hm")
		bind = gsub(bind, KEY_DELETE, "Del")
		bind = gsub(bind, KEY_NUMPADDECIMAL, "Nu.")
		bind = gsub(bind, KEY_NUMPADDIVIDE, "Nu/")
		bind = gsub(bind, KEY_NUMPADMINUS, "Nu-")
		bind = gsub(bind, KEY_NUMPADMULTIPLY, "Nu*")
		bind = gsub(bind, KEY_NUMPADPLUS, "Nu+")
		bind = gsub(bind, KEY_NUMLOCK, "NuL")
		bind = gsub(bind, KEY_MOUSEWHEELDOWN, "MWD")
		bind = gsub(bind, KEY_MOUSEWHEELUP, "MWU")
	end
	AutoButton.k:SetText(bind or "")
end)

-- Cooldown
AutoButton.cd = CreateFrame("Cooldown", nil, AutoButton, "CooldownFrameTemplate")
AutoButton.cd:SetAllPoints(AutoButton.t)
AutoButton.cd:SetFrameLevel(1)

local function startScanningBags()
	AutoButtonHide()
	-- Scan bags for Item matchs
	for b = 0, NUM_BAG_SLOTS do
		for s = 1, C_Container.GetContainerNumSlots(b) do
			local itemID = C_Container.GetContainerItemID(b, s)
			itemID = tonumber(itemID)
			if T.ABItems[itemID] and not T.ABItemsIgnore[itemID] then
				local itemName = GetItemInfo(itemID)
				local count = GetItemCount(itemID)
				local itemIcon = GetItemIcon(itemID)

				-- Set our texture to the item found in bags
				AutoButton.t:SetTexture(itemIcon)

				-- Get the count if there is one
				if count and count > 1 then
					AutoButton.c:SetText(count)
				else
					AutoButton.c:SetText("")
				end

				AutoButton:SetScript("OnUpdate", function()
					local cd_start, cd_finish, cd_enable = C_Container.GetContainerItemCooldown(b, s)
					CooldownFrame_Set(AutoButton.cd, cd_start, cd_finish, cd_enable)
				end)

				AutoButton:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_LEFT")
					GameTooltip:SetHyperlink(format("item:%s", itemID))
					GameTooltip:Show()
				end)

				AutoButton:SetScript("OnLeave", GameTooltip_Hide)
				AutoButton:SetID(itemID)

				AutoButtonShow(itemName)
			end
		end
	end
end

-- Add all items from quest to our table
hooksecurefunc("QuestObjectiveItem_Initialize", function(_, questLogIndex)
	local link = GetQuestLogSpecialItemInfo(questLogIndex)
	if link then
		local _, itemID = strsplit(":", link)
		itemID = tonumber(itemID)
		T.ABItems[itemID] = true
		startScanningBags()
	end
end)

local Scanner = CreateFrame("Frame")
Scanner:RegisterEvent("BAG_UPDATE")
Scanner:RegisterEvent("UNIT_INVENTORY_CHANGED")
Scanner:SetScript("OnEvent", function()
	startScanningBags()
end)

-- Temp hide quest item by middle-click
T.startScanningBags = startScanningBags

local macro = "/run local T = unpack(ShestakUI) T.ABItemsIgnore[AutoButton:GetID()] = true T.startScanningBags() C_Timer.After(0.05, function() AutoButton:SetButtonState('NORMAL') end)"
AutoButton:SetAttribute("macrotext3", macro)