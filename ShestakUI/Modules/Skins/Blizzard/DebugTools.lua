local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DebugTools skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ScriptErrorsFrame:SetParent(UIParent)
	ScriptErrorsFrame:SetTemplate("Transparent")
	ScriptErrorsFrame.Reload:SkinButton()
	ScriptErrorsFrame.Close:SkinButton()
	T.SkinNextPrevButton(ScriptErrorsFrame.PreviousError, true)
	T.SkinNextPrevButton(ScriptErrorsFrame.NextError)
	T.SkinScrollBar(ScriptErrorsFrameScrollBar)
	T.SkinCloseButton(ScriptErrorsFrameClose)
	ScriptErrorsFrame.ScrollFrame:CreateBackdrop("Overlay")
	ScriptErrorsFrame.ScrollFrame:SetHeight(ScriptErrorsFrame:GetHeight() - 71)

	local texs = {
		"TopLeft",
		"TopRight",
		"Top",
		"BottomLeft",
		"BottomRight",
		"Bottom",
		"Left",
		"Right",
		"TitleBG",
		"DialogBG"
	}

	for i = 1, #texs do
		_G["ScriptErrorsFrame"..texs[i]]:SetTexture(nil)
		_G["EventTraceFrame"..texs[i]]:SetTexture(nil)
	end

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

	FrameStackTooltip:HookScript("OnShow", function(self)
		self:SetTemplate("Transparent")
	end)
end

T.SkinFuncs["Blizzard_DebugTools"] = LoadSkin