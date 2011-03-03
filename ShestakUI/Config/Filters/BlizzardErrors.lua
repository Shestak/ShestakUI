----------------------------------------------------------------------------------------
--	All errors on www.wowwiki.com/WoW_Constants/Errors
----------------------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...))
----------------------------------------------------------------------------------------
--	White list errors, that will not be hidden
----------------------------------------------------------------------------------------
T.white_list = {
	[ERR_INV_FULL] = true,
	[ERR_QUEST_LOG_FULL] = true,
	[ERR_ITEM_MAX_COUNT] = true,
	[ERR_NOT_ENOUGH_MONEY] = true,
	[SPELL_FAILED_IN_COMBAT_RES_LIMIT_REACHED] = true,
	[ERR_LOOT_MASTER_INV_FULL] = true,
	[ERR_LOOT_MASTER_OTHER] = true,
	[ERR_LOOT_MASTER_UNIQUE_ITEM] = true,
}

----------------------------------------------------------------------------------------
--	Black list errors, that will be hidden
----------------------------------------------------------------------------------------
T.black_list = {
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_TARGETS_DEAD] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[SPELL_FAILED_TARGET_AURASTATE] = true,
	[SPELL_FAILED_CASTER_AURASTATE] = true,
	[SPELL_FAILED_NO_ENDURANCE] = true,
	[SPELL_FAILED_BAD_TARGETS] = true,
	[SPELL_FAILED_NOT_MOUNTED] = true,
	[SPELL_FAILED_NOT_ON_TAXI] = true,
	[SPELL_FAILED_NOT_INFRONT] = true,
	[SPELL_FAILED_NOT_IN_CONTROL] = true,
	[SPELL_FAILED_MOVING] = true,
	[SPELL_FAILED_AURA_BOUNCED] = true,
	[ERR_ATTACK_FLEEING] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_GENERIC_NO_TARGET] = true,
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_NO_ATTACK_TARGET] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_RAGE] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_RUNES] = true,
	[ERR_OUT_OF_RUNIC_POWER] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_POWER_DISPLAY] = true,
	[ERR_BADATTACKPOS] = true,
	[ERR_INVALID_ATTACK_TARGET] = true,
	[ERR_NOEMOTEWHILERUNNING] = true,
}