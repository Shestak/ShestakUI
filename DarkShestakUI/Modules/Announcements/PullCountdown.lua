local T, C, L, _ = unpack(select(2, ...))
if C.announcements.pull_countdown ~= true then return end

----------------------------------------------------------------------------------------
--	Pull Countdown(by Dridzt)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "PullCountdown")
local timerframe = CreateFrame("Frame")
local firstdone, delay, target
local interval = 1.5
local lastupdate = 0

local function reset()
	timerframe:SetScript("OnUpdate", nil)
	firstdone, delay, target = nil, nil, nil
	lastupdate = 0
end

local function pull(self, elapsed)
	local tname = UnitName("target")
	if tname then
		target = tname
	else
		target = ""
	end
	if not firstdone then
		SendChatMessage(string.format(L_ANNOUNCE_PC_MSG, target, tostring(delay)), T.CheckChat(true))
		firstdone = true
		delay = delay - 1
	end
	lastupdate = lastupdate + elapsed
	if lastupdate >= interval then
		lastupdate = 0
		if delay > 0 then
			SendChatMessage(tostring(delay).."..", T.CheckChat(true))
			delay = delay - 1
		else
			SendChatMessage(L_ANNOUNCE_PC_GO, T.CheckChat(true))
			reset()
		end
	end
end

function frame.Pull(timer)
	delay = timer or 3
	if timerframe:GetScript("OnUpdate") then
		reset()
		SendChatMessage(L_ANNOUNCE_PC_ABORTED, T.CheckChat(true))
	else
		timerframe:SetScript("OnUpdate", pull)
	end
end

SlashCmdList.PULLCOUNTDOWN = function(msg)
	if tonumber(msg) ~= nil then
		frame.Pull(msg)
	else
		frame.Pull()
	end
end
SLASH_PULLCOUNTDOWN1 = "/pc"
SLASH_PULLCOUNTDOWN2 = "/зс"