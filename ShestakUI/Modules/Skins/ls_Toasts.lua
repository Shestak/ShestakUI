local T, C, L, _ = unpack(select(2, ...))
if C.skins.ls_toasts ~= true then return end
if not IsAddOnLoaded("ls_Toasts") then return end
local toast_F = unpack(ls_Toasts)

----------------------------------------------------------------------------------------
--	ls:Toasts skin
----------------------------------------------------------------------------------------

function toast_F:SkinToast(toast, toastType)
	toast:SetFrameStrata("DIALOG")
	toast.Border:SetAlpha(0)
	toast:SetTemplate("Default")
	toast.BG:SetAlpha(0.9)
	toast.BG:SetPoint("TOPLEFT", toast, 0, 0)
	toast.BG:SetPoint("BOTTOMRIGHT", toast, 0, 0)
	
	if toast.Level then toast.Level:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME") end
	if toast.Count then
		toast.Count:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME")
		toast.CountUpdate:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME")
	end
	if toast.Points then toast.Points:SetFont(C.media.pixel_font, 8, "OUTLINEMONOCHROME") end
	
	if toastType	 == "mission" or toastType == "follower" then return end
	if toast.IconBorder then
		if toastType	 == "misc" then
			local texture = toast.BG:GetTexture()
			if texture == "Interface\\AddOns\\ls_Toasts\\media\\toast-bg-archaeology" then return end
		end
		toast.IconBorder:Hide()
		toast:CreateBackdrop("Default")
		toast.backdrop:SetPoint("TOPLEFT", toast.IconBorder, 1, -1)
		toast.backdrop:SetPoint("BOTTOMRIGHT", toast.IconBorder, -1, 1)
		toast.backdrop:SetBackdropColor(0, 0, 0, 0)
		r, g, b = toast.IconBorder:GetVertexColor()
		toast.backdrop:SetBackdropBorderColor(r, g, b, 1)
		toast.backdrop:SetFrameStrata("FULLSCREEN")
		if toast.Icon then
			toast.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			toast.Icon:SetPoint("TOPLEFT", toast.IconBorder, 2, -2)
			toast.Icon:SetPoint("BOTTOMRIGHT", toast.IconBorder, -2, 2)
		end
	end
end
