----------------------------------------------------------------------------------------
--	By Tukz
----------------------------------------------------------------------------------------
if SettingsCF.aura.player_auras ~= true then return end

local db = SettingsCF["font"]
local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
local rowbuffs = 16

local GetFormattedTime = function(s)
	if s >= 86400 then
		return format('%dd', floor(s/86400 + 0.5))
	elseif s >= 3600 then
		return format('%dh', floor(s/3600 + 0.5))
	elseif s >= 60 then
		return format('%dm', floor(s/60 + 0.5))
	end
	return floor(s + 0.5)
end

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint(unpack(SettingsCF["position"].player_buffs))
ConsolidatedBuffs:SetSize(SettingsCF["aura"].player_buff_size, SettingsCF["aura"].player_buff_size)
ConsolidatedBuffs.SetPoint = nil

ConsolidatedBuffsIcon:SetTexture("Interface\\Icons\\Spell_ChargePositive")
ConsolidatedBuffsIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
ConsolidatedBuffsIcon:SetSize(SettingsCF["aura"].player_buff_size - 4, SettingsCF["aura"].player_buff_size - 4)

local h = CreateFrame("Frame")
h:SetParent(ConsolidatedBuffs)
h:SetAllPoints(ConsolidatedBuffs)
h:SetFrameLevel(30)

ConsolidatedBuffsCount:SetParent(h)
ConsolidatedBuffsCount:SetPoint("BOTTOMRIGHT", 0, SettingsDB.Scale(1))
ConsolidatedBuffsCount:SetFont(db.auras_font, db.auras_font_size, db.auras_font_style);
ConsolidatedBuffsCount:SetShadowOffset(db.auras_font_shadow and 1 or 0, db.auras_font_shadow and -1 or 0)

local CBbg = CreateFrame("Frame", nil, ConsolidatedBuffs)
SettingsDB.CreateTemplate(CBbg)
CBbg:SetPoint("TOPLEFT", ConsolidatedBuffs, 0, 0)
CBbg:SetPoint("BOTTOMRIGHT", ConsolidatedBuffs, 0, 0)
CBbg:SetFrameStrata("BACKGROUND")

for i = 1, 3 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	SettingsDB.CreatePanel(f, SettingsCF["aura"].player_buff_size, SettingsCF["aura"].player_buff_size, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)	
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], SettingsDB.Scale(2), SettingsDB.Scale(-2))
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], SettingsDB.Scale(-2), SettingsDB.Scale(2))
	_G["TempEnchant"..i]:SetHeight(SettingsDB.Scale(SettingsCF["aura"].player_buff_size))
	_G["TempEnchant"..i]:SetWidth(SettingsDB.Scale(SettingsCF["aura"].player_buff_size))	
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("CENTER", SettingsDB.Scale(2), SettingsDB.Scale(1))
	_G["TempEnchant"..i.."Duration"]:SetFont(db.auras_font, db.auras_font_size, db.auras_font_style);
	_G["TempEnchant"..i.."Duration"]:SetShadowOffset(db.auras_font_shadow and 1 or 0, db.auras_font_shadow and -1 or 0)
end

local function StyleBuffs(buttonName, index, debuff)
	local buff = _G[buttonName..index]
	local icon = _G[buttonName..index.."Icon"]
	local border = _G[buttonName..index.."Border"]
	local duration = _G[buttonName..index.."Duration"]
	local count = _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", buff, SettingsDB.Scale(2), SettingsDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", buff, SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		buff:SetHeight(SettingsDB.Scale(SettingsCF["aura"].player_buff_size))
		buff:SetWidth(SettingsDB.Scale(SettingsCF["aura"].player_buff_size))
		
		duration:ClearAllPoints()
		duration:SetPoint("CENTER", SettingsDB.Scale(2), SettingsDB.Scale(1))
		duration:SetFont(db.auras_font, db.auras_font_size, db.auras_font_style);
		duration:SetShadowOffset(db.auras_font_shadow and 1 or 0, db.auras_font_shadow and -1 or 0)
		
		count:ClearAllPoints()
		count:SetPoint("BOTTOMRIGHT", 0, SettingsDB.Scale(1))
		count:SetFont(db.auras_font, db.auras_font_size, db.auras_font_style);
		count:SetShadowOffset(db.auras_font_shadow and 1 or 0, db.auras_font_shadow and -1 or 0)
		
		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		SettingsDB.CreatePanel(panel, SettingsCF["aura"].player_buff_size, SettingsCF["aura"].player_buff_size, "CENTER", buff, "CENTER", 0, 0)
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

function UpdateFlash(self, elapsed)
	local index = self:GetID()
	self:SetAlpha(1)
end

local UpdateDuration = function(auraButton, timeLeft)
	local duration = auraButton.duration
	if SHOW_BUFF_DURATIONS == "1" and timeLeft and SettingsCF["aura"].show_timer == true then
		duration:SetFormattedText(GetFormattedTime(timeLeft))
		duration:SetVertexColor(1, 1, 1)
		duration:Show()
	else
		duration:Hide()
	end
end

local function UpdateBuffAnchors()
	local buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff;
	local numBuffs = 0;
	local slack = BuffFrame.numEnchants
	local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
	if ( BuffFrame.numConsolidated > 0 ) then
		slack = slack + 1;	
	end
	for index = 1, BUFF_ACTUAL_DISPLAY do
		StyleBuffs(buttonName, index, false)
		local buff = _G[buttonName..index]
		
		if not ( buff.consolidated ) then	
			numBuffs = numBuffs + 1
			index = numBuffs + slack
			buff:ClearAllPoints()
			if ( (index > 1) and (mod(index, rowbuffs) == 1) ) then
 				if ( index == rowbuffs + 1 ) then
					buff:SetPoint("TOP", ConsolidatedBuffs, "BOTTOM", 0, SettingsDB.Scale(-3))
				else
					buff:SetPoint("TOP", aboveBuff, "BOTTOM", 0, SettingsDB.Scale(-3))
				end
				aboveBuff = buff; 
			elseif ( index == 1 ) then
				buff:SetPoint(unpack(SettingsCF["position"].player_buffs))
			else
				if ( numBuffs == 1 ) then
					if (mainhand and offhand and hand3) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant3, "LEFT", SettingsDB.Scale(-3), 0)
					elseif ((mainhand and offhand) or (mainhand and hand3) or (offhand and hand3)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", SettingsDB.Scale(-3), 0)
					elseif ((mainhand and not offhand and not hand3) or (offhand and not mainhand and not hand3) or (hand3 and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", SettingsDB.Scale(-3), 0)
					else
						buff:SetPoint("RIGHT", ConsolidatedBuffs, "LEFT", SettingsDB.Scale(-3), 0);
					end
				else
					buff:SetPoint("RIGHT", previousBuff, "LEFT", SettingsDB.Scale(-3), 0);
				end
			end
			previousBuff = buff
		end		
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	_G[buttonName..index]:Hide()
end

-- Fixing the consolidated buff container size
local z = 0.79
local function UpdateConsolidatedBuffsAnchors()
	ConsolidatedBuffsTooltip:SetWidth(min(BuffFrame.numConsolidated * SettingsCF["aura"].player_buff_size * z + 18, 4 * SettingsCF["aura"].player_buff_size * z + 18));
    ConsolidatedBuffsTooltip:SetHeight(floor((BuffFrame.numConsolidated + 3) / 4 ) * SettingsCF["aura"].player_buff_size * z + CONSOLIDATED_BUFF_ROW_HEIGHT * z);
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
hooksecurefunc("AuraButton_UpdateDuration", UpdateDuration)
hooksecurefunc("AuraButton_OnUpdate", UpdateFlash)
hooksecurefunc("ConsolidatedBuffs_UpdateAllAnchors", UpdateConsolidatedBuffsAnchors)