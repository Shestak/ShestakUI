local T, C, L, _ = unpack(select(2, ...))
if C.misc.profession_database ~= true then return end

----------------------------------------------------------------------------------------
--	Access professions without actually having to know them(Professions Database by Vladinator)
----------------------------------------------------------------------------------------
local PROFESSIONS = {
	{
		80731,	-- Alchemy
		76666,	-- Blacksmithing
		74258,	-- Enchanting
		82774,	-- Engineering
		86008,	-- Inscription
		73318,	-- Jewelcrafting
		81199,	-- Leatherworking
		75156,	-- Tailoring
	},
	{
		88053,	-- Cooking
		74559,	-- First Aid
	},
}

-- Handle clicked links from dropdown menu
local function DropDown_OnClick(self)
	local spellId = self.arg1
	local guid = UnitGUID("player"):sub(4)
	local _, template = GetSpellLink(spellId)
	if type(template) ~= "string" or template:len() == 0 then return end
	local chars = template:sub(select(2, template:find(guid)), template:find("|h")):len() - 3
	local maxed = type(PROFESSION_RANKS) == "table" and select(2, next(PROFESSION_RANKS[#PROFESSION_RANKS])) or 0
	local suffix = ""
	for i = 1, chars do
		suffix = suffix.."/"
	end
	local link = format("trade:%d:%d:%d:%s:%s", spellId, maxed, maxed, guid, suffix)
	local text = format("|H%s|h[%s]|h", link, GetSpellInfo(spellId) or "spellId#"..spellId)
	if IsModifiedClick() then
		local fixedLink = format("|cffffd000%s|r", text)
		if ChatEdit_GetActiveWindow() then
			ChatEdit_InsertLink(fixedLink)
		else
			print("Open the chat and shift-click", fixedLink, "to link it.")
		end
	else
		SetItemRef(link, text, "LeftButton", DEFAULT_CHAT_FRAME)
	end
end

-- Handle building dropdown list when menu is shown
local function DropDown_Init()
	for i, spellIds in ipairs(PROFESSIONS) do
		UIDropDownMenu_AddButton({isTitle = 1, notCheckable = 1, text = i == 1 and PRIMARY or SECONDARY})
		for _, spellId in ipairs(spellIds) do
			local info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text, _, info.icon = GetSpellInfo(spellId)
			info.arg1 = spellId
			info.tCoordLeft = 0.1
			info.tCoordRight = 0.9
			info.tCoordTop = 0.1
			info.tCoordBottom = 0.9
			info.func = DropDown_OnClick
			UIDropDownMenu_AddButton(info)
		end
	end
end

-- Create dropdown menu
local dropdown = CreateFrame("Frame", "ProfessionsDatabaseDropDown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_Initialize(dropdown, DropDown_Init, "MENU")

-- Shows the dropdown on said frame
local function DropDown_Show(self)
	ToggleDropDownMenu(nil, nil, dropdown, self, 0, 0)
end

-- Create button in SpellBook
local button = CreateFrame("Button", "ProfessionsDatabaseToggleButton", SpellBookProfessionFrame)
button:SetSize(16, 16)
if C.skins.blizzard_frames == true then
	button:SetPoint("TOPRIGHT", button:GetParent(), "TOPRIGHT", -10, -5)
else
	button:SetPoint("TOPRIGHT", button:GetParent(), "TOPRIGHT", -26, -3)
end
button:SetNormalTexture("Interface\\GossipFrame\\DailyActiveQuestIcon")
button:SetPushedTexture("Interface\\GossipFrame\\DailyActiveQuestIcon")
button:SetHighlightTexture("Interface\\GossipFrame\\DailyActiveQuestIcon", "ADD")
button:SetScript("OnClick", DropDown_Show)