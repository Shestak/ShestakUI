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
		elseif region:GetObjectType() == "FontString" then
			frame.text = region
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

	frame.text:SetFont(C.media.normal_font, 14)
end

local function isChatBubble(frame)
	if frame:GetName() then return end
	if not frame:GetRegions() then return end
	return frame:GetRegions():GetTexture() == [[Interface\Tooltips\ChatBubble-Background]]
end

f:SetScript("OnUpdate", function(self, elapsed)
	total = total + elapsed
	if total > 0.1 then
		total = 0
		local newNumKids = WorldFrame:GetNumChildren()
		if newNumKids ~= numKids then
			for i = numKids + 1, newNumKids do
				local frame = select(i, WorldFrame:GetChildren())
				if isChatBubble(frame) then
					styleBubble(frame)
				end
			end
			numKids = newNumKids
		end
	end
end)