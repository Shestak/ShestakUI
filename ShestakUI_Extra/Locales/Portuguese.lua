local T, C, L, _ = unpack(ShestakUI)
if T.client ~= "ptBR" and T.client ~= "ptPT" then return end

----------------------------------------------------------------------------------------
--	Localization for ptBR and ptPT client
--	Translation: Need full translation
----------------------------------------------------------------------------------------
-- Key binding Header Name
L_EXTRA_HEADER_EXTRABAR = "Extra Bar"

-- Announce fps
L_EXTRA_ANNOUNCE_FPS = "My current FPS is "

-- BG announce
L_EXTRA_ANNOUNCE_BG_LIGHT = "Light attack incoming to "
L_EXTRA_ANNOUNCE_BG_MEDIUM = "Medium attack incoming to "
L_EXTRA_ANNOUNCE_BG_HEAVY = "Heavy attack incoming to "
L_EXTRA_ANNOUNCE_BG_CLEAR = "All clear at "
L_EXTRA_ANNOUNCE_BG_FOCUS = "Focus Damage on "
L_EXTRA_ANNOUNCE_BG_STEALTH = "Stealthed Enemies Nearby"

-- Taunt announce
L_EXTRA_TAUNT_UNKNOWN = "Unknown command:"
L_EXTRA_TAUNT_ADD = "Add tank"
L_EXTRA_TAUNT_DEL = "Delete tank"
L_EXTRA_TAUNT_DEL_ALL = "Delete all tanks"
L_EXTRA_TAUNT_TANK_LIST = "List of tanks"
L_EXTRA_TAUNT_AURA = "Auras check"
L_EXTRA_TAUNT_AURA_CHECK = "Auras check done."
L_EXTRA_TAUNT_ALREADY_LIST = " is already in the list."
L_EXTRA_TAUNT_ADDED_TANK = "Added tank "
L_EXTRA_TAUNT_REMOVED_TANK = "Removed tank "
L_EXTRA_TAUNT_TARGET_FIRST = "You have to target a group member first."
L_EXTRA_TAUNT_ALL_REMOVED = "All custom tanks removed."