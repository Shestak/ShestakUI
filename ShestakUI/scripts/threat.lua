----------------------------------------------------------------------------------------
--	Based on sThreatMeter2
----------------------------------------------------------------------------------------
if not SettingsCF.threat.enable == true or not SettingsCF.unitframe.enable == true then return end

local db = SettingsCF["font"]
local threatguid, threatunit, threatlist, threatbars = "", "target", {}, {};

local function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local function short_value(value)
	local strLen = strlen(value);
	local retString = value;
	if ( strLen > 6 ) then
		retString = string.sub(value, 1, -7)..SECOND_NUMBER_CAP;
	elseif ( strLen > 3 ) then
		retString = string.sub(value, 1, -4)..FIRST_NUMBER_CAP;
	end
	return retString;
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function GetThreat(unit, pet)
	if ( UnitName(pet or unit) == UNKNOWN or not UnitIsVisible(pet or unit) ) then
		return;
	end
	
	local tperc, _, tvalue = select(3, UnitDetailedThreatSituation(pet or unit, threatunit));
	local name = pet and UnitName(unit) .. ": " .. UnitName(pet) or UnitName(unit);
	
	for index, value in ipairs(threatlist) do
		if ( value.name == name ) then
			tremove(threatlist, index);
			break;
		end
	end
	if tvalue and tvalue < 0 then
		tvalue = tvalue + 410065408;
	end
	table.insert(threatlist, {
		name = name,
		class = select(2, UnitClass(unit)),
		tperc = tperc or 0,
		tvalue = tvalue or 0,
	});
end

local function AddThreat(unit, pet)
	if ( UnitExists(pet) ) then
		GetThreat(unit);
		GetThreat(unit, pet);
	else
		if ( GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 ) then
			GetThreat(unit);
		end
	end
end

local function SortThreat(a, b)
	return a.tperc > b.tperc;
end

local function OnUpdateBar(self, elpased)
	if ( self.moveTo == self.value ) then
		self:SetScript("OnUpdate", nil);
	else
		if ( self.moveTo > self.value ) then
			self.value = self.value+1;
		elseif ( self.moveTo < self.value ) then
			self.value = self.value-1;
		end
		self:SetValue(self.value);
	end
end

local function UpdateThreatBars()
	for index, value in ipairs(threatbars) do
		value:Hide();
	end
	table.sort(threatlist, SortThreat);
	local bar, class, r, g, b, text;
	for index, value in ipairs(threatlist) do
		if ( index > SettingsCF["threat"].bar_rows ) then
			return;
		end
		bar = threatbars[index];
		if ( not bar ) then
			bar = CreateFrame("StatusBar", "ThreatMeterBar"..index, UIParent);
			bar:SetWidth(SettingsCF["threat"].width);
			bar:SetHeight(SettingsCF["threat"].height);
			bar:SetStatusBarTexture(SettingsCF["media"].texture);
			bar:SetMinMaxValues(0, 100);
			bar:SetValue(0);
			if ( index == 1 ) then
				bar:SetPoint("TOP", ThreatMeter);
			else
				bar:SetPoint("TOP", threatbars[index-1], "BOTTOM", 0, SettingsDB.Scale(-7));
			end
			
			bar.background = bar:CreateTexture("$parentBackground", "BACKGROUND");
			bar.background:SetAllPoints();
			bar.background:SetTexture(SettingsCF["media"].texture);
			
			bar.backgdrop = CreateFrame("Frame", nil, bar)
			SettingsDB.CreateTemplate(bar.backgdrop)
			bar.backgdrop:SetFrameStrata("BACKGROUND")
			bar.backgdrop:SetPoint("TOPLEFT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
			bar.backgdrop:SetPoint("BOTTOMRIGHT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
			
			bar.textright = bar:CreateFontString("$parentTextRight", "ARTWORK");
			bar.textright:SetFont(db.threat_meter_font, db.threat_meter_font_size, db.threat_meter_font_style);
			bar.textright:SetShadowOffset(db.threat_meter_font_shadow and 1 or 0, db.threat_meter_font_shadow and -1 or 0)
			bar.textright:SetJustifyH("RIGHT");
			bar.textright:SetPoint("RIGHT", SettingsDB.Scale(-1), 0);
			
			bar.textleft = bar:CreateFontString("$parentTextLeft", "ARTWORK");
			bar.textleft:SetFont(db.threat_meter_font, db.threat_meter_font_size, db.threat_meter_font_style);
			bar.textleft:SetShadowOffset(db.threat_meter_font_shadow and 1 or 0, db.threat_meter_font_shadow and -1 or 0)
			bar.textleft:SetJustifyH("LEFT");
			bar.textleft:SetPoint("LEFT", SettingsDB.Scale(2), 0);
			bar.textleft:SetPoint("RIGHT", bar.textright, "LEFT", SettingsDB.Scale(-1), 0);
			
			tinsert(threatbars, bar);
		end
		
		bar:SetValue(tonumber(format("%d", value.tperc)));
		
		class = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[value.class] and CUSTOM_CLASS_COLORS[value.class] or RAID_CLASS_COLORS[value.class];
		if ( value.name == UnitName("player") ) then
			bar:SetStatusBarColor(1, 0, 0, 1);
		else
			bar:SetStatusBarColor(class.r, class.g, class.b, 1);
		end
		bar.textright:SetTextColor(1, 1, 1, 1);
		bar.textleft:SetTextColor(1, 1, 1, 1);
		bar.background:SetVertexColor(class.r, class.g, class.b, 0.25);
		
		r, g, b = ColorGradient(((value.tperc > 100 and 100 or value.tperc)/100), 0, 1, 0, 1, 1, 0, 1, 0, 0);
		text = string.gsub("$value [$perc%]", "$value", comma_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$shortvalue", short_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$perc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.tperc));
		text = string.gsub(text, "$name", value.name);
		bar.textright:SetText(text);
		
		text = string.gsub("$name", "$value", comma_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$shortvalue", short_value(tonumber(format("%d", value.tvalue/100))));
		text = string.gsub(text, "$perc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.tperc));
		text = string.gsub(text, "$name", value.name);
		bar.textleft:SetText(text);
		
		bar:Show();
	end
end

local function OnEvent(self, event, ...)
	local unit = ...;
	if ( event == "ADDON_LOADED" and unit == "ShestakUI" ) then
		self:SetPoint(unpack(SettingsCF["position"].threat_meter));
		self:SetWidth(SettingsCF["threat"].width);
		self:SetHeight(SettingsCF["threat"].height);
		self:UnregisterEvent(event);
	elseif ( event == "UNIT_THREAT_LIST_UPDATE" ) then
		if ( unit and UnitExists(unit) and UnitGUID(unit) == threatguid and UnitCanAttack("player", threatunit) ) then
			if ( GetNumRaidMembers() > 0 ) then
				for i=1, GetNumRaidMembers(), 1 do
					AddThreat("raid"..i, "raid"..i.."pet");
				end
			elseif ( GetNumPartyMembers() > 0 ) then
				AddThreat("player", "pet");
				for i=1, GetNumPartyMembers(), 1 do
					AddThreat("party"..i, "party"..i.."pet");
				end
			else
				AddThreat("player", "pet");
			end
			UpdateThreatBars();
		end
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		if ( UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") ) then
			threatguid = UnitGUID("target");
		else
			threatguid = "";
		end
		wipe(threatlist);
		UpdateThreatBars();
	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
		wipe(threatlist);
		UpdateThreatBars();
	end
end

local frame = CreateFrame("Frame", "ThreatMeter", UIParent);
frame:SetClampedToScreen(true);
frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("PLAYER_REGEN_ENABLED");
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", OnEvent);

if SettingsCF["threat"].test_mode == true then
	table.insert(threatlist, { name = PLAYER.." 1", class = "WARRIOR", tperc = 100, tvalue = 100*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 2", class = "ROGUE", tperc = 90, tvalue = 90*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 3", class = "HUNTER", tperc = 80, tvalue = 80*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 4", class = "PRIEST", tperc = 70, tvalue = 70*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 5", class = "DRUID", tperc = 60, tvalue = 60*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 6", class = "WARLOCK", tperc = 50, tvalue = 50*1000*1000 });
	table.insert(threatlist, { name = PLAYER.." 7", class = "MAGE", tperc = 40, tvalue = 40*1000*1000 });
	UpdateThreatBars();
end