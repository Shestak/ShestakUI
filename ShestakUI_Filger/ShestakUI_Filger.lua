if SettingsCF["unitframe"].enable ~= true then return end
--[[
	
	Filger
	Copyright (c) 2009, Nils Ruesch
	All rights reserved.
	Modded by Affli@RU-HowlingFjord
	
]]

local f_s = Filger_Settings;
local db = SettingsCF["font"]
local class = select(2, UnitClass("player"));
local active, bars = {}, {};
local MyUnits = {
    player = true,
    vehicle = true,
    pet = true,
}

local time, Update;
local function OnUpdate(self, elapsed)
	time = self.filter == "CD" and self.expirationTime+self.duration-GetTime() or self.expirationTime-GetTime();
	if (self:GetParent().Mode == "BAR") then
		self.statusbar:SetValue(time);
		if time <= 60 then
			self.time:SetFormattedText("%.1f",(time));
		else
			self.time:SetFormattedText("%d:%.2d",(time/60),(time%60));
		end
	end
	if (time < 0 and self.filter == "CD") then
		local id = self:GetParent().Id;
		for index, value in ipairs(active[id]) do
			local spn = GetSpellInfo(value.data.spellID or value.data.slotID)
			if (self.spellName == spn) then
				tremove(active[id], index);
				break;
			end
		end
		self:SetScript("OnUpdate", nil);
		Update(self:GetParent());
	end
end

function Update(self)
	local id = self.Id;
	if (not bars[id]) then
		bars[id] = {};
	end
	for index, value in ipairs(bars[id]) do
		value:Hide();
	end
	local bar;
	for index, value in ipairs(active[id]) do
		bar = bars[id][index];
		if (not bar) then
			bar = CreateFrame("Frame", "FilgerAnchor"..id.."Frame"..index, self);
			bar:SetWidth(value.data.size);
			bar:SetHeight(value.data.size);
			bar:SetScale(1);
			SettingsDB.CreateTemplate(bar);

			if (index == 1) then
				bar:SetPoint(unpack(self.setPoint));
			else
				if (self.Direction == "UP") then
					bar:SetPoint("BOTTOM", bars[id][index-1], "TOP", 0, self.Interval);
				elseif (self.Direction == "RIGHT") then
					bar:SetPoint("LEFT", bars[id][index-1], "RIGHT", self.Mode == "ICON" and self.Interval or value.data.barWidth+self.Interval, 0);
				elseif (self.Direction == "LEFT") then
					bar:SetPoint("RIGHT", bars[id][index-1], "LEFT", self.Mode == "ICON" and -self.Interval or -(value.data.barWidth+self.Interval), 0);
				else
					bar:SetPoint("TOP", bars[id][index-1], "BOTTOM", 0, -self.Interval);
				end
			end

			if (bar.icon) then
				bar.icon = _G[bar.icon:GetName()]
			else
				bar.icon = bar:CreateTexture("$parentIcon", "ARTWORK");
				bar.icon:SetPoint("TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
				bar.icon:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
				bar.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
			end
			
			if (self.Mode == "ICON") then
				bar.cooldown = CreateFrame("Cooldown", "$parentCD", bar, "CooldownFrameTemplate");
				bar.cooldown:SetAllPoints(bar.icon);
				bar.cooldown:SetReverse();
				
				if (bar.count) then
					bar.count = _G[bar.count:GetName()]
				else
					bar.count = bar:CreateFontString("$parentCount", "OVERLAY");
					bar.count:SetFont(db.cooldown_timers_font, db.cooldown_timers_font_size, db.cooldown_timers_font_style);
					bar.count:SetShadowOffset(db.cooldown_timers_font_shadow and 1 or 0, db.cooldown_timers_font_shadow and -1 or 0)
					bar.count:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(1), SettingsDB.Scale(-1));
					bar.count:SetJustifyH("CENTER");
				end
			else
				if (bar.statusbar) then
					bar.statusbar = _G[bar.statusbar:GetName()]
				else
					bar.statusbar = CreateFrame("StatusBar", "$parentStatusBar", bar);
					bar.statusbar:SetWidth(SettingsDB.Scale(value.data.barWidth - 2));
					bar.statusbar:SetHeight(SettingsDB.Scale(value.data.size - 10));
					bar.statusbar:SetStatusBarTexture(SettingsCF["media"].texture);
					bar.statusbar:SetStatusBarColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 1);
					bar.statusbar:SetPoint("BOTTOMLEFT", bar, "BOTTOMRIGHT", SettingsDB.Scale(5), SettingsDB.Scale(2));
				end
				bar.statusbar:SetMinMaxValues(0, 1);
				bar.statusbar:SetValue(0);
				
				if (bar.bg)then
					bar.bg = _G[bar.bg:GetName()]
				else
					bar.bg = CreateFrame("Frame", "$parentBG", bar.statusbar)
					bar.bg:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
					bar.bg:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
					bar.bg:SetFrameStrata("BACKGROUND")
					SettingsDB.CreateTemplate(bar.bg)
				end
				
				if (bar.background)then
					bar.background = _G[bar.background:GetName()]
				else
					bar.background = bar.statusbar:CreateTexture(nil, "BACKGROUND");
					bar.background:SetAllPoints();
					bar.background:SetTexture(SettingsCF["media"].texture);
					bar.background:SetVertexColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b, 0.25);
				end
				
				if (bar.time)then
					bar.time = _G[bar.time:GetName()]
				else			
					bar.time = bar.statusbar:CreateFontString("$parentTime", "ARTWORK");
					bar.time:SetFont(db.filger_font, db.filger_font_size, db.filger_font_style);
					bar.time:SetShadowOffset(db.filger_font_shadow and 1 or 0, db.filger_font_shadow and -1 or 0)
					bar.time:SetPoint("RIGHT", bar.statusbar, SettingsDB.Scale(0), 0);
				end
				
				if (bar.count) then
					bar.count = _G[bar.count:GetName()]
				else
					bar.count = bar:CreateFontString("$parentCount", "ARTWORK");
					bar.count:SetFont(db.filger_font, db.filger_font_size, db.filger_font_style);
					bar.count:SetShadowOffset(db.filger_font_shadow and 1 or 0, db.filger_font_shadow and -1 or 0)
					bar.count:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(1), SettingsDB.Scale(1));
					bar.count:SetJustifyH("CENTER");
				end
				
				if (bar.spellname)then
					bar.spellname = _G[bar.spellname:GetName()]
				else
					bar.spellname = bar.statusbar:CreateFontString("$parentSpellName", "ARTWORK");
					bar.spellname:SetFont(db.filger_font, db.filger_font_size, db.filger_font_style);
					bar.spellname:SetShadowOffset(db.filger_font_shadow and 1 or 0, db.filger_font_shadow and -1 or 0)
					bar.spellname:SetPoint("LEFT", bar.statusbar, SettingsDB.Scale(2), 0);
					bar.spellname:SetPoint("RIGHT", bar.time, "LEFT");
					bar.spellname:SetJustifyH("LEFT");
				end
			end
			tinsert(bars[id], bar);
		end
		
		bar.spellName = GetSpellInfo( value.data.spellID or value.data.slotID );
		
		bar.icon:SetTexture(value.icon);
		bar.count:SetText(value.count > 1 and value.count or "");
		if (self.Mode == "BAR") then
			bar.spellname:SetText(value.data.displayName or GetSpellInfo( value.data.spellID ));
		end
		if (value.duration > 0) then
			if (self.Mode == "ICON") then
				CooldownFrame_SetTimer(bar.cooldown, value.data.filter == "CD" and value.expirationTime or value.expirationTime-value.duration, value.duration, 1);
				if (value.data.filter == "CD") then
					bar.expirationTime = value.expirationTime;
					bar.duration = value.duration;
					bar.filter = value.data.filter;
					bar:SetScript("OnUpdate", OnUpdate);
				end
			else
				bar.statusbar:SetMinMaxValues(0, value.duration);
				bar.expirationTime = value.expirationTime;
				bar.duration = value.duration;
				bar.filter = value.data.filter;
				bar:SetScript("OnUpdate", OnUpdate);
			end
		else
			if (self.Mode == "ICON") then
				bar.cooldown:Hide();
			else
				bar.statusbar:SetMinMaxValues(0, 1);
				bar.statusbar:SetValue(1);
				bar.time:SetText("");
				bar:SetScript("OnUpdate", nil);
			end
		end
		
		bar:Show();
	end
end

local function OnEvent(self, event, ...)
	local unit = ...;
	if ( ( unit == "target" or unit == "player" ) or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_COOLDOWN" ) then
		local data, name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, start, enabled, slotLink, spn;
		local id = self.Id;
		for i=1, #Filger_Spells[class][id], 1 do
			data = Filger_Spells[class][id][i];
			if (data.filter == "BUFF") then
				spn = GetSpellInfo( data.spellID )
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff(data.unitId, spn);
			elseif (data.filter == "DEBUFF") then
				spn = GetSpellInfo( data.spellID )
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(data.unitId, spn);
			else
				if (data.spellID) then
					spn = GetSpellInfo(data.spellID)
					start, duration, enabled = GetSpellCooldown(spn);
					_, _, icon = GetSpellInfo(data.spellID);
				else
					slotLink = GetInventoryItemLink("player", data.slotID);
					if ( slotLink ) then
						name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink);
						if (not data.displayName) then
							data.displayName = name;
						end
						start, duration, enabled = GetInventoryItemCooldown("player", data.slotID);
					end
				end
				count = 0;
				caster = "all";
			end
			if (not active[id]) then
				active[id] = {};
			end
			for index, value in ipairs(active[id]) do
				if (data.spellID == value.data.spellID) then
					tremove(active[id], index);
					break;
				end
			end
			if ( ( name and ( data.caster ~= 1 and ( caster == data.caster or data.caster == "all" ) or MyUnits[caster] )) or ( ( enabled or 0 ) > 0 and ( duration or 0 ) > 1.5 ) ) then
				table.insert(active[id], { data = data, icon = icon, count = count, duration = duration, expirationTime = expirationTime or start });
			end
		end
		Update(self);
	end
end

if (Filger_Spells and Filger_Spells["ALL"]) then
	if (not Filger_Spells[class]) then
		Filger_Spells[class] = {}
	end

	for i = 1, #Filger_Spells["ALL"], 1 do
		table.insert(Filger_Spells[class], Filger_Spells["ALL"][i])
	end
end

if (Filger_Spells and Filger_Spells[class]) then
	for index in pairs(Filger_Spells) do
		if (index ~= class) then
			Filger_Spells[index] = nil;
		end
	end
	local data, frame;
	for i = 1, #Filger_Spells[class], 1 do
		data = Filger_Spells[class][i];
		
		frame = CreateFrame("Frame", "FilgerAnchor"..i, UIParent);
		frame.Id = i;
		frame.Name = data.Name;
		frame.Direction = data.Direction or "DOWN";
		frame.Interval = data.Interval or 3;
		frame.Mode = data.Mode or "ICON";
		frame.setPoint = data.setPoint or "CENTER";
		frame:SetWidth(Filger_Spells[class][i][1] and Filger_Spells[class][i][1].size or 100);
		frame:SetHeight(Filger_Spells[class][i][1] and Filger_Spells[class][i][1].size or 20);
		frame:SetPoint(unpack(data.setPoint));

		if (f_s.configmode) then
			for j = 1, #Filger_Spells[class][i], 1 do
				data = Filger_Spells[class][i][j];
				if (not active[i]) then
					active[i] = {};
				end
				if (data.spellID) then
					_, _, spellIcon = GetSpellInfo(data.spellID)
				else
					slotLink = GetInventoryItemLink("player", data.slotID);
					if (slotLink) then
						name, _, _, _, _, _, _, _, _, spellIcon = GetItemInfo(slotLink);
					end
				end
				table.insert(active[i], { data = data, icon = spellIcon, count = 9, duration = 0, expirationTime = 0 });
			end
			Update(frame);
		else
			for j = 1, #Filger_Spells[class][i], 1 do
				data = Filger_Spells[class][i][j];
				if (data.filter == "CD") then
					frame:RegisterEvent("SPELL_UPDATE_COOLDOWN");
					break;
				end
			end
			frame:RegisterEvent("UNIT_AURA");
			frame:RegisterEvent("PLAYER_TARGET_CHANGED");
			frame:RegisterEvent("PLAYER_ENTERING_WORLD");
			frame:SetScript("OnEvent", OnEvent);
		end
	end
end