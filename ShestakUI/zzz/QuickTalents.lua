-- QuickTalents 快速切换天赋
local T, C, L, _ = unpack(select(2, ...))
if C.zzz.QuickTalents ~= true then return end

CreateFrame("Button","QuickTalents",UIParent,"SecureHandlerClickTemplate,SecureHandlerStateTemplate"):RegisterEvent("ADDON_LOADED");
QuickTalents:SetScript("OnEvent",function(self)
	self:UnregisterEvent("ADDON_LOADED");
	
	-- Load/Validate Settings
	local settings = {
		Scale = {1,"Set size/scale."},
		ShowTooltips = {true,"Toggle mouseover tooltips on talents."},
		BackgroundAlpha = {0.5, "Set background opacity."},
		Collapsed = {false},
		CollapseInCombat = {false,"Automatically hide buttons while in combat."},
		--UnfocusedAlpha = {1,"Set frame opacity when not in use."},
		--FixMacroSpells = {false,"Enable/Disable  in macros"},
		BarBottom = {true,"Show reagent bar on the bottom & collapse downwards."},
	};
	
	local cfg = {}	--QT_Settings or {};
	for k,v in pairs(settings) do
		if type(cfg[k]) ~= type(v[1]) then cfg[k] = v[1]; end
	end
	--QT_Settings = cfg;
	
	-- Main Frame
	self:SetPoint('CENTER');
	self:SetSize(86,18);
	self:SetMovable(true);
	self:IsUserPlaced(true);
	self:SetClampedToScreen(true);
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart", self.StartMoving)
	self:SetScript("OnDragStop", self.StopMovingOrSizing)
	--self:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8"});
	
	local ReagentText = self:CreateFontString();
	ReagentText:SetFont("Fonts\\ARIALN.TTF", 13, "OUTLINE");
	ReagentText:SetPoint("TOPRIGHT",-2,-2);
	
	local ButtonContainer = CreateFrame('Frame', '$parentButtonContainer', self, 'SecureFrameTemplate');
	--ButtonContainer:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8"});
	ButtonContainer:SetSize(150,300);
	
	self.Buttons = {};
	do -- Create Buttons
		local OnEnter = function(btn)
			if cfg.ShowTooltips then
				GameTooltip:SetOwner(btn, "ANCHOR_RIGHT");
				GameTooltip:SetTalent(btn.talentId);
				GameTooltip:Show();
			end
			btn:SetAlpha(btn.selected and 1 or 0.5);
		end
		local OnLeave = function(btn)
			GameTooltip:Hide();
			btn:SetAlpha(btn.selected and 1 or 0.25);
		end
		local OnDragStart = function(btn)
			return InCombatLockdown() or PickupTalent(btn.talentId);
		end;
		for i = 1,21 do
			local btn = CreateFrame("BUTTON","$parent_Button"..i,ButtonContainer,"SecureActionButtonTemplate");
			btn:SetAttribute("type1","macro");
			btn:SetSize(26,26);
			btn:CreateBackdrop()
			btn:SetPoint("TOPLEFT",2+((i-1)%3)*40,-((ceil(i/3)-1)*40)-2);
			btn:SetScript("OnLeave",OnLeave);
			btn:SetScript("OnEnter",OnEnter);
			btn:SetScript("OnDragStart",OnDragStart);
			btn:RegisterForDrag("LeftButton");
			btn:SetAttribute("macrotext",
				"/stopmacro [combat]\n"..
				"/click QuickTalentsOpener\n".. -- ensures the talent frame is ready for interaction
				"/click PlayerTalentFrameTalentsTalentRow"..ceil(i/3).."Talent"..((i-1)%3+1).."\n".. -- only way(?) to get the unlearn popup without taint
				"/click StaticPopup1Button1\n".. -- confirm unlearn (TODO: what if popup1 is not the talent prompt)
				"/run QuickTalents:Learn("..i..")\n" -- queue new talents for learn
			);
			btn.texture = btn:CreateTexture(nil,"ARTWORK");
			btn.texture:SetAllPoints();
			btn.texture:SetTexCoord(0.075,0.925,0.075,0.925);
			self.Buttons[i] = btn;
		end
	end
	
	-- Handles the safe loading & opening of the Blizzard Talent UI
	CreateFrame("BUTTON","QuickTalentsOpener",self,"SecureActionButtonTemplate"):SetAttribute("type","macro");
	QuickTalentsOpener:SetAttribute("macrotext",
		"/click TalentMicroButton\n"..
		"/click [spec:1] PlayerSpecTab1\n"..
		"/click [spec:2] PlayerSpecTab2\n"..
		"/click PlayerTalentFrameTab3\n"..
		"/click PlayerTalentFrameTab2\n"..
		"/click TalentMicroButton"
	);
	
	-- Learn Queue
	function self:Learn(i)
		local id = self.Buttons[i].talentId;
		local isFree, curId = GetTalentRowSelectionInfo(ceil(i/3));
		if id == curId then
			return; -- already selected
		end
		C_Timer.After( isFree and 0 or 0.1, function()
			LearnTalents(id)
		end);
	end
	
	-- Updates button textures and stuff on talent changes
	function self:Update()
		local reagents, icon = select(2,GetTalentClearInfo());
		ReagentText:SetText( format("%d |T%s:13:13:0:0:64:64:5:59:5:59|t",reagents or 0, icon or '') );
		local group = GetActiveSpecGroup();
		for i,btn in pairs(self.Buttons) do
			local id, name, texture, selected = GetTalentInfo( ceil(i/3), 1+(i-1)%3, group );
			btn.talentId = id;
			btn.selected = selected;
			btn:SetAlpha(selected and 1 or 0.25);
			btn.texture:SetTexture(texture);
		end
		
		-- apply settings
		self:SetBackdropColor(0,0,0,cfg.BackgroundAlpha);
		ButtonContainer:SetBackdropColor(0,0,0,cfg.BackgroundAlpha);
		if not InCombatLockdown() then
			self:SetAttribute("CollapseInCombat",cfg.CollapseInCombat);
			self:SetScale(cfg.Scale);
			
			ButtonContainer:ClearAllPoints();
			if cfg.BarBottom then
				ButtonContainer:SetPoint('BOTTOMLEFT',self,'TOPLEFT',0,-2);
			else
				ButtonContainer:SetPoint('TOPLEFT',self,'BOTTOMLEFT',0,2);
			end
		end
		
	end
	self:Update()
	
	-- Event Handler
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("BAG_UPDATE_DELAYED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:SetScript("OnEvent",function(self,e,...)
		if e:match("^PLAYER_REGEN") then
			for i,btn in pairs(self.Buttons) do
				SetDesaturation(btn.texture, e=="PLAYER_REGEN_DISABLED");
			end
		end
		self:Update();
	end);
	
	-- Collapse stuff
	self:SetAttribute("Collapsed",cfg.Collapsed);
	self:SetAttribute('Update',[[
		if self:GetAttribute("Collapsed") or (PlayerInCombat() and self:GetAttribute("CollapseInCombat")) then
			self:GetFrameRef("ButtonContainer"):Hide()
		else
			self:GetFrameRef("ButtonContainer"):Show()
		end
	]]);
	self:SetAttribute("_onclick",[[
		self:SetAttribute("Collapsed", not self:GetAttribute("Collapsed") );
		self:RunAttribute("Update");
	]]);
	self:HookScript("OnClick",function()
		cfg.Collapsed = self:GetAttribute("Collapsed");
	end);
	RegisterStateDriver(self, 'combat', '[combat]1;2;');
	self:SetAttribute('_onstate-combat', 'self:RunAttribute("Update")');
	self:SetFrameRef("ButtonContainer", ButtonContainer);
	
	
	SLASH_QUICKTALENTS1,SLASH_QUICKTALENTS2 = "/quicktalents","/qts";
	SlashCmdList.QUICKTALENTS = function(args)
		local arg1,arg2 = strsplit(" ",strlower(args),2);
		
		for key, info in pairs(settings) do
			if strlower(key) == arg1 then
				if type(info[1]) == 'boolean' then
					cfg[key] = not not (( arg2 == 'true' ) or ( arg2 ~= 'false' and not cfg[key] ));
				elseif type(info[1]) == 'number' then
					cfg[key] = tonumber(arg2) or cfg[key];
				end
				print(format("|cFF0088FF%s|r: |cFF00BBFF%s|r", key, tostring(cfg[key])));
				self:Update();
				return;
			end
		end
		
		print("Options:");
		for key, info in pairs(settings) do
			if info[2] then
				print(format("|cFF0088FF%s|r [|cFF00BBFF%s|r] - %s", key, tostring(cfg[key]), info[2]));
			end
		end
	end
	
end);
