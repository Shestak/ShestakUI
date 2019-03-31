local T, C, L, _ = unpack(select(2, ...))
if C.loot.lootframe ~= true then return end

----------------------------------------------------------------------------------------
--	MasterLoot by Ammo
----------------------------------------------------------------------------------------
local hexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = "|c"..v.colorStr
end
hexColors["UNKNOWN"] = string.format("|cff%02x%02x%02x", 0.6 * 255, 0.6 * 255, 0.6 * 255)

if CUSTOM_CLASS_COLORS then
	local function update()
		for k, v in pairs(CUSTOM_CLASS_COLORS) do
			hexColors[k] = "|c"..v.colorStr
		end
	end
	CUSTOM_CLASS_COLORS:RegisterCallback(update)
	update()
end

local classesInRaid = {}
local players, player_indices = {}, {}
local randoms = {}
local wipe = table.wipe

local function MasterLoot_RequestRoll(frame)
	DoMasterLootRoll(frame.value)
end

local function MasterLoot_GiveLoot(frame)
	MasterLooterFrame.slot = LootFrame.selectedSlot
	MasterLooterFrame.candidateId = frame.value
	if LootFrame.selectedQuality >= MASTER_LOOT_THREHOLD then
		StaticPopup_Show("CONFIRM_LOOT_DISTRIBUTION", ITEM_QUALITY_COLORS[LootFrame.selectedQuality].hex..LootFrame.selectedItemName..FONT_COLOR_CODE_CLOSE, frame:GetText() or UNKNOWN, "LootWindow")
	else
		GiveMasterLoot(LootFrame.selectedSlot, frame.value)
	end
	CloseDropDownMenus()
end

local function init()
	local candidate, lclass, className
	local slot = LootFrame.selectedSlot or 0
	local info = UIDropDownMenu_CreateInfo()

	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		-- Raid class menu
		wipe(players)
		wipe(player_indices)
		local this_class = UIDROPDOWNMENU_MENU_VALUE
		for i = 1, MAX_RAID_MEMBERS do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate and this_class == className then
				table.insert(players, candidate)
				player_indices[candidate] = i
			end
		end
		if #players > 0 then
			table.sort(players)
			for _, cand in ipairs(players) do
				-- Add candidate button
				info.text = cand
				info.colorCode = hexColors[this_class] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.value = player_indices[cand]
				info.notCheckable = 1
				info.disabled = nil
				info.func = MasterLoot_GiveLoot
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
			end
		end
		return
	end

	info.isTitle = 1
	info.text = GIVE_LOOT
	info.textHeight = 12
	info.notCheckable = 1
	info.disabled = nil
	info.notClickable = nil
	UIDropDownMenu_AddButton(info)

	if IsInRaid() then
		-- In a raid
		wipe(classesInRaid)
		for i = 1, MAX_RAID_MEMBERS do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate then
				classesInRaid[className] = lclass
			end
		end

		for i, class in ipairs(CLASS_SORT_ORDER) do
			local cname = classesInRaid[class]
			if cname then
				info.isTitle = nil
				info.text = cname
				info.colorCode = hexColors[class] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.hasArrow = 1
				info.notCheckable = 1
				info.value = class
				info.func = nil
				info.disabled = nil
				UIDropDownMenu_AddButton(info)
			end
		end
	else
		-- In a party
		for i = 1, MAX_PARTY_MEMBERS + 1, 1 do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate then
				-- Add candidate button
				info.text = candidate
				info.colorCode = hexColors[className] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.value = i
				info.notCheckable = 1
				info.hasArrow = nil
				info.isTitle = nil
				info.disabled = nil
				info.func = MasterLoot_GiveLoot
				UIDropDownMenu_AddButton(info)
			end
		end
	end

	info.colorCode = "|cffffffff"
	info.isTitle = nil
	info.textHeight = 12
	info.value = slot
	info.notCheckable = 1
	info.hasArrow = nil
	info.text = REQUEST_ROLL
	info.func = MasterLoot_RequestRoll
	info.icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up"
	UIDropDownMenu_AddButton(info)

	wipe(randoms)
	for i = 1, MAX_RAID_MEMBERS do
		candidate, lclass, className = GetMasterLootCandidate(slot, i)
		if candidate then
			table.insert(randoms, i)
		end
	end
	if #randoms > 0 then
		info.colorCode = "|cffffffff"
		info.isTitle = nil
		info.textHeight = 12
		info.value = randoms[math.random(1, #randoms)]
		info.notCheckable = 1
		info.text = L_LOOT_RANDOM
		info.func = MasterLoot_GiveLoot
		info.icon = "Interface\\Buttons\\UI-GroupLoot-Coin-Up"
		UIDropDownMenu_AddButton(info)
	end
	for i = 1, MAX_RAID_MEMBERS do
		candidate, lclass, className = GetMasterLootCandidate(slot, i)
		if candidate and candidate == T.name then
			info.colorCode = hexColors[className] or hexColors["UNKNOWN"]
			info.isTitle = nil
			info.textHeight = 12
			info.value = i
			info.notCheckable = 1
			info.text = L_LOOT_SELF
			info.func = MasterLoot_GiveLoot
			info.icon = "Interface\\GossipFrame\\VendorGossipIcon"
			UIDropDownMenu_AddButton(info)
		end
	end
end

UIDropDownMenu_Initialize(GroupLootDropDown, init, "MENU")