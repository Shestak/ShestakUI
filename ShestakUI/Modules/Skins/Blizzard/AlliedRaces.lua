local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AlliedRacesUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	AlliedRacesFrame:StripTextures()
	AlliedRacesFrame:SetTemplate("Transparent")

	AlliedRacesFramePortrait:SetAlpha(0)

	AlliedRacesFrame.ModelFrame:StripTextures()
	AlliedRacesFrame.ModelFrame:CreateBackdrop("Transparent")
	AlliedRacesFrame.ModelFrame.backdrop:SetFrameLevel(1)
	AlliedRacesFrame.ModelFrame.backdrop:SetPoint("TOPLEFT", -2, 2)
	AlliedRacesFrame.ModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)

	AlliedRacesFrame.ModelFrame:SetSize(313, 575)
	AlliedRacesFrame.ModelFrame:SetPoint("LEFT", 10, -6)

	local scrollFrame = AlliedRacesFrame.RaceInfoFrame.ScrollFrame
	scrollFrame.ScrollBar.Border:Hide()
	scrollFrame.ScrollBar.ScrollUpBorder:Hide()
	scrollFrame.ScrollBar.ScrollDownBorder:Hide()
	scrollFrame.ScrollBar.Track:Hide()

	AlliedRacesFrame.RaceInfoFrame.AlliedRacesRaceName:SetTextColor(1, .8, 0)
	scrollFrame.Child.RaceDescriptionText:SetTextColor(1, 1, 1)
	scrollFrame.Child.RacialTraitsLabel:SetTextColor(1, .8, 0)

	scrollFrame.Child.ObjectivesFrame:StripTextures()
	scrollFrame.Child.ObjectivesFrame:CreateBackdrop("Overlay")

	AlliedRacesFrame:HookScript("OnShow", function(self)
		for button in self.abilityPool:EnumerateActive() do
			select(3, button:GetRegions()):Hide()
			button.Icon:SkinIcon()
			button.Text:SetTextColor(1, 1, 1)
		end
	end)

	T.SkinScrollBar(scrollFrame.ScrollBar)
	T.SkinCloseButton(AlliedRacesFrameCloseButton)
end

T.SkinFuncs["Blizzard_AlliedRacesUI"] = LoadSkin