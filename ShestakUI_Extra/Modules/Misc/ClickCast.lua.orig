local T, C, L = unpack(ShestakUI)
if C.extra_general.click_cast ~= true then return end

----------------------------------------------------------------------------------------
--	sBinder(by Fernir)
----------------------------------------------------------------------------------------
local addonName, ns = ...
local sbOpen = false

local SpellBinder = {}
local spellbuttons = {}

local frames= {
	"oUF_Player",
	"oUF_Pet",
	"oUF_Target",
	"oUF_TargetTarget",
	"oUF_Focus",
	"oUF_FocusTarget",
	"oUF_Boss1",
	"oUF_Boss2",
	"oUF_Boss3",
}
for i = 1, 5 do
	local party_dps = "oUF_PartyDPSUnitButton"..i
	local partytarget_dps = "oUF_PartyTargetDPSUnitButton"..i
	local party_heal = "oUF_PartyUnitButton"..i
	local partytarget_heal = "oUF_PartyTargetUnitButton"..i
	local arena = "oUF_Arena"..i
	local arenatarget = "oUF_Arena"..i.."Target"

	if party_dps then
		tinsert(frames, party_dps)
	end
	if partytarget_dps then
		tinsert(frames, partytarget_dps)
	end
	if party_heal then
		tinsert(frames, party_heal)
	end
	if partytarget_heal then
		tinsert(frames, partytarget_heal)
	end
	if arena then
		tinsert(frames, arena)
	end
	if arenatarget then
		tinsert(frames, arenatarget)
	end
end

for i = 1, 8 do
	for j = 1, 5 do
		local raid_heal = "oUF_RaidHeal"..i.."UnitButton"..j
		local raid_dps = "oUF_RaidDPS"..i.."UnitButton"..j

		if raid_heal then
			tinsert(frames, raid_heal)
		end
		if raid_dps then
			tinsert(frames, raid_dps)
		end
	end
end

local mainf = CreateFrame("Frame", "SpellBinderMainFrame", SpellBookFrame)
mainf:EnableMouse(true)
mainf:SetFrameStrata("TOOLTIP")

function SpellBinder:Style(frame)
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3},
	})
	frame:SetBackdropColor(0.01, 0.01, 0.01, 0.85)
	frame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
end

function SpellBinder:NewButton(text,parent)
	local result = CreateFrame("Button", "btn_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

mainf:SetPoint("TOPLEFT", SpellBookFrame, "TOPRIGHT", 100, 0)
mainf:SetWidth(300)
mainf:SetHeight(400)
mainf:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 32, edgeSize = 32,
	insets = {left = 11, right = 12, top = 12, bottom = 11}
})
mainf:Hide()

local scrollf = CreateFrame("ScrollFrame", "SpellBinderScrollFrameFrameList", mainf, "UIPanelScrollFrameTemplate")
local framesf = CreateFrame("Frame", "SpellBinderScrollFrameFrameListChild", scrollf)
scrollf:SetPoint("TOPLEFT", mainf, "TOP", 20, -40)
scrollf:SetPoint("BOTTOMRIGHT", mainf, "BOTTOMRIGHT", -38, 45)
scrollf:SetScrollChild(framesf)
scrollf:Hide()

local scrolls = CreateFrame("ScrollFrame", "SpellBinderScrollFrameSpellList", mainf, "UIPanelScrollFrameTemplate")
local framess = CreateFrame("Frame", "SpellBinderScrollFrameSpellListChild", scrolls)
scrolls:SetPoint("TOPLEFT", mainf, "TOPLEFT", 20, -40)
scrolls:SetPoint("BOTTOMRIGHT", mainf, "BOTTOMRIGHT", -38, 45)
scrolls:SetScrollChild(framess)

local titlef = mainf:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
titlef:SetPoint("BOTTOMLEFT", scrollf, "TOPLEFT", 0, 10)
titlef:SetText(L_EXTRA_BINDER_FRAMES)
titlef:Hide()

local titles = mainf:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
titles:SetPoint("BOTTOMLEFT", scrolls, "TOPLEFT", 0, 10)
titles:SetText(SPELLS)

local slider = CreateFrame("Button", "SpellBinderSlideButton", mainf)
slider:SetWidth(25)
slider:SetHeight(25)
slider:SetPoint("BOTTOMRIGHT", C.skins.blizzard_frames and -4 or -11, C.skins.blizzard_frames and 4 or 10)
slider:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
slider:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
slider:SetHighlightTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")

slider:SetScript("OnClick", function(self)
	if self.open == nil then self.open = false end
	self.open = not self.open
	if self.open then
		mainf:SetWidth(600)
		scrolls:SetPoint("TOPLEFT", mainf, "TOPLEFT", 20, -40)
		scrolls:SetPoint("BOTTOMRIGHT", mainf, "BOTTOM", -18, 45)
		scrollf:Show()
		titlef:Show()
	else
		mainf:SetWidth(300)
		scrolls:SetPoint("TOPLEFT", mainf, "TOPLEFT", 20, -40)
		scrolls:SetPoint("BOTTOMRIGHT", mainf, "BOTTOMRIGHT", -38, 45)
		scrollf:Hide()
		titlef:Hide()
	end
	SpellBinder:makeFramesList()
	SpellBinder:makeSpellsList(true)
end)
 
function SpellBinder:makeSpellsList(delete)
	local self = framess
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.CreateBD(scrolls)
	else
		if C.skins.blizzard_frames == true then
			scrolls:SetTemplate("Overlay")
		else
			SpellBinder:Style(scrolls)
		end
	end
	self:SetPoint("TOPLEFT")
	self:SetWidth(scrolls:GetWidth())
	self:SetHeight(scrolls:GetHeight())
	local oldb

	if delete then
		i = 1
		while _G[i.."_cbs"] do
			_G[i.."_fs"]:SetText("")
			_G[i.."_texture"]:SetTexture(nil)
			_G[i.."_cbs"].checked = false
			_G[i.."_cbs"]:ClearAllPoints()
			_G[i.."_cbs"]:Hide()
			i = i + 1
		end
	end

	for i, spell in ipairs(DB.spells) do
		v = spell.spell
		if v then
			local bf = _G[i.."_cbs"] or CreateFrame("Button", i.."_cbs", self)
			spell.checked = spell.checked or false
			if i == 1 then
				bf:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
				bf:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -10, -34)
			else
				bf:SetPoint("TOPLEFT", oldb, "BOTTOMLEFT", 0, -2)
				bf:SetPoint("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -26)
			end	
			bf:EnableMouse(true)
			bf:SetBackdrop({bgFile = C.media.blank})
			bf:SetBackdropColor(0, 0, 0, 0)
			if spell.checked then
				bf:SetBackdropColor(1, 0.1, 0.1, 0.25)
			end

			bf:SetScript("OnEnter", function(self) 
				self:SetBackdropColor(0, 1, 0, 0.25)
				if spell.checked then
					self:SetBackdropColor(1, 0.1, 0.1, 0.25)
				end
			end)

			bf:SetScript("OnLeave", function(self) 
				self:SetBackdropColor(0, 0, 0, 0) 
				if spell.checked then
					self:SetBackdropColor(1, 0.1, 0.1, 0.25)
				end
			end)

			local tex = _G[i.."_texture"] or bf:CreateTexture(i.."_texture", "OVERLAY")
			tex:SetWidth(22)
			tex:SetHeight(22)
			tex:SetTexture(spell.texture)
			tex:SetPoint("LEFT", 4, 0)
			tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			local fs = _G[i.."_fs"] or bf:CreateFontString(i.."_fs", "OVERLAY", "GameFontNormal")
			fs:SetText(spell.modifier..spell.origbutton)
			fs:SetPoint("RIGHT", -4, 0)

			bf:SetScript("OnClick", function(self)
				for j, k in ipairs(DB.spells) do
					if k ~= spell then
						k.checked = false
						_G[j.."_cbs"]:SetBackdropColor(0, 0, 0, 0)
					end
				end
				spell.checked = not spell.checked
			end)

			for j, frame in pairs(frames) do
				local f
				if _G[frame] then f = _G[frame]:GetName() end
				if f and DB.frames[frame] then
				if _G[f]:CanChangeAttribute() or _G[f]:CanChangeProtectedState() then
					if _G[f]:GetAttribute(spell.modifier.."type"..spell.button) ~= "menu" then
						if GetCVarBool("ActionButtonUseKeyDown") then
							_G[f]:RegisterForClicks("AnyDown")
						else
							_G[f]:RegisterForClicks("AnyUp")
						end
						if spell.button:find("harmbutton") then
							_G[f]:SetAttribute(spell.modifier..spell.button, spell.spell)
							_G[f]:SetAttribute(spell.modifier.."type-"..spell.spell, "spell")
							_G[f]:SetAttribute(spell.modifier.."spell-"..spell.spell, spell.spell)
							DB.keys[spell.modifier..spell.button] = spell.spell
							DB.keys[spell.modifier.."type-"..spell.spell] = "spell"
							DB.keys[spell.modifier.."spell-"..spell.spell] = spell.spell
						else
							_G[f]:SetAttribute(spell.modifier.."type"..spell.button, "spell")
							_G[f]:SetAttribute(spell.modifier.."spell"..spell.button, spell.spell)
							DB.keys[spell.modifier.."type"..spell.button] = "spell"
							DB.keys[spell.modifier.."spell"..spell.button] = spell.spell
						end
					end
				end
			end
		end
		bf:Show()
		oldb = bf
		end
	end
end

function SpellBinder:makeFramesList()
	local self = framesf
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.CreateBD(scrollf)
	else
		if C.skins.blizzard_frames == true then
			scrollf:SetTemplate("Overlay")
		else
			SpellBinder:Style(scrollf)
		end
	end
	self:SetPoint("TOPLEFT")
	self:SetWidth(scrollf:GetWidth())
	self:SetHeight(scrollf:GetHeight())

	local oldb
	table.sort(frames)

	for i, frame in pairs(frames) do
		local v
		if _G[frame] then v = _G[frame]:GetName() end
		if v then
			DB.frames[frame] = DB.frames[frame] or true

			local bf = _G[v.."_cbf"] or CreateFrame("Button", v.."_cbf", self)
			if i == 1 then
				bf:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
				bf:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 140, -30)
			else
				bf:SetPoint("TOPLEFT", oldb, "BOTTOMLEFT", 0, 0)
				bf:SetPoint("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -20)
			end

			bf:EnableMouse(true)

			bf:SetBackdrop({bgFile = C.media.blank})
			bf:SetBackdropColor(0, 0, 0, 0)
			bf:SetScript("OnEnter", function(self) self:SetBackdropColor(0, 1, 0, 0.25) end)
			bf:SetScript("OnLeave", function(self) self:SetBackdropColor(0, 0, 0, 0) end)

			oldb = bf

			local cb = _G[v.."_cb"] or CreateFrame("CheckButton", v.."_cb", bf, "OptionsCheckButtonTemplate")

			_G[v.."_cb".."Text"]:SetText(v)
			_G[v.."_cb".."Text"]:SetFontObject("GameFontNormal")

			cb:SetChecked(DB.frames[frame])

			cb:SetScript("OnClick", function(self)
				local checked = (self:GetChecked() and true or false)
				self:SetChecked(checked or true and false)
				checked = self:GetChecked() and true or false

				DB.frames[frame] = checked
				if checked then
					for h, g in pairs(DB.keys) do
						if _G[frame]:CanChangeAttribute() or _G[frame]:CanChangeProtectedState() then
							if _G[frame]:GetAttribute(h) ~= "menu" then
								_G[frame]:SetAttribute(h, g)
							end
						end
					end
				else
					for h, g in pairs(DB.keys) do
						if _G[frame]:CanChangeAttribute() or _G[frame]:CanChangeProtectedState() then
							if _G[frame]:GetAttribute(h) ~= "menu" then
								_G[frame]:SetAttribute(h, nil)
							end
						end
					end
				end
			end)

			cb:SetPoint("LEFT", 4, 0)
			cb:SetScript("OnEnter", function() bf:SetBackdropColor(0, 1, 0, 0.25) end)
			cb:SetScript("OnLeave", function() bf:SetBackdropColor(0, 0, 0, 0) end)
			bf:SetScript("OnClick", function(self) cb:Click() end)	
		end
	end
end

local openbinder = CreateFrame("Button", "SpellBinderOpenButton", SpellBookFrame, "UIPanelButtonTemplate")
openbinder:SetWidth(120)
openbinder:SetHeight(22)
openbinder:SetPoint("TOP", -160, 0)
openbinder:SetText(L_EXTRA_BINDER_OPEN)
openbinder:SetScript("OnClick", function(self) 
	if InCombatLockdown() then mainf:Hide()	return end

	if mainf:IsVisible() then
		mainf:Hide()
		sbOpen = false
		self:SetText(L_EXTRA_BINDER_OPEN)
	else 
		mainf:Show()
		sbOpen = true
		self:SetText(L_EXTRA_BINDER_CLOSE)
	end
	local method = sbOpen and "Show" or "Hide"
	local buttons = spellbuttons
	for i = 1, SPELLS_PER_PAGE do
		buttons[i][method](buttons[i])
	end

	SpellBinder:makeFramesList()
	SpellBinder:makeSpellsList(true)
end)

closeb = CreateFrame("Button", "SpellBinderCloseButton", mainf, "UIPanelCloseButton")
closeb:SetPoint("TOPRIGHT", -8, -8)
closeb:SetScript("OnClick", function()
	mainf:Hide()
	sbOpen = false
	openbinder:SetText(L_EXTRA_BINDER_OPEN)
end)

local deleteb = SpellBinder:NewButton(DELETE, mainf)
deleteb:SetWidth(100)
deleteb:SetHeight(22)
deleteb:SetPoint("BOTTOM", 0, 20)
deleteb:SetScript("OnClick", function() 
	local count = table.getn(DB.spells)
	for i, spell in ipairs(DB.spells) do
		if spell.checked then
			for j, frame in pairs(frames) do
				local f
				if _G[frame] then f = _G[frame]:GetName() end
				if f then
					if _G[f]:CanChangeAttribute() or _G[f]:CanChangeProtectedState() then
						if _G[f]:GetAttribute(spell.modifier.."type"..spell.button) ~= "menu" then
							if spell.button:find("harmbutton") then
								_G[f]:SetAttribute(spell.modifier..spell.button, nil)
								_G[f]:SetAttribute(spell.modifier.."type-"..spell.spell, nil)
								_G[f]:SetAttribute(spell.modifier.."spell-"..spell.spell, nil)
							else
								_G[f]:SetAttribute(spell.modifier.."type"..spell.button, nil)
								_G[f]:SetAttribute(spell.modifier.."spell"..spell.button, nil)
							end
						end
					end
				end
			end
			tremove(DB.spells, i)
		end
	end
	SpellBinder:makeSpellsList(true)
end)

local addSpell = function(self, button)
	if sbOpen == true then
		local slot = SpellBook_GetSpellBookSlot(self:GetParent())
		local spellname, subtype = GetSpellBookItemName(slot, SpellBookFrame.bookType)
		local texture = GetSpellBookItemTexture(slot, SpellBookFrame.bookType)

		if spellname ~= 0 and ((SpellBookFrame.bookType == BOOKTYPE_PET) or (SpellBookFrame.selectedSkillLine > 1)) then
			local originalbutton = button

			local modifier = ""
			if IsShiftKeyDown() then
				modifier = "Shift-"..modifier
			end
			
			if IsControlKeyDown() then
				modifier = "Ctrl-"..modifier
			end
			
			if IsAltKeyDown() then
				modifier = "Alt-"..modifier
			end

			if IsHarmfulSpell(slot, SpellBookFrame.bookType) then
				button = format("%s%d", "harmbutton", SecureButton_GetButtonSuffix(button))
				originalbutton = "|cffff2222(harm)|r "..originalbutton
			else
				button = SecureButton_GetButtonSuffix(button)
			end

			for i, v in pairs(DB.spells) do
				if v.spell == spellname then return end
			end

			tinsert( DB.spells , { ["id"] = slot, ["modifier"] = modifier, ["button"] = button, ["spell"] = spellname, ["rank"] = rank, ["texture"] = texture, ["origbutton"] = originalbutton, } )
			SpellBinder:makeSpellsList(false)
		end
	end
end

local eventf = CreateFrame("Frame", "SpellBinderEventFrame", UIParent)
eventf:RegisterEvent("RAID_ROSTER_UPDATE")
eventf:RegisterEvent("PLAYER_ENTERING_WORLD")
eventf:RegisterEvent("PLAYER_LOGIN")
eventf:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventf:RegisterEvent("ZONE_CHANGED")
eventf:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		ExtraOptionsDB = ExtraOptionsDB or {}
		ExtraOptionsDB[UnitName("player")] = ExtraOptionsDB[UnitName("player")] or {}
		DB = ExtraOptionsDB[UnitName("player")]
		DB.spells = DB.spells or {}
		DB.frames = DB.frames or {}
		DB.keys = DB.keys or {}
		SpellBinder:makeFramesList()
		SpellBinder:makeSpellsList(true)

		for i = 1, SPELLS_PER_PAGE do
			local parent = _G["SpellButton"..i]
			local button = CreateFrame("Button", "SpellBinderFakeButton"..i, parent)
			button:SetID(parent:GetID())
			button:RegisterForClicks("AnyUp")
			button:SetAllPoints(parent)
			button:SetScript("OnClick", addSpell)
			button:Hide()
			spellbuttons[i] = button
		end
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "PLAYER_ENTERING_WORLD" or event == "RAID_ROSTER_UPDATE" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		SpellBinder:makeFramesList()
		SpellBinder:makeSpellsList(true)
	end
end)

if IsAddOnLoaded("Aurora") then
	local F = unpack(Aurora)
	F.CreateBD(SpellBinderMainFrame)
	F.CreateSD(SpellBinderMainFrame)
	F.Reskin(btn_SpellBinderMainFrame)
	F.Reskin(SpellBinderOpenButton)
	F.ReskinClose(SpellBinderCloseButton)
	F.ReskinScroll(SpellBinderScrollFrameSpellListScrollBar)
	F.ReskinScroll(SpellBinderScrollFrameFrameListScrollBar)
	F.ReskinArrow(SpellBinderSlideButton, 2)
	SpellBinderOpenButton:ClearAllPoints()
	SpellBinderOpenButton:Point("TOPLEFT", SpellBookFrame, "TOPLEFT", 4, -4)
elseif C.skins.blizzard_frames == true then
	SpellBinderMainFrame:StripTextures()
	SpellBinderMainFrame:SetTemplate("Transparent")
	SpellBinderOpenButton:SkinButton()
	SpellBinderOpenButton:ClearAllPoints()
	SpellBinderOpenButton:Point("TOPLEFT", SpellBookFrame.backdrop, "TOPLEFT", 4, -4)
	btn_SpellBinderMainFrame:SkinButton()
	T.SkinCloseButton(SpellBinderCloseButton)
	T.SkinNextPrevButton(SpellBinderSlideButton)
end