local T, C, L, _ = unpack(select(2, ...))
if not T.classic or C.chat.bubbles ~= true then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin(by Haleth)
----------------------------------------------------------------------------------------
local f = CreateFrame("Frame", nil, UIParent)
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
		bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = T.noscalemult,
		insets = {left = -T.noscalemult, right = -T.noscalemult, top = -T.noscalemult, bottom = -T.noscalemult}
	})
	frame:SetBackdropColor(C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha)
	frame:SetBackdropBorderColor(unpack(C.media.border_color))
	frame:SetClampedToScreen(false)
	frame:SetFrameStrata("BACKGROUND")
end

f:SetScript("OnUpdate", function(self, elapsed)
	total = total + elapsed
	if total > 0.1 then
		total = 0
		local newNumKids = WorldFrame:GetNumChildren()
		if newNumKids ~= numKids then
			for i = numKids + 1, newNumKids do
				local frame = select(i, WorldFrame:GetChildren())
				if frame:IsForbidden() then return end -- 7.2 Fix for friendly nameplate in raid
				local b = frame:GetBackdrop()
				if b and b.bgFile == [[Interface\Tooltips\ChatBubble-Background]] then
					styleBubble(frame)
				end
			end
			numKids = newNumKids
		end
	end
end)