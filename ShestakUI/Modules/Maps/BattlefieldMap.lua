local T, C, L, _ = unpack(select(2, ...))
if C.map.bg_map_stylization ~= true or IsAddOnLoaded("Capping") or IsAddOnLoaded("Aurora") then return end

----------------------------------------------------------------------------------------
--	BattlefieldMap style
----------------------------------------------------------------------------------------
local tinymap = CreateFrame("Frame", "UIZoneMap", UIParent)
tinymap:SetPoint("CENTER")
tinymap:SetSize(223, 150)
tinymap:EnableMouse(true)
tinymap:SetMovable(true)
tinymap:RegisterEvent("ADDON_LOADED")
tinymap:SetPoint("CENTER", UIParent, 0, 0)
tinymap:SetFrameLevel(7)
tinymap:Hide()

local tinymapbg = CreateFrame("Frame", nil, tinymap)
tinymapbg:SetAllPoints()
tinymapbg:SetFrameLevel(0)
tinymapbg:SetTemplate("ClassColor")

tinymap:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_BattlefieldMap" then return end

	BattlefieldMapFrame:HookScript("OnShow", function(self)
		tinymap:Show()
		BattlefieldMapFrame.BorderFrame:Kill()
		BattlefieldMapTab:Kill()
		self:SetParent(tinymap)
		self:SetPoint("TOPLEFT", tinymap, "TOPLEFT", 2, -2)
		self:SetFrameStrata(tinymap:GetFrameStrata())
		self:SetFrameLevel(6)
		tinymap:SetScale(1)
		tinymap:SetAlpha(1)
		-- BattlefieldMinimap_Update()
	end)

	BattlefieldMapFrame:SetScript("OnHide", function(self)
		tinymap:SetScale(0.00001)
		tinymap:SetAlpha(0)
	end)

	tinymap:SetScript("OnMouseUp", function(self, btn)
		if btn == "LeftButton" then
			self:StopMovingOrSizing()
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		elseif btn == "RightButton" then
			local function InitializeOptionsDropDown(self)
				self:GetParent():InitializeOptionsDropDown()
			end
			UIDropDownMenu_Initialize(BattlefieldMapTab.OptionsDropDown, InitializeOptionsDropDown, "MENU")
			ToggleDropDownMenu(nil, nil, BattlefieldMapTab.OptionsDropDown, self:GetName(), 0, -4)
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		end
	end)

	tinymap:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			if BattlefieldMapOptions and BattlefieldMapOptions.locked then
				return
			else
				self:StartMoving()
			end
		end
	end)
end)