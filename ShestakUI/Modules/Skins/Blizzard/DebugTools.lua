local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DebugTools skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ScriptErrorsFrame:SetParent(UIParent)
	ScriptErrorsFrame:SetTemplate("Transparent")
	EventTraceFrame:SetTemplate("Transparent")
	T.SkinCloseButton(ScriptErrorsFrameClose)
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

	for i = 1, ScriptErrorsFrame:GetNumChildren() do
		local child = select(i, ScriptErrorsFrame:GetChildren())
		if child:GetObjectType() == "Button" and not child:GetName() then
			child:SkinButton()
		end
	end
end

T.SkinFuncs["Blizzard_DebugTools"] = LoadSkin