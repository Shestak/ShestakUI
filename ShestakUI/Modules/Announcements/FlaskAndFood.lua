local T, C, L, _ = unpack(select(2, ...))
if C.announcements.flask_food ~= true then return end

----------------------------------------------------------------------------------------
--	Checks the usage of flasks and food of your party/raid members(ffCheck by Silverwind)
----------------------------------------------------------------------------------------
local noFood, noFlask, unitBuffs = {}, {}, {}
local foods = T.ReminderBuffs["Food"]
local flasks = T.ReminderBuffs["Flask"]

local function scan(unit)
	table.wipe(unitBuffs)
	local i = 1
	while true do
		local name = UnitAura(unit, i, "HELPFUL")
		if not name then return end
		unitBuffs[name] = true
		i = i + 1
	end
end

local function checkFood(unit)
	scan(unit)
	for _, id in pairs(foods) do
		if unitBuffs[GetSpellInfo(id)] then
			return true
		end
	end
end

local function checkFlask(unit)
	scan(unit)
	for _, id in pairs(flasks) do
		if unitBuffs[GetSpellInfo(id)] then
			return true
		end
	end
end

local function checkUnit(unit)
	local name = UnitName(unit)
	if not checkFood(unit) then
		noFood[#noFood + 1] = name
	end
	if not checkFlask(unit) then
		noFlask[#noFlask + 1] = name
	end
end

local function print(text)
	_G.print("|cffffff00"..text.."|r")
end

-- The Main function to run a check
local function run()
	local checkType
	local output

	if C.announcements.flask_food_auto == true then C.announcements.flask_food_raid = true end

	table.wipe(noFood)
	table.wipe(noFlask)

	if UnitInRaid("player") then
		checkType = "raid"
	else
		checkType = "party"
		checkUnit("player")
	end

	for i = 1, GetNumGroupMembers() do
		if checkType == "raid" then
			local online = select(8, GetRaidRosterInfo(i))
			if online then
				local unit = checkType..i
				checkUnit(unit)
			end
		else
			local unit = checkType..i
			if UnitIsConnected(unit) then
				checkUnit(unit)
			end
		end
	end

	if #noFlask > 0 then
		table.sort(noFlask)
		output = L_ANNOUNCE_FF_NOFLASK..table.concat(noFlask, ", ")
		if C.announcements.flask_food_raid then
			SendChatMessage(output, T.CheckChat())
		else
			print(output)
		end
	end

	if #noFood > 0 then
		table.sort(noFood)
		output = L_ANNOUNCE_FF_NOFOOD..table.concat(noFood, ", ")
		if C.announcements.flask_food_raid then
			SendChatMessage(output, T.CheckChat())
		else
			print(output)
		end
	end

	if #noFood == 0 and #noFlask == 0 then
		if C.announcements.flask_food_raid then
			SendChatMessage(L_ANNOUNCE_FF_ALLBUFFED, T.CheckChat())
		else
			print(L_ANNOUNCE_FF_ALLBUFFED)
		end
	end
end

-- Event Handler
local frame = CreateFrame("Frame")
frame:RegisterEvent("READY_CHECK")
frame:SetScript("OnEvent", function(self, event, ...)
	if C.announcements.flask_food_auto then
		run()
	end
end)

-- Slash command
SlashCmdList.FFCHECK = run
SLASH_FFCHECK1 = "/ffcheck"
SLASH_FFCHECK2 = "/аасрусл"

-- Check button
if C.misc.raid_tools == true then
	RaidUtilityPanel:SetHeight(168)

	local button = CreateFrame("Button", "FoodFlaskCheckButton", RaidUtilityPanel, "UIPanelButtonTemplate")
	button:SetWidth(RaidUtilityRoleButton:GetWidth())
	button:SetHeight(18)
	button:SetPoint("TOP", RaidUtilityRaidControlButton, "BOTTOM", 0, -5)
	if IsAddOnLoaded("Aurora") then
		local F = unpack(Aurora)
		F.Reskin(button)
	else
		button:SkinButton()
	end
	button:EnableMouse(true)
	button:SetScript("OnMouseUp", function(self) run() end)

	local t = button:CreateFontString(nil, "OVERLAY", button)
	t:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	t:SetPoint("CENTER")
	t:SetJustifyH("CENTER")
	t:SetText(L_ANNOUNCE_FF_CHECK_BUTTON)
end