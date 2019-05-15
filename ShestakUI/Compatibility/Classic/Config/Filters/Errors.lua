local T, C, L, _ = unpack(select(2, ...))
if not T.classic or (C.error.white ~= true and C.error.black ~= true) then return end

----------------------------------------------------------------------------------------
--	All errors on http://wowwiki.wikia.com/wiki/WoW_Constants/Errors
----------------------------------------------------------------------------------------

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
	[SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW] = true,
	[SPELL_FAILED_AFFECTING_COMBAT] = true,
	[ERR_ATTACK_FLEEING] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_GENERIC_NO_TARGET] = true,
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_NO_ATTACK_TARGET] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_RAGE] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_POWER_DISPLAY] = true,
	[ERR_OUT_OF_RANGE] = true,
	[ERR_BADATTACKPOS] = true,
	[ERR_INVALID_ATTACK_TARGET] = true,
	[ERR_NOEMOTEWHILERUNNING] = true,
	[ERR_NOT_EQUIPPABLE] = true,
	[ERR_NOT_IN_COMBAT] = true,
	[ERR_MAIL_DATABASE_ERROR] = true,
	[OUT_OF_POWER_DISPLAY] = true,
	[OUT_OF_ENERGY] = true,
	[OUT_OF_FOCUS] = true,
	[OUT_OF_MANA] = true,
	[OUT_OF_POWER_DISPLAY] = true,
	[OUT_OF_RAGE] = true,
	[ERR_SPELL_OUT_OF_RANGE] = true,
	[ERR_TOO_FAR_TO_INTERACT] = true,
}