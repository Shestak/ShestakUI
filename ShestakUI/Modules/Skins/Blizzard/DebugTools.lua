local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DebugTools skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if EventTraceFrame then
		EventTraceFrame:StripTextures()
		EventTraceFrame:SetTemplate("Transparent")
		T.SkinCloseButton(EventTraceFrameCloseButton)
		EventTraceFrameScrollBG:SetTexture(nil)

		local scroll = EventTraceFrameScroll
		scroll:GetThumbTexture():SetTexture(nil)
		scroll.thumbbg = CreateFrame("Frame", nil, scroll)
		scroll.thumbbg:SetPoint("TOPLEFT", scroll:GetThumbTexture(), "TOPLEFT", 1, 0)
		scroll.thumbbg:SetPoint("BOTTOMRIGHT", scroll:GetThumbTexture(), "BOTTOMRIGHT", 3, -2)
		scroll.thumbbg:SetTemplate("Overlay")

		EventTraceTooltip:HookScript("OnShow", function(self)
			self:SetTemplate("Transparent")
		end)
	else
		-- TODO: add new skin
		-- EventTrace
	end

	FrameStackTooltip:HookScript("OnShow", function(self)
		self:SetTemplate("Transparent")
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