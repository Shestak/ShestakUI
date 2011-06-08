local T, C, L = unpack(select(2, ...))
if C.chat.bubbles ~= true or (IsAddOnLoaded("BossEncounter2")) then return end

----------------------------------------------------------------------------------------
--	ChatBubbles skin(by Elv22 or nightcracker)
----------------------------------------------------------------------------------------
local chatbubblehook = CreateFrame("Frame", nil, UIParent)
local noscalemult = T.mult * C.general.uiscale
local tslu = 0
local numkids = 0
local bubbles = {}

local function skinbubble(frame)
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
	
	tinsert(bubbles, frame)
end

local function ischatbubble(frame)
	if frame:GetName() then return end
	local bg = frame:GetRegions()
	if bg then return bg:GetTexture() == [[Interface\Tooltips\ChatBubble-Background]] end
end

chatbubblehook:SetScript("OnUpdate", function(chatbubblehook, elapsed)
	tslu = tslu + elapsed

	if tslu > 0.05 then
		tslu = 0

		local newnumkids = WorldFrame:GetNumChildren()
		if newnumkids ~= numkids then
			for i = numkids + 1, newnumkids do
				local frame = select(i, WorldFrame:GetChildren())

				if ischatbubble(frame) then
					skinbubble(frame)
				end
			end
			numkids = newnumkids
		end
		
		for i, frame in next, bubbles do
			frame:SetBackdropBorderColor(unpack(C.media.border_color))
		end
	end
end)