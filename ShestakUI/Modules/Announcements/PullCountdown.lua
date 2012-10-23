local T, C, L, _ = unpack(select(2, ...))
if C.announcements.pull_countdown ~= true then return end

----------------------------------------------------------------------------------------
--	Pull Countdown(by Dridzt)
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame", "PullCountdown")
frame:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](...) end end)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")

local channel, delay, target
local INTERVAL = 1.5
local lastupdate = 0
local firstdone
local timerframe = CreateFrame("Frame")

local function getChannel()
	local ch
	if IsInRaid() then
		if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
			ch = "RAID_WARNING"
		else
			ch = "RAID"
		end
	elseif IsInGroup() then
		ch = "PARTY"
	end
	return ch or "SAY"
end

function frame.PLAYER_ENTERING_WORLD()
	channel = getChannel()
end

function frame.GROUP_ROSTER_UPDATE()
	channel = getChannel()
end

local function reset()
	timerframe:SetScript("OnUpdate", nil)
	firstdone, delay, target = nil, nil, nil
	lastupdate = 0
end

local function pull(self, elapsed)
	local tname = UnitName("target")
	if tname then
		target = tname.." "
	else
		target = ""
	end
	if not firstdone then
		SendChatMessage(string.format(L_ANNOUNCE_PC_MSG, target, tostring(delay)), channel)
		firstdone = true
		delay = delay - 1
	end
	lastupdate = lastupdate + elapsed
	if lastupdate >= INTERVAL then
		lastupdate = 0
		if delay > 0 then
			SendChatMessage(tostring(delay).."..", channel)
			delay = delay - 1
		else
			SendChatMessage(L_ANNOUNCE_PC_GO, channel)
			reset()
		end
	end
end

function frame.Pull(timer)
	delay = timer or 3
	if timerframe:GetScript("OnUpdate") then
		reset()
		SendChatMessage(L_ANNOUNCE_PC_ABORTED, channel)
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