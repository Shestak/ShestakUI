local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.hide_combat ~= true then return end

----------------------------------------------------------------------------------------
--	Hide Chat in Combat (by Urtgard)
----------------------------------------------------------------------------------------
local hcic = CreateFrame("Frame")
local MouseoverFrames = {}
-- Events
local event = CreateFrame("Frame")
event:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

-- Register events
event:RegisterEvent("PLAYER_REGEN_ENABLED")
event:RegisterEvent("PLAYER_REGEN_DISABLED")
event:RegisterEvent("PLAYER_LOGIN")
event:RegisterEvent("PET_BATTLE_CLOSE")
event:RegisterEvent("PET_BATTLE_OPENING_START")
-- Handle events
function event:PLAYER_REGEN_ENABLED()
	hcic:CombatEnd()
end
function event:PLAYER_REGEN_DISABLED()
	hcic:CombatStart()
end
function event:PLAYER_LOGIN()
	hcic:Init()
end
function event:PET_BATTLE_CLOSE()
	hcic:CombatEnd()
end
function event:PET_BATTLE_OPENING_START()
	hcic:CombatStart()
end

--
function hcic:Init()
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame"..i]
		if f:IsShown() then
			local chatMouseover = CreateFrame("Frame", "HCIC"..i, UIParent)

			chatMouseover:SetPoint("TOPLEFT", "ChatFrame"..i, "TOPLEFT", -25, 30)
			chatMouseover:SetPoint("BOTTOMRIGHT", "ChatFrame"..i, "BOTTOMRIGHT", 2, -2)

			chatMouseover.FadeOut = function(self)
				hcic:FadeOut(self)
			end
			chatMouseover.FadeIn = function(self)
				hcic:FadeIn(self)
			end

			chatMouseover:SetScript("OnEnter", function(self)
				if InCombatLockdown() or C_PetBattles.IsInBattle() then
					self:FadeIn(self)
				end
			end)

			chatMouseover:SetScript("OnLeave", function(self)
					hcic:ChatOnLeave(self)
			end)

			chatMouseover.Frames = {_G["ChatFrame"..i], _G["ChatFrame"..i.."Tab"], _G["ChatFrame"..i.."ButtonFrame"]}
			if i == 1 then
				tinsert(chatMouseover.Frames, GeneralDockManager)
				tinsert(chatMouseover.Frames, GeneralDockManagerScrollFrame)

				if C.chat.background == true then
					tinsert(chatMouseover.Frames, ChatBackground)
					tinsert(chatMouseover.Frames, ChatTabsPanel)
				elseif C.stats.bottom_line then
					tinsert(chatMouseover.Frames, LeftPanel)
				end

				if C.chat.chat_bar and C.chat.chat_bar_mouseover ~= true then
					tinsert(chatMouseover.Frames, ChatBar)
				end
			end

			chatMouseover:SetFrameStrata("BACKGROUND")
			tinsert(MouseoverFrames, _G["HCIC"..i])
		end
	end
end

--
function hcic:CombatStart()
	for _, f in pairs(MouseoverFrames) do
		f:FadeOut()
	end
end

--
function hcic:CombatEnd()
	for _, f in pairs(MouseoverFrames) do
		f:FadeIn()
	end
end

-- Fade
function hcic:FadeOut(self)
	hcic:fade(self, 1)
end
function hcic:FadeIn(self)
	hcic:fade(self, 0)
end
function hcic:fade(self, mode)
	for _, frame in pairs(self.Frames) do
		local alpha = frame:GetAlpha()
		if mode == 0 then
			frame.Show = Show
			frame:Show()
			UIFrameFadeIn(frame, 0.4 * (1 - alpha), alpha, 1)
		else
			UIFrameFadeOut(frame, 0.8 * alpha, alpha, 0)
			frame.Show = T.dummy
			frame.fadeInfo.finishedArg1 = frame
			frame.fadeInfo.finishedFunc = frame.Hide
		end
	end
end

local function checkAgain(self)
	C_Timer.After(1, function()
		local f = GetMouseFocus()
		local name = GetMouseFocus():GetName()
		if f and name and not name:match("HCIC") then
			hcic:ChatOnLeave(self)
		end
	end)
end

function hcic:ChatOnLeave(self)
	if InCombatLockdown() or C_PetBattles.IsInBattle() then
		local f = GetMouseFocus()
		if f then
			if f.messageInfo then
				return nil
			end
			if hcic:IsInArray(self.Frames, f) then
				checkAgain(self) return nil
			end
			if f:GetParent() then
				f = f:GetParent()
				if hcic:IsInArray(self.Frames, f) then
					checkAgain(self) return nil
				end
				if f:GetParent() then
					f = f:GetParent()
					if hcic:IsInArray(self.Frames, f) then
						checkAgain(self) return nil
					end
				end
			end
		end

		self:FadeOut(self)
	end
end

function hcic:IsInArray(array, s)
	for _, v in pairs(array) do
		if v == s then
			return true
		end
	end
	return false
end

hooksecurefunc("FCF_Tab_OnClick", function(self)
	local chatFrame = _G["ChatFrame"..self:GetID()]
	if chatFrame.isDocked then
		HCIC1.Frames[1] = chatFrame
	end
end)