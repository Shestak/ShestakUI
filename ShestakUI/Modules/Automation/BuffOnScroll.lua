local T, C, L, _ = unpack(select(2, ...))
if C.automation.buff_on_scroll ~= true or T.level ~= MAX_PLAYER_LEVEL then return end

----------------------------------------------------------------------------------------
--	Cast buff on mouse scroll(by Gsuz)
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000WARNING: spell ID ["..tostring(id).."] no longer exists! Report this to Shestak.|r")
		return "Empty"
	end
end

local spells = {
	MAGE = {
		[SpellName(1459)] = true,	-- Arcane Intellect
	},

	PRIEST = {
		[SpellName(21562)] = true,	-- Power Word: Fortitude
	},

	WARRIOR = {
		[SpellName(6673)] = true,	-- Battle Shout
	},
}

local specSpells = spells[T.class]
local frame = CreateFrame("Frame")
-- Function for waiting through the global cooldown
local GcTimer, CheckBuffs = 0
local function WaitForGC(_, elapsed)
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
	if IsFlying() or IsMounted() or UnitIsDeadOrGhost("Player") or InCombatLockdown() then return end
	ClearOverrideBindings(btn)
	btn:SetAttribute("spell", nil)
	if specSpells then
		for name in pairs(specSpells) do
			if name and not T.CheckPlayerBuff(name) then
				if GetSpellCooldown(name) == 0 then
					btn:SetAttribute("spell", name)
					SetOverrideBindingClick(btn, true, "MOUSEWHEELUP", "AutoBuffButton")
					SetOverrideBindingClick(btn, true, "MOUSEWHEELDOWN", "AutoBuffButton")
				else
					local _, duration = GetSpellCooldown(name)
					if duration == nil or duration > 1.5 then return end
					frame:SetScript("OnUpdate", WaitForGC)
				end
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