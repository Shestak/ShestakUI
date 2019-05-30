local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	InspectUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrame:CreateBackdrop("Transparent")
	InspectFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	InspectFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(InspectFrameCloseButton, InspectFrame.backdrop)

	InspectNameText:ClearAllPoints()
    InspectNameText:SetPoint("TOP", InspectFrame.backdrop, "TOP", 0, -6)

	InspectFrameTab1:ClearAllPoints()
	InspectFrameTab1:SetPoint("TOPLEFT", InspectFrame.backdrop, "BOTTOMLEFT", 2, -2)
	for i = 1, 2 do
		T.SkinTab(_G["InspectFrameTab"..i])
	end

	-- Character Frame
	InspectPaperDollFrame:StripTextures()

	InspectModelFrame:StripTextures()
	InspectModelFrame:CreateBackdrop("Default")
	InspectModelFrame.backdrop:SetPoint("TOPLEFT", -3, 4)
	InspectModelFrame.backdrop:SetPoint("BOTTOMRIGHT", 4, 0)

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
		"SecondaryHandSlot",
		"RangedSlot"
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

		hooksecurefunc(slot.IconBorder, "SetVertexColor", function(self, r, g, b)
			self:SetTexture("")
		end)
	end

	InspectHonorFrame:StripTextures(true)

	InspectHonorFrameProgressBar:ClearAllPoints()
	InspectHonorFrameProgressBar:SetPoint("TOP", InspectFrame.backdrop, "TOP", 1, -65)
	
	InspectHonorFrameProgressBar:CreateBackdrop("Default")
	InspectHonorFrameProgressBar:SetHeight(24)
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin