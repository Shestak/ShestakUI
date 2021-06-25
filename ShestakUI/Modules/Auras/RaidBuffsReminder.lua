local T, C, L, _ = unpack(select(2, ...))
if C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by Elv22)
----------------------------------------------------------------------------------------
local flaskbuffs = T.ReminderBuffs["Flask"]
local battleelixirbuffs = T.ReminderBuffs["BattleElixir"]
local guardianelixirbuffs = T.ReminderBuffs["GuardianElixir"]
local foodbuffs = T.ReminderBuffs["Food"]
local staminabuffs = T.ReminderBuffs["Stamina"]
local custombuffs = T.ReminderBuffs["Custom"]
local visible, flask, battleelixir, guardianelixir, food, stamina, spell4, custom, weapon, armor
local playerBuff = {}

local function CheckElixir()
	if #battleelixirbuffs > 0 then
		for i = 1, #battleelixirbuffs do
			local name, icon = unpack(battleelixirbuffs[i])
			if playerBuff[name] then
				FlaskFrame.t:SetTexture(icon)
				battleelixir = true
				break
			else
				battleelixir = false
			end
		end
	end

	if #guardianelixirbuffs > 0 then
		for i = 1, #guardianelixirbuffs do
			local name, icon = unpack(guardianelixirbuffs[i])
			if playerBuff[name] then
				guardianelixir = true
				if not battleelixir then
					FlaskFrame.t:SetTexture(icon)
				end
				break
			else
				guardianelixir = false
			end
		end
	end

	if guardianelixir == true and battleelixir == true then
		FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		flask = true
		return
	else
		FlaskFrame:SetAlpha(1)
		flask = false
	end
end

local function CheckWeaponBuff()
	local weaponBuff = false
	local weaponOffBuff = false
	local hasMainHandEnchant, _, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
	if hasMainHandEnchant then
		weaponBuff = true
	end
	local OffhandHasWeapon = C_PaperDollInfo.OffhandHasWeapon()
	if not OffhandHasWeapon or OffhandHasWeapon and hasOffHandEnchant then
		weaponOffBuff = true
	end

	if weaponBuff == true and weaponOffBuff == true then
		WeaponFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		weapon = true
		return
	else
		WeaponFrame:SetAlpha(1)
		weapon = false
	end
end

local scanner = CreateFrame("GameTooltip", "ArmorScanningTooltip", nil, "GameTooltipTemplate")
scanner:SetOwner(UIParent, "ANCHOR_NONE")

local KitPattern = "(.+) %(%d+ .+%)$"
if T.client == "zhTW" then
    KitPattern = "%(%+%d+.+"
elseif T.client == "zhCN" then
    KitPattern = "%（%+%d+ .+"
elseif T.client == "koKR" then
    KitPattern = "%(.+ %+%d+%)"
end

local function CheckArmorBuff()
	local armorBuff = false
	local hasItem = scanner:SetInventoryItem("player", 5)
	if hasItem then
		for i = 2, scanner:NumLines() do
			local tooltipLine = _G["ArmorScanningTooltipTextLeft"..i]
			local text = tooltipLine:GetText()
			if text and text ~= "" then
				if text:find(KitPattern) then
					armorBuff = true
					break
				end
			end
		end
	end

	if armorBuff == true then
		ArmorFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		armor = true
		return
	else
		ArmorFrame:SetAlpha(1)
		armor = false
	end
end

local function OnAuraChange(_, event, arg1)
	if (event == "UNIT_AURA" or event == "UNIT_INVENTORY_CHANGED") and arg1 ~= "player" then return end

	wipe(playerBuff)
	local i = 1
	while true do
		local name = UnitBuff("player", i)
		if not name then break end
		playerBuff[name] = true
		i = i + 1
	end

	-- If We're a caster we may want to see different buffs
	if T.Role == "Caster" or T.Role == "Healer" then
		T.ReminderCasterBuffs()
	else
		T.ReminderPhysicalBuffs()
	end

	-- Start checking buffs to see if we can find a match from the list
	for i = 1, #flaskbuffs do
		local name, icon = unpack(flaskbuffs[i])
		if i == 1 then
			FlaskFrame.t:SetTexture(icon)
		end
		if playerBuff[name] then
			FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
			flask = true
			break
		else
			CheckElixir()
		end
	end

	for i = 1, #foodbuffs do
		local name, icon = unpack(foodbuffs[i])
		if i == 1 then
			FoodFrame.t:SetTexture(icon)
		end
		if playerBuff[name] then
			FoodFrame:SetAlpha(C.reminder.raid_buffs_alpha)
			food = true
			break
		else
			FoodFrame:SetAlpha(1)
			food = false
		end
	end

	do
		WeaponFrame.t:SetTexture(463543)
		CheckWeaponBuff()
	end

	do
		ArmorFrame.t:SetTexture(3528447)
		CheckArmorBuff()
	end

	for i = 1, #staminabuffs do
		local name, icon = unpack(staminabuffs[i])
		if i == 1 then
			StaminaFrame.t:SetTexture(icon)
		end
		if playerBuff[name] then
			StaminaFrame:SetAlpha(C.reminder.raid_buffs_alpha)
			stamina = true
			break
		else
			StaminaFrame:SetAlpha(1)
			stamina = false
		end
	end

	for i = 1, #Spell4Buff do
		local name, icon = unpack(Spell4Buff[i])
		if i == 1 then
			Spell4Frame.t:SetTexture(icon)
		end
		if playerBuff[name] then
			Spell4Frame:SetAlpha(C.reminder.raid_buffs_alpha)
			spell4 = true
			break
		else
			Spell4Frame:SetAlpha(1)
			spell4 = false
		end
	end

	if #custombuffs > 0 then
		for i = 1, #custombuffs do
			local name, icon = unpack(custombuffs[i])
			if i == 1 then
				CustomFrame.t:SetTexture(icon)
			end
			if playerBuff[name] then
				CustomFrame:SetAlpha(C.reminder.raid_buffs_alpha)
				custom = true
				break
			else
				CustomFrame:SetAlpha(1)
				custom = false
			end
		end
	else
		CustomFrame:Hide()
		custom = true
	end

	local _, instanceType = IsInInstance()
	if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
		RaidBuffReminder:SetAlpha(0)
		visible = false
	elseif flask == true and food == true and stamina == true and spell4 == true and custom == true and weapon == true and armor == true then
		if not visible then
			RaidBuffReminder:SetAlpha(0)
			visible = false
		end
		if visible then
			UIFrameFadeOut(RaidBuffReminder, 0.5)
			visible = false
		end
	else
		if not visible then
			UIFrameFadeIn(RaidBuffReminder, 0.5)
			visible = true
		end
	end
end

-- Create Anchor
local RaidBuffsAnchor = CreateFrame("Frame", "RaidBuffsAnchor", UIParent)
RaidBuffsAnchor:SetWidth((C.reminder.raid_buffs_size * 6) + 15)
RaidBuffsAnchor:SetHeight(C.reminder.raid_buffs_size)
RaidBuffsAnchor:SetPoint(unpack(C.position.raid_buffs))

-- Create Main bar
local raidbuff_reminder = CreateFrame("Frame", "RaidBuffReminder", UIParent)
raidbuff_reminder:CreatePanel("Invisible", (C.reminder.raid_buffs_size * 6) + 15, C.reminder.raid_buffs_size + 4, "TOPLEFT", RaidBuffsAnchor, "TOPLEFT", 0, 4)
raidbuff_reminder:RegisterEvent("UNIT_AURA")
raidbuff_reminder:RegisterEvent("PLAYER_ENTERING_WORLD")
raidbuff_reminder:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
raidbuff_reminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidbuff_reminder:RegisterEvent("UNIT_INVENTORY_CHANGED")
raidbuff_reminder:SetScript("OnEvent", OnAuraChange)

local line = math.ceil(C.minimap.size / (C.reminder.raid_buffs_size + 2))

local buffButtons = {
	"FlaskFrame",
	"FoodFrame",
	"WeaponFrame",
	"ArmorFrame",
	"StaminaFrame",
	"Spell4Frame",
	"CustomFrame",
}

for i = 1, #buffButtons do
	local name = buffButtons[i]
	local button = CreateFrame("Frame", name, RaidBuffReminder)
	if i == 1 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", RaidBuffReminder, "BOTTOMLEFT", 0, 0)
	elseif i == line then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOM", buffButtons[1], "TOP", 0, 3)
	else
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", buffButtons[i-1], "RIGHT", 3, 0)
	end
	button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)

	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.t:SetPoint("TOPLEFT", 2, -2)
	button.t:SetPoint("BOTTOMRIGHT", -2, 2)
end