local T, C, L = unpack(select(2, ...))
if C.loot.rolllootframe ~= true then return end

----------------------------------------------------------------------------------------
--	Based on teksLoot(by Tekkub)
----------------------------------------------------------------------------------------
local pos = "TOP"
local frames = {}
local cancelled_rolls = {}
local LootRollAnchor = CreateFrame("Frame", "LootRollAnchor", UIParent)
LootRollAnchor:Size(362, 26)

local function ClickRoll(frame)
	RollOnLoot(frame.parent.rollID, frame.rolltype)
end

local function HideTip() GameTooltip:Hide() end
local function HideTip2() GameTooltip:Hide() ResetCursor() end

local rolltypes = {[1] = "need", [2] = "greed", [3] = "disenchant", [0] = "pass"}

local function SetTip(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:SetText(frame.tiptext)
	if frame:IsEnabled() == 0 then GameTooltip:AddLine("|cffff3333"..L_LOOT_CANNOT) end
	for name, roll in pairs(frame.parent.rolls) do if rolltypes[roll] == rolltypes[frame.rolltype] then GameTooltip:AddLine(name, 1, 1, 1) end end
	GameTooltip:Show()
end

local function SetItemTip(frame)
	if not frame.link then return end
	GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(frame.link)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	if IsModifiedClick("DRESSUP") then ShowInspectCursor() else ResetCursor() end
end

local function ItemOnUpdate(self)
	if IsShiftKeyDown() then GameTooltip_ShowCompareItem() end
	CursorOnUpdate(self)
end

local function LootClick(frame)
	if IsControlKeyDown() then DressUpItemLink(frame.link)
	elseif IsShiftKeyDown() then ChatEdit_InsertLink(frame.link) end
end

local function OnEvent(frame, event, rollID)
	cancelled_rolls[rollID] = true
	if frame.rollID ~= rollID then return end

	frame.rollID = nil
	frame.time = nil
	frame:Hide()
end

local function StatusUpdate(frame)
	if not frame.parent.rollID then return end
	local t = GetLootRollTimeLeft(frame.parent.rollID)
	local perc = t / frame.parent.time
	frame:SetValue(t)
	if t > 1000000000 then
		frame:GetParent():Hide()
	end
end

local function CreateRollButton(parent, ntex, ptex, htex, rolltype, tiptext, ...)
	local f = CreateFrame("Button", nil, parent)
	f:SetPoint(...)
	f:SetSize(28, 28)
	f:SetNormalTexture(ntex)
	if ptex then f:SetPushedTexture(ptex) end
	f:SetHighlightTexture(htex)
	f.rolltype = rolltype
	f.parent = parent
	f.tiptext = tiptext
	f:SetScript("OnEnter", SetTip)
	f:SetScript("OnLeave", HideTip)
	f:SetScript("OnClick", ClickRoll)
	f:SetMotionScriptsWhileDisabled(true)
	local txt = f:CreateFontString(nil, nil)
	txt:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
	txt:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
	txt:Point("CENTER", 0, rolltype == 2 and 1 or rolltype == 0 and -1.2 or 0)
	return f, txt
end

local function CreateRollFrame()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:CreateBackdrop("Default")
	frame:Size(328, 22)
	frame:SetScript("OnEvent", OnEvent)
	frame:RegisterEvent("CANCEL_LOOT_ROLL")
	frame:Hide()

	local button = CreateFrame("Button", nil, frame)
	button:Point("LEFT", -29, 0)
	button:Size(22)
	button:CreateBackdrop("Default")
	button:SetScript("OnEnter", SetItemTip)
	button:SetScript("OnLeave", HideTip2)
	button:SetScript("OnUpdate", ItemOnUpdate)
	button:SetScript("OnClick", LootClick)
	frame.button = button

	button.icon = button:CreateTexture(nil, "OVERLAY")
	button.icon:SetAllPoints()
	button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local status = CreateFrame("StatusBar", nil, frame)
	status:Size(326, 20)
	status:Point("TOPLEFT", 0, 0)
	status:Point("BOTTOMRIGHT", 0, 0)
	status:SetScript("OnUpdate", StatusUpdate)
	status:SetFrameLevel(status:GetFrameLevel() - 1)
	status:SetStatusBarTexture(C.media.texture)
	status:SetStatusBarColor(0.8, 0.8, 0.8, 0.9)
	status.parent = frame
	frame.status = status

	status.bg = status:CreateTexture(nil, 'BACKGROUND')
	status.bg:SetAlpha(0.1)
	status.bg:SetAllPoints()
	status.bg:SetDrawLayer('BACKGROUND', 2)

	local need, needtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Dice-Up", "Interface\\Buttons\\UI-GroupLoot-Dice-Highlight", "Interface\\Buttons\\UI-GroupLoot-Dice-Down", 1, NEED, "LEFT", frame.button, "RIGHT", 5, -1)
	local greed, greedtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Coin-Up", "Interface\\Buttons\\UI-GroupLoot-Coin-Highlight", "Interface\\Buttons\\UI-GroupLoot-Coin-Down", 2, GREED, "LEFT", need, "RIGHT", 0, -1)
	local de, detext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-DE-Up", "Interface\\Buttons\\UI-GroupLoot-DE-Highlight", "Interface\\Buttons\\UI-GroupLoot-DE-Down", 3, ROLL_DISENCHANT, "LEFT", greed, "RIGHT", 0, -1)
	local pass, passtext = CreateRollButton(frame, "Interface\\Buttons\\UI-GroupLoot-Pass-Up", nil, "Interface\\Buttons\\UI-GroupLoot-Pass-Down", 0, PASS, "LEFT", de or greed, "RIGHT", 0, 2.2)
	frame.needbutt, frame.greedbutt, frame.disenchantbutt = need, greed, de
	frame.need, frame.greed, frame.pass, frame.disenchant = needtext, greedtext, passtext, detext

	local bind = frame:CreateFontString()
	bind:Point("LEFT", pass, "RIGHT", 3, 1)
	bind:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
	bind:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
	frame.fsbind = bind

	local loot = frame:CreateFontString(nil, "ARTWORK")
	loot:SetFont(C.font.loot_font, C.font.loot_font_size, C.font.loot_font_style)
	loot:SetShadowOffset(C.font.loot_font_shadow and 1 or 0, C.font.loot_font_shadow and -1 or 0)
	loot:Point("LEFT", bind, "RIGHT", 0, 0)
	loot:Point("RIGHT", frame, "RIGHT", -5, 0)
	loot:Size(200, 10)
	loot:SetJustifyH("LEFT")
	frame.fsloot = loot

	frame.rolls = {}

	return frame
end

local function GetFrame()
	for i, f in ipairs(frames) do
		if not f.rollID then return f end
	end

	local f = CreateRollFrame()
	if pos == "TOP" then
		f:Point("TOPRIGHT", next(frames) and frames[#frames] or LootRollAnchor, "BOTTOMRIGHT", 0, -7)
	else
		f:Point("BOTTOMRIGHT", next(frames) and frames[#frames] or LootRollAnchor, "TOPRIGHT", 0, 7)
	end
	table.insert(frames, f)
	return f
end

local function START_LOOT_ROLL(rollID, time)
	if cancelled_rolls[rollID] then return end

	local f = GetFrame()
	f.rollID = rollID
	f.time = time
	for i in pairs(f.rolls) do f.rolls[i] = nil end
	f.need:SetText(0)
	f.greed:SetText(0)
	f.pass:SetText(0)
	f.disenchant:SetText(0)

	local texture, name, count, quality, bop, canNeed, canGreed, canDisenchant = GetLootRollItemInfo(rollID)
	f.button.icon:SetTexture(texture)
	f.button.link = GetLootRollItemLink(rollID)

	if canNeed then f.needbutt:Enable() else f.needbutt:Disable() end
	if canGreed then f.greedbutt:Enable() else f.greedbutt:Disable() end
	if canDisenchant then f.disenchantbutt:Enable() else f.disenchantbutt:Disable() end
	SetDesaturation(f.needbutt:GetNormalTexture(), not canNeed)
	SetDesaturation(f.greedbutt:GetNormalTexture(), not canGreed)
	SetDesaturation(f.disenchantbutt:GetNormalTexture(), not canDisenchant)
	if canNeed then f.needbutt:SetAlpha(1) else f.needbutt:SetAlpha(0.2) end
	if canGreed then f.greedbutt:SetAlpha(1) else f.greedbutt:SetAlpha(0.2) end
	if canDisenchant then f.disenchantbutt:SetAlpha(1) else f.disenchantbutt:SetAlpha(0.2) end

	f.fsbind:SetText(bop and "BoP" or "BoE")
	f.fsbind:SetVertexColor(bop and 1 or 0.3, bop and 0.3 or 1, bop and 0.1 or 0.3)

	local color = ITEM_QUALITY_COLORS[quality]
	f.fsloot:SetText(name)
	f.status:SetStatusBarColor(color.r, color.g, color.b, 0.7)
	f.status.bg:SetTexture(color.r, color.g, color.b)
	f.backdrop:SetBackdropBorderColor(color.r, color.g, color.b, 0.7)
	f.button.backdrop:SetBackdropBorderColor(color.r, color.g, color.b, 0.7)

	f.status:SetMinMaxValues(0, time)
	f.status:SetValue(time)

	f:Point("CENTER", WorldFrame, "CENTER")
	f:Show()
end

local function LOOT_HISTORY_ROLL_CHANGED(itemIdx, playerIdx)
	local rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot = C_LootHistory.GetItem(itemIdx)
	local name, class, rollType, roll, isWinner = C_LootHistory.GetPlayerInfo(itemIdx, playerIdx)

	if name and rollType then
		for _, f in ipairs(frames) do
			if f.rollID == rollID then
				f.rolls[name] = rollType
				f[rolltypes[rollType]]:SetText(tonumber(f[rolltypes[rollType]]:GetText()) + 1)
				return
			end
		end
	end
end

LootRollAnchor:RegisterEvent("ADDON_LOADED")
LootRollAnchor:SetScript("OnEvent", function(frame, event, addon)
	if addon ~= "ShestakUI" then return end

	LootRollAnchor:UnregisterEvent("ADDON_LOADED")
	LootRollAnchor:RegisterEvent("LOOT_HISTORY_ROLL_CHANGED")
	LootRollAnchor:RegisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

	LootRollAnchor:SetScript("OnEvent", function(frame, event, ...) if event == "LOOT_HISTORY_ROLL_CHANGED" then return LOOT_HISTORY_ROLL_CHANGED(...) else return START_LOOT_ROLL(...) end end)

	LootRollAnchor:Point(unpack(C.position.group_loot))
end)