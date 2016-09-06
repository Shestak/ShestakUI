local T, C, L, _ = unpack(select(2, ...))
if C.automation.screenshot ~= true then return end

----------------------------------------------------------------------------------------
--	Take screenshots of defined events (Sinaris)
----------------------------------------------------------------------------------------
local function TakeScreen(delay, func, ...)
	local waitTable = {}
	local waitFrame = CreateFrame("Frame", nil, UIParent)
	waitFrame:SetScript("OnUpdate", function(self, elapse)
		local count = #waitTable
		local i = 1
		while (i <= count) do
			local waitRecord = tremove(waitTable, i)
			local d = tremove(waitRecord, 1)
			local f = tremove(waitRecord, 1)
			local p = tremove(waitRecord, 1)
			if (d > elapse) then
				tinsert(waitTable, i, {d-elapse, f, p})
				i = i + 1
			else
				count = count - 1
				f(unpack(p))
			end
		end
	end)
	tinsert(waitTable, {delay, func, {...}})
end
local AchScreen = CreateFrame("Frame")
AchScreen:RegisterEvent("ACHIEVEMENT_EARNED")
AchScreen:SetScript("OnEvent", function()
	TakeScreen(1, Screenshot)
end)
