local T, C, L = unpack(ShestakUI)
if C.extra_general.buff_automator ~= true or T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	Personal buff automator(by Gsuz)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "AutomatorFrame")

-- Settings for each class and spec in the format of : Class'TalentTree'
-- PRIEST1 is Disc Priest while MAGE2 is Fire Mage
MAGE1 = {
	6117,	-- Mage Armor
	1459,	-- Arcane Intellect
	543,	-- Mage Ward
}

MAGE2 = {
	34913,	-- Molten Armor
	1459,	-- Arcane Intellect
	543,	-- Mage Ward
}

MAGE3 = {
	7302,	-- Frost Armor
	1459,	-- Arcane Intellect
	543,	-- Mage Ward
	11426,	-- Ice Barrier
}

PRIEST1 = {
	79107,	-- Shadow Protection
	79105,	-- Power Word: Fortitude
	73413,	-- Inner Will
	6346,	-- Fear Ward
}

PRIEST2 = {
	79107,	-- Shadow Protection
	79105,	-- Power Word: Fortitude
	73413,	-- Inner Will
	6346,	-- Fear Ward
}

PRIEST3 = {
	79107,	-- Shadow Protection
	79105,	-- Power Word: Fortitude
	73413,	-- Inner Will
	6346,	-- Fear Ward
}

DEATHKNIGHT1 = {
	49222,	-- Bone Shield
	57330,	-- Horn of Winter
	3714,	-- Path of Frost
}

DEATHKNIGHT2 = {
	57330,	-- Horn of Winter
	3714,	-- Path of Frost
}

DEATHKNIGHT3 = {
	57330,	-- Horn of Winter
	3714,	-- Path of Frost
}

WARRIOR1 = {
	6673,	-- Battle Shout
}

WARRIOR2 = {
	6673,	-- Battle Shout
}

WARRIOR3 = {
	6673,	-- Battle Shout
}

WARLOCK1 = {
	6229,	-- Shadow Ward
	28176,	-- Fel Armor
}

WARLOCK2 = {
	6229,	-- Shadow Ward
	28176,	-- Fel Armor
}

WARLOCK3 = {
	6229,	-- Shadow Ward
	28176,	-- Fel Armor
}

ROGUE1 = {}

ROGUE2 = {}

ROGUE3 = {}

PALADIN1 = {
	20217,	-- Blessing of Kings
	20165,	-- Seal of Insight
}

PALADIN2 = {
	20217,	-- Blessing of Kings
}

PALADIN3 = {
	20217,	-- Blessing of Kings
}

HUNTER1 = {
	13165,	-- Aspect of the Hawk
}

HUNTER2 = {
	13165,	-- Aspect of the Hawk
}

HUNTER3 = {
	13165,	-- Aspect of the Hawk
}

DRUID1 = {
	1126,	-- Mark of the Wild
}

DRUID2 = {
	1126,	-- Mark of the Wild
}

DRUID3 = {
	1126,	-- Mark of the Wild
}

-- Function for waiting through the global cooldown
local GcTimer = 0
local function WaitForGC(self, elapsed)
	GcTimer = GcTimer + elapsed
	if GcTimer >= 1.5 then
		CheckBuffs()
		frame:SetScript("OnUpdate", nil)
		GcTimer = 0
	end
end

-- Create Secure Action Button for better control
local btn = CreateFrame("Button", "AutoBuffButton", UIParent, "SecureActionButtonTemplate")
btn:SetAttribute("type", "action")
btn:SetAttribute("action", 1)
btn:SetAttribute("type", "spell")
btn:SetAttribute("unit", "player")

-- Main function for changing keybinding to mousewheel when a buff is needed
function CheckBuffs()
	local tree = GetPrimaryTalentTree() or 1
	if IsFlying() or IsMounted() or UnitIsDeadOrGhost("Player") or InCombatLockdown() then return end
	ClearOverrideBindings(btn)
	btn:SetAttribute("spell", nil)
	for i, v in pairs(_G[T.class..tree]) do
		local spellname = select(1, GetSpellInfo(v))
		if not UnitAura("player", spellname) then
			if GetSpellCooldown(spellname) == 0 then
				btn:SetAttribute("spell", spellname)
				SetOverrideBindingClick(btn, true, "MOUSEWHEELUP", "AutoBuffButton")
				SetOverrideBindingClick(btn, true, "MOUSEWHEELDOWN", "AutoBuffButton")
			else
				local start, duration, enabled = GetSpellCooldown(spellname)
				if duration == nil or duration > 1.5 then return end
				frame:SetScript("OnUpdate", WaitForGC)
			end
		end
	end
end

-- Events that will trigger the Main Function
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("SPELL_UPDATE_USABLE")
frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
frame:RegisterEvent("PLAYER_LEAVE_COMBAT")
frame:RegisterEvent("READY_CHECK")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:SetScript("OnEvent", CheckBuffs)