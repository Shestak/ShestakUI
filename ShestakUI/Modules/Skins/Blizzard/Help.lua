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
	}

	local buttons = {
		"HelpFrameAccountSecurityOpenTicket",
		"HelpFrameReportLagLoot",
		"HelpFrameReportLagAuctionHouse",
		"HelpFrameReportLagMail",
		"HelpFrameReportLagMovement",
		"HelpFrameReportLagSpell",
		"HelpFrameReportLagChat",
		"HelpFrameReportAbuseOpenTicket",
		"HelpFrameOpenTicketHelpTopIssues",
		"HelpFrameOpenTicketHelpOpenTicket",
		"HelpFrameKnowledgebaseSearchButton",
		"HelpFrameKnowledgebaseNavBarHomeButton",
		"HelpFrameCharacterStuckStuck",
		"GMChatOpenLog",
		"HelpFrameTicketSubmit",
		"HelpFrameTicketCancel",
	}

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

	T.SkinScrollBar(HelpFrameKnowledgebaseScrollFrame2ScrollBar)

	-- Sub buttons
	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures(true)
		_G[buttons[i]]:SkinButton(true)

		if _G[buttons[i]].text then
			_G[buttons[i]].text:ClearAllPoints()
			_G[buttons[i]].text:SetPoint("CENTER")
			_G[buttons[i]].text:SetJustifyH("CENTER")
		end
	end

	-- Main buttons
	for i = 1, 6 do
		local b = _G["HelpFrameButton"..i]
		b:SkinButton(true)
		b.text:ClearAllPoints()
		b.text:SetPoint("CENTER")
		b.text:SetJustifyH("CENTER")
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
	HelpFrameCharacterStuckHearthstone:SetTemplate("Default", true)
	HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("TOPLEFT", 2, -2)
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("BOTTOMRIGHT", -2, 2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)

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

	HelpFrameGM_ResponseNeedMoreHelp:SkinButton()
	HelpFrameGM_ResponseCancel:SkinButton()
	for i = 1, HelpFrameGM_Response:GetNumChildren() do
		local child = select(i, HelpFrameGM_Response:GetChildren())
		if child and child:GetObjectType() == "Frame" and not child:GetName() then
			child:SetTemplate("Overlay")
		end
	end
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)