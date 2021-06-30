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
	["1535"] = 1,	-- Drust
	["1534"] = 2,	-- Zandalari
	["1174"] = 3,	-- Demonic
	["1173"] = 4,	-- Highmountain
	["1172"] = 5,	-- Highborne
	["828"] = 6,	-- Ogre
	["821"] = 7,	-- Draenor Clans
	["829"] = 8,	-- Arakkoa
	["677"] = 9,	-- Mogu
	["676"] = 10,	-- Pandaren
	["754"] = 11,	-- Mantid
	["399"] = 12,	-- Vrykul
	["385"] = 13,	-- Troll
	["401"] = 14,	-- Tol'vir
	["397"] = 15,	-- Orc
	["400"] = 16,	-- Nerubian
	["394"] = 17,	-- Night Elf
	["393"] = 18,	-- Fossil
	["398"] = 19,	-- Draenei
	["384"] = 20,	-- Dwarf
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_CURRENCY")
frame:SetScript("OnEvent", function(_, _, msg)
	local _, _, currencyID = string.find(msg, "currency:(%d+)");
	if not currencyID then return end

	local race = fragment[currencyID]
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
