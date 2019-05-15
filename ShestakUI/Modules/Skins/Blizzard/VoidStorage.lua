local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

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
	VoidStorageTransferButton:SkinButton()

	VoidStorageHelpBox:StripTextures()
	VoidStorageHelpBox:SetTemplate("Transparent")
	VoidStorageHelpBoxArrow:Hide()
	VoidStorageHelpBoxButton:SkinButton()

	T.SkinCloseButton(VoidStorageBorderFrame.CloseButton)
	VoidItemSearchBox:CreateBackdrop("Overlay")
	VoidItemSearchBox.backdrop:SetPoint("TOPLEFT", 10, -1)
	VoidItemSearchBox.backdrop:SetPoint("BOTTOMRIGHT", 4, 1)

	VoidStorageFrame:HookScript("OnShow", function()
		SideDressUpFrame:ClearAllPoints()
		SideDressUpFrame:SetPoint("TOPLEFT", VoidStorageFrame, "TOPRIGHT", 3, 0)
	end)

	for i = 1, 9 do
		local button_d = _G["VoidStorageDepositButton"..i]
		local button_w = _G["VoidStorageWithdrawButton"..i]
		local icon_d = _G["VoidStorageDepositButton"..i.."IconTexture"]
		local icon_w = _G["VoidStorageWithdrawButton"..i.."IconTexture"]

		_G["VoidStorageDepositButton"..i.."Bg"]:Hide()
		_G["VoidStorageWithdrawButton"..i.."Bg"]:Hide()

		button_d:StyleButton()
		button_d:SetTemplate("Default")
		button_d.IconBorder:Kill()

		button_w:StyleButton()
		button_w:SetTemplate("Default")
		button_w.IconBorder:Kill()

		icon_d:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon_d:ClearAllPoints()
		icon_d:SetPoint("TOPLEFT", 2, -2)
		icon_d:SetPoint("BOTTOMRIGHT", -2, 2)

		icon_w:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon_w:ClearAllPoints()
		icon_w:SetPoint("TOPLEFT", 2, -2)
		icon_w:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, 80 do
		local button = _G["VoidStorageStorageButton"..i]
		local icon = _G["VoidStorageStorageButton"..i.."IconTexture"]

		_G["VoidStorageStorageButton"..i.."Bg"]:Hide()

		button:StyleButton()
		button:SetTemplate("Default")
		button.IconBorder:Kill()

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", 2, -2)
		icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	for i = 1, 2 do
		local tab = VoidStorageFrame["Page"..i]

		tab:GetRegions():Hide()
		tab:GetNormalTexture():ClearAllPoints()
		tab:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
		tab:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
		tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()

		tab:StyleButton(true)

		if i == 1 then
			tab:SetPoint("TOPLEFT", VoidStorageFrame, "TOPRIGHT", 1, 0)
		end
	end
end

T.SkinFuncs["Blizzard_VoidStorageUI"] = LoadSkin