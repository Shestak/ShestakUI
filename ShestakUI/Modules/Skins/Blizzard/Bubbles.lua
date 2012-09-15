local T, C, L, _ = unpack(select(2, ...))
if C.chat.bubbles ~= true or IsAddOnLoaded("BossEncounter2") then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin(by Haleth)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", nil, UIParent)
local noscalemult = T.mult * C.general.uiscale
local total = 0
local numKids = 0

local function styleBubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		end
	end

	frame:SetBackdrop({
		bgFile = C.media.blank,
		edgeFile = C.media.blank,
		tile = false, tileSize = 0, edgeSize = noscalemult,
		insets = {left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
	})
	frame:SetBackdropColor(unpack(C.media.overlay_color))
	frame:SetBackdropBorderColor(unpack(C.media.border_color))
	frame:SetClampedToScreen(false)
end

local function isChatBubble(frame)
	if frame:GetName() then return end
	if not frame:GetRegions() then return end
	return frame:GetRegions():GetTexture() == [[Interface\Tooltips\ChatBubble-Background]]
end

local function FindBubble()
	local newNumKids = WorldFrame:GetNumChildren()
	if newNumKids ~= numKids then
		for i = numKids + 1, newNumKids do
			local frame = select(i, WorldFrame:GetChildren())

			if isChatBubble(frame) then return frame end
		end
		numKids = newNumKids
	end
end

local function onUpdate(self, elapsed)
	total = total + elapsed

	local frame = FindBubble()
	if frame or total > 0.3 then
		self:SetScript("OnUpdate", nil)
		total = 0
		if frame then styleBubble(frame) end
	end
end

local events = {
	CHAT_MSG_SAY = "chatBubbles", CHAT_MSG_YELL = "chatBubbles",
	CHAT_MSG_PARTY = "chatBubblesParty", CHAT_MSG_PARTY_LEADER = "chatBubblesParty",
	CHAT_MSG_MONSTER_SAY = "chatBubbles", CHAT_MSG_MONSTER_YELL = "chatBubbles", CHAT_MSG_MONSTER_PARTY = "chatBubblesParty",
}

for event in pairs(events) do f:RegisterEvent(event) end

f:SetScript("OnEvent", function(self, event)
	if GetCVarBool(events[event]) then
		f:SetScript("OnUpdate", onUpdate)
	end
end)