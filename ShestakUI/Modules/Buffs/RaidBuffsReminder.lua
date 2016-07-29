local T, C, L, _ = unpack(select(2, ...))
if C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by Elv22)
----------------------------------------------------------------------------------------
-- Locals
local flaskbuffs = T.ReminderBuffs["Flask"]
local battleelixirbuffs = T.ReminderBuffs["BattleElixir"]
local guardianelixirbuffs = T.ReminderBuffs["GuardianElixir"]
local foodbuffs = T.ReminderBuffs["Food"]
local statbuffs = T.ReminderBuffs["Stat"]
local staminabuffs = T.ReminderBuffs["Stamina"]
local visible, flask, battleelixir, guardianelixir, food, stat, stamina, spell5, spell6

-- We need to check if you have two different elixirs if your not flasked, before we say your not flasked
local function CheckElixir(unit)
	if battleelixirbuffs and battleelixirbuffs[1] then
		for i, battleelixirbuffs in pairs(battleelixirbuffs) do
			local name, _, icon = GetSpellInfo(battleelixirbuffs)
			if UnitAura("player", name) then
				FlaskFrame.t:SetTexture(icon)
				battleelixir = true
				break
			else
				battleelixir = false
			end
		end
	end

	if guardianelixirbuffs and guardianelixirbuffs[1] then
		for i, guardianelixirbuffs in pairs(guardianelixirbuffs) do
			local name, _, icon = GetSpellInfo(guardianelixirbuffs)
			if UnitAura("player", name) then
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

-- Main Script
local function OnAuraChange(self, event, arg1, unit)
	if event == "UNIT_AURA" and arg1 ~= "player" then return end

	-- If We're a caster we may want to see different buffs
	if T.Role == "Caster" or T.Role == "Healer" then
		T.ReminderCasterBuffs()
	else
		T.ReminderPhysicalBuffs()
	end

	-- Start checking buffs to see if we can find a match from the list
	if flaskbuffs and flaskbuffs[1] then
		for i, flaskbuffs in pairs(flaskbuffs) do
			local name, _, icon = GetSpellInfo(flaskbuffs)
			if i == 1 then
				FlaskFrame.t:SetTexture(icon)
			end
			if UnitAura("player", name) then
				FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
				flask = true
				break
			else
				CheckElixir()
			end
		end
	end

	if foodbuffs and foodbuffs[1] then
		for i, foodbuffs in pairs(foodbuffs) do
			local name, _, icon = GetSpellInfo(foodbuffs)
			if i == 1 then
				FoodFrame.t:SetTexture(icon)
			end
			if UnitAura("player", name) then
				FoodFrame:SetAlpha(C.reminder.raid_buffs_alpha)
				food = true
				break
			else
				FoodFrame:SetAlpha(1)
				food = false
			end
		end
	end

	for i, statbuffs in pairs(statbuffs) do
		local name, _, icon = GetSpellInfo(statbuffs)
		if i == 1 then
			StatFrame.t:SetTexture(icon)
		end
		if UnitAura("player", name) then
			StatFrame:SetAlpha(C.reminder.raid_buffs_alpha)
			stat = true
			break
		else
			StatFrame:SetAlpha(1)
			stat = false
		end
	end

	for i, staminabuffs in pairs(staminabuffs) do
		local name, _, icon = GetSpellInfo(staminabuffs)
		if i == 1 then
			StaminaFrame.t:SetTexture(icon)
		end
		if UnitAura("player", name) then
			StaminaFrame:SetAlpha(C.reminder.raid_buffs_alpha)
			stamina = true
			break
		else
			StaminaFrame:SetAlpha(1)
			stamina = false
		end
	end

	for i, Spell5Buff in pairs(Spell5Buff) do
		local name, _, icon = GetSpellInfo(Spell5Buff)
		if i == 1 then
			Spell5Frame.t:SetTexture(icon)
		end
		if UnitAura("player", name) then
			Spell5Frame:SetAlpha(C.reminder.raid_buffs_alpha)
			spell5 = true
			break
		else
			Spell5Frame:SetAlpha(1)
			spell5 = false
		end
	end

	for i, Spell6Buff in pairs(Spell6Buff) do
		local name, _, icon = GetSpellInfo(Spell6Buff)
		if i == 1 then
			Spell6Frame.t:SetTexture(icon)
		end
		if UnitAura("player", name) then
			Spell6Frame:SetAlpha(C.reminder.raid_buffs_alpha)
			spell6 = true
			break
		else
			Spell6Frame:SetAlpha(1)
			spell6 = false
		end
	end

	local _, instanceType = IsInInstance()
	if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
		RaidBuffReminder:SetAlpha(0)
		visible = false
	elseif flask == true and food == true and stat == true and stamina == true and spell5 == true and spell6 == true then
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
raidbuff_reminder:SetScript("OnEvent", OnAuraChange)

-- Function to create buttons
local function CreateButton(name, relativeTo, firstbutton)
	local button = CreateFrame("Frame", name, RaidBuffReminder)
	if firstbutton == true then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", relativeTo, "BOTTOMLEFT", 0, 0)
	else
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", relativeTo, "RIGHT", 3, 0)
	end
	button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)

	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.t:SetPoint("TOPLEFT", 2, -2)
	button.t:SetPoint("BOTTOMRIGHT", -2, 2)
end

-- Create Buttons
do
	CreateButton("FlaskFrame", RaidBuffReminder, true)
	CreateButton("FoodFrame", FlaskFrame, false)
	-- CreateButton("StatFrame", FoodFrame, false)
	-- CreateButton("StaminaFrame", StatFrame, false)
	-- CreateButton("Spell5Frame", StaminaFrame, false)
	-- CreateButton("Spell6Frame", Spell5Frame, false)
end