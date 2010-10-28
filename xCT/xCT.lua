if (IsAddOnLoaded("aCombatText") or IsAddOnLoaded("MikScrollingBattleText") or IsAddOnLoaded("xDamageFont") or IsAddOnLoaded("NiceDamage") or IsAddOnLoaded("LightCT")) then return end
--[[

xCT by affli @ RU-Howling Fjord
All rights reserved.
Thanks ALZA and Shestak for making this mod possible. Thanks Tukz for his wonderful style of coding. Thanks Rostok for some fixes and healing code.

]]--
local myname, _ = UnitName("player")

local ct={

	["myclass"] = select(2,UnitClass("player")),
	["myname"] = myname,
---------------------------------------------------------------------------------
-- config
-- use ["option"] = true/false, to set options.
-- options
-- blizz damage options.
	["blizzheadnumbers"] = SettingsCF["combattext"].blizz_head_numbers,	-- use blizzard damage/healing output (above mob/player head)
	["damagestyle"] = SettingsCF["combattext"].damage_style,		-- change default damage/healing font above mobs/player heads. you need to restart WoW to see changes! has no effect if blizzheadnumbers = false
-- xCT outgoing damage/healing options
	["damage"] = SettingsCF["combattext"].damage,		-- show outgoing damage in it's own frame
	["healing"] = SettingsCF["combattext"].healing,		-- show outgoing healing in it's own frame
	["showhots"] = SettingsCF["combattext"].show_hots,		-- show periodic healing effects in xCT healing frame.
	["damagecolor"] = SettingsCF["combattext"].damage_color,		-- display damage numbers depending on school of magic, see http://www.wowwiki.com/API_COMBAT_LOG_EVENT
	["critprefix"] = "|cffFF0000"..SettingsCF["combattext"].crit_prefix.."|r",	-- symbol that will be added before amount, if you deal critical strike/heal. leave "" for empty. default is red *
	["critpostfix"] = "|cffFF0000"..SettingsCF["combattext"].crit_postfix.."|r",	-- postfix symbol, "" for empty.
	["icons"] = SettingsCF["combattext"].icons,		-- show outgoing damage icons
	["iconsize"] = SettingsCF["combattext"].icon_size,		-- icon size of spells in outgoing damage frame, also has effect on dmg font size.
	["petdamage"] = SettingsCF["combattext"].pet_damage,		-- show your pet damage.
	["dotdamage"] = SettingsCF["combattext"].dot_damage,		-- show damage from your dots. someone asked an option to disable lol.
	["treshold"] = SettingsCF["combattext"].treshold,		-- minimum damage to show in outgoing damage frame
	["healtreshold"] = SettingsCF["combattext"].heal_treshold,		-- minimum healing to show in incoming/outgoing healing messages.
	["killingblow"] = SettingsCF["combattext"].killingblow,		-- tells you about your killingblows
	
-- appearence
	["font"] = SettingsCF["font"].combat_text_font,	-- "Fonts\\ARIALN.ttf" is default WoW font.
	["fontsize"] = SettingsCF["font"].combat_text_font_size,
	["fontstyle"] = SettingsCF["font"].combat_text_font_style,	-- valid options are "OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = SettingsCF["font"].combat_text_font,	 -- "Fonts\\FRIZQT__.ttf" is default WoW damage font
	["timevisible"] = SettingsCF["combattext"].time_visible, 		-- time (seconds) a single message will be visible. 3 is a good value.
	["scrollable"] = SettingsCF["combattext"].scrollable,		-- allows you to scroll frame lines with mousewheel.
	["maxlines"] = SettingsCF["combattext"].max_lines,		-- max lines to keep in scrollable mode. more lines=more memory. nom nom nom.

-- class modules and goodies
	["stopvespam"] = SettingsCF["combattext"].stop_ve_spam,		-- automaticly turns off healing spam for priests in shadowform. HIDE THOSE GREEN NUMBERS PLX!
	["dkrunes"] = SettingsCF["combattext"].dk_runes,		-- show deatchknight rune recharge
	["mergeaoespam"] = SettingsCF["combattext"].merge_aoe_spam,	-- merges multiple aoe spam into single message, can be useful for dots too.
	["mergeaoespamtime"] = SettingsCF["combattext"].merge_aoe_spam_time,	-- time in seconds aoe spell will be merged into single message.
}
---------------------------------------------------------------------------------
-- outgoing healing filter, hide this spammy shit, plx
if(ct.healing)then
	ct.healfilter={}
	ct.healfilter[28176]=true -- Fel Armor
	ct.healfilter[63106]=true -- Siphon Life
	ct.healfilter[54181]=true -- Fel Synergy
end
---------------------------------------------------------------------------------
if(ct.mergeaoespam)then
	ct.aoespam={}
	ct.aoespam[27285]=true	-- Seed of Corruption Explosion
	ct.aoespam[172]=true	-- Corruption
	ct.aoespam[30108]=true	-- Unstable Corruption
	ct.aoespam[8921]=true	-- Moonfire
	ct.aoespam[5570]=true	-- Insect Swarm
end
---------------------------------------------------------------------------------
-- class config, overrides general
if ct.myclass == "WARRIOR" then
	-- do something
end
---------------------------------------------------------------------------------
-- character config, overrides general and class
if ct.myname == "Affli" then
	ct["treshold"] = 500
end
---------------------------------------------------------------------------------

--do not edit below unless you know what you are doing

--local numf
if(ct.damage or ct.healing)then
	numf=4
else
	numf=3
end
-- detect vechile
local function SetUnit()
	if(UnitHasVehicleUI("player"))then
		ct.unit="vehicle"
	else
		ct.unit="player"
	end
	CombatTextSetActiveUnit(ct.unit)
end

--limit lines
local function LimitLines()
	for i=1,#ct.frames do
		f=ct.frames[i]
		f:SetMaxLines(f:GetHeight()/ct.fontsize)
	end
end

-- scrollable frames
local function SetScroll()
	for i=1,#ct.frames do
		ct.frames[i]:EnableMouseWheel(true)
		ct.frames[i]:SetScript("OnMouseWheel", function(self,delta)
			if delta >0 then
				self:ScrollUp()
			elseif delta <0 then
				self:ScrollDown()
			end
		end)
	end
end
	
-- msg flow direction
local function ScrollDirection()
	if (COMBAT_TEXT_FLOAT_MODE=="2") then
		ct.mode="TOP"
	else
		ct.mode="BOTTOM"
	end
	for i=1,#ct.frames do
		ct.frames[i]:Clear()
		ct.frames[i]:SetInsertMode(ct.mode)
	end
end
-- partial resists styler
local part="-%s [%s %s]"
local r,g,b
-- the function, handles everything
local function OnEvent(self,event,subevent,...)
if(event=="COMBAT_TEXT_UPDATE")then
	local arg2,arg3 = ...
	if (SHOW_COMBAT_TEXT=="0")then
		return
	else
	if subevent=="DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.1,.1)
	elseif subevent=="DAMAGE_CRIT"then
		xCT1:AddMessage(ct.critprefix.."-"..arg2..ct.critpostfix,1,.1,.1)
	elseif subevent=="SPELL_DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.3,.85)
	elseif subevent=="SPELL_DAMAGE_CRIT"then
		xCT1:AddMessage(ct.critprefix.."-"..arg2..ct.critpostfix,1,.3,.5)

	elseif subevent=="HEAL"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..arg3,.1,.75,.1)
		end
	elseif subevent=="HEAL_CRIT"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..ct.critprefix..arg3..ct.critpostfix,.1,1,.1)
		end
	elseif subevent=="PERIODIC_HEAL"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..arg3,.1,.5,.1)
		end

	elseif subevent=="SPELL_CAST"then
		xCT3:AddMessage(arg2,1,.82,0)

	
	elseif subevent=="MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)
	elseif subevent=="SPELL_MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="SPELL_DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="SPELL_PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="SPELL_EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="SPELL_IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="SPELL_DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="SPELL_REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)

	elseif subevent=="RESIST"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1") then
				xCT1:AddMessage(part:format(arg2,RESIST,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="BLOCK"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="ABSORB"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end
	elseif subevent=="SPELL_RESIST"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1") then
				xCT1:AddMessage(part:format(arg2,RESIST,arg3),.5,.3,.5)
			else
				xCT1:AddMessage(arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="SPELL_BLOCK"then
		if (arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.5,.3,.5)
			else
				xCT1:AddMessage("-"..arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="SPELL_ABSORB"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.5,.3,.5)
			else
				xCT1:AddMessage(arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end

	elseif subevent=="ENERGIZE"and(COMBAT_TEXT_SHOW_ENERGIZE=="1")then
		if  tonumber(arg2)>0 then
			if(arg3 and arg3=="MANA" or arg3=="RAGE" or arg3=="FOCUS" or arg3=="ENERGY" or arg3=="RUINIC_POWER" or arg3=="SOUL_SHARDS")then
				xCT3:AddMessage("+"..arg2.." ".._G[arg3],PowerBarColor[arg3].r,PowerBarColor[arg3].g,PowerBarColor[arg3].b)
			end
		end

	elseif subevent=="PERIODIC_ENERGIZE"and(COMBAT_TEXT_SHOW_PERIODIC_ENERGIZE=="1")then
		if  tonumber(arg2)>0 then
			if(arg3 and arg3=="MANA" or arg3=="RAGE" or arg3=="FOCUS" or arg3=="ENERGY" or arg3=="RUINIC_POWER" or arg3=="SOUL_SHARDS")then
				xCT3:AddMessage("+"..arg2.." ".._G[arg3],PowerBarColor[arg3].r,PowerBarColor[arg3].g,PowerBarColor[arg3].b)
			end
		end
	elseif subevent=="SPELL_AURA_START"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.5,.5)
	elseif subevent=="SPELL_AURA_END"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.5,.5,.5)
	elseif subevent=="SPELL_AURA_START_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.1,.1)
	elseif subevent=="SPELL_AURA_END_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.1,1,.1)

	elseif subevent=="HONOR_GAINED"and(COMBAT_TEXT_SHOW_HONOR_GAINED=="1")then
		arg2=tonumber(arg2)
		if(arg2 and abs(arg2)>1) then
			arg2=floor(arg2)
			if (arg2>0)then
				xCT3:AddMessage(HONOR.." +"..arg2,.1,.1,1)
			end
		end

	elseif subevent=="FACTION"and(COMBAT_TEXT_SHOW_REPUTATION=="1")then
		xCT3:AddMessage(arg2.." +"..arg3,.1,.1,1)

	elseif subevent=="SPELL_ACTIVE"and(COMBAT_TEXT_SHOW_REACTIVES=="1")then
		xCT3:AddMessage(arg2,1,.82,0)
	end
end

elseif event=="UNIT_HEALTH"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if subevent==ct.unit then
		if(UnitHealth(ct.unit)/UnitHealthMax(ct.unit)<=COMBAT_TEXT_LOW_HEALTH_THRESHOLD)then
			if (not lowHealth) then
				xCT3:AddMessage(HEALTH_LOW,1,.1,.1)
				lowHealth=true
			end
		else
			lowHealth=nil
		end
	end

elseif event=="UNIT_MANA"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if subevent==ct.unit then
		local _,powerToken=UnitPowerType(ct.unit)
		if (powerToken=="MANA"and(UnitPower(ct.unit)/UnitPowerMax(ct.unit))<=COMBAT_TEXT_LOW_MANA_THRESHOLD)then
			if (not lowMana)then
				xCT3:AddMessage(MANA_LOW,1,.1,.1)
				lowMana=true
			end
		else
			lowMana=nil
		end
	end

elseif event=="PLAYER_REGEN_ENABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("-"..LEAVING_COMBAT,.1,1,.1)

elseif event=="PLAYER_REGEN_DISABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("+"..ENTERING_COMBAT,1,.1,.1)

elseif event=="UNIT_COMBO_POINTS"and(COMBAT_TEXT_SHOW_COMBO_POINTS=="1")then
	if(subevent==ct.unit)then
		local cp=GetComboPoints(ct.unit,"target")
			if(cp>0)then
				r,g,b=1,.82,.0
				if (cp==MAX_COMBO_POINTS)then
					r,g,b=0,.82,1
				end
				xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS,cp),r,g,b)
			end
	end

elseif event=="RUNE_POWER_UPDATE"then
	local arg1,arg2 = subevent,...
	if(arg2==true)then
		local rune=GetRuneType(arg1);
		local msg=COMBAT_TEXT_RUNE[rune];
		if(rune==1)then 
			r=.75
			g=0
			b=0
		elseif(rune==2)then
			r=.75
			g=1
			b=0
		elseif(rune==3)then
			r=0
			g=1
			b=1	
		end
		if(rune and rune<4)then
			xCT3:AddMessage("+"..msg,r,g,b)
		end
	end

elseif event=="UNIT_ENTERED_VEHICLE"or event=="UNIT_EXITING_VEHICLE"then
	if(arg1=="player")then
		SetUnit()
	end

elseif event=="PLAYER_ENTERING_WORLD"then
	SetUnit()
	if(ct.scrollable)then
		SetScroll()
	else
		LimitLines()
	end
end
end
-- change damage font (if desired)
if(ct.damagestyle)then
	DAMAGE_TEXT_FONT=ct.damagefont
end

-- the frames
ct.locked=true
ct.frames={}
for i=1,numf do
	local f=CreateFrame("ScrollingMessageFrame","xCT"..i,UIParent)
	f:SetFont(ct.font,ct.fontsize,ct.fontstyle)
	f:SetShadowColor(0,0,0,SettingsCF["font"].combat_text_font_shadow and 1 or 0)
	f:SetShadowOffset(SettingsCF["font"].combat_text_font_shadow and 1 or 0, SettingsCF["font"].combat_text_font_shadow and -1 or 0)
	f:SetFading(true)
	f:SetFadeDuration(0.5)
	f:SetTimeVisible(ct.timevisible)
	f:SetMaxLines(ct.maxlines)
	f:SetSpacing(2)
	f:SetWidth(128)
	f:SetHeight(128)
	f:SetJustifyH"LEFT"
	f:SetPoint("CENTER",0,0)
	f:SetMovable(true)
	f:SetResizable(true)
	f:SetMinResize(128,128)
	f:SetMaxResize(768,768)
	f:SetClampedToScreen(true)
	f:SetClampRectInsets(0,0,ct.fontsize,0)
	if(i==1)then
		f:SetJustifyH"LEFT"
		if SettingsCF["unitframe"].enable == true then
			f:SetPoint("BOTTOMLEFT", "oUF_Player", "TOPLEFT", -3, 45)
		else
			f:SetPoint("CENTER",-192,-32)
		end
	elseif(i==2)then
		f:SetJustifyH"RIGHT"
		if SettingsCF["unitframe"].enable == true then
			f:SetPoint("BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 5, 45)
		else
			f:SetPoint("CENTER",192,-32)
		end
	elseif(i==3)then
		f:SetJustifyH"CENTER"
		f:SetWidth(256)
		f:SetPoint("CENTER",0,205)
	else
		f:SetJustifyH"RIGHT"
		f:SetPoint("CENTER",330,205)
	end
	ct.frames[i] = f
end

-- register events
local xCT=CreateFrame"Frame"
xCT:RegisterEvent"COMBAT_TEXT_UPDATE"
xCT:RegisterEvent"UNIT_HEALTH"
xCT:RegisterEvent"UNIT_MANA"
xCT:RegisterEvent"PLAYER_REGEN_DISABLED"
xCT:RegisterEvent"PLAYER_REGEN_ENABLED"
xCT:RegisterEvent"UNIT_COMBO_POINTS"
if(ct.dkrunes and select(2,UnitClass"player")=="DEATHKNIGHT")then
	xCT:RegisterEvent"RUNE_POWER_UPDATE"
end
xCT:RegisterEvent"UNIT_ENTERED_VEHICLE"
xCT:RegisterEvent"UNIT_EXITING_VEHICLE"
xCT:RegisterEvent"PLAYER_ENTERING_WORLD"
xCT:SetScript("OnEvent",OnEvent)

if(ct.killingblow)then
	local xCTkb=CreateFrame"Frame"
	xCTkb:SetScript("OnEvent", function(_, _, _, event, guid, _, _, _, tname)
		if event == "PARTY_KILL" and guid==UnitGUID("player") then
			xCT3:AddMessage("Killing Blow: "..tname, 1, 1, 0)
		end
	end)
	xCTkb:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

-- turn off blizz ct
CombatText:UnregisterAllEvents()
CombatText:SetScript("OnLoad",nil)
CombatText:SetScript("OnEvent",nil)
CombatText:SetScript("OnUpdate",nil)

-- steal external messages sent by other addons using CombatText_AddMessage
Blizzard_CombatText_AddMessage=CombatText_AddMessage
function CombatText_AddMessage(message,scrollFunction,r,g,b,displayType,isStaggered)
	xCT3:AddMessage(message,r,g,b)
end

-- hide some blizz options
InterfaceOptionsCombatTextPanelFriendlyHealerNames:Hide()

-- force hide blizz damage/healing, if desired
if not(ct.blizzheadnumbers==true)then
	InterfaceOptionsCombatTextPanelTargetDamage:Hide()
	InterfaceOptionsCombatTextPanelPeriodicDamage:Hide()
	InterfaceOptionsCombatTextPanelPetDamage:Hide()
	InterfaceOptionsCombatTextPanelHealing:Hide()
	SetCVar("CombatLogPeriodicSpells",0)
	SetCVar("PetMeleeDamage",0)
	SetCVar("CombatDamage",0)
	SetCVar("CombatHealing",0)
end


-- hook blizz float mode selector. blizz sucks, because changing  cVar combatTextFloatMode doesn't fire CVAR_UPDATE
--	hooksecurefunc("InterfaceOptionsCombatTextPanelFCTDropDown_OnClick",ScrollDirection)
--	--COMBAT_TEXT_SCROLL_ARC="" --may cause unexpected bugs, use with caution!

InterfaceOptionsCombatTextPanelFCTDropDown:Hide() -- sorry, blizz fucking bug with SCM:SetInsertMode()

-- modify blizz ct options title lol
InterfaceOptionsCombatTextPanelTitle:SetText(COMBAT_TEXT_LABEL.." (powered by |cffFF0000x|rCT)")

-- color printer
local pr = function(msg)
    print("|cffFF0000x|rCT:", tostring(msg))
end

-- awesome configmode and testmode
local StartConfigmode=function()
	for i=1,#ct.frames do
		f=ct.frames[i]
		f:SetBackdrop({
			bgFile="Interface/Tooltips/UI-Tooltip-Background",
			edgeFile="Interface/Tooltips/UI-Tooltip-Border",
			tile=false,tileSize=0,edgeSize=2,
			insets={left=0,right=0,top=0,bottom=0}})
		f:SetBackdropColor(.1,.1,.1,.8)
		f:SetBackdropBorderColor(.1,.1,.1,.5)

		f.fs=f:CreateFontString(nil,"OVERLAY")
		f.fs:SetFont(ct.font,ct.fontsize,ct.fontstyle)
		f.fs:SetPoint("BOTTOM",f,"TOP",0,0)
		if(i==1)then
			f.fs:SetText(DAMAGE.." (drag me)")
			f.fs:SetTextColor(1,.1,.1,.9)
		elseif(i==2)then
			f.fs:SetText(SHOW_COMBAT_HEALING.."(drag me)")
			f.fs:SetTextColor(.1,1,.1,.9)
		elseif(i==3)then
			f.fs:SetText(COMBAT_TEXT_LABEL.."(drag me)")
			f.fs:SetTextColor(.1,.1,1,.9)
		else
			f.fs:SetText(SCORE_DAMAGE_DONE.." / "..SCORE_HEALING_DONE)
			f.fs:SetTextColor(1,1,0,.9)
		end

		f.t=f:CreateTexture"ARTWORK"
		f.t:SetPoint("TOPLEFT",f,"TOPLEFT",1,-1)
		f.t:SetPoint("TOPRIGHT",f,"TOPRIGHT",-1,-19)
		f.t:SetHeight(20)
		f.t:SetTexture(.5,.5,.5)
		f.t:SetAlpha(.3)

		f.d=f:CreateTexture"ARTWORK"
		f.d:SetHeight(16)
		f.d:SetWidth(16)
		f.d:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-1,1)
		f.d:SetTexture(.5,.5,.5)
		f.d:SetAlpha(.3)

		f.tr=f:CreateTitleRegion()
		f.tr:SetPoint("TOPLEFT",f,"TOPLEFT",0,0)
		f.tr:SetPoint("TOPRIGHT",f,"TOPRIGHT",0,0)
		f.tr:SetHeight(20)

		f:EnableMouse(true)
		f:RegisterForDrag"LeftButton"
		f:SetScript("OnDragStart",f.StartSizing)
		if not(ct.scrollable)then
		f:SetScript("OnSizeChanged",function(self)
			self:SetMaxLines(self:GetHeight()/ct.fontsize)
			self:Clear()
		end)
		end

		f:SetScript("OnDragStop",f.StopMovingOrSizing)
		ct.locked=false
	end
end

local function EndConfigmode()
	for i=1,#ct.frames do
		f=ct.frames[i]
		f:SetBackdrop(nil)
		f.fs:Hide()
		f.fs=nil
		f.t:Hide()
		f.t=nil
		f.d:Hide()
		f.d=nil
		f.tr=nil
		f:EnableMouse(false)
		f:SetScript("OnDragStart",nil)
		f:SetScript("OnDragStop",nil)
		
	end
	ct.locked=true
	pr("Window positions unsaved, don't forget to reload UI.")
end

local function StartTestMode()
--init really random number generator.
	local random=math.random
	random(time());random(); random(time())
	
	local TimeSinceLastUpdate=0
	local UpdateInterval
	if(ct.damagecolor)then
		ct.dmindex={}
		ct.dmindex[1]=1
		ct.dmindex[2]=2
		ct.dmindex[3]=4
		ct.dmindex[4]=8
		ct.dmindex[5]=16
		ct.dmindex[6]=32
		ct.dmindex[7]=64
	end

	
	for i=1,#ct.frames do
	ct.frames[i]:SetScript("OnUpdate",function(self,elapsed)
		UpdateInterval=random(65,1000)/250
		TimeSinceLastUpdate=TimeSinceLastUpdate+elapsed
		if(TimeSinceLastUpdate>UpdateInterval)then
			if(i==1)then
			ct.frames[i]:AddMessage("-"..random(100000),1,random(255)/255,random(255)/255)
			elseif(i==2)then
			ct.frames[i]:AddMessage("+"..random(50000),.1,random(128,255)/255,.1)
			elseif(i==3)then
			ct.frames[i]:AddMessage(COMBAT_TEXT_LABEL,random(255)/255,random(255)/255,random(255)/255)
			elseif(i==4)then
				local msg
				local icon
				local color={}
				msg=random(40000)
				if(ct.icons)then
					_,_,icon=GetSpellInfo(msg)
				end
				if(icon)then
					msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					if(ct.damagecolor)then
						color=ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
					else
						color={1,1,0}
					end
				elseif(ct.damagecolor) and not(ct.icons)then
					color=ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
				elseif not(ct.damagecolor)then
					color={1,1,random(0,1)}
				end
				ct.frames[i]:AddMessage(msg,unpack(color))
				
			end
			TimeSinceLastUpdate = 0
		end
		end)		
	ct.testmode=true
end
end

local function EndTestMode()
	for i=1,#ct.frames do
		ct.frames[i]:SetScript("OnUpdate",nil)
		ct.frames[i]:Clear()
	end
	if(ct.damagecolor)then
		ct.dmindex=nil
	end
	ct.testmode=false
	end

-- /xct lock popup dialog
StaticPopupDialogs["XCT_LOCK"]={
	text="To save |cffFF0000x|rCT window positions you need to reload your UI.\n Click "..ACCEPT.." to reload UI.\nClick "..CANCEL.." to do it later.",
	button1=ACCEPT,
	button2=CANCEL,
	OnAccept=ReloadUI,
	OnCancel=EndConfigmode,
	timeout=0,
	whileDead=1,
	hideOnEscape=true,
	showAlert=true,
}

-- slash commands
SLASH_XCT1="/xct"
SlashCmdList["XCT"]=function(input)
	input=string.lower(input)
	if(input=="unlock")then
		if (ct.locked)then
			StartConfigmode()
			pr("unlocked.")
		else
			pr("already unlocked.")
		end
	elseif(input=="lock")then
		if (ct.locked) then
			pr("already locked.")
		else
			StaticPopup_Show("XCT_LOCK")
		end
	elseif(input=="test")then
		if (ct.testmode) then
			EndTestMode()
			pr("test mode disabled.")
		else
			StartTestMode()
			pr("test mode enabled.")
		end

	else
		pr("use |cffFF0000/xct unlock|r to move and resize frames.")
		pr("use |cffFF0000/xct lock|r to lock frames.")
		pr("use |cffFF0000/xct test|r to toggle testmode (sample xCT output).")
	end
end

-- awesome shadow priest helper
if(ct.stopvespam and ct.myclass=="PRIEST")then
	local sp=CreateFrame("Frame")
	sp:SetScript("OnEvent",function(...)
		if(GetShapeshiftForm()==1)then
			if(ct.blizzheadnumbers)then
				SetCVar('CombatHealing',0)
			end
			ct.shadowform=true
		else
			if(ct.blizzheadnumbers)then
				SetCVar('CombatHealing',1)
			end
			ct.shadowform=false
		end
	end)
	sp:RegisterEvent("PLAYER_ENTERING_WORLD")	
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
end

-- damage
local SQ
if(ct.damage)then
	local xCTd=CreateFrame"Frame"
	if(ct.damagecolor)then
		ct.dmgcolor={}
		ct.dmgcolor[1]={1,1,0} -- physical
		ct.dmgcolor[2]={1,.9,.5} -- holy
		ct.dmgcolor[4]={1,.5,0} -- fire
		ct.dmgcolor[8]={.3,1,.3} -- nature
		ct.dmgcolor[16]={.5,1,1} -- frost
		ct.dmgcolor[32]={.5,.5,1} -- shadow
		ct.dmgcolor[64]={1,.5,1} -- arcane
	end
	
	if(ct.icons)then
		ct.blank="Interface\\AddOns\\ShestakUI\\media\\blank"
	end

	if(ct.mergeaoespam)then
		local pairs=pairs
		SQ={}
		for k,v in pairs(ct.aoespam) do
			SQ[k]={queue = 0, msg = "", color={}, count=0}
		end
		ct.SpamQueue=function(spellId, add)
			local amount
			local spam=SQ[spellId]["queue"]
			if (spam and type(spam=="number"))then
				amount=spam+add
			else
				amount=add
			end
			return amount
		end
		local tslu=0
		local xCTspam=CreateFrame"Frame"
		xCTspam:SetScript("OnUpdate", function(self, elapsed)
			local count
			tslu=tslu+elapsed
			if tslu > ct.mergeaoespamtime then
				tslu=0
				for k,v in pairs(SQ) do
					if SQ[k]["queue"]>0 then
						if SQ[k]["count"]>1 then
							count=" |cffFFFFFFx"..SQ[k]["count"].."|r"
						else
							count=""
						end
						xCT4:AddMessage(SQ[k]["queue"]..SQ[k]["msg"]..count, unpack(SQ[k]["color"]))
						SQ[k]["queue"]=0
						SQ[k]["count"]=0
					end
				end
			end
		end)
	end

	local dmg=function(self,event,...) 
		local unpack,select=unpack,select
		local msg,icon
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1,...)
		if(sourceGUID==UnitGUID"player")or(sourceGUID==UnitGUID"pet" and ct.petdamage)then
			if(eventType=="SWING_DAMAGE")then
				local amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					msg=amount
					if (critical) then
						msg=ct.critprefix..msg..ct.critpostfix
					end
					if(ct.icons)then
						if(sourceGUID==UnitGUID"pet")then
							icon=PET_ATTACK_TEXTURE
						else
							icon=GetSpellTexture(1, BOOKTYPE_SPELL)
						end
						msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					end
	
					xCT4:AddMessage(msg)
				end
			elseif(eventType=="RANGE_DAMAGE")then
				local spellId,_,_,amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					msg=amount
					if (critical) then
						msg=ct.critprefix..msg..ct.critpostfix
					end
					if(ct.icons)then
						local _,_,icon=GetSpellInfo(spellId)
						msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					end
	
					xCT4:AddMessage(msg)
				end
	
			elseif(eventType=="SPELL_DAMAGE")or(eventType=="SPELL_PERIODIC_DAMAGE" and ct.dotdamage)then
				local spellId,_,spellSchool,amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					local color={}
					local rawamount=amount
					if (critical) then
						amount=ct.critprefix..amount..ct.critpostfix
					end
	
					if(ct.icons)then
						_,_,icon=GetSpellInfo(spellId)
					end
					if(ct.damagecolor)then
						if(ct.dmgcolor[spellSchool])then
							color=ct.dmgcolor[spellSchool]
						else
							color=ct.dmgcolor[1]
						end
					else
						color={1,1,0}
					end
					if (icon) then
						msg=" \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					elseif(ct.icons)then
						msg=" \124T"..ct.blank..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					end
					if ct.mergeaoespam and ct.aoespam[spellId] then
						SQ[spellId]["queue"]=ct.SpamQueue(spellId, rawamount)
						SQ[spellId]["msg"]=msg
						SQ[spellId]["color"]=color
						SQ[spellId]["count"]=SQ[spellId]["count"]+1
						return
					end
					
					xCT4:AddMessage(amount.." "..msg,unpack(color))
				end
	
			elseif(eventType=="SWING_MISSED")then
				local missType,_=select(9,...)
				if(ct.icons)then
					if(sourceGUID==UnitGUID"pet")then
						icon=PET_ATTACK_TEXTURE
					else
						icon=GetSpellTexture(1, BOOKTYPE_SPELL)
					end
					missType=missType.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
				end
	
				xCT4:AddMessage(missType)
	
			elseif(eventType=="SPELL_MISSED")or(eventType=="RANGE_MISSED")then
				local spellId,_,_,missType,_ = select(9,...)
				if(ct.icons)then
					_,_,icon=GetSpellInfo(spellId)
					missType=missType.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
				end 
				xCT4:AddMessage(missType)
	
			
			end
		end
	end
	xCTd:RegisterEvent"COMBAT_LOG_EVENT_UNFILTERED"
	xCTd:SetScript("OnEvent",dmg)
end
if(ct.healing)then
	local xCTh=CreateFrame"Frame"
	if(ct.icons)then
		ct.blank="Interface\\AddOns\\ShestakUI\\media\\blank"
	end
	local heal=function(self,event,...) 
		local unpack,select=unpack,select
		local msg,icon
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1,...)
		if(sourceGUID==UnitGUID"player")then
			if(eventType=='SPELL_HEAL')or(eventType=='SPELL_PERIODIC_HEAL'and ct.showhots)then
				if(ct.healing)then
					local spellId,spellName,spellSchool,amount,overhealing,absorbed,critical = select(9,...)
					if(ct.healfilter[spellId]) then
						return
					end
					if(amount>=ct.healtreshold)then
						local color={}
						if(ct.stopvespam and ct.shadowform and spellId==15290)then
							return
						end
						if (critical) then 
							msg=ct.critprefix..amount..ct.critpostfix
							color={.1,1,.1}
						else
							msg=amount
							color={.1,.75,.1}
						end 
						if(ct.icons)then
							_,_,icon=GetSpellInfo(spellId)
						end
               					if (icon) then 
                					msg=msg..' \124T'..icon..':'..ct.iconsize..':'..ct.iconsize..':0:0:64:64:5:59:5:59\124t'
						elseif(ct.icons)then
							msg=msg.." \124T"..ct.blank..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
                				end 
						xCT4:AddMessage(msg,unpack(color))
					end
				end
			end
		end
	end
	xCTh:RegisterEvent"COMBAT_LOG_EVENT_UNFILTERED"
	xCTh:SetScript("OnEvent",heal)
end