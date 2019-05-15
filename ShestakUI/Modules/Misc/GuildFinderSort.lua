local T, C, L, _ = unpack(select(2, ...))
if T.classic then return end

----------------------------------------------------------------------------------------
--	Sorts the guild finder list(GuildFinderSorter by Tekkub)
----------------------------------------------------------------------------------------
if IsInGuild() then return end
local o = GetRecruitingGuildInfo
local indexmap

local function guildsort(a, b)
	if a.lvl == b.lvl then
		if a.mem == b.mem then return a.ach > b.ach end
		return a.mem > b.mem
	end
	return a.lvl > b.lvl
end

function GetRecruitingGuildInfo(index, ...)
	if not indexmap then
		indexmap = {}

		for i = 1, GetNumRecruitingGuilds() do
			local _, level, numMembers, achPoints = o(i)
			indexmap[i] = {
				index = i,
				mem = numMembers,
				lvl = level,
				ach = achPoints
			}
		end

		table.sort(indexmap, guildsort)
	end

	return o(indexmap[index].index, ...)
end

local f = CreateFrame("Frame")
f:RegisterEvent("LF_GUILD_BROWSE_UPDATED")
f:SetScript("OnEvent", function() indexmap = nil end)