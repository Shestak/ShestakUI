local T, C, L, _ = unpack(select(2, ...))
if C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by NDui@NGACN)
----------------------------------------------------------------------------------------
local BuffFrame = {}
local Melee, text
local RaidBuffsAnchor = CreateFrame("Frame", "RaidBuffsAnchor", UIParent)
RaidBuffsAnchor:SetPoint(unpack(C.position.raid_buffs))
RaidBuffsAnchor:SetWidth(1)
RaidBuffsAnchor:SetHeight(1)
RaidBuffsAnchor:RegisterEvent("UNIT_AURA")
RaidBuffsAnchor:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidBuffsAnchor:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RaidBuffsAnchor:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidBuffsAnchor:RegisterEvent("GROUP_ROSTER_UPDATE") 
RaidBuffsAnchor:RegisterUnitEvent("UNIT_AURA", "player")
RaidBuffsAnchor:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")
RaidBuffsAnchor:RegisterEvent("BAG_UPDATE")

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
	
	button:SetAlpha(0)	
	table.insert(BuffFrame,button)
end

local function OnAuraChange(self, event, arg1, unit, ...)
	if event == "UNIT_AURA" and arg1 ~= "player" then return end
	
	local _, instanceType = IsInInstance()
	for key, value in pairs(BuffFrame) do
		if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
			value:Hide()
		else
			value:Show()
		end
	end
	
	if T.Role == "Caster" or T.Role == "Healer" then
		Melee = false
	else
		Melee = true
	end

	for i = 1, 9 do
		if T.ReminderBuffs and T.ReminderBuffs[i][1] then
			BuffFrame[i]:SetAlpha(1)
			BuffFrame[i].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[i][1])))
			BuffFrame[i].hasBuff = nil
			for key, value in pairs(T.ReminderBuffs[i]) do
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
	
	--攻强/法强
	if Melee then
		if T.ReminderBuffs[10] and T.ReminderBuffs[10][1] then
			BuffFrame[10]:SetAlpha(1)
			BuffFrame[10].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[10][1])))
			BuffFrame[10].hasBuff = nil
			for key, value in pairs(T.ReminderBuffs[10]) do
				local name = GetSpellInfo(value)
				if UnitAura("player", name) then
					BuffFrame[10].Icon:SetTexture(select(3, GetSpellInfo(value)))
					BuffFrame[10]:SetAlpha(0.2)
					BuffFrame[10].hasBuff = true
					BuffFrame[10].name = name
					break
				end
			end
		end
	else
		if T.ReminderBuffs[11] and T.ReminderBuffs[11][1] then
			BuffFrame[10]:SetAlpha(1)
			BuffFrame[10].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[11][1])))
			BuffFrame[10].hasBuff = nil
			for key, value in pairs(T.ReminderBuffs[11]) do
				local name = GetSpellInfo(value)
				if UnitAura("player", name) then
					BuffFrame[10].Icon:SetTexture(select(3, GetSpellInfo(value)))
					BuffFrame[10]:SetAlpha(0.2)
					BuffFrame[10].hasBuff = true
					BuffFrame[10].name = name
					break
				end
			end
		end
	end
	--治疗石
	if T.ReminderBuffs[12] and T.ReminderBuffs[12][1] then
		local stone = select(10, GetItemInfo(T.ReminderBuffs[12][1]))
		BuffFrame[11]:SetAlpha(1)
		BuffFrame[11].Icon:SetTexture(stone)
		BuffFrame[11].Text:SetText(nil)
		BuffFrame[11].hasBuff = nil
		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local tex = GetContainerItemInfo(bag, slot)
				if tex and tex == stone then
					BuffFrame[11]:SetAlpha(0.2)
					BuffFrame[11].Text:SetText(GetItemCount(T.ReminderBuffs[12][1], nil, true))
					BuffFrame[11].hasBuff = true
					BuffFrame[11].info = {bag, slot}
					break
				end
			end
		end					
	end
	
	if T.ReminderBuffs[13] and T.ReminderBuffs[13][1] then
		BuffFrame[12]:SetAlpha(1)
		BuffFrame[12].Icon:SetTexture(select(3, GetSpellInfo(T.ReminderBuffs[13][1])))
		BuffFrame[12].hasBuff = nil
		for key, value in pairs(T.ReminderBuffs[13]) do
			local name = GetSpellInfo(value)
			if UnitAura("player", name) then
				BuffFrame[12].Icon:SetTexture(select(3, GetSpellInfo(value)))
				BuffFrame[12]:SetAlpha(0.2)
				BuffFrame[12].hasBuff = true
				BuffFrame[12].name = name
				break
			end
		end
	end
end

for i = 1, 12 do
	local function Button_OnEnter(self)
		GameTooltip:Hide()
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", -5, -5)
		GameTooltip:ClearLines()

		if(self.hasBuff) then
			if i == 11 then
				GameTooltip:SetBagItem(unpack(BuffFrame[11].info))
			else
				GameTooltip:SetUnitAura("player", BuffFrame[i].name)
			end
		else	
			
			if i == 1 then text = "药剂"
			elseif i == 2 then text = "食物"
			elseif i == 3 then text = "属性"
			elseif i == 4 then text = "耐力"
			elseif i == 5 then text = "暴击"
			elseif i == 6 then text = "精通"
			elseif i == 7 then text = "溅射"
			elseif i == 8 then text = "全能"
			elseif i == 9 then text = "急速"
			elseif i == 10 then
				if Melee then text = "攻强" else text = "法强" end
			elseif i == 11 then text = "治疗石"
			elseif i == 12 then text = "符文"
			end
			GameTooltip:SetText(text, 1, 1, 1)
		end
		GameTooltip:Show()
	end
	
	BuffFrame[i]:SetScript("OnEnter", Button_OnEnter)
	BuffFrame[i]:SetScript("OnLeave", GameTooltip_Hide)
end

RaidBuffsAnchor:SetScript("OnEvent", OnAuraChange)
