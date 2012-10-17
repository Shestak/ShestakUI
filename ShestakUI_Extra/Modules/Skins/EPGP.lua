local T, C, L, _ = unpack(ShestakUI)
if C.extra_skins.epgp ~= true then return end

----------------------------------------------------------------------------------------
--	EPGP skin(Not Ready)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("epgp") then return end

	local StripAllTextures = {
		"EPGPFrame",
		"EPGPSideFrame",
		"EPGPSideFrame2",
		"EPGPLogFrame",
		"EPGPExportImportFrame",
		"EPGPScrollFrameScrollBarBorder"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	EPGPFrame:CreateBackdrop("Transparent")
	EPGPFrame.backdrop:SetPoint("TOPLEFT", 10, 0)
	EPGPFrame.backdrop:SetPoint("BOTTOMRIGHT", -35, 70)

	EPGPLogFrame:CreateBackdrop("Transparent")
	EPGPLogFrame.backdrop:SetPoint("TOPLEFT", 5, 6)
	EPGPLogFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)

	EPGPSideFrame:CreateBackdrop("Transparent")
	EPGPSideFrame.backdrop:SetPoint("TOPLEFT", 1, 0)
	EPGPSideFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

	EPGPSideFrame2:CreateBackdrop("Transparent")
	EPGPSideFrame2.backdrop:SetPoint("TOPLEFT", 1, 0)
	EPGPSideFrame2.backdrop:SetPoint("BOTTOMRIGHT", 0, -2)

	EPGPExportImportFrame:SetTemplate("Transparent")

	T.SkinDropDownBox(EPGPSideFrameEPControlDropDown, 180)
	T.SkinDropDownBox(EPGPSideFrameGPControlDropDown, 180)
	T.SkinDropDownBox(EPGPSideFrame2EPControlDropDown, 180)

	T.SkinEditBox(EPGPSideFrameEPControlEditBox)
	T.SkinEditBox(EPGPSideFrame2EPControlEditBox)
	T.SkinEditBox(EPGPSideFrameGPControlEditBox)
	T.SkinEditBox(EPGPSideFrameEPControlOtherEditBox)
	T.SkinEditBox(EPGPSideFrame2EPControlOtherEditBox)

	for i = 1, EPGPFrame:GetNumChildren() do
		local child = select(i, EPGPFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child, EPGPFrame.backdrop)
		end
	end

	for i = 1, EPGPSideFrame:GetNumChildren() do
		local child = select(i, EPGPSideFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child)
		end
	end

	for i = 1, EPGPSideFrame2:GetNumChildren() do
		local child = select(i, EPGPSideFrame2:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child)
		end
	end

	for i = 1, EPGPLogFrame:GetNumChildren() do
		local child = select(i, EPGPLogFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() and not child:GetText() then
			T.SkinCloseButton(child, EPGPLogFrame.backdrop)
		elseif child:GetObjectType() == "Button" and child:GetText() then
			child:SkinButton()
		end
	end
end)