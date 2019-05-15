local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"PlayerTalentFramePetSpecializationLearnButton",
		"PlayerTalentFrameSpecializationLearnButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton(true)
	end
	PlayerTalentFrameActivateButton:SkinButton()

	PlayerTalentFrameTalentsTutorialButton.Ring:Hide()
	PlayerTalentFrameTalentsTutorialButton:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPLEFT", -12, 12)
	PlayerTalentFrameSpecializationTutorialButton.Ring:Hide()
	PlayerTalentFrameSpecializationTutorialButton:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPLEFT", -12, 12)
	PlayerTalentFramePetSpecializationTutorialButton.Ring:Hide()
	PlayerTalentFramePetSpecializationTutorialButton:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPLEFT", -12, 12)

	PlayerTalentFrame:StripTextures()
	PlayerTalentFrameInset:StripTextures()
	PlayerTalentFrame:CreateBackdrop("Transparent")
	PlayerTalentFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	PlayerTalentFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)

	PlayerTalentFrameTalentsBg:Hide()
	PlayerTalentFrameTalents:DisableDrawLayer("BORDER")

	PlayerTalentFramePortrait:Kill()
	T.SkinCloseButton(PlayerTalentFrameCloseButton)

	for i = 1, 6 do
		select(i, PlayerTalentFrameSpecialization:GetRegions()):Hide()
	end

	select(7, PlayerTalentFrameSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")

	for i = 1, 5 do
		select(i, PlayerTalentFrameSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
	end

	PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetColorTexture(1, 1, 1)
	PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetAlpha(0.2)

	if T.class == "HUNTER" then
		for i = 1, 6 do
			select(i, PlayerTalentFramePetSpecialization:GetRegions()):Hide()
		end

		select(7, PlayerTalentFramePetSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")

		for i = 1, 5 do
			select(i, PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
		end

		PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.Seperator:SetColorTexture(1, 1, 1)
		PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.Seperator:SetAlpha(0.2)

		for i = 1, GetNumSpecializations(false, true) do
			local bu = PlayerTalentFramePetSpecialization["specButton"..i]
			local _, _, _, icon = GetSpecializationInfo(i, false, true)

			bu.ring:Hide()
			bu.specIcon:SetTexture(icon)
			bu.specIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			bu.specIcon:SetSize(50, 50)
			bu.specIcon:SetPoint("LEFT", bu, "LEFT", 15, 0)
		end
	end

	for i = 1, NUM_TALENT_FRAME_TABS do
		T.SkinTab(_G["PlayerTalentFrameTab"..i])
	end

	local PlayerSpec = _G["PlayerTalentFrameSpecializationSpellScrollFrameScrollChild"]
	PlayerSpec.ring:Hide()
	PlayerSpec.specIcon:SetPoint("TOPLEFT", PlayerSpec, 22, -25)
	PlayerSpec.specIcon:SkinIcon()

	local PetSpec = _G["PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild"]
	PetSpec.ring:Hide()
	PetSpec.specIcon:SetPoint("TOPLEFT", PetSpec, 22, -25)
	PetSpec.specIcon:SkinIcon()

	T.SkinScrollBar(PlayerTalentFrameSpecializationSpellScrollFrameScrollBar)
	PlayerTalentFrameSpecializationSpellScrollFrameScrollBar:SetPoint("TOPLEFT", PlayerTalentFrameSpecializationSpellScrollFrame, "TOPRIGHT", -16, -16)
	PlayerTalentFrameSpecializationSpellScrollFrame:SetHeight(PlayerTalentFrameSpecializationSpellScrollFrame:GetHeight() + 5)

	hooksecurefunc("PlayerTalentFrame_UpdateSpecFrame", function(self, spec)
		local playerTalentSpec = GetSpecialization(nil, self.isPet, PlayerSpecTab2:GetChecked() and 2 or 1)
		local shownSpec = spec or playerTalentSpec or 1
		local numSpecs = GetNumSpecializations(nil, self.isPet)

		local id, _, _, icon = GetSpecializationInfo(shownSpec, nil, self.isPet)
		local scrollChild = self.spellsScroll.child

		scrollChild.specIcon:SetTexture(icon)

		local index = 1
		local bonuses
		local bonusesIncrement = 1
		if self.isPet then
			bonuses = {GetSpecializationSpells(shownSpec, nil, self.isPet, true)}
			bonusesIncrement = 2
		else
			bonuses = C_SpecializationInfo.GetSpellsDisplay(id)
		end
		if bonuses then
			for i = 1, #bonuses, bonusesIncrement do
				local frame = scrollChild["abilityButton"..index]
				local _, icon = GetSpellTexture(bonuses[i])
				frame.icon:SetTexture(icon)
				if not frame.reskinned then
					frame.reskinned = true
					frame.ring:Hide()
					frame:CreateBackdrop("Default")
					frame.backdrop:SetPoint("TOPLEFT", 2, -2)
					frame.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)
					frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					frame.icon:SetParent(frame.backdrop)
					frame.icon:SetPoint("TOPLEFT", 2, -2)
					frame.icon:SetPoint("BOTTOMRIGHT", -2, 2)
				end
				index = index + 1
			end
		end

		for i = 1, numSpecs do
			local bu = self["specButton"..i]
			if bu.selected then
				bu.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				bu.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
				bu.border.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
			else
				bu.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				bu.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				bu.border.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	for i = 1, GetNumSpecializations(false, nil) do
		local bu = PlayerTalentFrameSpecialization["specButton"..i]
		local _, _, _, icon = GetSpecializationInfo(i, false, nil)

		bu.ring:Hide()

		bu.specIcon:SetTexture(icon)
		bu.specIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		bu.specIcon:SetSize(50, 50)
		bu.specIcon:SetPoint("LEFT", bu, "LEFT", 15, 0)
	end

	local buttons = {"PlayerTalentFrameSpecializationSpecButton", "PlayerTalentFramePetSpecializationSpecButton"}

	for _, name in pairs(buttons) do
		for i = 1, 4 do
			local bu = _G[name..i]
			_G["PlayerTalentFrameSpecializationSpecButton"..i.."Glow"]:Hide()
			_G["PlayerTalentFrameSpecializationSpecButton"..i.."Glow"].Show = T.dummy

			local hover = bu:CreateTexture(nil, nil, self)
			hover:SetColorTexture(1, 1, 1, 0.3)
			bu:SetHighlightTexture(hover)
			bu:GetHighlightTexture():SetPoint("TOPLEFT", 10, 0)
			bu:GetHighlightTexture():SetPoint("BOTTOMRIGHT", 8, 0)

			bu.bg:SetAlpha(0)
			bu.learnedTex:SetAlpha(0)
			bu.selectedTex:SetAlpha(0)

			bu:CreateBackdrop("Overlay")
			bu.backdrop:SetPoint("TOPLEFT", 8, 2)
			bu.backdrop:SetPoint("BOTTOMRIGHT", 10, -2)

			bu.border = CreateFrame("Frame", nil, bu)
			bu.border:CreateBackdrop("Default")
			bu.border.backdrop:SetPoint("TOPLEFT", bu.specIcon, -2, 2)
			bu.border.backdrop:SetPoint("BOTTOMRIGHT", bu.specIcon, 2, -2)
		end
	end

	for i = 1, MAX_TALENT_TIERS do
		local row = _G["PlayerTalentFrameTalentsTalentRow"..i]
		_G["PlayerTalentFrameTalentsTalentRow"..i.."Bg"]:Hide()
		row:DisableDrawLayer("BORDER")

		row.TopLine:SetAlpha(0)
		row.BottomLine:SetAlpha(0)
		row.GlowFrame:SetAlpha(0)

		for j = 1, NUM_TALENT_COLUMNS do
			local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
			local ic = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j.."IconTexture"]

			bu:StripTextures()
			bu:SetFrameLevel(bu:GetFrameLevel() + 2)
			bu:CreateBackdrop("Default")
			bu.backdrop:SetPoint("TOPLEFT", ic, -2, 2)
			bu.backdrop:SetPoint("BOTTOMRIGHT", ic, 2, -2)

			bu.knownSelection:SetAlpha(0)
			bu.GlowFrame:StripTextures()

			ic:SetDrawLayer("ARTWORK")
			ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			bu.bg = CreateFrame("Frame", nil, bu)
			bu.bg:CreateBackdrop("Overlay")
			bu.bg:SetFrameLevel(bu:GetFrameLevel() - 1)
			bu.bg:SetPoint("TOPLEFT", 15, -1)
			bu.bg:SetPoint("BOTTOMRIGHT", -10, 1)
		end
	end

	hooksecurefunc("TalentFrame_Update", function()
		for i = 1, MAX_TALENT_TIERS do
			for j = 1, NUM_TALENT_COLUMNS do
				local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
				local selected = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j.."Selection"]
				if selected:IsShown() then
					bu.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
					bu.bg.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
					bu.bg.backdrop.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
				else
					bu.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					bu.bg.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					bu.bg.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
			end
		end
	end)

	for i = 1, 2 do
		local tab = _G["PlayerSpecTab"..i]
		_G["PlayerSpecTab"..i.."Background"]:Hide()

		tab:StripTextures()
		tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		tab:GetNormalTexture():ClearAllPoints()
		tab:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
		tab:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)

		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()
		tab:StyleButton(true)
	end

	-- Reposition tabs
	hooksecurefunc("PlayerTalentFrame_UpdateSpecs", function()
		PlayerSpecTab1:SetPoint("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", 1, 0)
		PlayerSpecTab2:SetPoint("TOP", PlayerSpecTab1, "BOTTOM")
	end)

	-- PvP Talents
	PlayerTalentFrameTalentsPvpTalentButton:SetSize(20, 20)
	PlayerTalentFrameTalentsPvpTalentButton:SkinButton()
	PlayerTalentFrameTalentsPvpTalentButtonIcon:SetTexCoord(0.3, 0.29, 0.3, 0.79, 0.65, 0.29, 0.65, 0.79)

	for _, button in pairs(PlayerTalentFrameTalents.PvpTalentFrame.Slots) do
		button:CreateBackdrop()
		button.backdrop:SetOutside(button.Texture)

		button.Arrow:SetAlpha(0)
		button.Border:Hide()

		hooksecurefunc(button, "Update", function(self)
			local selectedTalentID = self.predictedSetting:Get()
			if selectedTalentID then
				local _, _, texture = GetPvpTalentInfoByID(selectedTalentID)
				self.Texture:SetTexture(texture)
				self.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			else
				self.Texture:SetTexCoord(.15, .85, .15, .85)
			end
		end)
	end

	PlayerTalentFrameTalents.PvpTalentFrame.Swords:SetSize(72, 67)
	PlayerTalentFrameTalents.PvpTalentFrame.Orb:Hide()
	PlayerTalentFrameTalents.PvpTalentFrame.Ring:Hide()
	PlayerTalentFrameTalents.PvpTalentFrame.OrbModelScene:SetAlpha(0)

	PlayerTalentFrameTalents.PvpTalentFrame:StripTextures()
	PlayerTalentFrameTalentsPvpTalentFrameTalentList:StripTextures()
	PlayerTalentFrameTalentsPvpTalentFrameTalentList:CreateBackdrop("Transparent")
	T.SkinScrollBar(PlayerTalentFrameTalentsPvpTalentFrameTalentListScrollFrameScrollBar)

	local TalentList_CloseButton = select(4, PlayerTalentFrameTalents.PvpTalentFrame.TalentList:GetChildren())
	if TalentList_CloseButton and TalentList_CloseButton:HasScript("OnClick") then
		TalentList_CloseButton:SkinButton()
	end

	for _, button in pairs(PlayerTalentFrameTalents.PvpTalentFrame.TalentList.ScrollFrame.buttons) do
		button:DisableDrawLayer("BACKGROUND")
		button.Selected:SetTexture("")
		button:StyleButton()

		button:CreateBackdrop("Default")
		button.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)

		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.Icon:SetSize(28, 28)
		button.Icon:SetPoint("LEFT", button, "LEFT", 6, 0)

		button.bg = CreateFrame("Frame", nil, button)
		button.bg:CreateBackdrop("Overlay")
		button.bg:SetFrameLevel(button:GetFrameLevel() - 1)
		button.bg:SetPoint("TOPLEFT", 2, -3)
		button.bg:SetPoint("BOTTOMRIGHT", -2, 3)
	end

	hooksecurefunc(PlayerTalentFrameTalents.PvpTalentFrame.TalentList, "Update", function(self)
		for _, button in pairs(PlayerTalentFrameTalents.PvpTalentFrame.TalentList.ScrollFrame.buttons) do
			if button.Selected:IsShown() then
				button.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
				button.bg.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
				button.bg.backdrop.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.bg.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.bg.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end
	end)

	PlayerTalentFrameLockInfo:StripTextures()
	PlayerTalentFrameLockInfo:SetTemplate("Transparent")
	PlayerTalentFrameLockInfo:SetFrameLevel(PlayerTalentFrameLockInfo:GetFrameLevel() + 1)

	-- Help box
	local HelpBox = {
		PlayerTalentFrameTalentsPvpTalentFrame.TrinketSlot.HelpBox,
		PlayerTalentFrameTalentsPvpTalentFrame.WarmodeTutorialBox
	}

	for i = 1, #HelpBox do
		local frame = HelpBox[i]
		T.SkinHelpBox(frame)
	end
end

T.SkinFuncs["Blizzard_TalentUI"] = LoadSkin