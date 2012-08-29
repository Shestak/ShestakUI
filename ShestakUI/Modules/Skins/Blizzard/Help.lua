local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Help skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"HelpFrameLeftInset",
		"HelpFrameMainInset",
		"HelpFrameKnowledgebase",
		"HelpFrameKnowledgebaseErrorFrame",
		"ReportPlayerNameDialogCommentFrame",
		"ReportCheatingDialogCommentFrame"
	}

	local buttons = {
		"HelpFrameAccountSecurityOpenTicket",
		"HelpFrameOpenTicketHelpTopIssues",
		"HelpFrameOpenTicketHelpOpenTicket",
		"HelpFrameKnowledgebaseSearchButton",
		"HelpFrameKnowledgebaseNavBarHomeButton",
		"HelpFrameCharacterStuckStuck",
		"GMChatOpenLog",
		"HelpFrameTicketSubmit",
		"HelpFrameTicketCancel",
		"HelpFrameGM_ResponseNeedMoreHelp",
		"HelpFrameGM_ResponseCancel",
		"HelpFrameSubmitSuggestionSubmit",
		"HelpFrameReportBugSubmit",
		"HelpFrameButton16",
		"ReportCheatingDialogCancelButton",
		"ReportCheatingDialogReportButton",
		"ReportPlayerNameDialogReportButton",
		"ReportPlayerNameDialogCancelButton"
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

	HelpFrameTicketScrollFrame:StripTextures()
	HelpFrameTicketScrollFrame:CreateBackdrop("Overlay")
	HelpFrameTicketScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
	HelpFrameTicketScrollFrame.backdrop:Point("BOTTOMRIGHT", 6, -4)

	for i = 1, HelpFrameTicket:GetNumChildren() do
		local child = select(i, HelpFrameTicket:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	HelpFrameReportBugScrollFrame:StripTextures()
	HelpFrameReportBugScrollFrame:CreateBackdrop("Overlay")
	HelpFrameReportBugScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
	HelpFrameReportBugScrollFrame.backdrop:Point("BOTTOMRIGHT", 6, -4)
	HelpFrameReportBugScrollFrame:ClearAllPoints()
	HelpFrameReportBugScrollFrame:Point("BOTTOM", HelpFrameReportBugSubmit, "TOP", 0, 10)

	for i = 1, HelpFrameReportBug:GetNumChildren() do
		local child = select(i, HelpFrameReportBug:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	HelpFrameSubmitSuggestionScrollFrame:StripTextures()
	HelpFrameSubmitSuggestionScrollFrame:CreateBackdrop("Overlay")
	HelpFrameSubmitSuggestionScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
	HelpFrameSubmitSuggestionScrollFrame.backdrop:Point("BOTTOMRIGHT", 6, -4)

	for i = 1, HelpFrameSubmitSuggestion:GetNumChildren() do
		local child = select(i, HelpFrameSubmitSuggestion:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	T.SkinScrollBar(HelpFrameKnowledgebaseScrollFrame2ScrollBar)

	-- Sub buttons
	for i = 1, #buttons do
		local b = _G[buttons[i]]

		b:SkinButton(false)

		if b.text then
			b.text:SetFont(C.media.normal_font, 13)
		end
	end

	-- Main buttons
	for i = 1, 6 do
		local b = _G["HelpFrameButton"..i]
		local t = _G["HelpFrameButton"..i.."Selected"]

		b:SkinButton(false)

		b.text:SetFont(C.media.normal_font, 13)

		if t then
			t:SetTexture(T.color.r, T.color.g, T.color.b, 0.3)
			t:Point("TOPLEFT", b, 2, -2)
			t:Point("BOTTOMRIGHT", b, -2, 2)
		end
	end

	-- Table options
	for i = 1, HelpFrameKnowledgebaseScrollFrameScrollChild:GetNumChildren() do
		local b = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]

		b:StripTextures(true)
		b:SkinButton(true)
	end

	-- Misc items
	HelpFrameKnowledgebaseSearchBox:ClearAllPoints()
	HelpFrameKnowledgebaseSearchBox:Point("TOPLEFT", HelpFrameMainInset, "TOPLEFT", 13, -10)
	HelpFrameKnowledgebaseNavBarHomeButton:ClearAllPoints()
	HelpFrameKnowledgebaseNavBarHomeButton:Point("TOPLEFT", HelpFrameKnowledgebaseSearchBox, "BOTTOMLEFT", -2, -10)
	HelpFrameKnowledgebaseNavBarOverlay:Kill()
	HelpFrameKnowledgebaseNavBar:StripTextures()
	HelpFrame:StripTextures(true)
	HelpFrame:CreateBackdrop("Transparent")
	T.SkinEditBox(HelpFrameKnowledgebaseSearchBox)
	T.SkinScrollBar(HelpFrameKnowledgebaseScrollFrameScrollBar)
	T.SkinScrollBar(HelpFrameTicketScrollFrameScrollBar)
	T.SkinCloseButton(HelpFrameCloseButton, HelpFrame.backdrop)
	T.SkinCloseButton(HelpFrameKnowledgebaseErrorFrameCloseButton, HelpFrameKnowledgebaseErrorFrame.backdrop)

	-- Hearth Stone Button
	HelpFrameCharacterStuckHearthstone:StyleButton()
	HelpFrameCharacterStuckHearthstone:SetTemplate("Default")
	HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("TOPLEFT", 2, -2)
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("BOTTOMRIGHT", -2, 2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	-- Report frames
	ReportPlayerNameDialog:StripTextures()
	ReportPlayerNameDialog:CreateBackdrop("Transparent")
	ReportCheatingDialog:StripTextures()
	ReportCheatingDialog:CreateBackdrop("Transparent")

	local function navButtonFrameLevel(self)
		for i = 1, #self.navList do
			local navButton = self.navList[i]
			local lastNav = self.navList[i-1]

			if navButton and lastNav then
				navButton:SetFrameLevel(lastNav:GetFrameLevel() - 2)
				navButton:ClearAllPoints()
				navButton:Point("LEFT", lastNav, "RIGHT", 3, 0)
			end
		end
	end

	hooksecurefunc("NavBar_AddButton", function(self, buttonData)
		local navButton = self.navList[#self.navList]

		if not navButton.skinned then
			navButton:SkinButton(true)
			navButton.skinned = true

			navButton:HookScript("OnClick", function()
				navButtonFrameLevel(self)
			end)
		end

		navButtonFrameLevel(self)
	end)

	for i = 1, HelpFrameGM_Response:GetNumChildren() do
		local child = select(i, HelpFrameGM_Response:GetChildren())
		if child and child:GetObjectType() == "Frame" and not child:GetName() then
			child:SetTemplate("Overlay")
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)