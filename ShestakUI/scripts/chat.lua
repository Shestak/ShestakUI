if SettingsCF.chat.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Setup chat
----------------------------------------------------------------------------------------
local UIChat = CreateFrame("Frame")
local _G = _G
local origs = {}
local type = type

-- Function to rename channel and other stuff
local AddMessage = function(self, text, ...)
	if(type(text) == "string") then
		text = text:gsub('|h%[(%d+)%. .-%]|h', '|h[%1]|h')
	end
	return origs[self](self, text, ...)
end

----------------------------------------------------------------------------------------
--	Global strings
----------------------------------------------------------------------------------------
_G.CHAT_BATTLEGROUND_GET = "|Hchannel:Battleground|h["..L_CHAT_BATTLEGROUND.."]|h %s:\32"
_G.CHAT_BATTLEGROUND_LEADER_GET = "|Hchannel:Battleground|h["..L_CHAT_BATTLEGROUND_LEADER.."]|h %s:\32"
_G.CHAT_BN_WHISPER_GET = L_CHAT_BN_WHISPER.." %s:\32"
_G.CHAT_GUILD_GET = "|Hchannel:Guild|h["..L_CHAT_GUILD.."]|h %s:\32"
_G.CHAT_OFFICER_GET = "|Hchannel:o|h["..L_CHAT_OFFICER.."]|h %s:\32"
_G.CHAT_PARTY_GET = "|Hchannel:Party|h["..L_CHAT_PARTY.."]|h %s:\32"
_G.CHAT_PARTY_LEADER_GET = "|Hchannel:party|h["..L_CHAT_PARTY_LEADER.."]|h %s:\32"
_G.CHAT_PARTY_GUIDE_GET = CHAT_PARTY_LEADER_GET
_G.CHAT_RAID_GET = "|Hchannel:raid|h["..L_CHAT_RAID.."]|h %s:\32"
_G.CHAT_RAID_LEADER_GET = "|Hchannel:raid|h["..L_CHAT_RAID_LEADER.."]|h %s:\32"
_G.CHAT_RAID_WARNING_GET = "["..L_CHAT_RAID_WARNING.."] %s:\32"
_G.CHAT_SAY_GET = "%s:\32"
_G.CHAT_WHISPER_GET = L_CHAT_WHISPER.." %s:\32"
_G.CHAT_YELL_GET = "%s:\32"
_G.CHAT_FLAG_AFK = "|cffFF0000"..L_CHAT_AFK.."|r "
_G.CHAT_FLAG_DND = "|cffE7E716"..L_CHAT_DND.."|r "
_G.CHAT_FLAG_GM = "|cff4154F5"..L_CHAT_GM.."|r "
_G.ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h "..L_CHAT_COME_ONLINE_COLOR
_G.ERR_FRIEND_OFFLINE_S = "%s "..L_CHAT_GONE_OFFLINE_COLOR
_G.ACHIEVEMENT_BROADCAST = "%s! %s!"
_G.ACHIEVEMENT_BROADCAST_SELF = "%s!"
_G.PLAYER_SERVER_FIRST_ACHIEVEMENT = "|Hplayer:%s|h[%s]|h! $a!"
_G.SERVER_FIRST_ACHIEVEMENT = "%s! $a!"
if SettingsDB.client == "ruRU" then
	_G.FACTION_STANDING_DECREASED = "Отношение |3-7(%s) -%d."
	_G.FACTION_STANDING_INCREASED = "Отношение |3-7(%s) +%d."
end

----------------------------------------------------------------------------------------
--	Custom timestamps color
----------------------------------------------------------------------------------------
do
	ChatFrame2ButtonFrameBottomButton:RegisterEvent("PLAYER_LOGIN")
	ChatFrame2ButtonFrameBottomButton:SetScript("OnEvent", function(f)
		_G.TIMESTAMP_FORMAT_HHMM = "|cff"..SettingsCF.chat.time_color.."[%I:%M]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS = "|cff"..SettingsCF.chat.time_color.."[%I:%M:%S]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS_24HR = "|cff"..SettingsCF.chat.time_color.."[%H:%M:%S]|r "
		_G.TIMESTAMP_FORMAT_HHMMSS_AMPM = "|cff"..SettingsCF.chat.time_color.."[%I:%M:%S %p]|r "
		_G.TIMESTAMP_FORMAT_HHMM_24HR = "|cff"..SettingsCF.chat.time_color.."[%H:%M]|r "
		_G.TIMESTAMP_FORMAT_HHMM_AMPM = "|cff"..SettingsCF.chat.time_color.."[%I:%M %p]|r "
		f:UnregisterEvent("PLAYER_LOGIN")
		f:SetScript("OnEvent", nil)
	end)
end

-- Hide friends micro button
SettingsDB.Kill(FriendsMicroButton)

-- Hide chat bubble menu button
SettingsDB.Kill(ChatFrameMenuButton)

-- Set chat style
local function SetChatStyle(frame)
	local id = frame:GetID()
	local chat = frame:GetName()

	-- ? :)
	_G[chat]:SetClampRectInsets(0, 0, 0, 0)
	
	-- Removes crap from the bottom of the chatbox so it can go to the bottom of the screen
	_G[chat]:SetClampedToScreen(false)

	-- Stop the chat chat from fading out
	_G[chat]:SetFading(false)
	
	-- Move the chat edit box
	_G[chat.."EditBox"]:ClearAllPoints();
	_G[chat.."EditBox"]:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", SettingsDB.Scale(-10), SettingsDB.Scale(20))
	_G[chat.."EditBox"]:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", SettingsDB.Scale(11), SettingsDB.Scale(20))
	
	-- Hide textures
	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end

	-- Removes Default ChatFrame Tabs texture				
	SettingsDB.Kill(_G[format("ChatFrame%sTabLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabRight", id)])

	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])
	
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabHighlightRight", id)])

	-- Killing off the new chat tab selected feature
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])

	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameUpButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameDownButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameBottomButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrameMinimizeButton", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sButtonFrame", id)])

	-- Kills off the retarded new circle around the editbox
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusLeft", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusMid", id)])
	SettingsDB.Kill(_G[format("ChatFrame%sEditBoxFocusRight", id)])

	SettingsDB.Kill(_G[format("ChatFrame%sTabGlow", id)])
	
	-- Kill off editbox artwork
	local a, b, c = select(6, _G[chat.."EditBox"]:GetRegions()); SettingsDB.Kill (a); SettingsDB.Kill (b); SettingsDB.Kill (c)

	-- Disable alt key usage
	_G[chat.."EditBox"]:SetAltArrowKeyMode(false)
	
	-- Hide editbox on login
	_G[chat.."EditBox"]:Hide()
	
	-- Script to hide editbox instead of fading editbox to 0.35 alpha via IM Style
	_G[chat.."EditBox"]:HookScript("OnEditFocusGained", function(self) self:Show() end)
	_G[chat.."EditBox"]:HookScript("OnEditFocusLost", function(self) self:Hide() end)
	
	-- Rename combat log tab
	if _G[chat] == _G["ChatFrame2"] then
		FCF_SetWindowName(_G[chat], GUILD_BANK_LOG)
	end
	
	if _G[chat] ~= _G["ChatFrame2"] then
		origs[_G[chat]] = _G[chat].AddMessage
		_G[chat].AddMessage = AddMessage
	end
end

-- Setup chatframes 1 to 10 on login
local function SetupChat(self)	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		SetChatStyle(frame)
	end
	
	-- Remember last channel
	ChatTypeInfo.SAY.sticky = 1
	ChatTypeInfo.PARTY.sticky = 1
	ChatTypeInfo.GUILD.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.BATTLEGROUND.sticky = 1
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
end

local function SetupChatPosAndFont(self)
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G[format("ChatFrame%s", i)]
		local id = chat:GetID()
		local name = FCF_GetChatWindowInfo(id)
		local point = GetChatWindowSavedPosition(id)
		local _, fontSize = FCF_GetChatWindowInfo(id)
		
		-- Min. size for chat font
		if fontSize < 11 then		
			FCF_SetChatWindowFontSize(nil, chat, SettingsCF.chat.font_size)
		else
			FCF_SetChatWindowFontSize(nil, chat, fontSize)
		end
		
		-- Force chat position
		if i == 1 then
			chat:ClearAllPoints()
			chat:SetSize(SettingsDB.Scale(SettingsCF.chat.width), SettingsDB.Scale(SettingsCF.chat.height))
			local pos = SettingsCF["position"]
			if SettingsCF["chat"].background == true then
				chat:SetPoint(pos.chat[1], pos.chat[2], pos.chat[3], pos.chat[4], pos.chat[5]+4)
			else
				chat:SetPoint(pos.chat[1], pos.chat[2], pos.chat[3], pos.chat[4], pos.chat[5])
			end
			FCF_SavePositionAndDimensions(chat)
		end
	end
	
	-- Reposition battle.net popup over chat #1
	BNToastFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint(unpack(SettingsCF.position.bn_popup))
	end)
end

UIChat:RegisterEvent("ADDON_LOADED")
UIChat:RegisterEvent("PLAYER_ENTERING_WORLD")
UIChat:SetScript("OnEvent", function(self, event, ...)
	local addon = ...
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_CombatLog" then
			self:UnregisterEvent("ADDON_LOADED")
			SetupChat(self)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		SetupChatPosAndFont(self)
	end
end)

-- Setup temp chat (BN, WHISPER) when needed
local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
	SetChatStyle(frame)
end
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

----------------------------------------------------------------------------------------
--	Tell Target
----------------------------------------------------------------------------------------
for i = 1, NUM_CHAT_WINDOWS do
	local editBox = _G["ChatFrame"..i.."EditBox"]
	editBox:HookScript("OnTextChanged", function(self)
	   local text = self:GetText()
	   if text:len() < 5 then
		  if text:sub(1, 4) == "/tt " then
			 local unitname, realm
			 unitname, realm = UnitName("target")
			 if unitname then unitname = gsub(unitname, " ", "") end
			 if unitname and not UnitIsSameServer("player", "target") then
				unitname = unitname .. "-" .. gsub(realm, " ", "")
			 end
			 ChatFrame_SendTell((unitname or SPELL_FAILED_BAD_TARGETS), ChatFrame1)
		  end
	   end
	end)
end

----------------------------------------------------------------------------------------
--	Copy Chat
----------------------------------------------------------------------------------------
local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreatCopyFrame()
	frame = CreateFrame("Frame", "CopyFrame", UIParent)
	SettingsDB.SkinFadedPanel(frame)
	frame:SetWidth(SettingsDB.Scale(500))
	frame:SetHeight(SettingsDB.Scale(300))
	frame:SetScale(1)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, SettingsDB.Scale(100))
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "CopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", SettingsDB.Scale(8), SettingsDB.Scale(-30))
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", SettingsDB.Scale(-30), SettingsDB.Scale(8))

	editBox = CreateFrame("EditBox", "CopyBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(SettingsDB.Scale(500))
	editBox:SetHeight(SettingsDB.Scale(300))
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

	isf = true
end

local function GetLines(...)
	-- Grab all those lines
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreatCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

function SettingsDB.ChatCopyButtons()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d",  i)]
		local button = CreateFrame("Button", format("ButtonCF%d", i), cf)
		button:SetPoint("BOTTOMRIGHT", 0, SettingsDB.Scale(1))
		button:SetHeight(SettingsDB.Scale(20))
		button:SetWidth(SettingsDB.Scale(20))
		button:SetAlpha(0)
		SettingsDB.SkinFadedPanel(button)
		button:SetBackdropBorderColor(SettingsDB.color.r, SettingsDB.color.g, SettingsDB.color.b)

		local buttontext = button:CreateFontString(nil, "OVERLAY", nil)
		buttontext:SetFont(SettingsCF.media.pixel_font, SettingsCF.media.pixel_font_size * 2, SettingsCF.media.pixel_font_style)
		buttontext:SetText("C")
		buttontext:SetPoint("CENTER")
		buttontext:SetJustifyH("CENTER")
		buttontext:SetJustifyV("CENTER")
			
		button:SetScript("OnMouseUp", function(self, btn)
			if i == 1 and btn == "RightButton" then
				ToggleFrame(ChatMenu)
			else
				Copy(cf)
			end
		end)
		button:SetScript("OnEnter", function() button:SetAlpha(1) end)
		button:SetScript("OnLeave", function() button:SetAlpha(0) end)
	end
end
SettingsDB.ChatCopyButtons()

----------------------------------------------------------------------------------------
--	Chat Scroll Module
----------------------------------------------------------------------------------------
local ScrollLines = 3 -- set the jump when a scroll is done
function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			for i = 1, ScrollLines do
				self:ScrollDown()
			end
		end
	elseif delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			for i = 1, ScrollLines do
				self:ScrollUp()
			end
		end
	end
end

----------------------------------------------------------------------------------------
--	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
if SettingsCF.chat.whisp_sound == true then
	local SoundSys = CreateFrame("Frame")
	SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
	SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
	SoundSys:HookScript("OnEvent", function(self, event, ...)
		if event == "CHAT_MSG_WHISPER" or "CHAT_MSG_BN_WHISPER" then
			PlaySoundFile(SettingsCF.media.whisp_sound)
		end
	end)
end

----------------------------------------------------------------------------------------
--	Chat Filter and Repeat spam filter(by Evl)
----------------------------------------------------------------------------------------
if SettingsCF.chat.filter == true then
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", function(msg) return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function(msg) return true end)
	DUEL_WINNER_KNOCKOUT = ""
	DUEL_WINNER_RETREAT = ""
	DRUNK_MESSAGE_ITEM_OTHER1 = ""
	DRUNK_MESSAGE_ITEM_OTHER2 = ""
	DRUNK_MESSAGE_ITEM_OTHER3 = ""
	DRUNK_MESSAGE_ITEM_OTHER4 = ""
	DRUNK_MESSAGE_OTHER1 = ""
	DRUNK_MESSAGE_OTHER2 = ""
	DRUNK_MESSAGE_OTHER3 = ""
	DRUNK_MESSAGE_OTHER4 = ""
	DRUNK_MESSAGE_ITEM_SELF1 = ""
	DRUNK_MESSAGE_ITEM_SELF2 = ""
	DRUNK_MESSAGE_ITEM_SELF3 = ""
	DRUNK_MESSAGE_ITEM_SELF4 = ""
	DRUNK_MESSAGE_SELF1 = ""
	DRUNK_MESSAGE_SELF2 = ""
	DRUNK_MESSAGE_SELF3 = ""
	DRUNK_MESSAGE_SELF4 = ""
	RAID_MULTI_LEAVE = ""
	RAID_MULTI_JOIN = ""
	ERR_PET_LEARN_ABILITY_S = ""
	ERR_PET_LEARN_SPELL_S = ""
	ERR_PET_SPELL_UNLEARNED_S = ""
	ERR_LEARN_ABILITY_S = ""
	ERR_LEARN_SPELL_S = ""
	ERR_SPELL_UNLEARNED_S = ""
	
	
	ChatFrame1.repeatFilter = true
	ChatFrame1:SetTimeVisible(10)

	local lastMessage
	local repeatMessageFilter = function(self, event, text, sender, ...)
		if self.repeatFilter then
			if not self.repeatMessages or self.repeatCount > 100 then
				self.repeatCount = 0
				self.repeatMessages = {}
			end
			lastMessage = self.repeatMessages[sender]
			if lastMessage == text then
				return true
			end
			self.repeatMessages[sender] = text
			self.repeatCount = self.repeatCount + 1
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", repeatMessageFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", repeatMessageFilter)
end

----------------------------------------------------------------------------------------
--	ChatBar(FavChatBar by Favorit)
----------------------------------------------------------------------------------------
if SettingsCF.chat.chat_bar == true then
	local cbar = CreateFrame("Frame", "favchat", favchat)
	cbar:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
	cbar:RegisterEvent("ADDON_LOADED")

	function cbar:SW(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/w ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/s ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GO(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/o ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/g ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:RP(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/raid ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/p ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:GT(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/2 ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/1 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:YG(button)
		if(button == "RightButton") then
			ChatFrame_OpenChat("/y ", SELECTED_DOCK_FRAME);		
		else
			ChatFrame_OpenChat("/3 ", SELECTED_DOCK_FRAME);	
		end
	end

	function cbar:Style()
		favchat:ClearAllPoints()
		favchat:SetParent(UIParent)

		sw = CreateFrame("Button", "sw", favchat)
		sw:ClearAllPoints()
		sw:SetParent(favchat)
		sw:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, SettingsCF.chat.background and SettingsCF.chat.height + 12 or SettingsCF.chat.height + 4)
		sw:SetWidth(SettingsDB.Scale(14))
		sw:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(sw)
		sw:SetBackdropBorderColor(0.7, 0.33, 0.82, 1)
		sw:RegisterForClicks("AnyUp")
		sw:SetScript("OnClick", cbar.SW)
		swtex = sw:CreateTexture(nil, "ARTWORK")
		swtex:SetTexture(SettingsCF.media.blank)
		swtex:SetVertexColor(0.8, 0.8, 0.8, 1)
		swtex:SetPoint("TOPLEFT", sw, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		swtex:SetPoint("BOTTOMRIGHT", sw, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		go = CreateFrame("Button", "go", favchat)
		go:ClearAllPoints()
		go:SetParent(favchat)
		go:SetPoint("TOP", sw, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		go:SetWidth(SettingsDB.Scale(14))
		go:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(go)
		go:SetBackdropBorderColor(0, 0.54, 0, 1)
		go:RegisterForClicks("AnyUp")
		go:SetScript("OnClick", cbar.GO)
		gotex = sw:CreateTexture(nil, "ARTWORK")
		gotex:SetTexture(SettingsCF.media.blank)
		gotex:SetVertexColor(0, 0.8, 0, 1)
		gotex:SetPoint("TOPLEFT", go, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		gotex:SetPoint("BOTTOMRIGHT", go, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
		
		rp = CreateFrame("Button", "rp", favchat)
		rp:ClearAllPoints()
		rp:SetParent(favchat)
		rp:SetPoint("TOP", go, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		rp:SetWidth(SettingsDB.Scale(14))
		rp:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(rp)
		rp:SetBackdropBorderColor(0.8, 0.4, 0.1, 1)
		rp:RegisterForClicks("AnyUp")
		rp:SetScript("OnClick", cbar.RP)
		rptex = rp:CreateTexture(nil, "ARTWORK")
		rptex:SetTexture(SettingsCF.media.blank)
		rptex:SetVertexColor(0.11, 0.5, 0.7, 1)
		rptex:SetPoint("TOPLEFT", rp, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		rptex:SetPoint("BOTTOMRIGHT", rp, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

		gt = CreateFrame("Button", "gt", favchat)
		gt:ClearAllPoints()
		gt:SetParent(favchat)
		gt:SetPoint("TOP", rp, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		gt:SetWidth(SettingsDB.Scale(14))
		gt:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(gt)
		gt:SetBackdropBorderColor(0.7, 0.7, 0, 1)
		gt:RegisterForClicks("AnyUp")
		gt:SetScript("OnClick", cbar.GT)
		gttex = rp:CreateTexture(nil, "ARTWORK")
		gttex:SetTexture(SettingsCF.media.blank)
		gttex:SetVertexColor(0.93, 0.8, 0.8, 1)
		gttex:SetPoint("TOPLEFT", gt, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		gttex:SetPoint("BOTTOMRIGHT", gt, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))

		yg = CreateFrame("Button", "yg", favchat)
		yg:ClearAllPoints()
		yg:SetParent(favchat)
		yg:SetPoint("TOP", gt, "BOTTOM", 0, SettingsCF.chat.background and SettingsDB.Scale(-11) or SettingsDB.Scale(-10))
		yg:SetWidth(SettingsDB.Scale(14))
		yg:SetHeight(SettingsDB.Scale(14))
		SettingsDB.CreateTemplate(yg)
		yg:SetBackdropBorderColor(0.7, 0.13, 0.13, 1)
		yg:RegisterForClicks("AnyUp")
		yg:SetScript("OnClick", cbar.YG)
		ygtex = rp:CreateTexture(nil, "ARTWORK")
		ygtex:SetTexture(SettingsCF.media.blank)
		ygtex:SetVertexColor(0.5, 1, 0.83, 1)
		ygtex:SetPoint("TOPLEFT", yg, "TOPLEFT", SettingsDB.Scale(2), SettingsDB.Scale(-2))
		ygtex:SetPoint("BOTTOMRIGHT", yg, "BOTTOMRIGHT", SettingsDB.Scale(-2), SettingsDB.Scale(2))
	end

	function cbar:ADDON_LOADED(event, name)
		self:Style()
	end
end