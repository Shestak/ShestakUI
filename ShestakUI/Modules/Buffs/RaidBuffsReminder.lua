local T, C, L, _ = unpack(select(2, ...))
if C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by NDui@NGACN, kurapica@NGACN)
----------------------------------------------------------------------------------------
local BuffFrame = {}
local Melee, m, value, text

local RaidBuffsAnchor = CreateFrame("Frame", "RaidBuffsAnchor", UIParent)
RaidBuffsAnchor:SetPoint(unpack(C.position.raid_buffs))
RaidBuffsAnchor:SetWidth(1)
RaidBuffsAnchor:SetHeight(1)

local function OnAuraChange(self, event, arg1, unit, ...)
	if event == "UNIT_AURA" and arg1 ~= "player" then return end
	
	for i = 1, 7 do
		local spellName, rank, texture, duration, expirationTime, spellId, slot = GetRaidBuffTrayAuraInfo(T.ReminderBuffs[i][1])
		if not spellName then
			BuffFrame[i]:SetAlpha(1)
			BuffFrame[i].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[i][2])))
			BuffFrame[i].hasBuff = nil
		else
			BuffFrame[i].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[i][2])))
			BuffFrame[i]:SetAlpha(0.2)
			BuffFrame[i].hasBuff = true
			BuffFrame[i].name = spellName
		end
	end
	
	if T.Role == "Caster" or T.Role == "Healer" then 
		Melee = false
		m = 9    --法强 
	else 
		Melee = true
		m = 8    --攻强 
	end
	local spellName, rank, texture, duration, expirationTime, spellId, slot = GetRaidBuffTrayAuraInfo(T.ReminderBuffs[m][1])
	if not spellName then
		BuffFrame[8]:SetAlpha(1)
		BuffFrame[8].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[m][2])))
		BuffFrame[8].hasBuff = nil
	else
		BuffFrame[8].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[m][2])))
		BuffFrame[8]:SetAlpha(0.2)
		BuffFrame[8].hasBuff = true
		BuffFrame[8].name = spellName
	end
	--食物/合剂/符文石
	for i = 9, 11 do
		if T.ReminderBuffs[i] and T.ReminderBuffs[i+1][1] then
			BuffFrame[i]:SetAlpha(1)
			BuffFrame[i].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[i+1][1])))
			BuffFrame[i].hasBuff = nil
			for key, value in pairs(T.ReminderBuffs[i+1]) do
				local name = GetSpellInfo(value)
				if UnitAura("player", name) then
					BuffFrame[i].Icon:SetTexture(select(3, GetSpellInfo(value)))
					BuffFrame[i]:SetAlpha(0.2)
					BuffFrame[i].hasBuff = true
					BuffFrame[i].name = name
					break
				end
			end
		end
	end
	--治疗石
	if T.ReminderBuffs[13] then
		local stone = select(10, GetItemInfo(T.ReminderBuffs[13]))
		BuffFrame[12]:SetAlpha(1)
		BuffFrame[12].Icon:SetTexture(stone)
		BuffFrame[12].Text:SetText(nil)
		BuffFrame[12].hasBuff = nil
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local tex = GetContainerItemInfo(bag, slot)
				if tex and tex == stone then
					BuffFrame[12]:SetAlpha(0.2)
					BuffFrame[12].Text:SetText(GetItemCount(T.ReminderBuffs[13], nil, true))
					BuffFrame[12].hasBuff = true
					BuffFrame[12].info = {bag, slot}
					break
				end
			end
		end					
	end
end

for i = 1, 12 do
	local button = CreateFrame("Frame", "RaidBuffReminder", UIParent)
	button.Icon = button:CreateTexture(nil, "ARTWORK")
	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.Icon:SetPoint("TOPLEFT", 2, -2)
	button.Icon:SetPoint("BOTTOMRIGHT", -2, 2)

	button.Text = button:CreateFontString(nil, "OVERLAY")
	button.Text:SetPoint("CENTER")
	button.Text:SetFont(C.font.stats_font, 14, "OUTLINE")
	
	if i == 1 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", RaidBuffsAnchor, "BOTTOMLEFT", 0, 0)
	elseif i > 1 and i < 7 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", BuffFrame[i-1], "RIGHT", 3, 0)
	elseif i == 7 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", BuffFrame[1], "TOPLEFT", 0, 3)
	elseif i > 7 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", BuffFrame[i-1], "RIGHT", 3, 0)
	end
	table.insert(BuffFrame, button)
	
	local _, instanceType = IsInInstance()
	if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
		button:Hide()
	else
		button:Show()
	end
end

for i = 1, 12 do
	local function Button_OnEnter(self)
		GameTooltip:Hide()
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -5, -5)
		GameTooltip:ClearLines()

		if(self.hasBuff) then
			if i == 12 then
				GameTooltip:SetBagItem(unpack(BuffFrame[12].info))
			else
				GameTooltip:SetUnitAura("player", BuffFrame[i].name)
			end
		else	
			if i == 1 then text = "属性"
			elseif i == 2 then text = "耐力"
			elseif i == 3 then text = "加速"
			elseif i == 4 then text = "暴击"
			elseif i == 5 then text = "精通"
			elseif i == 6 then text = "溅射"
			elseif i == 7 then text = "全能"
			elseif i == 8 then
				if Melee == true then text = "攻强" else text = "法强" end
			elseif i == 9 then text = "合剂"
			elseif i == 10 then text = "食物"
			elseif i == 11 then text = "符文"
			elseif i == 12 then text = "治疗石"
			end
			GameTooltip:AddLine(text, 1, 1, 1)
		end
		GameTooltip:Show()
	end
	
	BuffFrame[i]:SetScript("OnEnter", Button_OnEnter)
	BuffFrame[i]:SetScript("OnLeave", GameTooltip_Hide)
end

RaidBuffsAnchor:RegisterEvent("UNIT_AURA")
RaidBuffsAnchor:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidBuffsAnchor:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RaidBuffsAnchor:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidBuffsAnchor:RegisterEvent("GROUP_ROSTER_UPDATE") 
RaidBuffsAnchor:RegisterUnitEvent("UNIT_AURA", "player")
RaidBuffsAnchor:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
RaidBuffsAnchor:RegisterEvent("BAG_UPDATE")
RaidBuffsAnchor:SetScript("OnEvent", OnAuraChange)
