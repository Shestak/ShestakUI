local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DebugTools skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	FrameStackTooltip:HookScript("OnShow", function(self)
		if T.newPatch then -- TODO: detete in new patch
			self.NineSlice:SetTemplate("Transparent")
		else
			self:SetTemplate("Transparent")
		end
	end)
end

T.SkinFuncs["Blizzard_DebugTools"] = LoadSkin

local function LoadSecondarySkin()
	ScriptErrorsFrame:SetParent(UIParent)
	ScriptErrorsFrame:SetSize(400, 280)
	ScriptErrorsFrame:StripTextures()
	ScriptErrorsFrame:SetTemplate("Transparent")
	ScriptErrorsFrame.Reload:SkinButton()
	ScriptErrorsFrame.Close:SkinButton()

	T.SkinNextPrevButton(ScriptErrorsFrame.PreviousError, true)
	T.SkinNextPrevButton(ScriptErrorsFrame.NextError)
	T.SkinScrollBar(ScriptErrorsFrameScrollBar)
	T.SkinCloseButton(ScriptErrorsFrameClose)

	ScriptErrorsFrame.ScrollFrame:CreateBackdrop("Overlay")
	ScriptErrorsFrame.ScrollFrame:SetSize(ScriptErrorsFrame:GetWidth() - 45, ScriptErrorsFrame:GetHeight() - 72)
	ScriptErrorsFrame.ScrollFrame.Text:SetFont(C.media.normal_font, 12)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSecondarySkin)