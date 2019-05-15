local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	InspectUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrameInset:StripTextures(true)
	InspectFrame:CreateBackdrop("Transparent")
	InspectFrame.backdrop:SetAllPoints()
	T.SkinCloseButton(InspectFrameCloseButton)
	InspectPaperDollFrame.ViewButton:SkinButton()

	for i = 1, 4 do
		T.SkinTab(_G["InspectFrameTab"..i])
	end

	InspectModelFrame:StripTextures()
	InspectModelFrame:CreateBackdrop("Default")
	InspectModelFrame.backdrop:SetPoint("TOPLEFT", -3, 4)
	InspectModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)
	InspectModelFrame.BackgroundOverlay:SetColorTexture(0, 0, 0)

	-- Unit Background Texture
	InspectModelFrameBackgroundTopLeft:SetPoint("TOPLEFT", InspectModelFrame.backdrop, "TOPLEFT", 2, -2)
	InspectModelFrameBackgroundTopRight:SetPoint("TOPRIGHT", InspectModelFrame.backdrop, "TOPRIGHT", -2, -2)
	InspectModelFrameBackgroundBotLeft:SetPoint("BOTTOMLEFT", InspectModelFrame.backdrop, "BOTTOMLEFT", 2, -50)
	InspectModelFrameBackgroundBotRight:SetPoint("BOTTOMRIGHT", InspectModelFrame.backdrop, "BOTTOMRIGHT", -2, -50)

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot"
	}

	for _, slot in pairs(slots) do
		local icon = _G["Inspect"..slot.."IconTexture"]
		local slot = _G["Inspect"..slot]

		slot:StripTextures()
		slot:StyleButton()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)

		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()

		hooksecurefunc(slot.IconBorder, "SetVertexColor", function(self)
			self:SetTexture("")
		end)
	end

	-- Presige texture
	local portrait = InspectPVPFrame:CreateTexture(nil, "OVERLAY")
	portrait:SetSize(55, 55)
	portrait:SetPoint("CENTER", InspectPVPFrame.PortraitBackground, "CENTER", 0, 0)
	InspectPVPFrame.PortraitBackground:Kill()
	InspectPVPFrame.PortraitBackground:ClearAllPoints()
	InspectPVPFrame.PortraitBackground:SetPoint("TOPLEFT", 10, -5)
	InspectPVPFrame.SmallWreath:ClearAllPoints()
	InspectPVPFrame.SmallWreath:SetPoint("TOPLEFT", 3, -25)

	local function SkinPvpTalents(slot)
		local icon = slot.Texture
		slot:StripTextures()
		slot:CreateBackdrop("Default")
		slot.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
		slot.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)

		slot.Border:Hide()

		icon:SetTexCoord(.15, .85, .15, .85)
	end

	for i = 1, 3 do
		SkinPvpTalents(InspectPVPFrame["TalentSlot"..i])
	end

	SkinPvpTalents(InspectPVPFrame.TrinketSlot)

	InspectPVPFrame.BG:Kill()

	SpecializationRing:Hide()
	SpecializationSpecIcon:SkinIcon()
	SpecializationSpecIcon:SetTexCoord(.15, .85, .15, .85)
	SpecializationSpecName:SetFont(C.media.normal_font, 20)
	InspectTalentFrame:DisableDrawLayer("BACKGROUND")
	InspectTalentFrame:DisableDrawLayer("BORDER")

	for i = 1, 7 do
		for j = 1, 3 do
			local button = _G["TalentsTalentRow"..i.."Talent"..j]
			local icon = _G["TalentsTalentRow"..i.."Talent"..j.."IconTexture"]

			button:StripTextures()
			button:CreateBackdrop("Default")
			button.backdrop:SetPoint("TOPLEFT", icon, -2, 2)
			button.backdrop:SetPoint("BOTTOMRIGHT", icon, 2, -2)

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	InspectGuildFrameBG:Kill()
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin