local T, C, L, _ = unpack(select(2, ...))
if C.automation.solve_artifact ~= true then return end

----------------------------------------------------------------------------------------
--	Auto popup for solve artifact(module from Inomena by p3lim)
----------------------------------------------------------------------------------------
StaticPopupDialogs.ARCHAEOLOGY_SOLVE = {
	text = "%s",
	button1 = SOLVE,
	button2 = CANCEL,
	OnAccept = SolveArtifact,
	timeout = 0,
	preferredIndex = 5,
}

local fragment = {
	["1174"] = 1,	-- Demonic
	["1173"] = 2,	-- Highmountain
	["1172"] = 3,	-- Highborne
	["828"] = 4,	-- Ogre
	["821"] = 5,	-- Draenor Clans
	["829"] = 6,	-- Arakkoa
	["677"] = 7,	-- Mogu
	["676"] = 8,	-- Pandaren
	["754"] = 9,	-- Mantid
	["399"] = 10,	-- Vrykul
	["385"] = 11,	-- Troll
	["401"] = 12,	-- Tol'vir
	["397"] = 13,	-- Orc
	["400"] = 14,	-- Nerubian
	["394"] = 15,	-- Night Elf
	["393"] = 16,	-- Fossil
	["398"] = 17,	-- Draenei
	["384"] = 18,	-- Dwarf
}

local _CURRENCY = string.gsub(string.gsub(CURRENCY_GAINED_MULTIPLE, "%%s", "(.+)"), "%%d", "(.+)")
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_CURRENCY")
frame:SetScript("OnEvent", function(self, event, message)
	local link = string.match(message, _CURRENCY)
	if not link then return end
	local id = string.match(link, ":(%d+)|h")

	local race = fragment[id]
	if race then
		SetSelectedArtifact(race)

		local race, _, stone = GetArchaeologyRaceInfo(race)
		local artifact, _, rare, _, _, stones = GetSelectedArtifactInfo()
		if not artifact then return end

		for index = 1, math.min(stones, GetItemCount(stone)) do
			if not ItemAddedToArtifact(index) then
				SocketItemToArtifact()
			end
		end

		local fragments, stones, total = GetArtifactProgress()
		if fragments + stones >= total then
			local color
			if rare and rare > 0 then
				color = "|cff0070dd"
			else
				color = "|cff9d9d9d"
			end

			StaticPopup_Show("ARCHAEOLOGY_SOLVE", string.format("%s %s: %s[%s]|r?", SOLVE, race, color, artifact))
		end
	end
end)
