local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	VoidStorageUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"VoidStorageBorderFrame",
		"VoidStorageDepositFrame",
		"VoidStorageWithdrawFrame",
		"VoidStorageCostFrame",
		"VoidStorageStorageFrame",
		"VoidStoragePurchaseFrame",
		"VoidItemSearchBox"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	VoidStorageFrame:SetTemplate("Transparent")
	VoidStoragePurchaseFrame:SetTemplate("Overlay")
	VoidStoragePurchaseFrame:SetFrameLevel(VoidStorageFrame:GetFrameLevel() + 2)
	VoidStorageFrameMarbleBg:Kill()
	VoidStorageFrameLines:Kill()
	select(2, VoidStorageFrame:GetRegions()):Kill()

	VoidStoragePurchaseButton:SkinButton()
	VoidStorageHelpBoxButton:SkinButton()
	VoidStorageTransferButton:SkinButton()

	T.SkinCloseButton(VoidStorageBorderFrame.CloseButton)
	VoidItemSearchBox:CreateBackdrop("Overlay")
	VoidItemSearchBox.backdrop:Point("TOPLEFT", 10, -1)
	VoidItemSearchBox.backdrop:Point("BOTTOMRIGHT", 4, 1)

	VoidStorageFrame:HookScript("OnShow", function()
		SideDressUpFrame:ClearAllPoints()
		SideDressUpFrame:Point("TOPLEFT", VoidStorageFrame, "TOPRIGHT", 3, 0)
	end)

	for i = 1, 9 do
		local button_d = _G["VoidStorageDepositButton"..i]
		local button_w = _G["VoidStorageWithdrawButton"..i]
		local icon_d = _G["VoidStorageDepositButton"..i.."IconTexture"]
		local icon_w = _G["VoidStorageWithdrawButton"..i.."IconTexture"]

		_G["VoidStorageDepositButton"..i.."Bg"]:Hide()
		_G["VoidStorageWithdrawButton"..i.."Bg"]:Hide()

		button_d:StyleButton()
		button_d:SetTemplate()

		button_w:StyleButton()
		button_w:SetTemplate()

		icon_d:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon_d:ClearAllPoints()
		icon_d:Point("TOPLEFT", 2, -2)
		icon_d:Point("BOTTOMRIGHT", -2, 2)

		icon_w:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon_w:ClearAllPoints()
		icon_w:Point("TOPLEFT", 2, -2)
		icon_w:Point("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, 80 do
		local button = _G["VoidStorageStorageButton"..i]
		local icon = _G["VoidStorageStorageButton"..i.."IconTexture"]

		_G["VoidStorageStorageButton"..i.."Bg"]:Hide()

		button:StyleButton()
		button:SetTemplate()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)
	end
end

T.SkinFuncs["Blizzard_VoidStorageUI"] = LoadSkin