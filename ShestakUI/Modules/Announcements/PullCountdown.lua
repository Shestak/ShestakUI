local T, C, L, _ = unpack(select(2, ...))
if C.announcements.pull_countdown ~= true then return end

----------------------------------------------------------------------------------------
--	Pull Countdown(by Dridzt) /run PullCountdown.Pull(#)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	if self[event] then
		return self[event](...)
	end
end)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GROUP_ROSTER_UPDATE")

local channel, delay, target
local INTERVAL = 1.5
local lastupdate = 0
local firstdone
local timerframe = CreateFrame("Frame")

local function getChannel()
	local ch
	if GetNumSubgroupMembers() > 0 and not UnitInRaid("player") then
		ch = "PARTY"
	elseif GetNumGroupMembers() > 0 then
		if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
			ch = "RAID_WARNING"
		else
			ch = "RAID"
		end
	end
	return ch or "SAY"
end

function f.PLAYER_ENTERING_WORLD()
	channel = getChannel()
end

function f.GROUP_ROSTER_UPDATE()
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
		SendChatMessage("Pulling "..target.."in "..tostring(delay).."..", channel)
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
			SendChatMessage("GO!", channel)
			reset()
		end
	end
end

function f.Pull(timer)
	delay = timer or 3
	if timerframe:GetScript("OnUpdate") then
		reset()
		SendChatMessage("Pull ABORTED!", channel)
	else
		timerframe:SetScript("OnUpdate", pull)
	end
end

_G["PullCountdown"] = f