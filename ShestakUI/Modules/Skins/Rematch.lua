local T, C, L, _ = unpack(select(2, ...))
if C.skins.rematch ~= true or not IsAddOnLoaded("Rematch") then return end

----------------------------------------------------------------------------------------
--	Rematch skin
----------------------------------------------------------------------------------------
local _,skin = ...
Skin = skin

local rematch = Rematch
local roster = rematch.Roster

skin.panels = {

	Frame = function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		self.TitleBar:StripTextures()
		T.SkinCloseButton(self.TitleBar.CloseButton)
		skin:SetButtonIcon(self.TitleBar.LockButton,"Locked")
		for _,tab in ipairs(self.PanelTabs.Tabs) do
			skin:HandlePanelTab(tab)
		end
		hooksecurefunc(Rematch.Frame,"Update",function()
			local titlebar = Rematch.Frame.TitleBar
			skin:SetButtonIcon(titlebar.LockButton,RematchSettings.LockPosition and "Locked" or "Unlocked")
			titlebar.SinglePanelButton:SetShown(not RematchSettings.Minimized)
		end)
	end,

	Journal = function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		for _,tab in ipairs(self.PanelTabs.Tabs) do
			skin:HandlePanelTab(tab)
		end
		RematchJournalPortrait:Hide()
		T.SkinCloseButton(self.CloseButton)
		local handled
		self:HookScript("OnEvent",function()
			if not handled and UseRematchButton then
				T.SkinCheckBox(UseRematchButton)
				handled = true
			end
		end)
		-- added in Rematch 4.3.4
		if self.OtherAddonJournalStuff then
			hooksecurefunc(self,"OtherAddonJournalStuff",function()
				if self.CollectMeButton then
					self.CollectMeButton:SkinButton()
					self.CollectMeButton:SetHeight(20)
					self.CollectMeButton:SetPoint("RIGHT",Rematch.BottomPanel.SaveButton,"LEFT",-2,0)
				end
				if self.PetTrackerJournalButton then
					T.SkinCheckBox(self.PetTrackerJournalButton)
				end
			end)
		end
	end,

	BottomPanel = function(self)
		for _,button in ipairs({"SummonButton","SaveButton","SaveAsButton","FindBattleButton"}) do
			self[button]:SkinButton()
			self[button]:SetHeight(20)
		end
		T.SkinCheckBox(self.UseDefault)
	end,

	Toolbar = function(self)
		for _,button in ipairs(self.Buttons) do
			button.IconBorder:SetTexture(nil)
			button:CreateBackdrop("Overlay")
			button:StyleButton(nil, 4)

			button:SetSize(26, 26)
			button:CreateBackdrop("Default")
			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetDrawLayer("ARTWORK")
			button.Icon:SetParent(button.backdrop)

			button.hover:SetSize(26, 26)
			button.hover:ClearAllPoints()
			button.hover:SetPoint("CENTER",0,0)

			button.pushed:SetSize(26, 26)
			button.pushed:ClearAllPoints()
			button.pushed:SetPoint("CENTER",0,0)

			button.Cooldown:SetSize(26, 26)
			button.Cooldown:ClearAllPoints()
			button.Cooldown:SetPoint("CENTER",0,0)
		end
		self.PetCount:StripTextures()
	end,

	PetCard = function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		T.SkinCloseButton(self.CloseButton)
		T.SkinCloseButton(self.PinButton,nil,"")
		skin:SetButtonIcon(self.PinButton,"Pinned")
		self.Title.TitleBG:SetDrawLayer("BACKGROUND",2)
		local r,g,b = 0.05, 0.05, 0.05
		self.Front:SetBackdrop({edgeFile="Interface\\ChatFrame\\ChatFrameBackground",edgeSize=4})
		self.Front:SetBackdropBorderColor(r,g,b)
		self.Back:SetBackdrop({})
		self.Back:SetBackdrop({edgeFile="Interface\\ChatFrame\\ChatFrameBackground",edgeSize=4})
		self.Back:SetBackdropBorderColor(r,g,b)
		-- also reskinning ability card here
		local abilityCard = RematchAbilityCard
		abilityCard:SetBackdrop({edgeFile="Interface\\ChatFrame\\ChatFrameBackground",edgeSize=4})
		abilityCard:SetBackdropBorderColor(r,g,b)
		-- change all the horizontal divider lines to solid black lines
		for _,frame in ipairs({self.Front.Bottom,self.Front.Middle,self.Back.Source,self.Back.Bottom,self.Back.Middle,abilityCard,abilityCard.Hints}) do
		  for _,region in ipairs({frame:GetRegions()}) do
		    local anchorPoint,relativeTo = region:GetPoint()
		    if region:GetObjectType()=="Texture" and region:GetDrawLayer()=="ARTWORK" and anchorPoint=="LEFT" and relativeTo==frame then
		      region:SetColorTexture(r, g, b)
		      region:SetHeight(4)
		    end
		  end
		end
	end,

	PetPanel = function(self)
		self.List:StripTextures()
		self.List:SetTemplate("Transparent")
		T.SkinScrollBar(self.List.ScrollFrame.ScrollBar)
		-- top
		self.Top:StripTextures()
		self.Top.TypeBar:StripTextures()
		self.Top.Filter:SkinButton()
		self.Top.Toggle:SkinButton()
		T.SkinEditBox(self.Top.SearchBox)
		self.Top.SearchBox:SetBackdrop({})
		for _,region in ipairs({self.Top.SearchBox:GetRegions()}) do
			if region:GetDrawLayer()=="BACKGROUND" then
				region:Hide()
			end
		end
		self.Top.SearchBox:SetHeight(22)
		self.Top.SearchBox:SetPoint("LEFT",self.Top.Toggle,"RIGHT",4,0)
		self.Top.SearchBox:SetPoint("RIGHT",self.Top.Filter,"LEFT",-4,0)
		self.Results:StripTextures()
		self.Results:SetTemplate("Transparent")
		-- typebar requires a bit of extra work
		self.Top.TypeBar:SetPoint("BOTTOM",0,-2)
		for _,button in ipairs(self.Top.TypeBar.Tabs) do
			button:SkinButton()
			button:SetWidth(78)
		end
		for _,button in ipairs(self.Top.TypeBar.Tabs) do
		  button.Selected:ClearAllPoints()
		  button.Selected:SetPoint("TOPLEFT",2,-2)
		  button.Selected:SetPoint("BOTTOMRIGHT",-2,2)
		  for _,texture in ipairs({"LeftSelected","RightSelected","MidSelected"}) do
		        button.Selected[texture]:SetColorTexture(1, 1, 1, 0.25)
		        button.Selected[texture]:SetHeight(20)
		  end
			for _,region in ipairs({button.Selected:GetRegions()}) do
				if region:GetDrawLayer()=="ARTWORK" then
					region:Hide()
				end
			end
			for _,region in ipairs({button:GetRegions()}) do
				if region:GetDrawLayer()=="HIGHLIGHT" then
					region:Hide()
				end
			end
			button.HasStuff:SetPoint("TOPLEFT",3,-18)
			button.HasStuff:SetAlpha(1)
		end
		for _,button in ipairs(self.Top.TypeBar.Buttons) do
			button.IconBorder:SetTexture(nil)
			button:CreateBackdrop("Overlay")
			button:StyleButton(nil, 4)
			button:SetSize(20, 20)
			button:CreateBackdrop("Default")

			button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.Icon:SetDrawLayer("ARTWORK")
			button.Icon:SetParent(button.backdrop)

			button.hover:SetSize(20, 20)
			button.hover:ClearAllPoints()
			button.hover:SetPoint("CENTER",0,0)

			button.checked:SetSize(20, 20)
			button.checked:ClearAllPoints()
			button.checked:SetPoint("CENTER",0,0)
		end
		for _,button in ipairs(self.List.ScrollFrame.buttons) do
			if not button.isSkinned then
				button.Pet.IconBorder:SetAlpha(0)
				button.Faceplate:Hide()
				button.Backplate:Hide()

				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 2, -2)
				button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

				button:StyleButton(nil, 4)
				button.Pet:CreateBackdrop("Default")
				button.Pet.backdrop:SetPoint("TOPLEFT", -1, 1)
				button.Pet.backdrop:SetPoint("BOTTOMRIGHT", 1, -1)
				button.Pet:StyleButton(nil, 1)

				button.Pet.Favorite:SetParent(button.Pet.backdrop)
				button.Pet.Level.BG:SetAlpha(0)
				button.Pet.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				button.Pet.Icon:SetDrawLayer("ARTWORK")
				button.Pet.Icon:SetParent(button.Pet.backdrop)
				button.Pet.Icon:ClearAllPoints()
				button.Pet.Icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 4)
				button.isSkinned = true
			end
		end
		hooksecurefunc(self,"UpdateList",function() skin.ColorPetListBordersPet(self.List.ScrollFrame) end)
		self.List.ScrollFrame:HookScript("OnVerticalScroll",skin.ColorPetListBordersPet)
		self.List.ScrollFrame:HookScript("OnMouseWheel",skin.ColorPetListBordersPet)
	end,

	LoadoutPanel = function(self)
		self:StripTextures()
		self.Target:StripTextures()
		self.Target:SetTemplate("Transparent")

		self.Target.Pet1:SkinButton()
		self.Target.Pet1.IconBorder:SetAlpha(0)
		self.Target.Pet2:SkinButton()
		self.Target.Pet2.IconBorder:SetAlpha(0)
		self.Target.Pet3:SkinButton()
		self.Target.Pet3.IconBorder:SetAlpha(0)
		self.Target.Model:SkinButton()
		self.Target.ModelBorder:SetAlpha(0)

		for i = 1, 3 do
			self.Loadouts[i]:StripTextures()
			self.Loadouts[i]:SetTemplate("Overlay")

			self.Loadouts[i].Pet.Pet.IconBorder:SetAlpha(0)
			self.Loadouts[i].Pet.Pet:StyleButton(nil, 4)
			self.Loadouts[i].Pet.Pet:SetSize(40, 40)
			self.Loadouts[i].Pet.Pet:CreateBackdrop("Default")

			self.Loadouts[i].Pet.Pet.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			self.Loadouts[i].Pet.Pet.Icon:SetDrawLayer("ARTWORK")
			self.Loadouts[i].Pet.Pet.Icon:SetParent(self.Loadouts[i].Pet.Pet.backdrop)

			self.Loadouts[i].Pet.Pet.hover:SetSize(40, 40)
			self.Loadouts[i].Pet.Pet.hover:ClearAllPoints()
			self.Loadouts[i].Pet.Pet.hover:SetPoint("CENTER",0,0)
			self.Loadouts[i].Pet.Pet.Level.BG:SetAlpha(0)

			self.Loadouts[i].HP:StripTextures()
			self.Loadouts[i].HP:CreateBackdrop("Overlay")
			self.Loadouts[i].HP:SetStatusBarTexture(C.media.texture)

			self.Loadouts[i].XP:StripTextures()
			self.Loadouts[i].XP:CreateBackdrop("Overlay")
			self.Loadouts[i].XP:SetStatusBarTexture(C.media.texture)
		end
		self.Target.TargetButton:SkinButton()
		self.Target.LoadSaveButton:SkinButton()
		for i = 1, 3 do
			for j = 1, 3 do
				self.Loadouts[i].Abilities[j].IconBorder:Hide()
				self.Loadouts[i].Abilities[j].IconBorder:SetTexture(nil)
				self.Loadouts[i].Abilities[j]:CreateBackdrop("Overlay")
				self.Loadouts[i].Abilities[j]:StyleButton(nil, 4)
				self.Loadouts[i].Abilities[j]:SetSize(30, 30)
				self.Loadouts[i].Abilities[j]:CreateBackdrop("Default")

				self.Loadouts[i].Abilities[j].Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				self.Loadouts[i].Abilities[j].Icon:SetDrawLayer("ARTWORK")
				self.Loadouts[i].Abilities[j].Icon:SetParent(self.Loadouts[i].Abilities[j].backdrop)

				self.Loadouts[i].Abilities[j].hover:SetSize(30, 30)
				self.Loadouts[i].Abilities[j].hover:ClearAllPoints()
				self.Loadouts[i].Abilities[j].hover:SetPoint("CENTER",0,0)

				self.Loadouts[i].Abilities[j].checked:SetSize(30, 30)
				self.Loadouts[i].Abilities[j].checked:ClearAllPoints()
				self.Loadouts[i].Abilities[j].checked:SetPoint("CENTER",0,0)
			end
		end
		self.Flyout:SetTemplate("Transparent")
		for i=1,2 do
			self.Flyout.Abilities[i]:SkinButton()
			self.Flyout.Abilities[i].IconBorder:Hide()
		end
	end,

	LoadedTeamPanel = function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		self.Footnotes:StripTextures()
		self.Footnotes:SetTemplate("Transparent")
		T.SkinCloseButton(self.Footnotes.Close)
		T.SkinCloseButton(self.Footnotes.Maximize,nil,"-")
	end,

	TeamPanel = function(self)
		self:StripTextures()
		self.List:StripTextures()
		self.List:SetTemplate("Transparent")
		T.SkinScrollBar(self.List.ScrollFrame.ScrollBar)

		self.Top:StripTextures()
		self.Top.Teams:SkinButton()
		self.Top.Toggle:SkinButton()
		T.SkinEditBox(self.Top.SearchBox)
		self.Top.SearchBox:SetBackdrop({})
		for _,region in ipairs({self.Top.SearchBox:GetRegions()}) do
			if region:GetDrawLayer()=="BACKGROUND" then
				region:Hide()
			end
		end
		self.Top.SearchBox:SetHeight(22)
		self.Top.SearchBox:SetPoint("LEFT",self.Top.Toggle,"RIGHT",4,0)
		self.Top.SearchBox:SetPoint("RIGHT",self.Top.Teams,"LEFT",-4,0)
		local function shiftpets(button)
			if not button.slim then
				for i=1,3 do
					local anchorPoint,relativeTo,relativePoint,x,y = button.Pets[i]:GetPoint()
					button.Pets[i].IconBorder:SetAlpha(0)
					button.Pets[i]:SetPoint(anchorPoint,relativeTo,relativePoint,x,0)
					button.Pets[i]:CreateBackdrop("Overlay")
					button.Pets[i]:StyleButton(nil, 4)
					button.Pets[i]:SetWidth(24)
					button.Pets[i]:CreateBackdrop("Default")
				end
			end
		end
		self.Top.Team:SkinButton()
		shiftpets(self.Top.Team)
		for _,button in ipairs(self.List.ScrollFrame.buttons) do
			if not button.isSkinned then
				button.Faceplate:Hide()
				button.Backplate:Hide()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 2, -2)
				button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
				button:StyleButton(nil, 4)
				button.isSkinned = true
			end
			shiftpets(button)
		end
		local function blackborders()
			for _,button in ipairs(self.List.ScrollFrame.buttons) do
				button:SetBackdropBorderColor(0,0,0)
			end
		end
		hooksecurefunc(self,"UpdateList",blackborders)
		self.List.ScrollFrame:HookScript("OnVerticalScroll",blackborders)
		self.List.ScrollFrame:HookScript("OnMouseWheel",blackborders)
	end,

	MiniPanel = function(self)
		self.Background:StripTextures()
		self.Background:SetTemplate("Transparent")
		self.Target:StripTextures()
		self.Target:SetTemplate("Transparent")
		self.Target.LoadButton:SkinButton()
		for i = 1, 3 do
			for j = 1, 3 do
				self.Pets[i].Abilities[j]:SkinButton()
				self.Pets[i].Abilities[j].IconBorder:Hide()
			end
		end
		self.Flyout:SetTemplate("Transparent")
		for i = 1, 2 do
			self.Flyout.Abilities[i]:SkinButton()
			self.Flyout.Abilities[i].IconBorder:Hide()
		end
	end,

	MiniQueue = function(self)
		self.Top:StripTextures()
		self.Top:SetTemplate("Transparent")
		self.Top.QueueButton:SkinButton()
		self.Status:StripTextures()
		self.Status:SetTemplate("Transparent")
		self.List:StripTextures()
		self.List:SetTemplate("Transparent")
		T.SkinScrollBar(self.List.ScrollFrame.ScrollBar)
		for _,button in ipairs(self.List.ScrollFrame.buttons) do
			button:SkinButton()
			if button.slim then
				button:GetChildren():Hide()
			end
		end
		hooksecurefunc(self,"UpdateList",function() skin.ColorPetListBordersQueue(self.List.ScrollFrame) end)
		self.List.ScrollFrame:HookScript("OnVerticalScroll",skin.ColorPetListBordersQueue)
		self.List.ScrollFrame:HookScript("OnMouseWheel",skin.ColorPetListBordersQueue)
	end,

	QueuePanel = function(self)
		self.List:StripTextures()
		self.List:SetTemplate("Transparent")
		T.SkinScrollBar(self.List.ScrollFrame.ScrollBar)
		self.Top:StripTextures()
		self.Top.QueueButton:SkinButton()
		self.Top.Toggle:SkinButton()
		self.Top.LevelingSlot:SkinButton()

		self.Top.LevelingSlot.Pet.IconBorder:SetAlpha(0)
		self.Top.LevelingSlot.Pet:CreateBackdrop("Overlay")
		self.Top.LevelingSlot.Pet.backdrop:SetPoint("TOPLEFT", 2, -2)
		self.Top.LevelingSlot.Pet.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
		self.Top.LevelingSlot.Pet:StyleButton(nil, 4)

		self.Top.LevelingSlot.Pet.Level.BG:SetAlpha(0)

		self.Top.LevelingSlot.Pet.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		self.Top.LevelingSlot.Pet.Icon:SetDrawLayer("ARTWORK")
		self.Top.LevelingSlot.Pet.Icon:SetParent(self.Top.LevelingSlot.Pet.backdrop)
		self.Top.LevelingSlot.Pet.Icon:ClearAllPoints()
		self.Top.LevelingSlot.Pet.Icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 4)
		self.Top.LevelingSlot.Pet:SetSize(48, 48)

		self.Status:StripTextures()
		self.Status:SetTemplate("Transparent")
		for _,button in ipairs(self.List.ScrollFrame.buttons) do
			if not button.isSkinned then
				button.Pet.IconBorder:SetAlpha(0)
				button.Faceplate:Hide()
				button.Backplate:Hide()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 2, -2)
				button.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
				button:StyleButton(nil, 4)

				button.Pet:CreateBackdrop("Default")
				button.Pet.backdrop:SetPoint("TOPLEFT", -1, 1)
				button.Pet.backdrop:SetPoint("BOTTOMRIGHT", 1, -1)
				button.Pet:StyleButton(nil, 1)

				button.Pet.Favorite:SetParent(button.Pet.backdrop)
				button.Pet.Level.BG:SetAlpha(0)

				button.Pet.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				button.Pet.Icon:SetDrawLayer("ARTWORK")
				button.Pet.Icon:SetParent(button.Pet.backdrop)
				button.Pet.Icon:ClearAllPoints()
				button.Pet.Icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", -3, 4)
				button.isSkinned = true
			end
		end
		hooksecurefunc(self,"UpdateList",function() skin.ColorPetListBordersQueue(self.List.ScrollFrame) end)
		self.List.ScrollFrame:HookScript("OnVerticalScroll",skin.ColorPetListBordersQueue)
		self.List.ScrollFrame:HookScript("OnMouseWheel",skin.ColorPetListBordersQueue)
	end,

	OptionPanel = function(self)
		self.List:StripTextures()
		self.List:SetTemplate("Transparent")
		T.SkinScrollBar(self.List.ScrollFrame.ScrollBar)
		for _,button in ipairs(self.List.ScrollFrame.buttons) do
			button:StripTextures()
			for _,region in ipairs({button.Header:GetRegions()}) do
				if region:GetDrawLayer()=="BACKGROUND" then
					region:SetColorTexture(0.15, 0.15, 0.15)
				end
			end
			T.SkinCheckBox(button.CheckButton)
		end
		self.CustomScale.ScaleButton:SkinButton()
		T.SkinCheckBox(self.CustomScale.CheckButton)
	end,

	TeamTabs = function(self)
		hooksecurefunc(self,"Update",function(self)
			if RematchSettings.TeamTabsToLeft and RematchSettings.AlwaysTeamTabs and self:GetParent()==Rematch.Frame then
				local anchorPoint,relativeTo,relativePoint,x,y = self:GetPoint()
				self:SetPoint(anchorPoint,relativeTo,relativePoint,x+5,y)
			end
			for _,button in ipairs(self.Tabs) do
			  button:SkinButton()
			  button:SetSize(40,40)
			  button.Icon:SetPoint("CENTER")
			end
		end)
	end,

	Dialog = function(self)
		self:StripTextures()
		self:SetTemplate("Default")
		T.SkinCloseButton(self.CloseButton)
		self.Accept:SkinButton()
		self.Cancel:SkinButton()
		self.Other:SkinButton()
		self.Prompt:StripTextures()
		self.Prompt:SetTemplate("Transparent")
		T.SkinEditBox(self.EditBox)
		self.EditBox:SetBackdrop({})
		self.TabPicker:SkinButton()
		self.TabPicker.Icon:SetDrawLayer("ARTWORK")
		self.TeamTabIconPicker:StripTextures()
		self.TeamTabIconPicker:SetTemplate("Transparent")
		T.SkinScrollBar(self.TeamTabIconPicker.ScrollFrame.ScrollBar)
		T.SkinEditBox(self.MultiLine)
		self.MultiLine:SetTemplate("Transparent")
		T.SkinScrollBar(self.MultiLine.ScrollBar)
		for _,child in ipairs({self.MultiLine:GetChildren()}) do
		  if child:GetObjectType()=="Button" then
		    child:SetBackdrop({})
		  end
		end
		T.SkinCheckBox(self.CheckButton)
		self.CollectionReport.ChartTypeComboBox:SetBackdrop({})
		self.CollectionReport.Chart:SetBackdrop({})
		T.SkinEditBox(self.SaveAs.Name)
		self.SaveAs.Name:SetBackdrop({})
		T.SkinEditBox(self.SaveAs.Target)
		self.SaveAs.Target:StripTextures()
		self.SaveAs.Target:SetTemplate("Transparent")
		T.SkinEditBox(self.ScriptFilter.Name)
		self.ScriptFilter.Name:SetBackdrop({})
		for i=1,3 do
		  self.ScriptFilter.ReferenceButtons[i]:SkinButton()
		end
		for _,button in ipairs({"MinHP","MaxHP","MinXP","MaxXP"}) do
		  T.SkinEditBox(self.Preferences[button])
		  self.Preferences[button]:SetBackdrop({})
		end
		T.SkinCheckBox(self.Preferences.AllowMM)
		local handledExpectedDD
		hooksecurefunc(Rematch,"ShowPreferencesDialog",function()
			if not handledExpectedDD then
				for i=1,10 do
					self.Preferences.expectedDD[i]:SkinButton()
					self.Preferences.expectedDD[i].IconBorder:Hide()
				end
				handledExpectedDD = true
			end
		end)
	end,

	Notes = function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		self.Controls.SaveButton:SkinButton()
		self.Controls.UndoButton:SkinButton()
		self.Controls.DeleteButton:SkinButton()
		T.SkinCloseButton(self.CloseButton)

		hooksecurefunc(self,"UpdateLockState",function()
			skin:SetButtonIcon(self.LockButton,RematchSettings.LockNotesPosition and "Locked" or "Unlocked")
		end)
		self.Content:StripTextures()
		self.Content:SetTemplate("Transparent")
		for _,region in ipairs({self.Content:GetRegions()}) do
		  if region:GetDrawLayer()=="ARTWORK" then
		    if region:GetObjectType()=="Texture" then -- restore thin gold border around icons
		      region:SetTexture("Interface\\PetBattles\\PetBattleHUD")
		      region:SetTexCoord(0.884765625,0.943359375,0.681640625,0.798828125)
		    end
		  end
		end
	end,

}

--[[ Stuff that needs to be done on login that has no panel goes here (menus, tooltips, etc) ]]
skin.misc = {

	Menu = function()
		-- menu framepool is local, going to force the creation of three levels of menus and skin them
		for i=1,3 do
			local menu = Rematch:GetMenuFrame(i,UIParent)
			menu:StripTextures()
			menu:SetTemplate("Default")
			for _,region in ipairs({menu.Title:GetRegions()}) do
				if region:GetObjectType()=="Texture" and region:GetDrawLayer()=="BACKGROUND" then
					region:SetTexture()
				end
			end
		end
	end,

	Tooltip = function()
		RematchTooltip:StripTextures()
		RematchTooltip:SetTemplate("Default")
		RematchTableTooltip:StripTextures()
		RematchTableTooltip:SetTemplate("Default")
	end,

	WinRecordCard = function()
		local self = RematchWinRecordCard
		self:StripTextures()
		self:SetTemplate("Transparent")
		for _,button in ipairs({"SaveButton","CancelButton","ResetButton"}) do
			self.Controls[button]:SkinButton()
			self.Controls[button]:SetHeight(20)
		end
		T.SkinCloseButton(self.CloseButton)
		self.Content:StripTextures()
		self.Content:SetTemplate("Default")
		for _,stat in ipairs({"Wins","Losses","Draws"}) do
			T.SkinEditBox(self.Content[stat].EditBox)
			self.Content[stat].EditBox:SetBackdrop({bgFile="Interface\\ChatFrame\\ChatFrameBackground",insets={left=3,right=3,top=3,bottom=3}})
			self.Content[stat].EditBox:SetBackdropColor(0,0,0)
			self.Content[stat].Add:SkinButton()
			self.Content[stat].Add.IconBorder:Hide()
		end
	end,
}

--[[ Helper functions ]]
local icons = {
	Locked = {0, 0.5, 0, 0.25},
	Unlocked = {0.5, 1, 0, 0.25},
	Minimized = {0, 0.5, 0.25, 0.5},
	Maximized = {0.5, 1, 0.25, 0.5},
	SinglePanel = {0, 0.5, 0.5, 0.75},
	DualPanel = {0.5, 1, 0.5, 0.75},
	Pinned = {0, 0.5, 0.75, 1},
}

function skin:SetButtonIcon(button,icon)
	if not button.RematchElvUISkinIcon then
		button.RematchElvUISkinIcon = button:CreateTexture(nil,"ARTWORK")
		button.RematchElvUISkinIcon:SetPoint("TOPLEFT",button,"TOPLEFT",10,-10)
		button.RematchElvUISkinIcon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-10,10)
		button.RematchElvUISkinIcon:SetTexture("Interface\\AddOns\\ShestakUI\\Media\\Textures\\icons.tga")
	end
	if icons[icon] then
		button.RematchElvUISkinIcon:SetTexCoord(unpack(icons[icon]))
	end
end

function skin:ColorPetListBordersPet()
	for _,button in ipairs(self.buttons) do
		if (button.index ~= nil) then
			local petID = roster.petList[button.index]
			if type(petID) == "string" then
				local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID)
				if rarity then
					local color = ITEM_QUALITY_COLORS[rarity-1]
					button.Name:SetTextColor(color.r, color.g, color.b)
				else
					button.Name:SetTextColor(1, 1, 1)
				end
			else
				button.Name:SetTextColor(0.5, 0.5, 0.5)
			end
		end
	end
end

function skin:ColorPetListBordersQueue()
	for _,button in ipairs(self.buttons) do
		if (button.index ~= nil) then
			local petID = RematchSettings.LevelingQueue[button.index]
			if type(petID) == "string" then
				local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID)
				if rarity then
					local color = ITEM_QUALITY_COLORS[rarity-1]
					button.Name:SetTextColor(color.r, color.g, color.b)
				else
					button.Name:SetTextColor(1, 1, 1)
				end
			else
				button.Name:SetTextColor(0.5, 0.5, 0.5)
			end
		end
	end
end

function skin:HandlePanelTab(tab)
	if not tab then return end
	for _,texture in ipairs({tab:GetRegions()}) do
		if texture:GetDrawLayer()=="BACKGROUND" then
				texture:SetTexture(nil)
		end
	end

	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end
	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	if bg then
		tab.backdrop:SetTemplate("Overlay")
		tab.backdrop:SetPoint("TOPLEFT", 3, -7)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -3, 2)
	else
		tab.backdrop:SetTemplate("Transparent")
		tab.backdrop:SetPoint("TOPLEFT", 10, -3)
		tab.backdrop:SetPoint("BOTTOMRIGHT", -10, 3)
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent",function(self,event,...)
	C_Timer.After(0,function()
		if Rematch.isLoaded and not self.skinDone then
			for panel,func in pairs(skin.panels) do
				func(Rematch[panel])
			end
			for _,func in pairs(skin.misc) do
				func()
			end
			self.skinDone = true
			self:UnregisterAllEvents()
		end
	end)
end)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
