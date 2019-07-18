local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true or C.skins.clique ~= true then return end

----------------------------------------------------------------------------------------
--	Clique skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if not IsAddOnLoaded("Clique") then return end
	CliqueConfig:StripTextures()
	CliqueConfig:SetTemplate("Transparent")

	CliqueConfigPage1Column1:StripTextures()
	CliqueConfigPage1Column2:StripTextures()
	CliqueConfigInset:StripTextures()
	CliqueConfigPage1_VSlider:StripTextures()

	CliqueClickGrabber:StripTextures()
	CliqueClickGrabber:CreateBackdrop("Overlay")
	CliqueClickGrabber.backdrop:SetPoint("TOPLEFT", -1, 0)
	CliqueClickGrabber.backdrop:SetPoint("BOTTOMRIGHT", 2, 3)

	CliqueDialog:StripTextures()
	CliqueDialog:SetTemplate("Transparent")

	T.SkinCloseButton(CliqueConfigCloseButton)
	if CliqueDialog.CloseButton then T.SkinCloseButton(CliqueDialog.CloseButton) end
	if CliqueDialogCloseButton then T.SkinCloseButton(CliqueDialogCloseButton) end

	CliqueConfigPage1ButtonOptions:SkinButton(true)
	CliqueConfigPage1ButtonOther:SkinButton(true)
	CliqueConfigPage1ButtonSpell:SkinButton(true)
	CliqueConfigPage2ButtonBinding:SkinButton()
	CliqueConfigPage2ButtonSave:SkinButton(true)
	CliqueConfigPage2ButtonCancel:SkinButton(true)
	CliqueDialogButtonBinding:SkinButton()
	CliqueDialogButtonAccept:SkinButton()

	CliqueSpellTab:GetRegions():SetSize(0.1, 0.1)
	CliqueSpellTab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
	CliqueSpellTab:GetNormalTexture():ClearAllPoints()
	CliqueSpellTab:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	CliqueSpellTab:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	CliqueSpellTab:CreateBackdrop("Default")
	CliqueSpellTab.backdrop:SetAllPoints()
	CliqueSpellTab:StyleButton()

	CliqueConfigPage1:SetScript("OnShow", function()
		for i = 1, 12 do
			if _G["CliqueRow"..i] then
				_G["CliqueRow"..i.."Icon"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["CliqueRow"..i.."Bind"]:ClearAllPoints()
				if _G["CliqueRow"..i] == CliqueRow1 then
					_G["CliqueRow"..i.."Bind"]:SetPoint("RIGHT", _G["CliqueRow"..i], 8, 0)
				else
					_G["CliqueRow"..i.."Bind"]:SetPoint("RIGHT", _G["CliqueRow"..i], -8, 0)
				end
			end
		end
		CliqueRow1:ClearAllPoints()
		CliqueRow1:SetPoint("TOPLEFT", 5, -(CliqueConfigPage1Column1:GetHeight() + 3))
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)