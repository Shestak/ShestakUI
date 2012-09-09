local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Mount list search function(Collie by p3lim)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_PetJournal" then
		local filter = ""
		local filterTable = {}
		local filterFlags = {
			["swimming"] = true,
			["flying"] = true,
			["ground"] = true,
			["combined"] = true,
		}

		local Search = CreateFrame("EditBox", "MountSearch", MountJournal, "SearchBoxTemplate")
		Search:SetSize(145, 20)
		Search:SetPoint("TOPLEFT", MountJournal.LeftInset, 15, -9)
		Search:SetMaxLetters(40)
		Search:SetScript("OnTextChanged", function(self)
			local text = self:GetText()
			if text == SEARCH then
				filter = ""
			else
				filter = text
			end

			MountJournal_UpdateMountList()
		end)

		local mounts = {}
		local function BuildMounts()
			for index = 1, GetNumCompanions("MOUNT") do
				local id, name, _, _, _, flag = GetCompanionInfo("MOUNT", index)

				if flag == 12 then
					mounts[index] = "swimming"
				elseif flag == 7 or flag == 15 then
					mounts[index] = "flying"
				elseif flag == 29 then
					mounts[index] = "ground"
				elseif flag == 31 then
					mounts[index] = "combined"
				end

				if id == 34187 then
					mounts[index] = "swimming"
				end
			end
		end

		MountJournal:HookScript("OnEvent", BuildMounts)
		BuildMounts()

		function MountJournal_UpdateMountList()
			local scroll = MountJournal.ListScrollFrame
			local offset = HybridScrollFrame_GetOffset(scroll)
			local total = GetNumCompanions("MOUNT")

			if UnitLevel("player") < 20 or total < 1 then
				scroll:Hide()
				MountJournal.MountDisplay.NoMounts:Show()
				MountJournal.selectedSpellID = 0
				MountJournal_UpdateMountDisplay()
				MountJournal.MountCount:SetText(0)
				MountJournal.MountButton:SetEnabled(false)
				return
			else
				scroll:Show()
				MountJournal.MountDisplay.NoMounts:Hide()
				MountJournal.MountButton:SetEnabled(true)
			end

			table.wipe(filterTable)

			for index = 1, total do
				local id, name, spell, icon, active, flag = GetCompanionInfo("MOUNT", index)
				if name:lower():find(filter) and filterFlags[mounts[index]] then
					table.insert(filterTable, index)
				end
			end

			local buttons = scroll.buttons
			for j = 1, #buttons do
				local button = buttons[j]
				local index = j + offset
				if index <= #filterTable then
					local _, name, spell, icon, active = GetCompanionInfo("MOUNT", filterTable[index])
					button.name:SetText(name)
					button.icon:SetTexture(icon)
					button.index = filterTable[index]
					button.spellID = spell
					button.active = active

					if active then
						button.DragButton.ActiveTexture:Show()
					else
						button.DragButton.ActiveTexture:Hide()
					end

					button:Show()

					if MountJournal.selectedSpellID == spell then
						button.selected = true
						button.selectedTexture:Show()
						if C.skins.blizzard_frames == true then
							button.name:SetTextColor(1, 1, 0)
							button.backdrop:SetBackdropBorderColor(1, 1, 0)
							button.border.backdrop:SetBackdropBorderColor(1, 1, 0)
						end
					else
						button.selected = false
						button.selectedTexture:Hide()
						if C.skins.blizzard_frames == true then
							button.name:SetTextColor(1, 1, 1)
							button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
							button.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					end

					button:SetEnabled(true)

					button.DragButton:SetEnabled(true)
					button.additionalText = nil
					button.icon:SetDesaturated(false)
					button.icon:SetAlpha(1)
					--button.name:SetFontObject("GameFontNormal")

					if button.showingTooltip then
						MountJournalMountButton_UpdateTooltip(button)
					end
				else
					button:Hide()
				end
			end

			HybridScrollFrame_Update(scroll, #filterTable * 46, scroll:GetHeight())
			MountJournal.MountCount.Count:SetText(total)
		end

		local scroll = MountJournal.ListScrollFrame
		scroll.update = MountJournal_UpdateMountList
		scroll:SetPoint("TOPLEFT", MountJournal.LeftInset, 3, -36)
		scroll.scrollBar:SetPoint("TOPLEFT", scroll, "TOPRIGHT", 4, 20)

		local function CreateDropDown()
			local info = UIDropDownMenu_CreateInfo()
			info.keepShownOnClick = true
			info.isNotRadio = true

			info.text = "Ground"
			info.checked = filterFlags.ground
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.ground = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = "Flying"
			info.checked = filterFlags.flying
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.flying = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = "Flying & Ground"
			info.checked = filterFlags.combined
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.combined = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = "Swimming"
			info.checked = filterFlags.swimming
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.swimming = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)
		end

		local FilterDropDown = CreateFrame("Frame")
		FilterDropDown.initialize = CreateDropDown
		FilterDropDown.displayMode = "MENU"

		local Filter = CreateFrame("Button", "MountFilter", MountJournal, "UIMenuButtonStretchTemplate")
		Filter:SetSize(93, 22)
		Filter:SetPoint("TOPRIGHT", MountJournal.LeftInset, -5, -9)
		Filter:SetText(FILTER)
		Filter.rightArrow:Show()
		Filter:SetScript("OnClick", function()
			PlaySound("igMainMenuOptionCheckBoxOn")
			ToggleDropDownMenu(1, nil, FilterDropDown, MountFilter, 74, 15)
		end)

		if C.skins.blizzard_frames == true then
			T.SkinEditBox(Search)
			Search:SetHeight(18)
			Filter:StripTextures(true)
			Filter:SkinButton()
			Filter:SetPoint("TOPLEFT", Search, "TOPRIGHT", 5, 2)
		end
	end
end)