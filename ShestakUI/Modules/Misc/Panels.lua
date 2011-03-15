local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Action Bar button size/spacings
----------------------------------------------------------------------------------------
T.buttonsize = C.actionbar.button_size
T.buttonspacing = C.actionbar.button_space

----------------------------------------------------------------------------------------
--	Bottom bars panel
----------------------------------------------------------------------------------------
local bottombaranchor = CreateFrame("Frame", "ActionBarAnchor", UIParent)
bottombaranchor:CreatePanel("Default", 1, 1, unpack(C.position.bottom_bars))
bottombaranchor:Width((T.buttonsize * 12) + (T.buttonspacing * 11))
if C.actionbar.bottombars == 2 then
	bottombaranchor:Height((T.buttonsize * 2) + T.buttonspacing)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		bottombaranchor:Height((T.buttonsize * 2) + T.buttonspacing)
	else
		bottombaranchor:Height((T.buttonsize * 3) + (T.buttonspacing * 2))
	end
else
	bottombaranchor:Height(T.buttonsize)
end
bottombaranchor:SetFrameStrata("LOW")
bottombaranchor:SetBackdropColor(0, 0, 0, 0)
bottombaranchor:SetBackdropBorderColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Right bars panel
----------------------------------------------------------------------------------------
local rightbaranchor = CreateFrame("Frame", "RightActionBarAnchor", UIParent)
rightbaranchor:CreatePanel("Default", 1, 1, unpack(C.position.right_bars))
rightbaranchor:Height((T.buttonsize * 12) + (T.buttonspacing * 11))
if C.actionbar.rightbars == 1 then
	rightbaranchor:Width(T.buttonsize)
elseif C.actionbar.rightbars == 2 then
	rightbaranchor:Width((T.buttonsize * 2) + T.buttonspacing)
elseif C.actionbar.rightbars == 3 then
	rightbaranchor:Width((T.buttonsize * 3) + (T.buttonspacing * 2))
else
	rightbaranchor:Hide()
end
rightbaranchor:SetFrameStrata("LOW")
rightbaranchor:SetBackdropColor(0, 0, 0, 0)
rightbaranchor:SetBackdropBorderColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Split bar panels
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", UIParent)
	SplitBarLeft:CreatePanel("Default", (T.buttonsize * 3) + (T.buttonspacing * 2), (T.buttonsize * 2) + T.buttonspacing, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", -T.buttonspacing, 0)
	SplitBarLeft:SetFrameStrata("LOW")
	SplitBarLeft:SetBackdropColor(0, 0, 0, 0)
	SplitBarLeft:SetBackdropBorderColor(0, 0, 0, 0)

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", UIParent)
	SplitBarRight:CreatePanel("Default", (T.buttonsize * 3) + (T.buttonspacing * 2), (T.buttonsize * 2) + T.buttonspacing, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", T.buttonspacing, 0)
	SplitBarRight:SetFrameStrata("LOW")
	SplitBarRight:SetBackdropColor(0, 0, 0, 0)
	SplitBarRight:SetBackdropBorderColor(0, 0, 0, 0)
end

----------------------------------------------------------------------------------------
--	Pet bar panel
----------------------------------------------------------------------------------------
local petbaranchor = CreateFrame("Frame", "PetActionBarAnchor", UIParent)
if C.actionbar.rightbars > 0 then
	if C.actionbar.petbar_horizontal == true then
		petbaranchor:CreatePanel("Default", (T.buttonsize * 10) + (T.buttonspacing * 9), (T.buttonsize + T.buttonspacing), unpack(C.position.pet_horizontal))
	else
		petbaranchor:CreatePanel("Default", (T.buttonsize + T.buttonspacing), (T.buttonsize * 10) + (T.buttonspacing * 9), "RIGHT", rightbaranchor, "LEFT", 0, 0)
	end
else
	petbaranchor:CreatePanel("Default", (T.buttonsize + T.buttonspacing), (T.buttonsize * 10) + (T.buttonspacing * 9), unpack(C.position.right_bars))
end
petbaranchor:SetBackdropColor(0, 0, 0, 0)
petbaranchor:SetBackdropBorderColor(0, 0, 0, 0)

----------------------------------------------------------------------------------------
--	Stance bar panel
----------------------------------------------------------------------------------------
if not C.actionbar.shapeshift_hide then
	local shiftanchor = CreateFrame("Frame", "ShapeShiftBarAnchor", UIParent)
	shiftanchor:RegisterEvent("PLAYER_LOGIN")
	shiftanchor:RegisterEvent("PLAYER_ENTERING_WORLD")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	shiftanchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	shiftanchor:SetScript("OnEvent", function(self, event, ...)
		local forms = GetNumShapeshiftForms()
		if forms > 0 then
			if C.actionbar.shapeshift_horizontal ~= true then
				shiftanchor:Width(T.buttonsize)
				shiftanchor:Height((T.buttonsize * forms) + ((T.buttonspacing * forms) - 3 ))
				shiftanchor:Point("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			else
				shiftanchor:Width((T.buttonsize * forms) + ((T.buttonspacing * forms) - 3))
				shiftanchor:Height(T.buttonsize)
				shiftanchor:Point("TOPLEFT", _G["ShapeshiftButton1"], "TOPLEFT")
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Bottom panel
----------------------------------------------------------------------------------------
local bottompanel = CreateFrame("Frame", "BottomPanel", UIParent)
bottompanel:CreatePanel("ClassColor", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:Point("BOTTOM", UIParent, "BOTTOM", 0, 20)
bottompanel:Point("LEFT", UIParent, "LEFT", 21, 0)
bottompanel:Point("RIGHT", UIParent, "RIGHT", -21, 0)

----------------------------------------------------------------------------------------
--	Chat background
----------------------------------------------------------------------------------------
if C.chat.background == true then
	local chatbd = CreateFrame("Frame", "ChatBackground", UIParent)
	chatbd:CreatePanel("Transparent", C.chat.width + 7, C.chat.height + 2, "TOPLEFT", ChatFrame1, "TOPLEFT", -3, -1)
	chatbd:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	chatbd:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
	
	local chattabs = CreateFrame("Frame", "ChatTabsPanel", UIParent)
	chattabs:CreatePanel("Transparent", chatbd:GetWidth(), 20, "BOTTOM", chatbd, "TOP", 0, 3)
	chattabs:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
	chattabs:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
else
	local leftpanel = CreateFrame("Frame", "LeftPanel", UIParent)
	leftpanel:CreatePanel("ClassColor", 1, C.chat.height, "BOTTOMLEFT", bottompanel, "LEFT", 0, 0)
end