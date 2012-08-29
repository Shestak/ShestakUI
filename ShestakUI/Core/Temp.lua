local T, C, L = unpack(select(2, ...))

--[[Simple_Spy = {
	Enemy1 = "",
	Enemy2 = "",
	Enemy3 = "",
	Enemy4 = "",
	Enemy5 = "",
	Sanctuary = nil,
	Colors = {
		["DEATHKNIGHT"] = "c41f3b",
		["DRUID"] = "ff7d0a",
		["HUNTER"] = "abd473",
		["MAGE"] = "69ccf0",
		["PALADIN"] = "f58cba",
		["PRIEST"] = "ffffff",
		["ROGUE"] = "fff569",
		["SHAMAN"] = "0070de",
		["WARRIOR"] = "c79c6e",
		["WARLOCK"] = "9482c9",
		["MONK"] = "00ff96",
	},
	rtime = 0,
	--ttime = 0,
	rhex = nil,
	ghex = nil,
	bhex = nil,
	red = 0,
	green = 0,
	blue = 0,
	HideAll = false,
	Stealth = false,
}

SSEnemies = {}
SSGUIDS = {}
SSCharacters = {}
SSEClasses = {}
i = 1

function LogParse(timeStamp, type, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	if Simple_Spy.Sanctuary then return end
	if srcGUID and srcName and srcFlags then
		if bit.band(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(srcFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= COMBATLOG_OBJECT_REACTION_HOSTILE then return end
		SSEClass, classId, SSERace, raceId, Sex, Name, srcServer = GetPlayerInfoByGUID(srcGUID)
		if raceId == nil then return end
		if not SSGUIDS or SSGUIDS[Name] == nil then
			if classId ~= nil then
				SSGUIDS[srcName] = srcGUID
				SSEClasses[srcName] = classId
				SSCharacters[srcName] = Name
			end
		end
		if type == "SPELL_CAST_SUCCESS" and Simple_Spy.Stealth == true then
			SpellId, SpellName, _ = ...
			if SpellId == 1856 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(1856)..".")
			elseif SpellId == 1784 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(1784)..".")
			elseif SpellId == 5215 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(5215)..".")
			elseif SpellId == 58984 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(58984)..".")
			elseif SpellId == 51753 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(51753)..".")
			elseif SpellId == 66 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(66)..".")
			elseif SpellId == 3680 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(3680)..".")
			elseif SpellId == 11392 then
				DEFAULT_CHAT_FRAME:AddMessage("Note: "..srcName.." casted "..GetSpellLink(11392)..".")
			end
		end
		if not SSEnemies[srcName] or SSEnemies[srcName] == nil then
			SSGUIDS[srcName] = srcGUID
			SSEnemies[srcName] = i
			if i >= 6 then
				for k, v in pairs(SSEnemies) do
					if v == 1 then
						SSEnemies[k] = nil
					elseif v == 2 then
						SSEnemies[k] = 1
					elseif v == 3 then
						SSEnemies[k] = 2
					elseif v == 4 then
						SSEnemies[k] = 3
					elseif v == 5 then
						SSEnemies[k] = 4
					elseif v == 6 then
						SSEnemies[k] = 5
					end
				end
				i = i - 1
			end
			i = i + 1
		end
	end
end

local SpyFrame = CreateFrame("Frame", "SpyFrame", UIParent, nil)
SpyFrame:RegisterEvent("PLAYER_ENTERING_WORLD", OnEvent)
SpyFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA", OnEvent)
SpyFrame:RegisterEvent("ZONE_CHANGED", OnEvent)
SpyFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", LogParse)
SpyFrame:SetWidth(120)
SpyFrame:SetHeight(70)
SpyFrame:SetPoint("CENTER", UIParent, "CENTER")
SpyFrame:SetMovable(true)
SpyFrame:EnableMouse(true)
SpyFrame:SetClampedToScreen(true)
SpyFrame:Show()
SpyFrame:SetTemplate("Transparent")

SpyFrame:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" and (IsAltKeyDown() or IsShiftKeyDown()) then
		self:StartMoving()
	end
end)

SpyFrame:SetScript("OnMouseUp", function(self, button)
	if button == "LeftButton" then
		self:StopMovingOrSizing()
	end
end)

SpyFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" then
		if event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" and not InCombatLockdown() then
			ResetLogParse()
		end
		if GetCurrentMapAreaID() ~= nil then
			SetMapToCurrentZone()
			local Type, _, _ = GetZonePVPInfo()
			-- Tol Barad
			if Type == "sanctuary" or UnitInBattleground("player") or GetCurrentMapAreaID() == 708 then
				Simple_Spy.Sanctuary = true
			else
				Simple_Spy.Sanctuary = false
			end
			if Simple_Spy.Sanctuary == false and Simple_Spy.HideAll == false then
				SpyFrame:Show()
				SpyFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			else
				SpyFrame:Hide()
				SpyFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			end
		end
	else
		timeStamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags = ...
		LogParse(...)
	end
end)

local Enemies = CreateFrame("Frame", "TempFrame", SpyFrame, nil)
Enemies:SetWidth(SpyFrame:GetWidth())
Enemies:SetHeight(11)
Enemies:SetPoint("TOP", SpyFrame, "TOP", 0, -1)

Enemies.txt = SpyFrame:CreateFontString("Title", "OVERLAY")
Enemies.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemies.txt:SetPoint("CENTER", Enemies, "CENTER")
Enemies.txt:SetJustifyH("CENTER")
Enemies.txt:SetText(SPELL_TARGET_TYPE13_DESC..":")
Enemies.txt:SetTextColor(1, 0, 0, 1)

local Enemy1 = CreateFrame("Button", nil, SpyFrame, "SecureActionButtonTemplate")
Enemy1:SetWidth(SpyFrame:GetWidth())
Enemy1:SetHeight(Enemies:GetHeight())
Enemy1:SetAttribute("type1", "macro")
Enemy1:SetPoint("TOP", Enemies, "BOTTOM", 0, -2)
Enemy1:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

Enemy1.txt = SpyFrame:CreateFontString("Enemy1", "OVERLAY")
Enemy1.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemy1.txt:SetPoint("CENTER", Enemy1, "CENTER")
Enemy1.txt:SetJustifyH("CENTER")

local Enemy2 = CreateFrame("Button", nil, SpyFrame, "SecureActionButtonTemplate")
Enemy2:SetWidth(SpyFrame:GetWidth())
Enemy2:SetHeight(Enemies:GetHeight())
Enemy2:SetAttribute("type1", "macro")
Enemy2:SetPoint("TOP", Enemy1, "BOTTOM")
Enemy2:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy2)

Enemy2.txt = SpyFrame:CreateFontString("Enemy2", "OVERLAY")
Enemy2.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemy2.txt:SetPoint("CENTER", Enemy2, "CENTER")
Enemy2.txt:SetJustifyH("CENTER")

local Enemy3 = CreateFrame("Button", nil, SpyFrame, "SecureActionButtonTemplate")
Enemy3:SetWidth(SpyFrame:GetWidth())
Enemy3:SetHeight(Enemies:GetHeight())
Enemy3:SetAttribute("type1", "macro")
Enemy3:SetPoint("TOP", Enemy2, "BOTTOM")
Enemy3:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy3)

Enemy3.txt = SpyFrame:CreateFontString("Enemy3", "OVERLAY")
Enemy3.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemy3.txt:SetPoint("CENTER", Enemy3, "CENTER")
Enemy3.txt:SetJustifyH("CENTER")

local Enemy4 = CreateFrame("Button", nil, SpyFrame, "SecureActionButtonTemplate")
Enemy4:SetWidth(SpyFrame:GetWidth())
Enemy4:SetHeight(Enemies:GetHeight())
Enemy4:SetAttribute("type1", "macro")
Enemy4:SetPoint("TOP", Enemy3, "BOTTOM")
Enemy4:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy4)

Enemy4.txt = SpyFrame:CreateFontString("Enemy4", "OVERLAY")
Enemy4.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemy4.txt:SetPoint("CENTER", Enemy4, "CENTER")
Enemy4.txt:SetJustifyH("CENTER")

local Enemy5 = CreateFrame("Button", nil, SpyFrame, "SecureActionButtonTemplate")
Enemy5:SetWidth(SpyFrame:GetWidth())
Enemy5:SetHeight(Enemies:GetHeight())
Enemy5:SetAttribute("type1", "macro")
Enemy5:SetPoint("TOP", Enemy4, "BOTTOM")
Enemy5:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy5)

Enemy5.txt = SpyFrame:CreateFontString("Enemy1", "OVERLAY")
Enemy5.txt:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
Enemy5.txt:SetPoint("CENTER", Enemy5, "CENTER")
Enemy5.txt:SetJustifyH("CENTER")

function ResetLogParse()
	SSEnemies = {}
	i = 1
	k = ""
	Simple_Spy.red = 0
	Simple_Spy.green = 0
	Simple_Spy.blue = 0
	SSGUIDS = {}
	SSEClasses = {}

	Simple_Spy.Enemy1 = k
	Enemy1.txt:SetText("")
	Enemy1:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy2.txt:SetText("")
	Enemy2:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy3.txt:SetText("")
	Enemy3:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy4.txt:SetText("")
	Enemy4:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy5.txt:SetText("")
	Enemy5:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)
end

local function onUpdate(self, elapsed)
	if InCombatLockdown() then return end -- !!!
	if Simple_Spy.Sanctuary then return end
	Simple_Spy.rtime = Simple_Spy.rtime + elapsed
	if Simple_Spy.rtime >= 0.25 then
		for k, v in pairs(SSEnemies) do
			if SSEClasses[k] ~= nil then
				l = SSEClasses[k]
				hex = Simple_Spy.Colors[l]
				Simple_Spy.rhex, Simple_Spy.ghex, Simple_Spy.bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
				Simple_Spy.red = tonumber(Simple_Spy.rhex, 16) / 255
				Simple_Spy.green = tonumber(Simple_Spy.ghex, 16) / 255
				Simple_Spy.blue = tonumber(Simple_Spy.bhex, 16) / 255
			end
			if k then
				k = SSCharacters[k]
				if v == 1 then
					Simple_Spy.Enemy1 = k
					Enemy1.txt:SetText(k)
					Enemy1.txt:SetTextColor(Simple_Spy.red, Simple_Spy.green, Simple_Spy.blue)
					Enemy1:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)
				elseif v == 2 then
					Simple_Spy.Enemy2 = k
					Enemy2.txt:SetText(k)
					Enemy2.txt:SetTextColor(Simple_Spy.red, Simple_Spy.green, Simple_Spy.blue)
					Enemy2:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy2)
				elseif v == 3 then
					Simple_Spy.Enemy3 = k
					Enemy3.txt:SetText(k)
					Enemy3.txt:SetTextColor(Simple_Spy.red, Simple_Spy.green, Simple_Spy.blue)
					Enemy3:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy3)
				elseif v == 4 then
					Simple_Spy.Enemy4 = k
					Enemy4.txt:SetText(k)
					Enemy4.txt:SetTextColor(Simple_Spy.red, Simple_Spy.green, Simple_Spy.blue)
					Enemy4:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy4)
				elseif v == 5 then
					Simple_Spy.Enemy5 = k
					Enemy5.txt:SetText(k)
					Enemy5.txt:SetTextColor(Simple_Spy.red, Simple_Spy.green, Simple_Spy.blue)
					Enemy5:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy5)
				end
			end
		end
		Simple_Spy.rtime = Simple_Spy.rtime - 0.25
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", onUpdate)
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event)
	SSEnemies = {}
	i = 1
	k = ""
	Simple_Spy.red = 0
	Simple_Spy.green = 0
	Simple_Spy.blue = 0
	SSGUIDS = {}
	SSEClasses = {}

	Simple_Spy.Enemy1 = k
	Enemy1.txt:SetText(k)
	Enemy1:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy2.txt:SetText(k)
	Enemy2:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy3.txt:SetText(k)
	Enemy3:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy4.txt:SetText(k)
	Enemy4:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	Enemy5.txt:SetText(k)
	Enemy5:SetAttribute("macrotext", "/target "..Simple_Spy.Enemy1)

	if GetCurrentMapAreaID() ~= nil then
		SetMapToCurrentZone()
		local Type, _, _ = GetZonePVPInfo()
		-- Tol Barad
		if Type == "sanctuary" or UnitInBattleground("player") or GetCurrentMapAreaID() == 708 then
			Simple_Spy.Sanctuary = true
		else
			Simple_Spy.Sanctuary = false
		end
		if Simple_Spy.Sanctuary == false and Simple_Spy.HideAll == false then
			Enemy1:Show()
			Enemy2:Show()
			Enemy3:Show()
			Enemy4:Show()
			Enemy5:Show()
		else
			Enemy1:Hide()
			Enemy2:Hide()
			Enemy3:Hide()
			Enemy4:Hide()
			Enemy5:Hide()
		end
	end
end)

SLASH_SS1 = "/ss"
SLASH_SS2 = "/sspy"

function SlashCmdList.SS(msg)
	local msg = string.lower(msg)
	local text, number = string.match(msg, "^(%S*)%s*(%d-)$")
	if text == nil then return end
	if text == "stealth" then
		if Simple_Spy.Stealth == true then
			Simple_Spy.Stealth = false
		elseif Simple_Spy.Stealth == false then
			Simple_Spy.Stealth = true
		end
	elseif text == "reset" and Simple_Spy.Sanctuary == false then
		SpyFrame:Show()
		Enemies:Show()
		Enemy1:Show()
		Enemy2:Show()
		Enemy3:Show()
		Enemy4:Show()
		Enemy5:Show()
		SpyFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

		ResetLogParse()

		Simple_Spy.HideAll = false
		SpyFrame:ClearAllPoints()
		SpyFrame:SetPoint("CENTER", UIParent)
	elseif text == "reset" and Simple_Spy.Sanctuary == true then
		SpyFrame:ClearAllPoints()
		SpyFrame:SetPoint("CENTER", UIParent)
	else
		if Simple_Spy.HideAll == false then
			SpyFrame:Hide()
			Enemies:Hide()
			Enemy1:Hide()
			Enemy2:Hide()
			Enemy3:Hide()
			Enemy4:Hide()
			Enemy5:Hide()
			SpyFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			Simple_Spy.HideAll = true
		elseif Simple_Spy.HideAll == true and Simple_Spy.Sanctuary == false then
			SpyFrame:Show()
			Enemies:Show()
			Enemy1:Show()
			Enemy2:Show()
			Enemy3:Show()
			Enemy4:Show()
			Enemy5:Show()
			SpyFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			Simple_Spy.HideAll = false
		elseif Simple_Spy.HideAll == true then
			Simple_Spy.HideAll = false
		end
	end
end
]]
----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[
ToggleDropDownMenu(1, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
EasyMenu(menuList, menuFrame, self, 0, 0, "MENU", 2)
/script BlackMarket_LoadUI() ShowUIPanel(BlackMarketFrame)
/script LoadAddOn("Blizzard_ItemUpgradeUI") ShowUIPanel(ItemUpgradeFrame)
function T.SkinScrollBar(f)
	local frame = f:GetName()

	if _G[frame.."Track"] then _G[frame.."Track"]:Hide() end
	if _G[frame.."BG"] then _G[frame.."BG"]:Hide() end
	if _G[frame.."Top"] then _G[frame.."Top"]:Hide() end
	if _G[frame.."Middle"] then _G[frame.."Middle"]:Hide() end
	if _G[frame.."Bottom"] then _G[frame.."Bottom"]:Hide() end

	local bu = _G[frame.."ThumbTexture"]
	local up = _G[frame.."ScrollUpButton"]
	local down = _G[frame.."ScrollDownButton"]

	bu:SetAlpha(0)
	bu:SetWidth(17)
	bu:SetHeight(22)

	bu.bg = CreateFrame("Frame", nil, f)
	bu.bg:SetTemplate("Overlay")
	bu.bg:SetPoint("TOPLEFT", bu, 0, -3)
	bu.bg:SetPoint("BOTTOMRIGHT", bu, 0, 3)

	up:SetWidth(17)
	up:SkinButton()
	up:SetDisabledTexture(C.media.blank)

	down:SetWidth(17)
	down:SkinButton()
	down:SetDisabledTexture(C.media.blank)

	local dis1 = up:GetDisabledTexture()
	dis1:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis1:SetDrawLayer("OVERLAY")
	dis1:SetPoint("TOPLEFT", up, 2, -2)
	dis1:SetPoint("BOTTOMRIGHT", up, -2, 2)

	local dis2 = down:GetDisabledTexture()
	dis2:SetVertexColor(0.6, 0.6, 0.6, 0.4)
	dis2:SetDrawLayer("OVERLAY")
	dis2:SetPoint("TOPLEFT", down, 2, -2)
	dis2:SetPoint("BOTTOMRIGHT", down, -2, 2)
end]]