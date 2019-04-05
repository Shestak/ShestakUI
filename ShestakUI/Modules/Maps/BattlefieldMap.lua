local T, C, L, _ = unpack(select(2, ...))
if C.minimap.bg_map_stylization ~= true or IsAddOnLoaded("Capping") or IsAddOnLoaded("Aurora") then return end

----------------------------------------------------------------------------------------
--	BattlefieldMap style
----------------------------------------------------------------------------------------
local tinymap = CreateFrame("Frame", "UIZoneMap", UIParent)
tinymap:Hide()

tinymap:RegisterEvent("ADDON_LOADED")
tinymap:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_BattlefieldMap" then return end

	BattlefieldMapFrame:SetSize(223, 150)
	BattlefieldMapFrame:CreateBackdrop("ClassColor")
	BattlefieldMapFrame.backdrop:SetPoint("TOPLEFT", -2, 4)
	BattlefieldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 1)

	BattlefieldMapFrame.BorderFrame:DisableDrawLayer("BORDER")
	BattlefieldMapFrame.BorderFrame:DisableDrawLayer("ARTWORK")

	BattlefieldMapFrame.BorderFrame.CloseButton:Hide()
	BattlefieldMapFrame.BorderFrame.CloseButtonBorder:Hide()

	BattlefieldMapTab:SetParent(tinymap)

	BattlefieldMapFrame.ScrollContainer:HookScript("OnMouseUp", function(self, btn)
		if btn == "LeftButton" then
			BattlefieldMapTab:StopMovingOrSizing()
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		elseif btn == "RightButton" then
			local function InitializeOptionsDropDown(BattlefieldMapFrame)
				BattlefieldMapFrame:GetParent():InitializeOptionsDropDown()
			end
			UIDropDownMenu_Initialize(BattlefieldMapTab.OptionsDropDown, InitializeOptionsDropDown, "MENU")
			ToggleDropDownMenu(nil, nil, BattlefieldMapTab.OptionsDropDown, "cursor", 0, -4)
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		end
	end)

	BattlefieldMapFrame.ScrollContainer:HookScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			if BattlefieldMapOptions and BattlefieldMapOptions.locked then
				return
			else
				BattlefieldMapTab:StartMoving()
			end
		end
	end)
end)