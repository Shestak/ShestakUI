local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	InspectUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrameInset:StripTextures(true)
	InspectFrame:CreateBackdrop("Transparent")
	InspectFrame.backdrop:SetAllPoints()
	T.SkinCloseButton(InspectFrameCloseButton)

	for i = 1, 4 do
		T.SkinTab(_G["InspectFrameTab"..i])
	end

	InspectModelFrame:StripTextures(true)
	InspectModelFrame:CreateBackdrop("Overlay")
	InspectModelFrame.backdrop:Point("TOPLEFT", -2, 2)
	InspectModelFrame.backdrop:Point("BOTTOMRIGHT", 2, -3)

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
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)

		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()
	end

	InspectPVPFrameBottom:Kill()
	InspectGuildFrameBG:Kill()
	InspectPVPFrame:HookScript("OnShow", function() InspectPVPFrameBG:Kill() end)

	for i = 1, 3 do
		_G["InspectPVPTeam"..i]:StripTextures()
	end

	SpecializationSpecName:SetFont(C.media.normal_font, 20)
	--SpecializationRing:SetTexture("")
	--InspectTalentFrame:StripTextures()
	InspectTalentFrame:DisableDrawLayer("BACKGROUND")
	InspectTalentFrame:DisableDrawLayer("BORDER")

	for i = 1, 6 do
		for j = 1, 3 do
			local button = _G["TalentsTalentRow"..i.."Talent"..j]
			local icon = _G["TalentsTalentRow"..i.."Talent"..j.."IconTexture"]

			button:StripTextures()
			button:CreateBackdrop("Default")
			button.backdrop:Point("TOPLEFT", icon, -2, 2)
			button.backdrop:Point("BOTTOMRIGHT", icon, 2, -2)

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end

	for i = 1, 6 do
		local button = _G["InspectGlyphsGlyph"..i]
		local icon = _G["InspectGlyphsGlyph"..i.."IconTexture"]

		--button:StripTextures()
		--button:CreateBackdrop("Default")
		--button.backdrop:Point("TOPLEFT", -2, 2)
		--button.backdrop:Point("BOTTOMRIGHT", 2, -2)

		--button.ring:SetTexCoord(0.1, 0.9, 0.1, 0.9);
	end
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin