--進入/退出戰鬥提示
local T, C, L, _ = unpack(select(2, ...))
if C.zzz.CombatAlert ~= true then return end

-----------------------------------------------------------------
-----------------------------------------------------------------
local Combat_s = false	--true/false  进战随机漫画材质
local Combat_e = false	--true/false  退战随机漫画材质
local Combat_d = false	--true/false  死亡随机漫画材质
local Combat_t = true	--true/false  随机文字提示

list = {
	Texture = {
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert1",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert2",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert3",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert4",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert5",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert6",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert7",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert8",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert9",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert10",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert11",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert12",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert13",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert14",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert15",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert16",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert17",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert18",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert19",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert20",
		"Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert21",
	},
	s_msg =  {"> >  戰鬥  < <"},
	e_msg =  {"> >  脱离戰鬥  < <"},
	d_msg =  {"> >  死亡  < <"},
}
-----------------------------------------------------------------
-----------------------------------------------------------------
local MyAddon = CreateFrame("Frame")
MyAddon:RegisterEvent("PLAYER_REGEN_ENABLED")			--脫離戰鬥
MyAddon:RegisterEvent("PLAYER_REGEN_DISABLED")			--戰鬥
MyAddon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")	--战斗记录事件触发，用于打断提示
MyAddon:RegisterEvent("PLAYER_DEAD")					--死亡
MyAddon:RegisterEvent("UNIT_HEALTH")					-- 血量
MyAddon:RegisterEvent("UNIT_POWER")						--法力
MyAddon:RegisterEvent("PLAYER_TARGET_CHANGED")			--目标改变
MyAddon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")	--切换天赋

local CombatAlert = CreateFrame("Frame")
CombatAlert:SetSize(1, 1)
CombatAlert:SetFrameLevel(99)
CombatAlert:SetPoint("CENTER")
CombatAlert:Hide()

--进入战斗
CombatAlert.s = CombatAlert:CreateTexture(nil, "HIGH")
CombatAlert.s:SetSize(128, 128)
CombatAlert.s:Hide()
if Combat_s == true then
	CombatAlert.s:SetPoint("CENTER", 0, -200)
elseif Combat_s == false then
	CombatAlert.s:SetPoint("CENTER", 0, -100)
	CombatAlert.s:SetTexture("Interface\\AddOns\\zUI\\media\\CombatAlert\\ComatAlert_start")
end

--离开战斗
CombatAlert.e = CombatAlert:CreateTexture(nil, "HIGH")
CombatAlert.e:SetSize(128, 128)
CombatAlert.e:Hide()
if Combat_e == true then
	CombatAlert.e:SetPoint("CENTER", 0, -200)
elseif Combat_e == false then
	CombatAlert.e:SetPoint("CENTER", 0, -100)
	local factionGroup = UnitFactionGroup("player")
	if factionGroup == "Alliance" then
		CombatAlert.e:SetTexture("Interface\\AddOns\\zUI\\media\\CombatAlert\\Alliance_Logo")
	elseif factionGroup == "Horde" then
		CombatAlert.e:SetTexture("Interface\\AddOns\\zUI\\media\\CombatAlert\\Horde_Logo")
	elseif factionGroup == "Neutral" then
		CombatAlert.e:SetTexture(nil)
	end
end

CombatAlert.t = CombatAlert:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
CombatAlert.t:SetPoint("CENTER", 0, 200)
CombatAlert.t:SetFont(STANDARD_TEXT_FONT, 100, "OUTLINE")	--("OUTLINE"=细描边;"THICKOUTLINE"=粗描边;"OUTLINEMONOCHROME"=像素描边)
CombatAlert.t:SetJustifyH("CENTER")
CombatAlert.t:Hide()

--灵魂/死亡
local Die = CreateFrame("Frame")
Die:SetSize(1, 1)
Die:SetFrameLevel(99)
Die:SetPoint("CENTER")
Die:Hide()
Die.d = Die:CreateTexture(nil, "HIGH")
Die.d:SetSize(256, 256)
Die.d:SetPoint("CENTER", 0, -200)
Die.d:Hide()

Die.m = CreateFrame("PlayerModel", Die)
Die.m:SetPoint("CENTER", Die, "CENTER", 0, -200)
Die.m:SetHeight(300)
Die.m:SetWidth(300)
Die.m:SetDisplayInfo(32803)	--灵魂医者的模型
Die.m:Hide()

Die.t = Die:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
Die.t:SetPoint("CENTER", 0, 200)
Die.t:SetTextColor(0, 0, 0.6)
Die.t:SetFont(STANDARD_TEXT_FONT, 100, "OUTLINE")	--("OUTLINE"=细描边;"THICKOUTLINE"=粗描边;"OUTLINEMONOCHROME"=像素描边)
Die.t:SetJustifyH("CENTER")
Die.t:Hide()

-----------------------------------------------------------------
-----------------------------------------------------------------
MyAddon:SetScript("OnEvent", function(self, event)
	if UnitIsDeadOrGhost("player") then  --灵魂/死亡
		Die:Show()
		CombatAlert:Hide()
		if Combat_d == true then
			Die.d:Show()
			Die.d:SetTexture(list.Texture[math.random(1,table.getn(list.Texture))])
		elseif Combat_d == false then
			Die.m:Show()
		end
		if Combat_t == true then
			Die.t:Show()
			Die.t:SetTextColor(0.37, 0.3, 0.3)
			Die.t:SetText(list.d_msg[math.random(1,table.getn(list.d_msg))])
		end
	else
		Die:Hide()
		Die.d:Hide()
		Die.m:Hide()
	end	
	if not UnitIsDeadOrGhost("player") then
		if event == "PLAYER_REGEN_DISABLED" then  --戰鬥
			CombatAlert:Show()
			CombatAlert.s:Show()
			CombatAlert.e:Hide()
			if Combat_s == true then
				CombatAlert.s:SetTexture(list.Texture[math.random(1,table.getn(list.Texture))])
			end
			if Combat_t == true then
				CombatAlert.t:Show()
				CombatAlert.t:SetTextColor(1, 0, 0)
				CombatAlert.t:SetText(list.s_msg[math.random(1,table.getn(list.s_msg))])
			end
		elseif event == "PLAYER_REGEN_ENABLED" then  --脫離戰鬥
			CombatAlert:Show()
			CombatAlert.s:Hide()
			CombatAlert.e:Show()
			if Combat_e == true then
				CombatAlert.e:SetTexture(list.Texture[math.random(1,table.getn(list.Texture))])
			end
			if Combat_t == true then
				CombatAlert.t:Show()
				CombatAlert.t:SetTextColor(1, 0.82, 0)
				CombatAlert.t:SetText(list.e_msg[math.random(1,table.getn(list.e_msg))])
			end
		end
	end
end)

local timer = 0
CombatAlert:SetScript("OnShow", function(self)
	timer = 0
	self:SetScript("OnUpdate", function(self, elasped)
		timer = timer + elasped
		if (timer<0.5) then
			self:SetAlpha(timer*2)
		elseif (timer>1 and timer<1.5) then
			self:SetAlpha(1-(timer-1)*2)
		elseif (timer>=1.5) then
			self:Hide()
		end
	end)
end)