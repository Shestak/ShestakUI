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
		local function BuildMounts(self, event)
			for index = 1, GetNumCompanions("MOUNT") do
				local id, name, _, _, _, flag = GetCompanionInfo("MOUNT", index)

				if flag == 12 then
					mounts[index] = "swimming"
				elseif flag == 7 or flag == 15 then
					mounts[index] = "flying"
				elseif flag == 29 then
					mounts[index] = "ground"
				elseif flag == 31 or flag == 23 then
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

			local lowbie = UnitLevel("player") < 20
			if lowbie or total < 1 then
				MountJournal.MountDisplay.NoMounts:Show()
				MountJournal.selectedSpellID = 0
				MountJournal_UpdateMountDisplay()
				MountJournal.MountButton:SetEnabled(false)
			else
				MountJournal.MountDisplay.NoMounts:Hide()
				MountJournal.MountButton:SetEnabled(true)
			end

			table.wipe(filterTable)

			for index = 1, total do
				local id, name, spell, icon, active, flag = GetCompanionInfo("MOUNT", index)
				if name and name:lower():find(filter) and filterFlags[mounts[index]] then
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

					button:SetEnabled(not lowbie)

					button.DragButton:SetEnabled(not lowbie)
					button.additionalText = nil
					button.icon:SetDesaturated(lowbie)
					button.icon:SetAlpha(1)

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

			info.text = L_MISC_MOUNTS_GROUND
			info.checked = filterFlags.ground
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.ground = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = L_MISC_MOUNTS_FLYING
			info.checked = filterFlags.flying
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.flying = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = L_MISC_MOUNTS_FLYINGGROUND
			info.checked = filterFlags.combined
			info.func = function(...)
				local _, _, _, enabled = ...
				filterFlags.combined = enabled
				MountJournal_UpdateMountList()
			end
			UIDropDownMenu_AddButton(info)

			info.text = L_MISC_MOUNTS_SWIMMING
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
			T.SkinEditBox(Search, nil, 18)
			Filter:StripTextures(true)
			Filter:SkinButton()
			Filter:SetPoint("TOPLEFT", Search, "TOPRIGHT", 5, 2)
		end
	end
end)