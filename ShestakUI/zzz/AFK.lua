local T, C, L, _ = unpack(select(2, ...))
if C.zzz.AFK ~= true then return end

----------------------------------------------------------------------------------------------------
-- Tips
----------------------------------------------------------------------------------------------------
L["TIPS"] = {
	"点击小地图上的时钟可以打开日历。",
	"如何把团队框架显示为职业颜色？插件设置→单位框体→样式→经典主题",
	"如何显示独立的施法条？插件设置→单位框体→施法条→独立的玩家施法条",
	"如何只显示治疗模式的团队框架？插件设置→团队框架→切换→禁用自动切换并选择治疗模式",
	"如何把动作条1和2交换位置？插件设置→动作条→主动做条→将动作条1放在动作条2上面",
	"如何改变特定怪物姓名版的颜色？插件设置→单位姓名版→自定义颜色",
	"如何改变小地图的大小？插件设置→其他→缩放按钮高度",
	"命令：/rl - 重载界面 ",
	"命令：/hb - 按键绑定模式",
	"SHIFT+左键 - 设置焦点。点击单位框体也可以哦！",
	"ALT+单击物品 - 快速分解、研磨、选矿、开锁",
	"激活输入框时点击Tab可以切换聊天频道",
	"字体文件在哪里？Interface\\AddOns\\Aurora\\media\\font.ttf(主要字体)，Interface\\AddOns\\AltzUI\\media\\number.ttf(一些时间文本用的字体)",
 }
----------------------------------------------------------------------------------------------------
-- Functions
----------------------------------------------------------------------------------------------------
local function CreateBD(f, a)
	f:SetBackdrop({
		bgFile = C.media.blank,
		edgeFile = C.media.blank,
		edgeSize = 1,
	})
	f:SetBackdropColor(0, 0, 0, a)
	f:SetBackdropBorderColor(0, 0, 0)
	--if not a then tinsert(C.frames, f) end
end

local function SetBD(f, x, y, x2, y2)
	local bg = CreateFrame("Frame", nil, f)
	if not x then
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
	else
		bg:SetPoint("TOPLEFT", x, y)
		bg:SetPoint("BOTTOMRIGHT", x2, y2)
	end
	bg:SetFrameLevel(f:GetFrameLevel()-1)
	CreateBD(bg, 0.7)
end

local function createtext(f, layer, fontsize, flag, justifyh)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[T.class]
	local text = f:CreateFontString(nil, layer)
	text:SetFont(STANDARD_TEXT_FONT, fontsize, flag)
	text:SetJustifyH(justifyh)
	text:SetTextColor(color.r, color.g, color.b)
	return text
end

local ColorGradient = function(perc, ...)-- http://www.wowwiki.com/ColorGradient
    if (perc > 1) then
        local r, g, b = select(select('#', ...) - 2, ...) return r, g, b
    elseif (perc < 0) then
        local r, g, b = ... return r, g, b
    end

    local num = select('#', ...) / 3

    local segment, relperc = math.modf(perc*(num-1))
    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

----------------------------------------------------------------------------------------------------
-- Screen
----------------------------------------------------------------------------------------------------
local TOPPANEL = CreateFrame("Frame","AFK toppanel", WorldFrame)
TOPPANEL:SetFrameStrata("FULLSCREEN")
TOPPANEL:SetPoint("TOPLEFT",WorldFrame,"TOPLEFT",0,0)
TOPPANEL:SetPoint("BOTTOMRIGHT",WorldFrame,"TOPRIGHT",0,-60)
SetBD(TOPPANEL)
TOPPANEL:Hide()
TOPPANEL:RegisterEvent("PLAYER_LOGIN")

TOPPANEL.wowlogo = TOPPANEL:CreateTexture(nil, 'OVERLAY')
TOPPANEL.wowlogo:SetTexture("Interface\\Glues\\Common\\GLUES-WOW-WODLOGO")
TOPPANEL.wowlogo:SetPoint("TOP", TOPPANEL, "TOP", 0, -5)
TOPPANEL.wowlogo:SetSize(200, 100)

TOPPANEL.date = createtext(TOPPANEL, "OVERLAY", 9, "OUTLINE", "RIGHT")
TOPPANEL.date:SetPoint("RIGHT", TOPPANEL, "RIGHT", -20, 10)
TOPPANEL:SetScript("OnEvent",function(self)
	-- Create Date
	local curDate = date("%Y, %b %d, %a")
	local function createDate()
		local today = date("%Y, %b %d, %a")
		-- stop if the date is the same
		if today == curDate then return end
		-- update if not
		TOPPANEL.date:SetText(today)
	end
	createDate()
	TOPPANEL.date:SetText(curDate)
end)

TOPPANEL.time = createtext(TOPPANEL, "OVERLAY", 20, "OUTLINE", "RIGHT")
TOPPANEL.time:SetPoint("RIGHT", TOPPANEL, "RIGHT", -20, -10)
TOPPANEL:SetScript("OnUpdate",function(self,elapsed)
	TOPPANEL.time:SetText(format("%s:%s:%s",date("%H"),date("%M"),date("%S")))
end)

local BOTTOMPANEL = CreateFrame("Frame","AFK Bottompanel", WorldFrame)
BOTTOMPANEL:SetFrameStrata("FULLSCREEN")
BOTTOMPANEL:SetPoint("BOTTOMLEFT",WorldFrame,"BOTTOMLEFT",-5,-5)
BOTTOMPANEL:SetPoint("TOPRIGHT",WorldFrame,"BOTTOMRIGHT",5,60)
SetBD(BOTTOMPANEL)
BOTTOMPANEL:Hide()

local Model = CreateFrame("PlayerModel", "afkModel", BOTTOMPANEL)
Model:SetSize(380, 380)
Model:SetPoint("BOTTOMLEFT", BOTTOMPANEL, "BOTTOMLEFT", 0, 30) 
Model:SetCamera(1)
Model:SetUnit("player")
Model:SetAnimation(69)
--[[BOTTOMPANEL:RegisterEvent("PLAYER_ENTERING_WORLD")
BOTTOMPANEL:RegisterEvent("PLAYER_FLAGS_CHANGED")
Model:SetScript("OnEvent",function(self, event) 
	if event == "PLAYER_ENTERING_WORLD" then
		self:SetUnit("player")
		self:SetAnimation(69)
	elseif event == "PLAYER_FLAGS_CHANGED" then
		if UnitIsAFK("player") then
			self:SetUnit("player")
			self:SetAnimation(69)
		end
	end
end)]]

local factionGroup = UnitFactionGroup("player");
BOTTOMPANEL.faction = BOTTOMPANEL:CreateTexture(nil, 'OVERLAY')
BOTTOMPANEL.faction:SetPoint("LEFT", BOTTOMPANEL, "LEFT", 80, 5)
BOTTOMPANEL.faction:SetTexture("Interface\\Timer\\"..factionGroup.."-Logo")
BOTTOMPANEL.faction:SetSize(60, 60)
	
BOTTOMPANEL.name = createtext(BOTTOMPANEL, "OVERLAY", 10, "OUTLINE", "CENTER")
BOTTOMPANEL.name:SetPoint("TOP", Model, "BOTTOM", 0, 20)
BOTTOMPANEL.name:SetText(T.name.." - "..T.realm.."\n"..LEVEL.." "..T.level.." "..T.race)

BOTTOMPANEL.petmodelbutton = CreateFrame("PlayerModel", "AFK petmodel", BOTTOMPANEL)
BOTTOMPANEL.petmodelbutton:SetSize(120,120)
BOTTOMPANEL.petmodelbutton:SetPosition(-0.5, 0, 0)
BOTTOMPANEL.petmodelbutton:SetPoint("CENTER", BOTTOMPANEL, "TOPRIGHT", -190, 0)

BOTTOMPANEL.petmodelbutton.text = createtext(BOTTOMPANEL.petmodelbutton, "OVERLAY", 13, "OUTLINE", "RIGHT")
BOTTOMPANEL.petmodelbutton.text:SetPoint("CENTER")
BOTTOMPANEL.petmodelbutton.text:SetText("")

BOTTOMPANEL.tipframe = CreateFrame("Frame", "AFK tips", BOTTOMPANEL)
BOTTOMPANEL.tipframe:SetHeight(40)
BOTTOMPANEL.tipframe:SetPoint("LEFT", BOTTOMPANEL, "LEFT", 200, 0)
BOTTOMPANEL.tipframe:SetPoint("RIGHT", BOTTOMPANEL, "RIGHT", -200, 0)
BOTTOMPANEL.tipframe:Hide()

BOTTOMPANEL.tipframe.text = createtext(BOTTOMPANEL.tipframe, "OVERLAY", 8, "OUTLINE", "CENTER")
BOTTOMPANEL.tipframe.text:SetPoint("BOTTOM", BOTTOMPANEL.tipframe, "CENTER", 0, 0)
BOTTOMPANEL.tipframe.text:SetPoint("LEFT")
BOTTOMPANEL.tipframe.text:SetPoint("RIGHT")

local current_tip = 1
local function SetRandomTip()
	local index = random(1 , #L["TIPS"])
	BOTTOMPANEL.tipframe.text:SetText(L["TIPS"][index])
	current_tip = index
end

local function SetTip(index)
	BOTTOMPANEL.tipframe.text:SetText(L["TIPS"][index])
	current_tip = index
end

local function Previous_tip()
	if current_tip == 1 then
		SetTip(#L["TIPS"])
	else
		SetTip(current_tip - 1)
	end
end

local function Next_tip()
	if current_tip == #L["TIPS"] then
		SetTip(1)
	else
		SetTip(current_tip + 1)
	end
end

StaticPopupDialogs["hideAFKtips"] = {
	text = "隐藏提示",
	button1 = ACCEPT, 
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

local function DontShowTips()
	aCoreCDB["OtherOptions"]["showAFKtips"] = false
	BOTTOMPANEL.tipframe:Hide()
	StaticPopup_Show("hideAFKtips")
	fadein()
end

BOTTOMPANEL.tipframe.next = CreateFrame("Button", "Next tip Button", BOTTOMPANEL.tipframe, "UIPanelButtonTemplate")
BOTTOMPANEL.tipframe.next:SetSize(120,15)
BOTTOMPANEL.tipframe.next:SetPoint("TOP", BOTTOMPANEL.tipframe, "CENTER", 0, -5)
BOTTOMPANEL.tipframe.next:SetText("下一条")
BOTTOMPANEL.tipframe.next:Hide()
BOTTOMPANEL.tipframe.next:StripTextures()
BOTTOMPANEL.tipframe.next:SetTemplate("Overlay")
_G["Next tip ButtonText"]:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
BOTTOMPANEL.tipframe.next:SetScript("OnClick", Next_tip)

BOTTOMPANEL.tipframe.previous = CreateFrame("Button", "Previous tip Button", BOTTOMPANEL.tipframe, "UIPanelButtonTemplate")
BOTTOMPANEL.tipframe.previous:SetSize(120,15)
BOTTOMPANEL.tipframe.previous:SetPoint("RIGHT", BOTTOMPANEL.tipframe.next, "LEFT", -5, 0)
BOTTOMPANEL.tipframe.previous:SetText("上一条")
BOTTOMPANEL.tipframe.previous:Hide()
BOTTOMPANEL.tipframe.previous:StripTextures()
BOTTOMPANEL.tipframe.previous:SetTemplate("Overlay")
_G["Previous tip ButtonText"]:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
BOTTOMPANEL.tipframe.previous:SetScript("OnClick", Previous_tip)

BOTTOMPANEL.tipframe.dontshow = CreateFrame("Button", "Dontshow tip Button", BOTTOMPANEL.tipframe, "UIPanelButtonTemplate")
BOTTOMPANEL.tipframe.dontshow:SetSize(120,15)
BOTTOMPANEL.tipframe.dontshow:SetPoint("LEFT", BOTTOMPANEL.tipframe.next, "RIGHT", 5, 0)
BOTTOMPANEL.tipframe.dontshow:SetText("我不想看到这些提示")
BOTTOMPANEL.tipframe.dontshow:Hide()
BOTTOMPANEL.tipframe.dontshow:StripTextures()
BOTTOMPANEL.tipframe.dontshow:SetTemplate("Overlay")
_G["Dontshow tip ButtonText"]:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
BOTTOMPANEL.tipframe.dontshow:SetScript("OnClick", DontShowTips)

local function fadeout()	--in afk frame
	Minimap:Hide()
	UIParent:SetAlpha(0)
	UIFrameFadeIn(BOTTOMPANEL, 3, BOTTOMPANEL:GetAlpha(), 1)
	UIFrameFadeIn(TOPPANEL, 3, TOPPANEL:GetAlpha(), 1)
	
	Model:SetUnit("player")
	Model:SetAnimation(69)

	SetRandomTip()
	
	BOTTOMPANEL.tipframe:Show()

	BOTTOMPANEL.t = 0
	BOTTOMPANEL:EnableKeyboard(true)
end

local function fadein()		--out afk frame
	Minimap:Show()
	UIFrameFadeIn(UIParent, 2, 0, 1)
	UIFrameFadeOut(BOTTOMPANEL, 2, BOTTOMPANEL:GetAlpha(), 0)
	UIFrameFadeOut(TOPPANEL, 2, TOPPANEL:GetAlpha(), 0)
	
	BOTTOMPANEL:SetScript("OnUpdate",  function(self, e)
		self.t = self.t + e
		if self.t > .5 then
			self:Hide()
			self:SetScript("OnUpdate", nil)
			self.t = 0
		end
	end)
	BOTTOMPANEL:EnableKeyboard(false)
end

local function ShowTipButtons()
	BOTTOMPANEL.tipframe.next:Show()
	BOTTOMPANEL.tipframe.previous:Show()
	BOTTOMPANEL.tipframe.dontshow:Show()
end

local function HideTipButtons()
	BOTTOMPANEL.tipframe.next:Hide()
	BOTTOMPANEL.tipframe.previous:Hide()
	BOTTOMPANEL.tipframe.dontshow:Hide()
end

BOTTOMPANEL.tipframe:SetScript("OnEnter", ShowTipButtons)
BOTTOMPANEL.tipframe.next:SetScript("OnEnter", ShowTipButtons)
BOTTOMPANEL.tipframe.previous:SetScript("OnEnter", ShowTipButtons)
BOTTOMPANEL.tipframe.dontshow:SetScript("OnEnter", ShowTipButtons)
BOTTOMPANEL.tipframe:SetScript("OnLeave", HideTipButtons)
BOTTOMPANEL.tipframe:SetScript("OnHide", HideTipButtons)

BOTTOMPANEL:SetScript("OnKeyDown", function(self, key) 
	fadein()
end)

BOTTOMPANEL:SetScript("OnMouseDown", function(self) 
	fadein()
end)

BOTTOMPANEL:SetScript("OnEvent",function(self, event) 
	if event == "PLAYER_ENTERING_WORLD" then
		--if aCoreDB.meet then
			fadeout()
		--end

		local PetNumber = max(C_PetJournal.GetNumPets(false), 5)
		local randomIndex = random(1 ,PetNumber)
		local randomID = select(11, C_PetJournal.GetPetInfoByIndex(randomIndex))
		if randomID then
			self.petmodelbutton:SetCreature(randomID)
		else
			self.petmodelbutton:SetCreature(53623) -- 塞纳里奥角鹰兽宝宝
		end
		
		hooksecurefunc("ToggleDropDownMenu", function(level, value, dropDownFrame, anchorName)
			if level == 2 and value == SELECT_LOOT_SPECIALIZATION then
				local listFrame = _G["DropDownList"..level]
				local point, anchor, relPoint, _, y = listFrame:GetPoint()
				listFrame:SetPoint(point, anchor, relPoint, 16, y)
			end
		end)
		
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_FLAGS_CHANGED" then
		if UnitIsAFK("player") then
			fadeout()
		end
	end
end)

BOTTOMPANEL:RegisterEvent("PLAYER_ENTERING_WORLD")
BOTTOMPANEL:RegisterEvent("PLAYER_FLAGS_CHANGED")

----------------------------------------------------------------------------------------------------
-- AFK Time
----------------------------------------------------------------------------------------------------
local AFK, hour, minute
local total = 0
local afk_minutes = 0
local afk_seconds = 0
local update = 0
local interval = 1.0

local afkframe = CreateFrame("Frame", "afktime", TOPPANEL)
afkframe:Hide()
afkframe:SetSize(120, 60)
afkframe:SetPoint("LEFT", TOPPANEL, "LEFT", 20, 0)

local afktext = createtext(afkframe, "OVERLAY", 9, "OUTLINE", "LEFT")
afktext:SetText("您现在处于暂离状态")
afktext:SetPoint("LEFT", afkframe, "LEFT", 0, 10)

local afktimer = createtext(afkframe, "OVERLAY", 20, "OUTLINE", "LEFT")
afktimer:SetText("0:00")
afktimer:SetPoint("LEFT", afkframe, "LEFT", 0, -10)

function frame_OnLoad(self)
    self:SetScript("OnEvent", frame_OnEvent)
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
end

function frame_OnEvent(self, event, ...)
	if (event == "PLAYER_FLAGS_CHANGED") then
		if UnitIsAFK("player") then
			afkframe:Show()
            AFK = true
            hour, minute = GetGameTime()
            afkframe:SetScript("OnUpdate", frame_OnUpdate)
        else
			afkframe:Hide()
            AFK = false
            total = 0
            afkframe:SetScript("OnUpdate", nil)
		end
	end
end

function frame_OnUpdate(self, elapsed)
	if AFK == true then
		update = update + elapsed
		if update > interval then
			total = total + 1
			frame_ParseSeconds(total)
			update = 0
		end
	end
end

function frame_ParseSeconds(num)
	local minutes = afk_minutes
	local seconds = afk_seconds
	if num >= 60 then
		minutes = floor(num / 60)
		seconds = tostring(num - (minutes * 60))
		frame_DisplayTime(minutes, seconds)
	else
		minutes = 0
		seconds = num
        frame_DisplayTime(minutes, seconds)
	end
	afk_minutes = tostring(minutes)
	afk_seconds = tostring(seconds)
end

function frame_DisplayTime(minutes, seconds)
	afktimer:SetText(tostring(minutes)..":"..string.format("%02d", tostring(seconds)))
end

frame_OnLoad(afkframe)