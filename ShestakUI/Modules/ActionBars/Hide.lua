local T, C, L = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

---------------------------------------------------------------------------
--	Hide all Blizzard stuff that we don't need by Tukz
---------------------------------------------------------------------------
do
	MainMenuBar:SetScale(0.00001)
	MainMenuBar:EnableMouse(false)
	OverrideActionBar:SetScale(0.00001)
	OverrideActionBar:EnableMouse(false)
	PetActionBarFrame:EnableMouse(false)
	StanceBarFrame:EnableMouse(false)

	local elements = {
		MainMenuBar, MainMenuBarArtFrame, BonusActionBarFrame, OverrideActionBar,
		PossessBarFrame, PetActionBarFrame, StanceBarFrame,
		ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
	}
	for _, element in pairs(elements) do
		if element:GetObjectType() == "Frame" then
			element:UnregisterAllEvents()
		end

		if element ~= MainMenuBar then
			element:Hide()
		end
		element:SetAlpha(0)
	end
	elements = nil

	hooksecurefunc("TalentFrame_LoadUI", function()
		PlayerTalentFrame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	end)
end

do
	local uiManagedFrames = {
		"MultiBarLeft",
		"MultiBarRight",
		"MultiBarBottomLeft",
		"MultiBarBottomRight",
		"StanceBarFrame",
		"PossessBarFrame",
		"PETACTIONBAR_YPOS",
		"ChatFrame1",
		"ChatFrame2",
	}
	for _, frame in pairs(uiManagedFrames) do
		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
	end
	uiManagedFrames = nil
end

function RightBarMouseOver(alpha)
	RightActionBarAnchor:SetAlpha(alpha)
	PetActionBarAnchor:SetAlpha(alpha)

	if MultiBarLeft:IsShown() then
		for i = 1, 12 do
			local pb = _G["MultiBarLeftButton"..i]
			pb:SetAlpha(alpha)
		end
		MultiBarLeft:SetAlpha(alpha)
	end

	if C.actionbar.rightbars > 2 then
		if MultiBarBottomRight:IsShown() then
			for i = 1, 12 do
				local pb = _G["MultiBarBottomRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarBottomRight:SetAlpha(alpha)
		end
	end

	if MultiBarRight:IsShown() then
		for i = 1, 12 do
			local pb = _G["MultiBarRightButton"..i]
			pb:SetAlpha(alpha)
		end
		MultiBarRight:SetAlpha(alpha)
	end

	if C.actionbar.petbar_horizontal == false then
		if C.actionbar.petbar_hide then return end
		if PetHolder:IsShown() then
			for i = 1, NUM_PET_ACTION_SLOTS do
				local pb = _G["PetActionButton"..i]
				pb:SetAlpha(alpha)
			end
			PetHolder:SetAlpha(alpha)
		end
	end
end

function ShapeShiftMouseOver(alpha)
	for i = 1, NUM_STANCE_SLOTS do
		local pb = _G["StanceButton"..i]
		pb:SetAlpha(alpha)
	end
	ShapeShiftBarAnchor:SetAlpha(alpha)
end

function PetMouseOver(alpha)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(alpha)
	end
	PetHolder:SetAlpha(alpha)
end

do
	if C.actionbar.rightbars_mouseover == true then
		RightActionBarAnchor:SetAlpha(0)
		RightActionBarAnchor:SetScript("OnEnter", function() RightBarMouseOver(1) end)
		RightActionBarAnchor:SetScript("OnLeave", function() RightBarMouseOver(0) end)
		if C.actionbar.petbar_horizontal == false then
			PetActionBarAnchor:SetAlpha(0)
			PetActionBarAnchor:SetScript("OnEnter", function() RightBarMouseOver(1) end)
			PetActionBarAnchor:SetScript("OnLeave", function() RightBarMouseOver(0) end)
		end
	end
	if C.actionbar.petbar_mouseover == true and C.actionbar.petbar_horizontal == true then
		PetActionBarAnchor:SetAlpha(0)
		PetActionBarAnchor:SetScript("OnEnter", function() PetMouseOver(1) end)
		PetActionBarAnchor:SetScript("OnLeave", function() PetMouseOver(0) end)
	end
end