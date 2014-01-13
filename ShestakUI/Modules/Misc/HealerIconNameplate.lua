local T, C, L, _ = unpack(select(2, ...))
if C.nameplate.enable ~= true or C.nameplate.healer_icon ~= true then return end

----------------------------------------------------------------------------------------
--	Show icon above enemy healers nameplate in battlegrounds(KillTheHealer by Kraftman)
----------------------------------------------------------------------------------------
local healList, exClass = {}, {}
local lastUpdate, lastCheck = 0, 0
local testing = false
local texture = false

exClass.DEATHKNIGHT = true
exClass.MAGE = true
exClass.ROGUE = true
exClass.WARLOCK = true
exClass.WARRIOR = true

local function UpdatePlate(self)
	local name = gsub(self.HPName:GetText(), '%s%(%*%)','')

	if testing then
		self.HPHeal:Show()
	else
		if healList[name] then
			if exClass[healList[name]] then
				self.HPHeal:Hide()
			else
				self.HPHeal:Show()
			end
		else
			self.HPHeal:Hide()
		end
	end
end

local function CreatePlate(frame, nameFrame)
	if frame.HPHeal then return end

	frame.HPName = nameFrame:GetRegions()

	if texture then
		frame.HPHeal = frame:CreateTexture()
		frame.HPHeal:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-Roles")
		frame.HPHeal:SetTexCoord(0.26171875, 0.5234375, 0, 0.26171875)
		frame.HPHeal:SetHeight(40)
		frame.HPHeal:SetWidth(40)
		if C.nameplate.track_auras == true then
			frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 13)
		else
			frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 0)
		end
	else
		frame.HPHeal = frame:CreateFontString(nil, "OVERLAY")
		frame.HPHeal:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
		frame.HPHeal:SetText("|cFFD53333+|r")
		if C.nameplate.track_auras == true then
			frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 13)
		else
			frame.HPHeal:SetPoint("BOTTOM", frame, "TOP", 0, 0)
		end
	end

	UpdatePlate(frame)
	frame:HookScript("OnShow", UpdatePlate)
end

local function HookFrames(...)
	for i = 1, select("#", ...) do
		local frame = select(i, ...)
		if frame:GetName() and frame:GetName():find("NamePlate%d") then
			local child1, child2 = frame:GetChildren()
			CreatePlate(child1, child2)
		end
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(self, elapsed)
	lastUpdate = lastUpdate + elapsed

	if lastUpdate > 5 then
		lastUpdate = 0
		if WorldFrame:GetNumChildren() ~= numChildren then
			numChildren = WorldFrame:GetNumChildren()
			HookFrames(WorldFrame:GetChildren())
		end
	end
end)

local t = CreateFrame("Frame")
t.factions = {
	["Horde"] = 1,
	["Alliance"] = 0,
}
t.healers = {
	[L_PLANNER_DRUID_4] = true,
	[L_PLANNER_MONK_2] = true,
	[L_PLANNER_PALADIN_1] = true,
	[L_PLANNER_PRIEST_1] = true,
}

local function CheckHealers(self, elapsed)
	lastCheck = lastCheck + elapsed
	if lastCheck > 30 then
		lastCheck = 0
		healList = {}
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
			name = name:match("(.+)%-.+") or name
			if name and t.healers[talentSpec] and t.factions[UnitFactionGroup("player")] == faction then
				healList[name] = talentSpec
			end
		end
	end
end

local function CheckLoc(self, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ENTERING_BATTLEGROUND" then
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			t:SetScript("OnUpdate", CheckHealers)
		else
			healList = {}
			t:SetScript("OnUpdate", nil)
		end
	end
end

t:RegisterEvent("PLAYER_ENTERING_WORLD")
t:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
t:SetScript("OnEvent", CheckLoc)