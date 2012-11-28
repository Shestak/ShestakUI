local T, C, L, _ = unpack(ShestakUI)
if C.extra_bar.switch_spec ~= true then return end

----------------------------------------------------------------------------------------
--	Switch spec panel(by Epic)
----------------------------------------------------------------------------------------
-- Colors
local cp = "|cff319f1b" -- +
local cm = "|cff9a1212" -- -
local dr, dg, db = unpack({0.4, 0.4, 0.4})
local panelcolor = ("|cff%.2x%.2x%.2x"):format(dr * 255, dg * 255, db * 255)

-- Functions
local function HasDualSpec() if GetNumSpecGroups() > 1 then return true end end

local function GetSecondarySpecIndex()
	return 3 - (GetActiveSpecGroup() or 1)
end

local function GetCurrentSpec()
	local index = GetSpecialization(false, false, GetActiveSpecGroup())
	local name = index and select(2, GetSpecializationInfo(index))
	return index, name
end

local function GetSecondarySpec()
	local index = GetSpecialization(false, false, GetSecondarySpecIndex())
	local name = index and select(2, GetSpecializationInfo(index))
	return index, name
end

-- Spec
local spec = CreateFrame("Button", "SwitchSpecBar", UIParent)
spec:CreatePanel("Transparent", 135, 20, unpack(C.extra_position.switch_spec))
tinsert(T.MoverFrames, SwitchSpecBar)

spec.t = spec:CreateFontString(nil, "OVERLAY")
spec.t:SetPoint("CENTER")
spec.t:SetWidth(spec:GetWidth() - 4)
spec.t:SetHeight(C.media.pixel_font_size)
spec.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)

spec:RegisterEvent("PLAYER_TALENT_UPDATE")
spec:RegisterEvent("PLAYER_ENTERING_WORLD")
spec:RegisterEvent("CHARACTER_POINTS_CHANGED")
spec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
spec:SetScript("OnEvent", function(self, event)
	name = select(2, GetCurrentSpec()) or NONE
	spec.t:SetText(name)

	if HasDualSpec() then
		local secondarySpecIndex, secondarySpecName = GetSecondarySpec()
		if secondarySpecIndex ~= nil then
			spec:SetScript("OnEnter", function()
				spec.t:SetText(cm..secondarySpecName)
				self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end)
			spec:SetScript("OnLeave", function()
				spec.t:SetText(name)
				self:SetBackdropBorderColor(unpack(C.media.border_color))
			end)
		else
			spec:SetScript("OnEnter", function()
				spec.t:SetText(cm..NONE)
				self:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
			end)
			spec:SetScript("OnLeave", function()
				spec.t:SetText(name)
				self:SetBackdropBorderColor(unpack(C.media.border_color))
			end)
		end
	end
end)
spec:SetScript("OnClick", function(self)
	if IsModifierKeyDown() then
		ToggleTalentFrame()
	else
		local i = GetActiveSpecGroup()
		if i == 1 then SetActiveSpecGroup(2) end
		if i == 2 then SetActiveSpecGroup(1) end
	end
end)

-- Toggle Button
local toggle = CreateFrame("Button", "$parentToggle", spec)
toggle:CreatePanel("Transparent", 20, 20, "TOPLEFT", spec, "TOPRIGHT", 3, 0)

toggle.t = toggle:CreateFontString(nil, "OVERLAY")
toggle.t:SetPoint("CENTER", 2, 0)
toggle.t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
toggle.t:SetText(cp.."+|r")

toggle:SetScript("OnEnter", T.SetModifiedBackdrop)
toggle:SetScript("OnLeave", T.SetOriginalBackdrop)
toggle:SetScript("OnClick", function(self)
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return end
	if SwitchSpecBarToggleDPS:IsShown() then
		SwitchSpecBarToggleDPS:Hide()
		toggle.t:SetText(cp.."+|r")
	else
		SwitchSpecBarToggleDPS:Show()
		toggle.t:SetText(cm.."-|r")
	end
end)

-- DPS layout
local dps = CreateFrame("Button", "$parentDPS", toggle)
dps:CreatePanel("Transparent", 20, 20, "BOTTOMRIGHT", toggle, "TOPRIGHT", 0, 3)
dps:SetScript("OnEnter", T.SetModifiedBackdrop)
dps:SetScript("OnLeave", T.SetOriginalBackdrop)
dps:SetScript("OnClick", function() SavedOptions.RaidLayout = "DPS" ReloadUI() end)
dps:Hide()

dps.t = dps:CreateTexture(nil, "OVERLAY")
dps.t:SetTexture("Interface\\LFGFrame\\LFGROLE")
dps.t:SetTexCoord(0.25, 0.5, 0, 1)
dps.t:SetPoint("TOPLEFT", dps, 2, -2)
dps.t:SetPoint("BOTTOMRIGHT", dps, -2, 2)

-- Heal layout
local heal = CreateFrame("Button", nil, dps)
heal:CreatePanel("Transparent", 20, 20, "RIGHT", dps, "LEFT", -3, 0)
heal:SetScript("OnEnter", T.SetModifiedBackdrop)
heal:SetScript("OnLeave", T.SetOriginalBackdrop)
heal:SetScript("OnClick", function() SavedOptions.RaidLayout = "HEAL" ReloadUI() end)

heal.t = heal:CreateTexture(nil, "OVERLAY")
heal.t:SetTexture("Interface\\LFGFrame\\LFGROLE")
heal.t:SetTexCoord(0.75, 1, 0, 1)
heal.t:SetPoint("TOPLEFT", heal, 2, -2)
heal.t:SetPoint("BOTTOMRIGHT", heal, -2, 2)

-- Blizzard layout
local bliz = CreateFrame("Button", nil, dps)
bliz:CreatePanel("Transparent", 20, 20, "RIGHT", heal, "LEFT", -3, 0)
bliz:SetScript("OnEnter", T.SetModifiedBackdrop)
bliz:SetScript("OnLeave", T.SetOriginalBackdrop)
bliz:SetScript("OnClick", function() SavedOptions.RaidLayout = "HEAL" ReloadUI() end)

bliz.t = bliz:CreateTexture(nil, "OVERLAY")
bliz.t:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-Blizz")
bliz.t:SetTexCoord(0.2, 0.8, -0.1, 1.1)
bliz.t:SetPoint("TOPLEFT", bliz, 2, -2)
bliz.t:SetPoint("BOTTOMRIGHT", bliz, -2, 2)

-- Gear switching
local gearSets = CreateFrame("Frame", nil, dps)
for i = 1, 10 do
	gearSets[i] = CreateFrame("Button", nil, gearSets)
	gearSets[i]:CreatePanel("Transparent", 20, 20, "CENTER", bliz, "CENTER", 0, 0)

	if i == 1 then
		gearSets[i]:SetPoint("BOTTOMRIGHT", bliz, "BOTTOMLEFT", -3, 0)
	elseif i == 5 then
		gearSets[i]:SetPoint("BOTTOMRIGHT", dps, "TOPRIGHT", 0, 3)
	else
		gearSets[i]:SetPoint("BOTTOMRIGHT", gearSets[i-1], "BOTTOMLEFT", -3, 0)
	end

	gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
	gearSets[i].texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i], "TOPLEFT", 2, -2)
	gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i], "BOTTOMRIGHT", -2, 2)
	gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))

	gearSets[i]:Hide()

	gearSets[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
	gearSets[i]:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	gearSets[i]:SetScript("OnEvent", function(self, event)
		local points, pt = 0, GetNumEquipmentSets()
		local frames = {
			gearSets[1]:IsShown(), gearSets[2]:IsShown(), gearSets[3]:IsShown(), gearSets[4]:IsShown(), gearSets[5]:IsShown(),
			gearSets[6]:IsShown(), gearSets[7]:IsShown(), gearSets[8]:IsShown(), gearSets[9]:IsShown(), gearSets[10]:IsShown()
		}

		if pt > points then
			for i = points + 1, pt do
				gearSets[i]:Show()
			end
		end

		if frames[pt + 1] == 1 then
			gearSets[pt + 1]:Hide()
		end

		gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))
	end)
	gearSets[i]:SetScript("OnEnter", T.SetModifiedBackdrop)
	gearSets[i]:SetScript("OnLeave", T.SetOriginalBackdrop)
	gearSets[i]:SetScript("OnClick", function(self) UseEquipmentSet(GetEquipmentSetInfo(i)) end)
end