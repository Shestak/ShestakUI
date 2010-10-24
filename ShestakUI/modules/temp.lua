----------------------------------------------------------------------------------------
--	Temporary stuff
----------------------------------------------------------------------------------------
--[[
-- Button Order
-- To disabled a button, set it to 0.
AtlasOrder = 1
BigBrotherOrder = 2
SkadaOrder = 3
RecountOrder = 4
OmenOrder = 5
DeadlyBossModOrder = 6


-- Toggles if the Open/Close button is hidden on mouseout
HideMenuButton = true

-- Set to the offset of the menu if you have data texts under your minimap
local Offset = 0

-- Sets height of buttons
local BtnHeight = 19

-- Sets side of minimap that menu anchors to
-- true = bottom, false = top
local AnchorSide = false

-- Set font
local font = SettingsCF["media"].pixel_font
local fontsize = SettingsCF["media"].pixel_font_size
local fontstyle = SettingsCF["media"].pixel_font_style

-- How Many Buttons?
local Btns = 0
if SkadaOrder > 0 then Btns = Btns + 1 end
if AtlasOrder > 0 then Btns = Btns + 1 end
if RecountOrder > 0 then Btns = Btns + 1 end
if OmenOrder > 0 then Btns = Btns + 1 end
if BigBrotherOrder > 0 then Btns = Btns + 1 end
if DeadlyBossModOrder > 0 then Btns = Btns + 1 end


----------------------------------------------------------------------------------------
--	Create menu
----------------------------------------------------------------------------------------
-- Open/Close Button
local MenuOpen = CreateFrame("Frame", "MenuOpen", UIParent)
if AnchorSide == true then
	SettingsDB.CreateFadedPanel(MenuOpen, Minimap:GetWidth()-10, BtnHeight, "TOP", Minimap, "BOTTOM", 0, -5 - Offset)
else
	SettingsDB.CreateFadedPanel(MenuOpen, Minimap:GetWidth()-10, BtnHeight, "BOTTOM", Minimap, "TOP", 0, 5 + Offset)
end
MenuOpen:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
if HideMenuButton == true then MenuOpen:SetAlpha(0) end
MenuOpen:EnableMouse(true)

-- Menu Background
local Menu = CreateFrame("Frame", "MinimapMenu", UIParent)
if AnchorSide == true then
	SettingsDB.CreatePanel(Menu, MenuOpen:GetWidth(),(Btns*(BtnHeight+1)), "TOP", Minimap, "BOTTOM", 0, -5 - Offset)
else
	SettingsDB.CreatePanel(Menu, MenuOpen:GetWidth(),(Btns*(BtnHeight+1)), "BOTTOM", Minimap, "TOP", 0, 5 + Offset)
end
Menu:SetBackdropColor(0, 0, 0, 0)
Menu:SetBackdropBorderColor(0, 0, 0, 0)
Menu.bg:SetVertexColor(0, 0, 0, 0)
Menu:Hide()
Menu:SetFrameStrata("BACKGROUND")
Menu:EnableMouse(true)

-- Create Open/Close Scripts
MenuOpen:SetScript("OnMouseDown", function()
	if Menu:IsShown() then
		Menu:Hide()
		MenuOpen:ClearAllPoints()
		MenuOpen:SetAlpha(0)
		if AnchorSide == true then
			MenuOpen:SetPoint("TOP", Minimap, "BOTTOM", 0, -5 - Offset)
		else
			MenuOpen:SetPoint("BOTTOM", Minimap, "TOP", 0, 5 + Offset)
		end
	else
		Menu:Show()
		MenuOpen:ClearAllPoints()
		MenuOpen:SetAlpha(1)
		if AnchorSide == true then
			MenuOpen:SetPoint("TOP", Menu, "BOTTOM", 0, 0)
		else
			MenuOpen:SetPoint("BOTTOM", Menu, "TOP", 0, 0)
		end
	end
end)


----------------------------------------------------------------------------------------
--	Modules
----------------------------------------------------------------------------------------
-- Create Button Function
local function CreateButton(f, o)
	if AnchorSide == true then
		SettingsDB.CreateFadedPanel(f, Menu:GetWidth(), BtnHeight, "BOTTOM", Menu, "TOP", 0, -o*(BtnHeight+1)+1)
		f:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
		f:SetFrameStrata("HIGH")
		
		f.title = f:CreateFontString()
		f.title:SetPoint("CENTER", f, "CENTER", 0, 0)
		f.title:SetFont(font, fontsize, fontstyle)
		f.title:SetTextColor(1, 1, 1)

		f:EnableMouse(true)
	else
		SettingsDB.CreateFadedPanel(f, Menu:GetWidth(), BtnHeight, "TOP", Menu, "BOTTOM", 0, o*(BtnHeight+1)-1)
		f:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)
		f:SetFrameStrata("HIGH")
		
		f.title = f:CreateFontString()
		f.title:SetPoint("CENTER", f, "CENTER", 0, 0)
		f.title:SetFont(font, fontsize, fontstyle)
		f.title:SetTextColor(1, 1, 1)

		f:EnableMouse(true)
	end
end

-- Toggle function
local ToggleButtons = CreateFrame("Frame")
ToggleButtons:RegisterEvent("PLAYER_LOGIN")
ToggleButtons:SetScript("OnEvent", function(self, event, addon)
	-- Skada Toggle Button
	if SkadaOrder > 0 then
		local SkadaButton = CreateFrame("Frame", "SkadaToggle", Menu)
		CreateButton(SkadaButton, SkadaOrder)

		if not IsAddOnLoaded("Skada") then 
			SkadaButton.title:SetTextColor(0.6, 0.6, 0.6)
			SkadaButton.title:SetText("Skada Disabled")
		else
			if SkadaBarWindowSkada:IsShown() then
				SkadaButton.title:SetText("Hide Skada")
			else
				SkadaButton.title:SetText("Show Skada")
			end
			
			SkadaButton:SetScript("OnEnter", function()
				SkadaButton.title:SetTextColor(1, 1, 0.3)
			end)
			SkadaButton:SetScript("OnLeave", function()
				SkadaButton.title:SetTextColor(1, 1, 1)
			end)
			SkadaButton:SetScript("OnMouseDown", function()
				if SkadaBarWindowSkada:IsShown() then
					SkadaButton.title:SetText("Show Skada")
					SlashCmdList.ACECONSOLE_SKADA('toggle')
					ChatFrame4:SetAlpha(1)
				else
					SkadaButton.title:SetText("Hide Skada")
					SlashCmdList.ACECONSOLE_SKADA('toggle')
					ChatFrame4:SetAlpha(0)
				end
			end)
		end
	end

	-- Recount Toggle Button
	if RecountOrder > 0 then
		local RecountButton = CreateFrame("Frame", "AtlasButton", Menu)
		CreateButton(RecountButton, RecountOrder)

		if not IsAddOnLoaded("Recount") then 
			RecountButton.title:SetTextColor(0.6, 0.6, 0.6)
			RecountButton.title:SetText("Recount Disabled")	
		else
			if Recount_MainWindow:IsShown() then
				RecountButton.title:SetText("Hide Recount")
			else
				RecountButton.title:SetText("Show Recount")
			end

			RecountButton:SetScript("OnEnter", function()
				RecountButton.title:SetTextColor(1, 1, 0.3)
			end)
			RecountButton:SetScript("OnLeave", function()
				RecountButton.title:SetTextColor(1, 1, 1)
			end)
			RecountButton:SetScript("OnMouseDown", function()
				if Recount_MainWindow:IsShown() then
					RecountButton.title:SetText("Show Recount")
					SlashCmdList.ACECONSOLE_RECOUNT('toggle')
				else
					RecountButton.title:SetText("Hide Recount")
					SlashCmdList.ACECONSOLE_RECOUNT('toggle')
				end
			end)
		end
	end

	-- Omen Toggle Button
	if OmenOrder > 0 then
		local OmenButton = CreateFrame("Frame", "OmenButton", Menu)
		CreateButton(OmenButton, OmenOrder)
		
		if not IsAddOnLoaded("Omen") then 
			OmenButton.title:SetTextColor(0.6, 0.6, 0.6)
			OmenButton.title:SetText("Omen Disabled")	
		else
			if OmenAnchor:IsShown() then
				OmenButton.title:SetText("Show Omen")
			else
				OmenButton.title:SetText("Hide Omen")
			end

			OmenButton:SetScript("OnEnter", function()
				OmenButton.title:SetTextColor(1, 1, 0.3)
			end)
			OmenButton:SetScript("OnLeave", function()
				OmenButton.title:SetTextColor(1, 1, 1)
			end)
			OmenButton:SetScript("OnMouseDown", function()
				if OmenAnchor:IsShown() then
					OmenButton.title:SetText("Show Omen")
					SlashCmdList.ACECONSOLE_OMEN('toggle')
				else
					OmenButton.title:SetText("Hide Omen")
					SlashCmdList.ACECONSOLE_OMEN('toggle')
				end
			end)
		end
	end

	-- AtlasLoot Toggle Button
	if AtlasOrder > 0 then
		local AtlasButton = CreateFrame("Frame", "AtlasToggle", Menu)
		CreateButton(AtlasButton,AtlasOrder)
		
		if not IsAddOnLoaded("AtlasLoot") then 
			AtlasButton.title:SetTextColor(0.6, 0.6, 0.6)
			AtlasButton.title:SetText("AtlasLoot Disabled")	
		else
			AtlasButton.title:SetText("Show Atlas Loot")

			AtlasButton:SetScript("OnEnter", function()
				AtlasButton.title:SetTextColor(1, 1, 0.3)
			end)
			AtlasButton:SetScript("OnLeave", function()
				AtlasButton.title:SetTextColor(1, 1, 1)
			end)
			AtlasButton:SetScript("OnMouseDown", function()
				if AtlasLootDefaultFrame:IsShown() then
					AtlasButton.title:SetText("Show Atlas Loot")
					AtlasLootDefaultFrame:Hide()
				else
					AtlasButton.title:SetText("Hide Atlas Loot")
					AtlasLootDefaultFrame:Show()
				end
			end)
			
			AtlasLootDefaultFrame_CloseButton:SetScript("OnMouseDown", function()
				AtlasButton.title:SetText("Show Atlas Loot")
				AtlasLootDefaultFrame:Hide()
			end)	
		end
	end

	-- Big Brother Toggle Button
	if BigBrotherOrder > 0 then
		local BigBrotherButton = CreateFrame("Frame", "BigBrotherButton", Menu)
		CreateButton(BigBrotherButton, BigBrotherOrder)
	 
		if not IsAddOnLoaded("BigBrother") then
			BigBrotherButton.title:SetTextColor(0.6, 0.6, 0.6)
			BigBrotherButton.title:SetText("BigBrother Disabled")
		else
			BigBrotherButton.title:SetText("Toggle BigBrother")
	 
			BigBrotherButton:SetScript("OnEnter", function()
				BigBrotherButton.title:SetTextColor(1, 1, 0.3)
			end)
			BigBrotherButton:SetScript("OnLeave", function()
				BigBrotherButton.title:SetTextColor(1, 1, 1)
			end)
			BigBrotherButton:SetScript("OnMouseDown", function()
				BigBrother:ToggleBuffWindow()
			end)
		end
	end
	
	---- DeadlyBossMod
	if DeadlyBossModOrder > 0 then
		local DeadlyBossModButton = CreateFrame("Frame", "DeadlyBossModButton", Menu)
		CreateButton(DeadlyBossModButton, DeadlyBossModOrder)
	 
		if not IsAddOnLoaded("DBM-Core") then
			DeadlyBossModButton.title:SetTextColor(0.6, 0.6, 0.6)
			DeadlyBossModButton.title:SetText("Deadly BossMod Disabled")
		else
			DeadlyBossModButton.title:SetText("Toggle Deadly BossMod")
	 
			DeadlyBossModButton:SetScript("OnEnter", function()
				DeadlyBossModButton.title:SetTextColor(1, 1, 0.3)
			end)
			DeadlyBossModButton:SetScript("OnLeave", function()
				DeadlyBossModButton.title:SetTextColor(1, 1, 1)
			end)
			DeadlyBossModButton:SetScript("OnMouseDown", function()
				DBM:LoadGUI()
			end)
		end
	end
end)]]