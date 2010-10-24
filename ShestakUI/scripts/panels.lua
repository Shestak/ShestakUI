----------------------------------------------------------------------------------------
--	Action Bar button size/spacings
----------------------------------------------------------------------------------------
SettingsDB.buttonsize = SettingsDB.Scale(SettingsCF["actionbar"].button_size)
SettingsDB.buttonspacing = SettingsDB.Scale(SettingsCF["actionbar"].button_space)

----------------------------------------------------------------------------------------
--	Bottom bars panel
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
SettingsDB.CreatePanel(bottombaranchor, 1, 1, unpack(SettingsCF["position"].bottom_bars))
bottombaranchor:SetWidth((SettingsDB.buttonsize * 12) + (SettingsDB.buttonspacing * 11))
if SettingsCF["actionbar"].bottombars == 2 then
	bottombaranchor:SetHeight((SettingsDB.buttonsize * 2) + SettingsDB.buttonspacing)
elseif SettingsCF["actionbar"].bottombars == 3 then
	bottombaranchor:SetHeight((SettingsDB.buttonsize * 3) + (SettingsDB.buttonspacing * 2))
else
	bottombaranchor:SetHeight(SettingsDB.buttonsize)
end
bottombaranchor:SetFrameStrata("LOW")
bottombaranchor:SetBackdropColor(0, 0, 0, 0)
bottombaranchor:SetBackdropBorderColor(0, 0, 0, 0)
bottombaranchor.bg:SetVertexColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Invisible frame covering ActionBarAnchor
----------------------------------------------------------------------------------------
local invbarbg = CreateFrame("Frame", "InvActionBarBackground", UIParent)
invbarbg:SetSize(bottombaranchor:GetWidth(), bottombaranchor:GetHeight())
invbarbg:SetPoint("BOTTOM", 0, SettingsDB.Scale(14))

----------------------------------------------------------------------------------------
--	Right bars panel
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
SettingsDB.CreatePanel(rightbaranchor, 1, 1, unpack(SettingsCF["position"].right_bars))
rightbaranchor:SetHeight((SettingsDB.buttonsize * 12) + (SettingsDB.buttonspacing * 11))
if SettingsCF["actionbar"].rightbars == 1 then
	rightbaranchor:SetWidth(SettingsDB.buttonsize)
elseif SettingsCF["actionbar"].rightbars == 2 then
	rightbaranchor:SetWidth((SettingsDB.buttonsize * 2) + SettingsDB.buttonspacing)
elseif SettingsCF["actionbar"].rightbars == 3 then
	rightbaranchor:SetWidth((SettingsDB.buttonsize * 3) + (SettingsDB.buttonspacing * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetBackdropColor(0, 0, 0, 0)
rightbaranchor:SetBackdropBorderColor(0, 0, 0, 0)
rightbaranchor.bg:SetVertexColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Pet bar panel
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if SettingsCF["actionbar"].rightbars > 0 then
	if SettingsCF["actionbar"].petbar_horizontal == true then
		SettingsDB.CreatePanel(petbaranchor, (SettingsDB.buttonsize * 10) + (SettingsDB.buttonspacing * 9), (SettingsDB.buttonsize + SettingsDB.buttonspacing), unpack(SettingsCF["position"].pet_horizontal))
	else
		SettingsDB.CreatePanel(petbaranchor, (SettingsDB.buttonsize + SettingsDB.buttonspacing), (SettingsDB.buttonsize * 10) + (SettingsDB.buttonspacing * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	SettingsDB.CreatePanel(petbaranchor, (SettingsDB.buttonsize + SettingsDB.buttonspacing), (SettingsDB.buttonsize * 10) + (SettingsDB.buttonspacing * 9), unpack(SettingsCF["position"].right_bars))
end
petbaranchor:SetBackdropColor(0, 0, 0, 0)
petbaranchor:SetBackdropBorderColor(0, 0, 0, 0)
petbaranchor.bg:SetVertexColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Chat background 
----------------------------------------------------------------------------------------
if SettingsCF["chat"].background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	SettingsDB.CreateFadedPanel(chatbd, SettingsCF["chat"].width + 3, SettingsCF["chat"].height + 2, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, 0)
	chatbd:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
	chatbd:SetBackdropColor(0, 0, 0, SettingsCF["chat"].background_alpha)
end