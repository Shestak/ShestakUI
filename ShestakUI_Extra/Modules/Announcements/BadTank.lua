local T, C, L = unpack(ShestakUI)
if C.extra_announce.bad_tank ~= true then return end

----------------------------------------------------------------------------------------
--	Announce taunt from not tanks(BadGroup by Rainrider)
----------------------------------------------------------------------------------------
local redColor = "|cffff0000"
local greenColor = "|cff00ff00"
local yellowColor = "|cffffff00"

local defaults = {
	["WasShown"] = true,
	["SocialOutput"] = false,
	["CustomTanks"] = {}
}

local spellList = {
	-- Warrior
	355,	-- Taunt
	1161,	-- Challenging Shout
	694,	-- Mocking Blow
	-- Paladin
	31789,	-- Rghteous Defense
	62124,	-- Hand of Reckoning
	-- Death Knight
	49576,	-- Death Grip
	56222,	-- Dark Command
	-- Druid
	6795,	-- Growl
	5209,	-- Challenging Roar
	-- Hunter
	20736,	-- Distracting Shot
	-- Hunter's pet
	--2649,	-- Growl (Stupid hunters will never turn off this ability)
	-- Warlock's pets
	33698,	-- Anguish 
	3716,	-- Torment
	17735,	-- Suffering
}

local badAuras = {
	["DEATHKNIGHT"] = 48263,	-- Blood Presence
	["PALADIN"] = 25780,		-- Righteous Fury
	["WARRIOR"] = 71,			-- Defensive Stance
}

local numMembers = 0
local groupType = ""

local raidIcons = {}
local rtmask

local metaSV = {
	__tostring = function(tbl)
		local str = ""

		for k, v in pairs(tbl) do
			str = str..greenColor..k..":|r "..tostring(v).." "
		end
		return str
	end
}

local BadGroup = CreateFrame("Frame", "BadGroup", UIParent)
BadGroup:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
BadGroup:RegisterEvent("ADDON_LOADED")

function BadGroup:ADDON_LOADED(event, name)
	if name == "ShestakUI_Extra" then
		-- Set slash commands
		SLASH_BadGroup1 = "/bgr"
		SLASH_BadGroup2 = "/bgrp"
		SLASH_BadGroup3 = "/badgroup"
		SlashCmdList.BadGroup = self.Command

		-- Set SavedVariables
		ExtraTanksDB = ExtraTanksDB or defaults
		ExtraTanksDB = setmetatable(ExtraTanksDB, metaSV)
		ExtraTanksDB.CustomTanks = setmetatable(ExtraTanksDB.CustomTanks, metaSV)

		if ExtraTanksDB.WasShown == false then
			BadGroupMenu:Hide()
		end

		-- Register events
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
	end
end

function BadGroup:PARTY_MEMBERS_CHANGED()
	self:CountGroupMembers()
end

function BadGroup:RAID_ROSTER_UPDATE()
	self:CountGroupMembers()
end

function BadGroup:PLAYER_ENTERING_WORLD()
	local _, locType = GetInstanceInfo()

	if locType ~= "raid" or locType ~= "party" then
		if self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end

	if locType == "raid" or locType == "party" then
		if not self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end

	self:CreateRaidIcons()
	self:CountGroupMembers()
end

function BadGroup:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local _, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellid, spellname = ...

	if eventType == "SPELL_CAST_SUCCESS" and not self:IsOutsider(srcFlags) and self:CheckSpellid(spellid) and not self:IsTank(srcName) then
		return self:ChatOutput(srcName, srcGUID, srcRaidFlags, dstName, dstRaidFlags, spellid)
	end
end

function BadGroup:CountGroupMembers(event)
	numMembers = GetNumRaidMembers()
	if numMembers > 0 then
		groupType = "raid"
		return
	end

	numMembers = GetNumPartyMembers()
	if numMembers > 0 then
		groupType = "party"
		return
	end

	numMembers = 0
	groupType = ""
end

function BadGroup:IsOutsider(srcFlags)
	return bit.band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MASK) >= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER
end

function BadGroup:IsTank(srcName)
	for i, tankName in ipairs(ExtraTanksDB.CustomTanks) do
		if srcName == tankName then
			return true
		end
	end

	if (groupType == "party" and UnitGroupRolesAssigned(srcName) == "TANK") or (groupType == "raid" and GetPartyAssignment("MAINTANK", srcName, exactMatch)) then
		return true
	end
end

function BadGroup:CheckSpellid(spellid)
	for i, v in ipairs(spellList) do
		if v == spellid then
			return true
		end
	end
end

function BadGroup:GetPetOwner(srcGUID)
	local petGUID

	if numMembers > 0 then
		for i = 1, numMembers do
			petGUID = UnitGUID(groupType.."pet"..i)
			if petGUID and petGUID == srcGUID then
				return UnitName(groupType..i)
			end
		end
	end

	petGUID = UnitGUID("pet")
	if petGUID and petGUID == srcGUID then
		return UnitName("player")
	end
end

function BadGroup:ClassColoredName(srcName)
	local _, playerClass = UnitClass(srcName)
	local classColor = RAID_CLASS_COLORS[playerClass]
	if classColor then
		return string.format("|cff%02x%02x%02x%s|r", classColor.r * 255, classColor.g * 255, classColor.b * 255, srcName)
	else
		return string.format("|cff%02x%02x%02x%s|r", 1, 1, 1, srcName)
	end
end

function BadGroup:CreateRaidIcons()
	rtmask = _G.COMBATLOG_OBJECT_RAIDTARGET_MASK

	for i = 1, #_G.ICON_LIST do
		local iconbit = _G["COMBATLOG_OBJECT_RAIDTARGET"..i]
		local icon = _G["COMBATLOG_ICON_RAIDTARGET"..i]
		raidIcons[iconbit] = {iconString = TEXT_MODE_A_STRING_DEST_ICON:format(iconbit, icon), icon = icon, rt = i,}
	end
end

function BadGroup:GetRaidIcon(flag, social)
	if flag == nil then return "" end

	local icon = raidIcons[bit.band(flag, rtmask)]
	if not icon then return "" end

	if social then
		return ("{rt%d}"):format(icon.rt)
	else
		return icon.iconString
	end
end

function BadGroup:ChatOutput(srcName, srcGUID, srcRaidFlags, dstName, dstRaidFlags, spellid)
	local spellLink = GetSpellLink(spellid)
	local srcRaidIcon = self:GetRaidIcon(srcRaidFlags, ExtraTanksDB.SocialOutput)
	local owner = self:GetPetOwner(srcGUID)

	local message
	local prvtMessage

	if not owner then
		message = ("%s used by %s%s"):format(spellLink, srcRaidIcon, srcName)
		prvtMessage = ("%s used by %s%s"):format(spellLink, srcRaidIcon, self:ClassColoredName(srcName))
	else
		message = ("%s used by %s's pet %s"):format(spellLink, owner, srcName)
		prvtMessage = ("%s used by %s's pet %s%s|r"):format(spellLink, self:ClassColoredName(owner), greenColor, srcName)
	end

	if dstName then
		local dstRaidIcon = self:GetRaidIcon(dstRaidFlags, ExtraTanksDB.SocialOutput)
		message = ("%s on %s%s"):format(message, dstRaidIcon, dstName)
		prvtMessage = ("%s on %s%s%s|r"):format(prvtMessage, dstRaidIcon, redColor, dstName)
	end

	if ExtraTanksDB.SocialOutput and numMembers > 0 then
		SendChatMessage(message, string.upper(groupType))
	else
		self:Print(prvtMessage)
	end
end

function BadGroup:ScanAuras(unitID, groupType)
	local _, playerClass = UnitClass(unitID)
	local auraID = badAuras[playerClass]
	local auraName

	if auraID then
		auraName = GetSpellInfo(auraID)
	else
		return
	end

	if UnitAura(unitID, auraName) == auraName then
		local playerName = UnitName(unitID)
		if ExtraTanksDB.SocialOutput and groupType == "raid" or groupType == "party" and not self:IsTank(playerName) then
			SendChatMessage("Non-tank "..playerName.." has "..GetSpellLink(auraID).." on.", groupType == "raid" and "RAID" or "PARTY")
		elseif not self:IsTank(playerName) then
			self:Print("Non-tank "..self:ClassColoredName(playerName).." has "..GetSpellLink(auraID).." on.")
		end
	end
end

function BadGroup:CheckAuras()
	if numMembers > 0 then
		for i = 1, numMembers do
			self:ScanAuras(groupType..i, groupType)
		end
	end

	self:ScanAuras("player", groupType)
	self:Print(L_EXTRA_TAUNT_AURA_CHECK)
end

function BadGroup:AddTank(tankName)
	if tankName == UnitName("player") or tankName == UnitName("pet") or UnitPlayerOrPetInParty(tankName) or UnitPlayerOrPetInRaid(tankName) then
		for i, v in ipairs(ExtraTanksDB.CustomTanks) do
			if v == tankName then
				self:Print(tankName..L_EXTRA_TAUNT_ALREADY_LIST)
				return
			end
		end

		table.insert(ExtraTanksDB.CustomTanks, tankName)
		self:Print(L_EXTRA_TAUNT_ADDED_TANK..self:ClassColoredName(tankName)..".")
	else
		self:Print(L_EXTRA_TAUNT_TARGET_FIRST)
	end
end

function BadGroup:RemoveTank(tankName)
	for i, name in ipairs(ExtraTanksDB.CustomTanks) do
		if tankName == name then
			table.remove(ExtraTanksDB.CustomTanks, i)
			self:Print(L_EXTRA_TAUNT_REMOVED_TANK..tankName..".")
		end
	end
end

function BadGroup:WipeTanks()
	table.wipe(ExtraTanksDB.CustomTanks)
	self:Print(L_EXTRA_TAUNT_ALL_REMOVED)
end

function BadGroup:Print(...)
	local str = tostring(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cff0099CCBadGroup:|r "..str)
end

function BadGroup.Command(str, editbox)
	if str == "social" then
		ExtraTanksDB.SocialOutput = true
		BadGroup:Print("Output set to "..yellowColor.."social|r.")
	elseif str == "private" then
		ExtraTanksDB.SocialOutput = false
		BadGroup:Print("Output set to "..yellowColor.."private|r.")
	elseif str == "status" then 
		BadGroup:Print(ExtraTanksDB)
	elseif str == "add" then
		if not UnitExists("target") then
			BadGroup:Print(L_EXTRA_TAUNT_TARGET_FIRST)
		else
			BadGroup:AddTank(UnitName("target"))
		end
	elseif str == "del" then
		if not UnitExists("target") then
			BadGroup:Print(L_EXTRA_TAUNT_TARGET_FIRST)
		else
			BadGroup:RemoveTank(UnitName("target"))
		end
	elseif str == "wipe" then
		BadGroup:WipeTanks()
	elseif str == "tanks" then
		BadGroup:Print(ExtraTanksDB.CustomTanks)
	elseif str == "auras" then
		BadGroup:CheckAuras()
	else
		BadGroup:Print(redColor..L_EXTRA_TAUNT_UNKNOWN.."|r "..str)
	end
end

local BadGroupMenu = CreateFrame("Frame", "BadGroupMenu", UIParent)
BadGroupMenu:SetWidth(C.minimap.size)
BadGroupMenu:SetHeight(181)
BadGroupMenu:SetPoint(unpack(C.extra_position.tank_announce))
BadGroupMenu:SetTemplate("Transparent")
BadGroupMenu:SetFrameLevel(1)
BadGroupMenu:EnableMouse(true)
BadGroupMenu:SetMovable(true)
BadGroupMenu:SetUserPlaced(true)
BadGroupMenu:HookScript("OnMouseDown", function(self) if IsShiftKeyDown() then self:StartMoving() end end)
BadGroupMenu:HookScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)

BadGroupMenu.text = BadGroupMenu:CreateFontString(nil, "OVERLAY")
BadGroupMenu.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
BadGroupMenu.text:SetPoint("TOP", BadGroupMenu, "TOP", 0, -6)
BadGroupMenu.text:SetText("BadGroup")

local BadGroupClose = CreateFrame("Button", "BadGroupClose", BadGroupMenu)
BadGroupClose:SetWidth(12)
BadGroupClose:SetHeight(12)
BadGroupClose:SetPoint("TOPRIGHT", BadGroupMenu,"TOPRIGHT", 0, -4)
BadGroupClose:EnableMouse(true)
BadGroupClose:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)

BadGroupClose.text = BadGroupClose:CreateFontString(nil, "OVERLAY")
BadGroupClose.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
BadGroupClose.text:SetPoint("CENTER")
BadGroupClose.text:SetText("x")

BadGroupClose:HookScript("OnEnter", function(self) BadGroupClose.text:SetTextColor(T.color.r, T.color.g, T.color.b) end)
BadGroupClose:HookScript("OnLeave", function(self) BadGroupClose.text:SetTextColor(1, 1, 1) end)
BadGroupClose:SetScript("OnMouseUp", function() BadGroupMenu:Hide() ExtraTanksDB.WasShown = false end)

local AddButton = CreateFrame("Button", "BGAddButton", BadGroupMenu)
AddButton:SetWidth(BadGroupMenu:GetWidth() - 8)
AddButton:SetHeight(20)
AddButton:SetPoint("TOP", BadGroupMenu.text, "BOTTOM", 0, -5)
AddButton:SkinButton()
AddButton:EnableMouse(true)
AddButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
AddButton:SetScript("OnMouseUp", function(self)
	if not UnitExists("target") then
		BadGroup:Print(L_EXTRA_TAUNT_TARGET_FIRST)
	else
		BadGroup:AddTank(UnitName("target"))
	end
end)

AddButton.text = AddButton:CreateFontString(nil, "OVERLAY")
AddButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
AddButton.text:SetPoint("CENTER")
AddButton.text:SetText(L_EXTRA_TAUNT_ADD)

local DelButton = CreateFrame("Button", "BGDelButton", BadGroupMenu)
DelButton:SetWidth(BadGroupMenu:GetWidth() - 8)
DelButton:SetHeight(20)
DelButton:SetPoint("TOP", AddButton, "BOTTOM", 0, -3)
DelButton:SkinButton()
DelButton:EnableMouse(true)
DelButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
DelButton:SetScript("OnMouseUp", function(self)
	if not UnitExists("target") then
		BadGroup:Print(L_EXTRA_TAUNT_TARGET_FIRST)
	else
		BadGroup:RemoveTank(UnitName("target"))
	end
end)

DelButton.text = DelButton:CreateFontString(nil, "OVERLAY")
DelButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
DelButton.text:SetPoint("CENTER")
DelButton.text:SetText(L_EXTRA_TAUNT_DEL)

local ClearButton = CreateFrame("Button", "BGClearButton", BadGroupMenu)
ClearButton:SetWidth(BadGroupMenu:GetWidth() - 8)
ClearButton:SetHeight(20)
ClearButton:SetPoint("TOP", DelButton, "BOTTOM", 0, -3)
ClearButton:SkinButton()
ClearButton:EnableMouse(true)
ClearButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
ClearButton:SetScript("OnMouseUp", function(self)
	BadGroup:WipeTanks()
end)

ClearButton.text = ClearButton:CreateFontString(nil, "OVERLAY")
ClearButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
ClearButton.text:SetPoint("CENTER")
ClearButton.text:SetText(L_EXTRA_TAUNT_DEL_ALL)

local ShowButton = CreateFrame("Button", "BGClearButton", BadGroupMenu)
ShowButton:SetWidth(BadGroupMenu:GetWidth() - 8)
ShowButton:SetHeight(20)
ShowButton:SetPoint("TOP", ClearButton, "BOTTOM", 0, -3)
ShowButton:SkinButton()
ShowButton:EnableMouse(true)
ShowButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
ShowButton:SetScript("OnMouseUp", function(self)
	BadGroup:Print(ExtraTanksDB.CustomTanks)
end)

ShowButton.text = ShowButton:CreateFontString(nil, "OVERLAY")
ShowButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
ShowButton.text:SetPoint("CENTER")
ShowButton.text:SetText(L_EXTRA_TAUNT_TANK_LIST)

local AuraButton = CreateFrame("Button", "BGAuraButton", BadGroupMenu)
AuraButton:SetWidth(BadGroupMenu:GetWidth() - 8)
AuraButton:SetHeight(20)
AuraButton:SetPoint("TOP", ShowButton, "BOTTOM", 0, -3)
AuraButton:SkinButton()
AuraButton:EnableMouse(true)
AuraButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
AuraButton:SetScript("OnMouseUp", function(self)
	BadGroup:CheckAuras()
end)

AuraButton.text = AuraButton:CreateFontString(nil, "OVERLAY")
AuraButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
AuraButton.text:SetPoint("CENTER")
AuraButton.text:SetText(L_EXTRA_TAUNT_AURA)

local SayButton = CreateFrame("Button", "BGAuraButton", BadGroupMenu)
SayButton:SetWidth(BadGroupMenu:GetWidth() - 8)
SayButton:SetHeight(20)
SayButton:SetPoint("TOP", AuraButton, "BOTTOM", 0, -3)
SayButton:SkinButton()
SayButton:EnableMouse(true)
SayButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
SayButton:SetScript("OnMouseUp", function(self)
	if ExtraTanksDB.SocialOutput == true then
		ExtraTanksDB.SocialOutput = false
		BadGroup:Print("Output set to "..yellowColor.."private|r.")
	else
		ExtraTanksDB.SocialOutput = true
		BadGroup:Print("Output set to "..yellowColor.."social|r.")
	end
end)

SayButton.text = SayButton:CreateFontString(nil, "OVERLAY")
SayButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
SayButton.text:SetPoint("CENTER")
SayButton.text:SetText(CHAT_ANNOUNCE)

local InfoButton = CreateFrame("Button", "BGAuraButton", BadGroupMenu)
InfoButton:SetWidth(BadGroupMenu:GetWidth() - 8)
InfoButton:SetHeight(20)
InfoButton:SetPoint("TOP", SayButton, "BOTTOM", 0, -3)
InfoButton:SkinButton()
InfoButton:EnableMouse(true)
InfoButton:SetFrameLevel(BadGroupMenu:GetFrameLevel() + 1)
InfoButton:SetScript("OnMouseUp", function(self)
	BadGroup:Print(ExtraTanksDB)
end)

InfoButton.text = InfoButton:CreateFontString(nil, "OVERLAY")
InfoButton.text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
InfoButton.text:SetPoint("CENTER")
InfoButton.text:SetText(GUILD_INFORMATION)

local b = CreateFrame("Button", nil, UIParent)
b:SetTemplate("ClassColor")
b:Size(19)
b:SetAlpha(0)
if C.extra_general.archaeology == true then
	b:Point("TOP", SwitchLayout, "BOTTOM", 0, -21)
else
	b:Point("TOP", SwitchLayout, "BOTTOM", 0, -1)
end

local bt = b:CreateTexture(nil, "OVERLAY")
bt:SetTexture("Interface\\Icons\\Ability_Hunter_Beastcall")
bt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
bt:Point("TOPLEFT", b, 2, -2)
bt:Point("BOTTOMRIGHT", b, -2, 2)

b:SetScript("OnClick", function(self)
	if not InCombatLockdown() then
		if _G["BadGroupMenu"]:IsShown() then
			ExtraTanksDB.WasShown = false
			_G["BadGroupMenu"]:Hide()
		else
			ExtraTanksDB.WasShown = true
			_G["BadGroupMenu"]:Show()
		end
		if C.minimap.toggle_menu and _G["TTMenuAddOnBackground"]:IsShown() then
			_G["TTMenuAddOnBackground"]:Hide()
		end
		if C.minimap.toggle_menu and _G["TTMenuBackground"]:IsShown() then
			_G["TTMenuBackground"]:Hide()
		end
	end
end)

b:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	b:FadeIn()
end)

b:SetScript("OnLeave", function()
	b:FadeOut()
end)