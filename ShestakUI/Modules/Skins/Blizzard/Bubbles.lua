local T, C, L, _ = unpack(select(2, ...))
if C.chat.bubbles ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin
----------------------------------------------------------------------------------------
local function styleBubble(frame)
	if frame:IsForbidden() then return end
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			region:SetTexture(nil)
		end
	end

	frame:CreateBackdrop("Transparent")
	frame.backdrop:SetScale(UIParent:GetScale())

	frame:SetClampedToScreen(false)
	frame:SetFrameStrata("BACKGROUND")
end

local function onUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed < 0.1 then return end
	self.elapsed = 0

	for _, frame in pairs(C_ChatBubbles.GetAllChatBubbles()) do
		if not frame.backdrop then
			styleBubble(frame)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	if instanceType == "party" or instanceType == "raid" then
		f:SetScript("OnUpdate", nil)
	else
		f:SetScript("OnUpdate", onUpdate)
	end
end)