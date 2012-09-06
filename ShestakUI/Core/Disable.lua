local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Prevent users config errors
----------------------------------------------------------------------------------------
if C.actionbar.rightbars > 3 then
	C.actionbar.rightbars = 3
end

if C.actionbar.bottombars > 3 then
	C.actionbar.bottombars = 3
end

if C.actionbar.bottombars == 3 and C.actionbar.rightbars == 3 then
	C.actionbar.bottombars = 3
	C.actionbar.rightbars = 2
end

if C.actionbar.split_bars == true then
	C.actionbar.bottombars = 3
	C.actionbar.rightbars = 2
end

if C.actionbar.bottombars < 1 then
	C.actionbar.bottombars = 1
end

if C.actionbar.petbar_horizontal == true then
	C.actionbar.stancebar_horizontal = false
end

if C.error.black == true and C.error.white == true then
	C.error.white = false
end

if C.error.combat == true then
	C.error.black = false
	C.error.white = false
end

----------------------------------------------------------------------------------------
--	Auto-overwrite script config is X addon is found
----------------------------------------------------------------------------------------
if IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") then
	C.unitframe.enable = false
end

if IsAddOnLoaded("Grid") or IsAddOnLoaded("Grid2") or IsAddOnLoaded("HealBot") or IsAddOnLoaded("VuhDo") or IsAddOnLoaded("oUF_Freebgrid") then
	C.raidframe.show_party = false
	C.raidframe.show_raid = false
end

if IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates") then
	C.nameplate.enable = false
end

if IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("RazerNaga") then
	C.actionbar.enable = false
end

if IsAddOnLoaded("Mapster") then
	C.map.enable = false
end

if IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter") then
	C.chat.enable = false
end

if IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar") then
	C.unitframe.unit_castbar = false
	C.unitframe.plugins_swing = false
	C.unitframe.plugins_gcd = false
end

if IsAddOnLoaded("Afflicted3") or IsAddOnLoaded("InterruptBar") or IsAddOnLoaded("alEnemyCD") then
	C.enemycooldown.enable = false
end

if IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip") or IsAddOnLoaded("bTooltip") or IsAddOnLoaded("PhoenixTooltip") or IsAddOnLoaded("Icetip") then
	C.tooltip.enable = false
end

if IsAddOnLoaded("Gladius") then
	C.unitframe.show_arena = false
end

if IsAddOnLoaded("Omen") or IsAddOnLoaded("sThreatMeter2") or IsAddOnLoaded("SkadaThreat") or IsAddOnLoaded("RecountThreat") then
	C.threat.enable = false
end

if IsAddOnLoaded("DBM-SpellTimers") or IsAddOnLoaded("alRaidCD") then
	C.raidcooldown.enable = false
end

if IsAddOnLoaded("TipTacTalents") then
	C.tooltip.talents = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") or IsAddOnLoaded("TBag") then
	C.bag.enable = false
end

if IsAddOnLoaded("MikScrollingBattleText") or IsAddOnLoaded("Parrot") or IsAddOnLoaded("xCT") or IsAddOnLoaded("sct") then
	C.combattext.enable = false
end

if IsAddOnLoaded("Doom_CooldownPulse") then
	C.pulsecooldown.enable = false
end

if IsAddOnLoaded("GnomishVendorShrinker") then
	C.misc.already_known = false
end

if IsAddOnLoaded("Clique") or IsAddOnLoaded("sBinder") then
	C.misc.click_cast = false
end

if IsAddOnLoaded("RaidSlackCheck") then
	C.announcements.flask_food = false
end

if IsAddOnLoaded("PhoenixStyle") then
	C.announcements.toy_train = false
	C.announcements.pull_countdown = false
end