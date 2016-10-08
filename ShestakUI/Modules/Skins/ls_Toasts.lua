local T, C, L, _ = unpack(select(2, ...))
if C.skins.ls_toasts ~= true then return end
if not IsAddOnLoaded("ls_Toasts") then return end
local toast_F = unpack(ls_Toasts)

----------------------------------------------------------------------------------------
--	ls:Toasts skin
----------------------------------------------------------------------------------------

function toast_F:SkinToast(toast, toastType)
	r, g, b, alpha = toast.Border:GetVertexColor()
	toast:SetTemplate("Default")
	toast:SetBackdropBorderColor(r, g, b, 1)
	toast:SetFrameStrata("DIALOG")
	toast.Border:SetAlpha(0)
	toast.BG:SetPoint("TOPLEFT", toast, 0, 0)
	toast.BG:SetPoint("BOTTOMRIGHT", toast, 1, 1)
	if toast.IconBorder then
		local texture = toast.BG:GetTexture()
	    if texture ~= "Interface\\AddOns\\ls_Toasts\\media\\toast-bg-archaeology" then
			toast.IconBorder:Hide()
			toast.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			toast.Icon:SetPoint("TOPLEFT", toast.IconBorder, 2, -2)
			toast.Icon:SetPoint("BOTTOMRIGHT", toast.IconBorder, -2, 2)
			toast:CreateBackdrop("Default")
			toast.backdrop:SetPoint("TOPLEFT", toast.IconBorder, 1, -1)
			toast.backdrop:SetPoint("BOTTOMRIGHT", toast.IconBorder, -1, 1)
			toast.backdrop:SetBackdropColor(r, g, b, 0)
			toast.backdrop:SetBackdropBorderColor(r, g, b, 1)
			toast.backdrop:SetFrameStrata("FULLSCREEN")
		end
	end
	if toast.Count then
		toast.Count:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME")
		toast.CountUpdate:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME")
	end
end
