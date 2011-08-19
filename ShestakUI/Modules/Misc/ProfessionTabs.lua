local T, C, L = unpack(ShestakUI)
if C.extra_general.profession_tabs ~= true then return end

----------------------------------------------------------------------------------------
--	Professions tabs on tradeskill frame(ProfessionTabs by Beoko)
----------------------------------------------------------------------------------------

local ProfessionTabs = CreateFrame("Frame", "ProfessionTabs")
ProfessionTabs:SetScript("OnEvent", function(self, Event, ...) self[Event](self, Event, ...) end)
ProfessionTabs:RegisterEvent("TRADE_SKILL_SHOW")
ProfessionTabs:RegisterEvent("TRADE_SHOW")
ProfessionTabs:RegisterEvent("SKILL_LINES_CHANGED")

local __TradeSkillFrame
local format = string.format
local IsCurrentSpell = IsCurrentSpell
local Cache, TradeSkillFrameTabs, TradeFrameTabs = {}, {}, {}
local TradeSkillFrameTabIndex, TradeFrameTabIndex = 1, 1
local Professions = {
	[1] = { 2259, 3101, 3464, 11611, 28596, 51304, 80731 },		-- Alchemy
	[2] = { 2018, 3100, 3538, 9785, 29844, 51300, 76666 },		-- Blacksmithing
	[3] = { 7411, 7412, 7413, 13920, 28029, 51313, 74258 },		-- Enchanting
	[4] = { 4036, 4037, 4038, 12656, 30350, 51306, 82774 },		-- Engineering
	[5] = { 45357, 45358, 45359, 45360, 45361, 45363, 86008 },	-- Inscription
	[6] = { 25229, 25230, 28894, 28895, 28897, 51311, 73318 },	-- Jewelcrafting
	[7] = { 2108, 3104, 3811, 10662, 32549, 51302, 81199 },		-- Leatherworking
	[8] = { 3908, 3909, 3910, 12180, 26790, 51309, 75156 },		-- Tailoring
	[9] = { 2550, 3102, 3413, 18260, 33359, 51296, 88053 },		-- Cooking
	[10] = { 3273, 3274, 7924, 10846, 27028, 45542, 74559 },	-- First Aid
	[11] = { 53428 },	-- Runeforging
	[12] = { 2656 },	-- Smelting
	[13] = { 13262 },	-- Disenchant
	[14] = { 51005 },	-- Milling
	[15] = { 31252 },	-- Prospecting
	[16] = { 818 },		-- Basic Campfire
	[17] = { 1804 },	-- Pick Lock
	[18] = { 78670, 88961, 89718, 89719, 89720, 89721, 89722 },	-- Archaeology
	[19] = { 80451 },	-- Survey
	[20] = { 74268 },	-- Track Archaeology Chests
}

function ProfessionTabs:CacheProfessions()
	wipe(Cache)

	for Index = 1, #Professions do
		for NewIndex = 1, #Professions[Index] do
			local Profession = Professions[Index][NewIndex]
			if IsSpellKnown(Profession) then
				Cache[#Cache + 1] = Profession
				break
			end
		end
	end
end

function ProfessionTabs:TriggerEvents()
	if TradeFrame and TradeFrame:IsShown() then
		self:TRADE_SHOW()
	end

	if __TradeSkillFrame and __TradeSkillFrame:IsShown() then
		self:TRADE_SKILL_SHOW()
	end
end

local function Tab_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT") 
	GameTooltip:AddLine(self.SpellRank ~= "" and format("%s (%s)", self.SpellName, self.SpellRank) or self.SpellName, 1, 1, 1)
	GameTooltip:Show()
end

local function Tab_OnLeave(self)
	GameTooltip:Hide()
end

function ProfessionTabs:CreateTab(Table, Parent)
	local Tab = CreateFrame("CheckButton", "ProTabs"..#Table, Parent, "SpellBookSkillLineTabTemplate SecureActionButtonTemplate")
	Tab:SetPoint("TOPLEFT", Parent, "TOPRIGHT", (Parent == ATSWFrame or Parent == TradeFrame) and -32 or 0, (Parent == TradeFrame and -32 or -24) + -44 * #Table)
	Tab:SetScript("OnEnter", Tab_OnEnter)
	Tab:SetScript("OnLeave", Tab_OnLeave)

	if C.skins.blizzard_frames == true then
		Tab:SetPoint("TOPLEFT", Parent, "TOPRIGHT", (Parent == ATSWFrame or Parent == TradeFrame) and -19 or 1, (Parent == TradeFrame and -12 or 0) + -44 * #Table)

		Tab:StripTextures()
		Tab:GetNormalTexture():ClearAllPoints()
		Tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
		Tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		Tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

		Tab:CreateBackdrop("Default")
		Tab.backdrop:SetAllPoints()
		Tab:StyleButton(true)
	end

	Table[#Table + 1] = Tab
	return Tab
end

function ProfessionTabs:UpdateTabs(Table)
	local Combat = InCombatLockdown()

	for Index = 1, #Table do
		local Tab = Table[Index]

		if Index > #Cache then
			if not Combat then Tab:Hide() end
		else
			if not Combat then Tab:Show() end
			Tab:SetChecked(IsCurrentSpell(Tab.SpellName))
		end
	end	
end

function ProfessionTabs:EventHandler(Table, Parent)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:CacheProfessions()

		for Index = 1, #Cache do
			local SpellName, SpellRank, SpellTexture = GetSpellInfo(Cache[Index])
			local Tab = Table[Index] or self:CreateTab(Table, Parent)
			
			Tab.SpellName = SpellName
			Tab.SpellRank = SpellRank
			Tab:SetNormalTexture(SpellTexture)
			Tab:SetAttribute("type", "spell")
			Tab:SetAttribute("spell", SpellName)
		end
	end

	self:UpdateTabs(Table)
end

function ProfessionTabs:TRADE_SKILL_SHOW()
	__TradeSkillFrame = __TradeSkillFrame or MRTSkillFrame or ATSWFrame or SkilletFrame or TradeSkillFrame
	self:EventHandler(TradeSkillFrameTabs, __TradeSkillFrame)

	if TradeFrame:IsShown() then
		self:EventHandler(TradeFrameTabs, TradeFrame)
	end
end

function ProfessionTabs:TRADE_SHOW()
	self:EventHandler(TradeFrameTabs, TradeFrame)
end

function ProfessionTabs:SKILL_LINES_CHANGED()
	self:TriggerEvents()
end

function ProfessionTabs:PLAYER_REGEN_ENABLED(Event)
	self:UnregisterEvent(Event)
	self:TriggerEvents()
end