local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Help skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"HelpFrameLeftInset",
		"HelpFrameMainInset",
		"HelpFrameKnowledgebase",
		"HelpFrameKnowledgebaseErrorFrame"
	}

	local buttons = {
		"HelpFrameAccountSecurityOpenTicket",
		"HelpFrameOpenTicketHelpOpenTicket",
		"HelpFrameKnowledgebaseSearchButton",
		"HelpFrameKnowledgebaseNavBarHomeButton",
		"HelpFrameCharacterStuckStuck",
		"HelpFrameGM_ResponseNeedMoreHelp",
		"HelpFrameGM_ResponseCancel",
		"HelpFrameSubmitSuggestionSubmit",
		"HelpFrameReportBugSubmit",
		"HelpFrameButton16",
		"GMChatOpenLog"
	}

	HelpFrameKnowledgebaseNavBarHomeButton:StripTextures(false)

	-- Main frames
	for i = 1, #frames do
		_G[frames[i]]:StripTextures(true)
		_G[frames[i]]:CreateBackdrop("Overlay")
	end

	HelpFrameHeader:StripTextures(true)
	HelpFrameHeader:SetFrameLevel(HelpFrameHeader:GetFrameLevel() + 2)
	HelpFrameKnowledgebaseErrorFrame:SetFrameLevel(HelpFrameKnowledgebaseErrorFrame:GetFrameLevel() + 2)

	HelpFrameReportBugScrollFrame:StripTextures()
	HelpFrameReportBugScrollFrame:CreateBackdrop("Overlay")
	HelpFrameReportBugScrollFrame.backdrop:SetPoint("TOPLEFT", -4, 4)
	HelpFrameReportBugScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 6, -4)
	HelpFrameReportBugScrollFrame:ClearAllPoints()
	HelpFrameReportBugScrollFrame:SetPoint("BOTTOM", HelpFrameReportBugSubmit, "TOP", 0, 10)

	for i = 1, HelpFrameReportBug:GetNumChildren() do
		local child = select(i, HelpFrameReportBug:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	HelpFrameSubmitSuggestionScrollFrame:StripTextures()
	HelpFrameSubmitSuggestionScrollFrame:CreateBackdrop("Overlay")
	HelpFrameSubmitSuggestionScrollFrame.backdrop:SetPoint("TOPLEFT", -4, 4)
	HelpFrameSubmitSuggestionScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 6, -4)

	for i = 1, HelpFrameSubmitSuggestion:GetNumChildren() do
		local child = select(i, HelpFrameSubmitSuggestion:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	T.SkinScrollBar(HelpFrameKnowledgebaseScrollFrame2ScrollBar)
	T.SkinScrollBar(HelpFrameReportBugScrollFrameScrollBar)
	T.SkinScrollBar(HelpFrameSubmitSuggestionScrollFrameScrollBar)

	-- Sub buttons
	for i = 1, #buttons do
		local b = _G[buttons[i]]
		local t = _G[buttons[i].."Selected"]

		b:SkinButton()

		if b.text then
			b.text:SetFont(C.media.normal_font, 13)
		end

		if t then
			t:SetColorTexture(T.color.r, T.color.g, T.color.b, 0.3)
			t:SetPoint("TOPLEFT", b, 2, -2)
			t:SetPoint("BOTTOMRIGHT", b, -2, 2)
		end
	end

	-- Main buttons
	for i = 1, 6 do
		local b = _G["HelpFrameButton"..i]
		local t = _G["HelpFrameButton"..i.."Selected"]

		b:SkinButton()
		b.text:SetFont(C.media.normal_font, 13)

		if t then
			t:SetColorTexture(T.color.r, T.color.g, T.color.b, 0.3)
			t:SetPoint("TOPLEFT", b, 2, -2)
			t:SetPoint("BOTTOMRIGHT", b, -2, 2)
		end
	end

	-- Table options
	for i = 1, HelpFrameKnowledgebaseScrollFrameScrollChild:GetNumChildren() do
		local b = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]

		b:StripTextures(true)
		b:SkinButton(true)
	end

	-- Help Browser
	T.SkinRotateButton(HelpBrowserNavHome)
	T.SkinNextPrevButton(HelpBrowserNavBack)
	T.SkinNextPrevButton(HelpBrowserNavForward)
	T.SkinRotateButton(HelpBrowserNavReload)
	T.SkinRotateButton(HelpBrowserNavStop)
	T.SkinRotateButton(HelpBrowserBrowserSettings)

	HelpBrowserNavBack:SetSize(18, 18)
	HelpBrowserNavForward:SetSize(18, 18)

	HelpBrowserNavHome:SetPoint("BOTTOMLEFT", HelpBrowser, "TOPLEFT", 1, 5)
	HelpBrowserBrowserSettings:SetPoint("TOPRIGHT", HelpFrameCloseButton, "BOTTOMLEFT", -4, -1)
	LoadingIcon:ClearAllPoints()
	LoadingIcon:SetPoint("LEFT", HelpBrowserNavStop, "RIGHT")

	BrowserSettingsTooltip:StripTextures()
	BrowserSettingsTooltip:CreateBackdrop("Transparent")
	BrowserSettingsTooltip.CacheButton:SkinButton()
	BrowserSettingsTooltip.CookiesButton:SkinButton()

	-- Misc items
	HelpFrameKnowledgebaseSearchBox:ClearAllPoints()
	HelpFrameKnowledgebaseSearchBox:SetPoint("TOPLEFT", HelpFrameMainInset, "TOPLEFT", 13, -10)
	HelpFrameKnowledgebaseNavBarHomeButton:ClearAllPoints()
	HelpFrameKnowledgebaseNavBarHomeButton:SetPoint("TOPLEFT", HelpFrameKnowledgebaseSearchBox, "BOTTOMLEFT", -2, -10)
	HelpFrameKnowledgebaseNavBar:StripTextures()
	HelpFrame:StripTextures(true)
	HelpFrame:CreateBackdrop("Transparent")
	T.SkinEditBox(HelpFrameKnowledgebaseSearchBox)
	T.SkinScrollBar(HelpFrameKnowledgebaseScrollFrameScrollBar)
	T.SkinCloseButton(HelpFrameCloseButton, HelpFrame.backdrop)
	T.SkinCloseButton(HelpFrameKnowledgebaseErrorFrameCloseButton, HelpFrameKnowledgebaseErrorFrame.backdrop)

	-- Hearth Stone Button
	HelpFrameCharacterStuckHearthstone:StyleButton()
	HelpFrameCharacterStuckHearthstone:SetTemplate("Default")
	HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
	HelpFrameCharacterStuckHearthstone.IconTexture:SetPoint("TOPLEFT", 2, -2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	HelpFrameCharacterStuckHearthstone.SetHighlightTexture = T.dummy

	for i = 1, HelpFrameGM_Response:GetNumChildren() do
		local child = select(i, HelpFrameGM_Response:GetChildren())
		if child and child:GetObjectType() == "Frame" and not child:GetName() then
			child:SetTemplate("Overlay")
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)