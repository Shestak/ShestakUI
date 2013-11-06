local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemAlterationUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TransmogrifyArtFrame:StripTextures()
	TransmogrifyArtFrame:SetTemplate("Transparent")
	TransmogrifyModelFrame:SetFrameLevel(TransmogrifyArtFrame:GetFrameLevel() + 2)

	local KillTextures = {
		"TransmogrifyModelFrameLines",
		"TransmogrifyModelFrameMarbleBg",
		"TransmogrifyFrameButtonFrameButtonBorder",
		"TransmogrifyFrameButtonFrameButtonBottomBorder",
		"TransmogrifyFrameButtonFrameMoneyLeft",
		"TransmogrifyFrameButtonFrameMoneyRight",
		"TransmogrifyFrameButtonFrameMoneyMiddle"
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	select(2, TransmogrifyModelFrame:GetRegions()):Kill()
	TransmogrifyFrameButtonFrame:GetRegions():Kill()

	TransmogrifyApplyButton:SkinButton(true)
	TransmogrifyApplyButton:SetPoint("BOTTOMRIGHT", TransmogrifyFrame, "BOTTOMRIGHT", -4, 4)
	T.SkinCloseButton(TransmogrifyArtFrameCloseButton)

	local slots = {"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet",
	"Wrist", "Hands", "Back", "MainHand", "SecondaryHand"}

	for i = 1, #slots do
		local slot = _G["TransmogrifyFrame"..slots[i].."Slot"]
		local icon = _G["TransmogrifyFrame"..slots[i].."SlotIconTexture"]
		local border = _G["TransmogrifyFrame"..slots[i].."SlotBorder"]
		local grabber = _G["TransmogrifyFrame"..slots[i].."SlotGrabber"]

		if slot then
			border:Kill()
			grabber:Kill()

			slot:StyleButton()
			slot:SetFrameLevel(slot:GetFrameLevel() + 2)
			slot:CreateBackdrop("Default")
			slot.backdrop:SetAllPoints()

			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", 2, -2)
			icon:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	-- Transmogrify popup
	TransmogrifyConfirmationPopup:SetTemplate("Transparent")
	TransmogrifyConfirmationPopup.Button1:SkinButton()
	TransmogrifyConfirmationPopup.Button2:SkinButton()

	TransmogrifyConfirmationPopupItemFrame1:StripTextures()
	TransmogrifyConfirmationPopupItemFrame1:SetTemplate("Default")
	TransmogrifyConfirmationPopupItemFrame1:StyleButton()

	TransmogrifyConfirmationPopupItemFrame1IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	TransmogrifyConfirmationPopupItemFrame1IconTexture:ClearAllPoints()
	TransmogrifyConfirmationPopupItemFrame1IconTexture:SetPoint("TOPLEFT", 2, -2)
	TransmogrifyConfirmationPopupItemFrame1IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)
end

T.SkinFuncs["Blizzard_ItemAlterationUI"] = LoadSkin