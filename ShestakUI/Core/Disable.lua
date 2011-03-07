local T, C, L = unpack(select(2, ...))

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
	C.actionbar.shapeshift_horizontal = false
end

if C.error.black == true and C.error.white == true then
	C.error.white = false
end

if C.error.hide == true and C.error.combat == true then
	C.error.hide = false
end

----------------------------------------------------------------------------------------
--	Auto-overwrite script config is X addon is found
----------------------------------------------------------------------------------------
if (IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames")) then
	C.unitframe.enable = false
end

if (IsAddOnLoaded("Grid") or IsAddOnLoaded("Grid2") or IsAddOnLoaded("HealBot") or IsAddOnLoaded("VuhDo") or IsAddOnLoaded("oUF_Freebgrid")) then
	C.unitframe.show_party = false
	C.unitframe.show_raid = false
end

if (IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates")) then
	C.nameplate.enable = false
end

if (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4")) then
	C.actionbar.enable = false
end

if (IsAddOnLoaded("Mapster")) then
	C.map.enable = false
end

if (IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
	C.chat.enable = false
end

if (IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar")) then
	C.unitframe.unit_castbar = false
end

if (IsAddOnLoaded("Afflicted3") or IsAddOnLoaded("InterruptBar") or IsAddOnLoaded("alEnemyCD")) then
	C.enemycooldown.enable = false
end

if (IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip")) then
	C.tooltip.enable = false
end

if (IsAddOnLoaded("Gladius")) then
	C.unitframe.show_arena = false
end

if (IsAddOnLoaded("Omen") or IsAddOnLoaded("sThreatMeter2") or IsAddOnLoaded("SkadaThreat")) then
	C.threat.enable = false
end

if (IsAddOnLoaded("DBM-SpellTimers") or IsAddOnLoaded("alRaidCD")) then
	C.raidcooldown.enable = false
end

if (IsAddOnLoaded("TipTacTalents")) then
	C.tooltip.talents = false
end

if (IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags")) then
	C.bag.enable = false
end

if (IsAddOnLoaded("MikScrollingBattleText")) then
	C.combattext.enable = false
end