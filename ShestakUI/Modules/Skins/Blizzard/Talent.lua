local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TalentUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"PlayerTalentFrameTalentsLearnButton",
		"PlayerTalentFrameActivateButton",
		"PlayerTalentFramePetSpecializationLearnButton",
		"PlayerTalentFrameSpecializationLearnButton"
	}

	for i = 1, #buttons do
		_G[buttons[i]]:SkinButton()
		_G[buttons[i]].overlay:SetVertexColor(0.3, 0.3, 0.3, 0.3)
		_G[buttons[i]]:SetScript("OnLeave", function(self)
			_G[buttons[i]]:SetBackdropBorderColor(unpack(C.media.border_color))
			_G[buttons[i]].overlay:SetVertexColor(0.3, 0.3, 0.3, 0.3)
		end)
	end

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

	T.SkinCloseButton(PlayerTalentFrameCloseButton)

	for i = 1, 6 do
		select(i, PlayerTalentFrameSpecialization:GetRegions()):Hide()
	end

	select(7, PlayerTalentFrameSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")

	for i = 1, 5 do
		select(i, PlayerTalentFrameSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
	end

	PlayerTalentFrameTalentsClearInfoFrame:SetTemplate("Default")

	PlayerTalentFrameTalentsClearInfoFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	PlayerTalentFrameTalentsClearInfoFrameIcon:SetPoint("TOPLEFT", 2, -2)
	PlayerTalentFrameTalentsClearInfoFrameIcon:SetPoint("BOTTOMRIGHT", -2, 2)

	PlayerTalentFrameTalentsClearInfoFrameCount:SetFont(C.media.normal_font, 11, "OUTLINE")
	PlayerTalentFrameTalentsClearInfoFrameCount:SetPoint("BOTTOMRIGHT", 2, 0)

	PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetTexture(1, 1, 1)
	PlayerTalentFrameSpecializationSpellScrollFrameScrollChild.Seperator:SetAlpha(0.2)

	if T.class == "HUNTER" then
		for i = 1, 6 do
			select(i, PlayerTalentFramePetSpecialization:GetRegions()):Hide()
		end

		select(7, PlayerTalentFramePetSpecialization:GetChildren()):DisableDrawLayer("OVERLAY")

		for i = 1, 5 do
			select(i, PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild:GetRegions()):Hide()
		end

		PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild.Seperator:SetTexture(1, 1, 1)
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

	local pspecspell = _G["PlayerTalentFrameSpecializationSpellScrollFrameScrollChild"]
	pspecspell.ring:Hide()
	pspecspell:CreateBackdrop("Default")
	pspecspell.backdrop:SetPoint("TOPLEFT", pspecspell.specIcon, -2, 2)
	pspecspell.backdrop:SetPoint("BOTTOMRIGHT", pspecspell.specIcon, 2, -2)
	pspecspell.specIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	pspecspell.specIcon:SetParent(pspecspell.backdrop)

	local specspell2 = _G["PlayerTalentFramePetSpecializationSpellScrollFrameScrollChild"]
	specspell2.ring:Hide()
	specspell2:CreateBackdrop("Default")
	specspell2.backdrop:SetPoint("TOPLEFT", specspell2.specIcon, -2, 2)
	specspell2.backdrop:SetPoint("BOTTOMRIGHT", specspell2.specIcon, 2, -2)
	specspell2.specIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	specspell2.specIcon:SetParent(specspell2.backdrop)

	hooksecurefunc("PlayerTalentFrame_UpdateSpecFrame", function(self, spec)
		local playerTalentSpec = GetSpecialization(nil, self.isPet, PlayerSpecTab2:GetChecked() and 2 or 1)
		local shownSpec = spec or playerTalentSpec or 1

		local id, _, _, icon = GetSpecializationInfo(shownSpec, nil, self.isPet)
		local scrollChild = self.spellsScroll.child

		scrollChild.specIcon:SetTexture(icon)

		local index = 1
		local bonuses
		if self.isPet then
			bonuses = {GetSpecializationSpells(shownSpec, nil, self.isPet)}
		else
			bonuses = SPEC_SPELLS_DISPLAY[id]
		end
		for i = 1, #bonuses, 2 do
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

		for i = 1, GetNumSpecializations(nil, self.isPet) do
			local bu = self["specButton"..i]
			if bu.selected then
				bu.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				bu.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
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

			bu:SetHighlightTexture("")
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

	for i = 1, MAX_NUM_TALENT_TIERS do
		local row = _G["PlayerTalentFrameTalentsTalentRow"..i]
		_G["PlayerTalentFrameTalentsTalentRow"..i.."Bg"]:Hide()
		row:DisableDrawLayer("BORDER")

		row.TopLine:SetAlpha(0)
		row.BottomLine:SetAlpha(0)

		for j = 1, NUM_TALENT_COLUMNS do
			local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
			local ic = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j.."IconTexture"]

			bu:StripTextures()
			bu:SetFrameLevel(bu:GetFrameLevel() + 2)
			bu:CreateBackdrop("Default")
			bu.backdrop:SetPoint("TOPLEFT", ic, -2, 2)
			bu.backdrop:SetPoint("BOTTOMRIGHT", ic, 2, -2)

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
		for i = 1, MAX_NUM_TALENT_TIERS do
			for j = 1, NUM_TALENT_COLUMNS do
				local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]
				if bu.knownSelection:IsShown() then
					bu.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
					bu.bg.backdrop:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b, 1)
					bu.bg.backdrop.overlay:SetVertexColor(T.color.r, T.color.g, T.color.b, 0.3)
				else
					bu.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					bu.bg.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					bu.bg.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
				if bu.learnSelection:IsShown() then
					bu.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
					bu.bg.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
					bu.bg.backdrop.overlay:SetVertexColor(1, 0.82, 0, 0.3)
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
end

T.SkinFuncs["Blizzard_TalentUI"] = LoadSkin