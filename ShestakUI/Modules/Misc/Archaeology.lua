local T, C, L, _ = unpack(select(2, ...))
if C.misc.archaeology ~= true or IsAddOnLoaded("stArchaeologist") then return end

----------------------------------------------------------------------------------------
--	Archaeology tracker(stArchaeologist by Safturento)
----------------------------------------------------------------------------------------
local stArch = {}
stArch["archSkill"] = {}	-- Archaeology skill level
stArch["progressBars"] = {}	-- Status bars for artifacts
stArch["artifactInfo"] = {}	-- Information to update bars

local numRaces = 20
local Loaded = false

function stArch:OnLoad(self)
	if SavedOptionsPerChar == nil then SavedOptionsPerChar = {} end
	if SavedOptionsPerChar.Archaeology == false then self:Hide() end
	-- Title Bar
	stArch["title"] = CreateFrame("Frame", "ArchTitleFrame", self)
	stArch["title"]:SetWidth(self:GetWidth() - 10)
	stArch["title"]:SetHeight(19)
	stArch["title"]:SetPoint("TOP", self, "TOP", 0, 0)
	stArch["title"]["text"] = stArch["title"]:CreateFontString()
	stArch["title"]["text"]:SetPoint("CENTER", stArch["title"], "CENTER", 0, 0)
	stArch["title"]["text"]:SetJustifyH("CENTER")
	stArch["title"]["text"]:SetJustifyV("CENTER")
	stArch["title"]["text"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	stArch["title"]["text"]:SetText(PROFESSIONS_ARCHAEOLOGY)

	-- Close button
	stArch["close"] = CreateFrame("Button", "ArchCloseButton", self)
	T.SkinCloseButton(stArch["close"], nil, nil, true)
	stArch["close"]:SetWidth(12)
	stArch["close"]:SetHeight(12)
	stArch["close"]:SetScript("OnMouseUp", function() self:Hide() SavedOptionsPerChar.Archaeology = false end)

	-- Artifact Progress Bars
	local progressBars = stArch["progressBars"]

	progressBars["frame"] = CreateFrame("Frame", "ArchBarFrame", self)
	progressBars["frame"]:SetHeight(200)
	progressBars["frame"]:SetWidth(self:GetWidth() - 8)
	progressBars["frame"]:SetPoint("TOP", stArch["title"], "BOTTOM", 0, 0)
	progressBars["frame"]:SetTemplate("Overlay")
	for i = 1, numRaces do
		-- Fill Table
		progressBars[i] = {}
		progressBars[i]["border"] = CreateFrame("Frame", "ArchBar"..i.."Border", progressBars["frame"])
		progressBars[i]["bar"] = CreateFrame("StatusBar", "ArchBar"..i, progressBars[i]["border"], "TextStatusBar")
		progressBars[i]["race"] = progressBars[i]["bar"]:CreateFontString()
		progressBars[i]["progress"] = progressBars[i]["bar"]:CreateFontString()
		progressBars[i]["solve"] = CreateFrame("Button", "ArchBar"..i, self)

		-- Border
		progressBars[i]["border"]:SetWidth(progressBars["frame"]:GetWidth() - 10)
		progressBars[i]["border"]:SetHeight(16)
		progressBars[i]["border"]:SetTemplate("Overlay")
		if i == 1 then
			progressBars[i]["border"]:SetPoint("TOP", progressBars["frame"], "TOP", 0, -5)
		else
			progressBars[i]["border"]:SetPoint("TOP", progressBars[i-1]["border"], "BOTTOM", 0, -5)
		end

		-- Bar
		progressBars[i]["bar"]:SetStatusBarTexture(C.media.texture)
		progressBars[i]["bar"]:SetPoint("TOPRIGHT", progressBars[i]["border"], "TOPRIGHT", -2, -2)
		progressBars[i]["bar"]:SetPoint("BOTTOMLEFT", progressBars[i]["border"], "BOTTOMLEFT", 2, 2)
		progressBars[i]["bar"]:SetStatusBarColor(0.4, 0.4, 0.4)
		progressBars[i]["bar"]:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -2, 7)
			GameTooltip:ClearLines()
			if GetNumArtifactsByRace(i) > 0 then
				SetSelectedArtifact(i)
				local artifactName, artifactDescription, artifactRarity, _, _, keystoneCount = GetSelectedArtifactInfo()
				local numFragmentsCollected, _, numFragmentsRequired = GetArtifactProgress()
				local r, g, b
				if artifactRarity == 1 then
					artifactRarity = ITEM_QUALITY3_DESC
					r, g, b = GetItemQualityColor(3)
				else
					artifactRarity = ITEM_QUALITY1_DESC
					r, g, b = GetItemQualityColor(1)
				end
				GameTooltip:AddLine(artifactName, r, g, b, 1)
				GameTooltip:AddLine(artifactRarity, r, g, b, r, g, b)
				GameTooltip:AddDoubleLine(ARCHAEOLOGY_RUNE_STONES..": "..numFragmentsCollected.."/"..numFragmentsRequired, "Keystones: "..keystoneCount, 1, 1, 1, 1, 1, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(artifactDescription, 1, 1, 1, 1)
				GameTooltip:Show()
			end
		end)
		progressBars[i]["bar"]:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		-- Progress Text
		progressBars[i]["progress"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		progressBars[i]["progress"]:SetText("")
		progressBars[i]["progress"]:SetPoint("RIGHT", progressBars[i]["bar"], "RIGHT", 1, 0)

		-- Race Text
		progressBars[i]["race"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		progressBars[i]["race"]:SetText(RACE)
		progressBars[i]["race"]:SetPoint("LEFT", progressBars[i]["bar"], "LEFT", 2, 0)
		progressBars[i]["race"]:SetPoint("RIGHT", progressBars[i]["progress"], "LEFT", -2, 0)
		progressBars[i]["race"]:SetWordWrap(false)
		progressBars[i]["race"]:SetJustifyH("LEFT")
	end

	-------------------------------------------------------------
	-- Archaeology Skill Level Frame
	local archSkill = stArch["archSkill"]
	archSkill["frame"] = CreateFrame("Frame", "ArchSkillFrame", self)
	archSkill["bar"] = CreateFrame("StatusBar", "ArchSkillBar", archSkill["frame"], "TextStatusbar")
	archSkill["text"] = archSkill["bar"]:CreateFontString()

	-- Border
	archSkill["frame"]:SetHeight(24)
	archSkill["frame"]:SetWidth(self:GetWidth() - 8)
	archSkill["frame"]:SetPoint("TOP", progressBars["frame"], "BOTTOM", 0, -3)
	archSkill["frame"]:SetTemplate("Overlay")

	-- StatusBar
	archSkill["bar"]:SetStatusBarTexture(C.media.texture)
	archSkill["bar"]:SetPoint("TOPRIGHT", archSkill["frame"], "TOPRIGHT", -2, -2)
	archSkill["bar"]:SetPoint("BOTTOMLEFT", archSkill["frame"], "BOTTOMLEFT", 2, 2)
	archSkill["bar"]:SetStatusBarColor(0, 0.4, 0.8)
	archSkill["bar"]:SetScript("OnMouseUp", function()
		if IsAddOnLoaded("Blizzard_ArchaeologyUI") then
			ToggleFrame(ArchaeologyFrame)
		else
			local loaded = LoadAddOn("Blizzard_ArchaeologyUI")
			if loaded then
				ShowUIPanel(ArchaeologyFrame)
			end
		end
	end)

	-- Text
	archSkill["text"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	archSkill["text"]:SetText("-")
	archSkill["text"]:SetPoint("CENTER", archSkill["bar"], "CENTER", 0, 0)

	-------------------------------------------------------------
	-- Solve Frame
	progressBars["solveFrame"] = CreateFrame("Frame", "ArchSolveFrame", self)
	progressBars["solveFrame"]:SetHeight(progressBars["frame"]:GetHeight())
	progressBars["solveFrame"]:SetWidth(85)
	progressBars["solveFrame"]:SetFrameLevel(0)
	progressBars["solveFrame"]:SetPoint("LEFT", self, "RIGHT", 1, 0)
	progressBars["solveFrame"]:SetPoint("TOP", progressBars["frame"], "TOP", 0, 0)
	progressBars["solveFrame"]:SetTemplate("Transparent")
	progressBars["solveFrame"]:Hide()
	for i = 1, numRaces do progressBars[i]["solve"]:Hide() end

	-- Solve Toggle
	progressBars["solveToggle"] = CreateFrame("Frame", "ArchSolveToggle", self)
	progressBars["solveToggle"]:SetHeight(progressBars["solveFrame"]:GetHeight())
	progressBars["solveToggle"]:SetWidth(16)
	progressBars["solveToggle"]:SetPoint("LEFT", self, "RIGHT", 1, 0)
	progressBars["solveToggle"]:SetPoint("TOP", progressBars["frame"], "TOP", 0, 0)
	progressBars["solveToggle"]:SetTemplate("Transparent")
	progressBars["solveToggle"]:SetAlpha(0)

	-- Solve Toggle Text
	progressBars["solveToggle"]["text"] = progressBars["solveToggle"]:CreateFontString()
	progressBars["solveToggle"]["text"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	progressBars["solveToggle"]["text"]:SetText(">")
	progressBars["solveToggle"]["text"]:SetPoint("CENTER", progressBars["solveToggle"], "CENTER", 1, 0)

	progressBars["solveToggle"]["closeDirection"] = "<"
	progressBars["solveToggle"]["openDirection"] = ">"

	progressBars["solveToggle"]:SetScript("OnEnter", function()
		progressBars["solveToggle"]["text"]:SetTextColor(T.color.r, T.color.g, T.color.b)
		progressBars["solveToggle"]:FadeIn()
	end)
	progressBars["solveToggle"]:SetScript("OnLeave", function()
		progressBars["solveToggle"]["text"]:SetTextColor(1, 1, 1)
		progressBars["solveToggle"]:FadeOut()
	end)
	progressBars["solveToggle"]:SetScript("OnMouseUp", function()
		if progressBars["solveFrame"]:IsShown() then
			progressBars["solveFrame"]:Hide()
			for i = 1, numRaces do progressBars[i]["solve"]:Hide() end
			progressBars["solveToggle"]["text"]:SetText(progressBars["solveToggle"]["openDirection"])
			progressBars["solveToggle"]:ClearAllPoints()
			progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["openPoint1"]))
			progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["openPoint2"]))
		else
			progressBars["solveFrame"]:Show()
			for i = 1, numRaces do progressBars[i]["solve"]:Show() end
			progressBars["solveToggle"]["text"]:SetText(progressBars["solveToggle"]["closeDirection"])
			progressBars["solveToggle"]:ClearAllPoints()
			progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["closePoint"]))
		end
	end)

	local solveFrame = stArch["progressBars"]
	for i = 1, numRaces do
		-- Button
		solveFrame[i]["solve"]:SetHeight(progressBars[i]["border"]:GetHeight())
		solveFrame[i]["solve"]:SetWidth(progressBars["solveFrame"]:GetWidth() - 10)
		solveFrame[i]["solve"]:SetPoint("LEFT", progressBars["solveFrame"], "LEFT", 5, 0)
		solveFrame[i]["solve"]:SetPoint("TOP", progressBars[i]["border"], "TOP", 0, 0)
		solveFrame[i]["solve"]:SetTemplate("Overlay")

		-- Text
		solveFrame[i]["solve"]["text"] = solveFrame[i]["solve"]:CreateFontString()
		solveFrame[i]["solve"]["text"]:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
		solveFrame[i]["solve"]["text"]:SetText(SOLVE)
		solveFrame[i]["solve"]["text"]:SetPoint("CENTER", solveFrame[i]["solve"], "CENTER", 2, 0)
	end

	-------------------------------------------------------------
	-- Construct artifact info table
	for i = 1, numRaces do
		stArch["artifactInfo"][i] = {}
	end

	Loaded = true
end

function stArch:UpdateFrameHeight(self)
	-- Update frame Sizes to fit correctly
	stArch["progressBars"]["frame"]:SetHeight(numRaces * (stArch["progressBars"][1]["border"]:GetHeight() + 5) + 5)
	stArch["progressBars"]["solveFrame"]:SetHeight(stArch["progressBars"]["frame"]:GetHeight())
	stArch["progressBars"]["solveToggle"]:SetHeight(stArch["progressBars"]["frame"]:GetHeight())
	if stArch["archSkill"]["frame"]:IsShown() then
		self:SetHeight(stArch["title"]:GetHeight() + stArch["progressBars"]["frame"]:GetHeight() + stArch["archSkill"]["frame"]:GetHeight() + 7)
	else
		self:SetHeight(stArch["title"]:GetHeight() + stArch["progressBars"]["frame"]:GetHeight() + 5)
	end
end

function IsArchaeologist()
	local _, _, arch = GetProfessions()
	if arch then
		return true
	else
		return false
	end
end

-- Update archaeology skill information
function stArch:updateSkillLevel()
	if IsArchaeologist() then
		local _, _, rank, maxRank = GetProfessionInfo(select(3, GetProfessions()))
		stArch["archSkill"]["rank"] = rank
		stArch["archSkill"]["maxRank"] = maxRank
	else
		stArch["archSkill"]["rank"] = 0
		stArch["archSkill"]["maxRank"] = 0
	end
end

-- Update a status bar to represent the skill information
function stArch:updateSkillBar()
	local skill = stArch["archSkill"]

	skill["bar"]:SetMinMaxValues(0, skill["maxRank"])
	skill["bar"]:SetValue(skill["rank"])
	skill["text"]:SetText(skill["rank"].."/"..skill["maxRank"])

	if (skill["rank"] + 5) > skill["maxRank"] and skill["rank"] ~= skill["maxRank"] then
		skill["bar"]:SetStatusBarColor(0.7, 0.2, 0)
	else
		skill["bar"]:SetStatusBarColor(0, 0.4, 0.8)
	end
end

-- Update artifact details, only keep relevant data
function stArch:updateArtifact(index)
	local numProjects = GetNumArtifactsByRace(index)
	local raceName, _, raceItemID = GetArchaeologyRaceInfo(index)
	local artifact = stArch["artifactInfo"][index]

	artifact["race"] = raceName
	artifact["keyID"] = raceItemID
	artifact["numKeystones"] = 0	-- Will dig for these in inventory later
	if numProjects == 0 then		-- The Artifact hasn"t been discovered
		artifact["numKeysockets"] = 0
		artifact["progress"] = 0
		artifact["modifier"] = 0
		artifact["total"] = 0
		artifact["canSolve"] = false
	else
		SetSelectedArtifact(index)
		local _, _, _, _, _, keystoneCount = GetSelectedArtifactInfo()
		local numFragmentsCollected, numFragmentsAdded, numFragmentsRequired = GetArtifactProgress()

		artifact["numKeysockets"] = keystoneCount
		artifact["progress"] = numFragmentsCollected
		artifact["modifier"] = numFragmentsAdded
		artifact["total"] = numFragmentsRequired
		artifact["canSolve"] = CanSolveArtifact()

		for i = 0, 4 do
			for j = 1, GetContainerNumSlots(i) do
				local slotID = GetContainerItemID(i, j)
				if slotID == artifact["keyID"] then
					local _, count = GetContainerItemInfo(i, j)
					if artifact["numKeystones"] < artifact["numKeysockets"] then
						artifact["numKeystones"] = artifact["numKeystones"] + count
					end
					if min(artifact["numKeystones"], artifact["numKeysockets"]) * numRaces + artifact["progress"] >= artifact["total"] then
						artifact["canSolve"] = true
					end
				end
			end
		end
	end
end

function stArch:updateArtifactBar(index)
	local artifact = stArch["artifactInfo"][index]
	local bar = stArch["progressBars"][index]

	bar["race"]:SetText(artifact["race"])

	if GetNumArtifactsByRace(index) ~= 0 then
		local keystoneBonus = 0

		if artifact["numKeysockets"] then
			keystoneBonus = min(artifact["numKeystones"], artifact["numKeysockets"]) * numRaces
		end

		bar["bar"]:SetMinMaxValues(0, artifact["total"])
		bar["bar"]:SetValue(min(artifact["progress"] + keystoneBonus, artifact["total"]))

		if artifact["numKeysockets"] and artifact["numKeysockets"] > 0 then
			bar["solve"]["text"]:SetText(SOLVE.." ["..artifact["numKeystones"].."/"..artifact["numKeysockets"].."]")
		else
			bar["solve"]["text"]:SetText(SOLVE)
		end

		if keystoneBonus > 0 then
			bar["progress"]:SetText(format("|cff00c1ea%d|r/%d", artifact["progress"] + keystoneBonus, artifact["total"]))
		else
			if artifact["total"] > 65 then
				bar["progress"]:SetText(format("%d/|cff00c1ea%d|r", artifact["progress"], artifact["total"]))
			else
				bar["progress"]:SetText(format("%d/%d", artifact["progress"], artifact["total"]))
			end
		end
		if artifact["canSolve"] then
			bar["bar"]:SetStatusBarColor(0.2, 0.8, 0.2)
			stArch:EnableSolve(index, bar["solve"])
		else
			bar["bar"]:SetStatusBarColor(0.7, 0.2, 0)
			stArch:DisableSolve(bar["solve"])
		end

		bar["border"]:SetAlpha(1)
		bar["solve"]:SetAlpha(1)
	else
		-- Empty information, sometimes tries to falsely update
		bar["solve"]["text"]:SetText("")
		bar["progress"]:SetText("")
		stArch:DisableSolve(bar["solve"])
		bar["bar"]:SetStatusBarColor(0.4, 0.4, 0.4)

		stArch["progressBars"][index]["border"]:SetAlpha(0.2)
		stArch["progressBars"][index]["solve"]:SetAlpha(0.2)
	end
end

function stArch:EnableSolve(index, button)
	button["text"]:SetTextColor(1, 1, 1)
	button:SetScript("OnEnter", function()
		button:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b)
		button.overlay:SetVertexColor(T.color.r * 0.3, T.color.g * 0.3, T.color.b * 0.3, 1)
	end)
	button:SetScript("OnLeave", function()
		button:SetBackdropBorderColor(unpack(C.media.border_color))
		button.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	end)
	button:SetScript("OnClick", function()
		SetSelectedArtifact(index)
		local _, _, _, _, _, numSockets = GetActiveArtifactByRace(index)
		local _, _, itemID = GetArchaeologyRaceInfo(index)

		if numSockets and numSockets > 0 then
			for socketNum = 1, numSockets do
				if not ItemAddedToArtifact(itemID) then
					SocketItemToArtifact()
				end
			end
		end

		if GetNumArtifactsByRace(index) > 0 then
			if stArch["artifactInfo"][index]["canSolve"] then
				if not ((stArch["archSkill"]["rank"] + 5) > stArch["archSkill"]["maxRank"] and stArch["archSkill"]["rank"] ~= stArch["archSkill"]["maxRank"]) or IsShiftKeyDown() then
					SolveArtifact()
				end
				if (stArch["archSkill"]["rank"] + 5) > stArch["archSkill"]["maxRank"] and stArch["archSkill"]["rank"] ~= stArch["archSkill"]["maxRank"] and not IsShiftKeyDown() then
					print("[|cffe76a6ast|rArch] You should go train before finishing this cast or you won't get all your skill points! (Hold shift if you don't care and still want to complete your artifact now)")
				end
			end
		end
	end)
end

function stArch:DisableSolve(button)
	button["text"]:SetTextColor(0.5, 0.5, 0.5)
	button:SetBackdropBorderColor(unpack(C.media.border_color))
	button.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
	button:SetScript("OnEnter", function() end)
	button:SetScript("OnLeave", function() end)
	button:SetScript("OnMouseUp", function() end)
end

function stArch:OnEvent()
	for i = 1, numRaces do
		stArch:updateArtifact(i)
	end
	for i = 1, numRaces do
		stArch:updateArtifactBar(i)
	end
	stArch:updateSkillLevel()
	stArch:updateSkillBar()

	if stArch["archSkill"]["rank"] == stArch["archSkill"]["maxRank"] then
		stArch["archSkill"]["frame"]:Hide()
	end
end

function stArch:updateFramePosition(self)
	local progressBars = stArch["progressBars"]
	local _, _, relativePoint = self:GetPoint()
	if relativePoint == "TOPRIGHT" or relativePoint == "RIGHT" or relativePoint == "BOTTOMRIGHT" then
		progressBars["solveFrame"]:ClearAllPoints()
		progressBars["solveFrame"]:SetPoint("RIGHT", self, "LEFT", -1, 0)
		progressBars["solveFrame"]:SetPoint("TOP", progressBars["frame"], "TOP", 0, 0)

		progressBars["solveToggle"]["openPoint1"] = {"RIGHT", self, "LEFT", -1, 0}
		progressBars["solveToggle"]["openPoint2"] = {"TOP", progressBars["frame"], "TOP", 0, 0}
		progressBars["solveToggle"]["closePoint"] = {"RIGHT", progressBars["solveFrame"], "LEFT", -1, 0}

		progressBars["solveToggle"]["closeDirection"] = ">"
		progressBars["solveToggle"]["openDirection"] = "<"
	else
		progressBars["solveFrame"]:ClearAllPoints()
		progressBars["solveFrame"]:SetPoint("LEFT", self, "RIGHT", 1, 0)
		progressBars["solveFrame"]:SetPoint("TOP", progressBars["frame"], "TOP", 0, 0)

		progressBars["solveToggle"]["openPoint1"] = {"LEFT", self, "RIGHT", 1, 0}
		progressBars["solveToggle"]["openPoint2"] = {"TOP", progressBars["frame"], "TOP", 0, 0 }
		progressBars["solveToggle"]["closePoint"] = {"LEFT", progressBars["solveFrame"], "RIGHT", 1, 0}

		progressBars["solveToggle"]["closeDirection"] = "<"
		progressBars["solveToggle"]["openDirection"] = ">"
	end

	if progressBars["solveFrame"]:IsShown() then
		progressBars["solveToggle"]["text"]:SetText(progressBars["solveToggle"]["closeDirection"])
	else
		progressBars["solveToggle"]["text"]:SetText(progressBars["solveToggle"]["openDirection"])
	end

	progressBars["solveToggle"]:ClearAllPoints()
	if progressBars["solveFrame"]:IsShown() then
		progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["closePoint"]))
	else
		progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["openPoint1"]))
		progressBars["solveToggle"]:SetPoint(unpack(progressBars["solveToggle"]["openPoint2"]))
	end
end

local stArchFrame = CreateFrame("Frame", "stArchaeologyFrame", UIParent)
stArchFrame:RegisterEvent("RESEARCH_ARTIFACT_HISTORY_READY")
stArchFrame:RegisterEvent("RESEARCH_ARTIFACT_COMPLETE")
stArchFrame:RegisterEvent("RESEARCH_ARTIFACT_DIG_SITE_UPDATED")
stArchFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
stArchFrame:RegisterEvent("SKILL_LINES_CHANGED")
stArchFrame:RegisterEvent("BAG_UPDATE")
stArchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

stArchFrame:SetWidth(C.minimap.size)
stArchFrame:SetHeight(15)
stArchFrame:SetPoint(unpack(C.position.archaeology))
stArchFrame:SetTemplate("Transparent")
stArchFrame:SetFrameLevel(1)
stArchFrame:SetFrameStrata("HIGH")

stArchFrame:EnableMouse(true)
stArchFrame:SetMovable(true)
stArchFrame:SetUserPlaced(true)
stArchFrame:HookScript("OnMouseDown", function(self, button)
	if IsShiftKeyDown() then
		self:StartMoving()
	elseif IsControlKeyDown() and button == "RightButton" then
		self:SetPoint(unpack(C.position.archaeology))
		self:StartMoving()
		self:StopMovingOrSizing()
		self:SetPoint(unpack(C.position.archaeology))
	end
end)
stArchFrame:HookScript("OnMouseUp", function(self)
	self:StopMovingOrSizing()
	stArch:updateFramePosition(self)
end)

SlashCmdList.STARCHAEOLOGIST = function()
	ToggleFrame(stArchFrame)
	stArchFrame:StopMovingOrSizing()

	if stArchFrame:IsShown() then SavedOptionsPerChar.Archaeology = true else SavedOptionsPerChar.Archaeology = false end
end
SLASH_STARCHAEOLOGIST1 = "/starch"
SLASH_STARCHAEOLOGIST2 = "/arch"

stArchFrame:HookScript("OnEvent", function(self)
	if Loaded ~= true then
		stArch:OnLoad(self)
		stArch:updateFramePosition(self)
	else
		stArch:OnEvent()
		stArch:UpdateFrameHeight(self)
	end
	if not select(3, GetProfessions()) then stArchFrame:Hide() SavedOptionsPerChar.Archaeology = false end
	if SavedOptionsPerChar.Archaeology == true and not self:IsShown() then self:Show() end
end)

local b = CreateFrame("Button", "SwitchArch", UIParent)
b:SetTemplate("ClassColor")
if C.actionbar.toggle_mode == true then
	b:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 3, -58)
else
	b:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 3, -38)
end
b:SetSize(19, 19)
b:SetAlpha(0)

b:SetScript("OnClick", function(self)
	if _G["stArchaeologyFrame"]:IsShown() then
		_G["stArchaeologyFrame"]:Hide()
		SavedOptionsPerChar.Archaeology = false
	else
		_G["stArchaeologyFrame"]:Show()
		SavedOptionsPerChar.Archaeology = true
	end
	if C.minimap.toggle_menu and _G["TTMenuAddOnBackground"]:IsShown() then
		_G["TTMenuAddOnBackground"]:Hide()
	end
	if C.minimap.toggle_menu and _G["TTMenuBackground"]:IsShown() then
		_G["TTMenuBackground"]:Hide()
	end
end)

b:SetScript("OnEnter", function()
	b:FadeIn()
end)

b:SetScript("OnLeave", function()
	b:FadeOut()
end)

local bt = b:CreateTexture(nil, "OVERLAY")
bt:SetTexture("Interface\\Icons\\Trade_Archaeology")
bt:SetTexCoord(0.1, 0.9, 0.1, 0.9)
bt:SetPoint("TOPLEFT", b, 2, -2)
bt:SetPoint("BOTTOMRIGHT", b, -2, 2)

----------------------------------------------------------------------------------------
--	Survey cooldown timer
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", nil, UIParent)
f:SetPoint("CENTER", 0, -80)
f:SetSize(40, 40)

local text = f:CreateFontString(nil, "OVERLAY")
text:SetFont(C.media.pixel_font, 16, "OUTLINEMONOCHROME")
text:SetPoint("CENTER")

local last = 0
local time = 3

f:RegisterEvent("UNIT_SPELLCAST_STOP")
f:SetScript("OnEvent", function(self, event, unit, _, _, _, spellid)
	if not unit == "player" or select(2, UnitRace("player")) == "Dwarf" then return end
	if spellid == 80451 then
		text:SetText("3")
		f:SetScript("OnUpdate", function(self, elapsed)
			last = last + elapsed
			if last > 1 then
				time = time - 1
				text:SetText(time)
					if time <= 0 then
						f:SetScript("OnUpdate", nil)
						text:SetText("")
						time = 3
					end
				last = 0
			end
		end)
	end
end)