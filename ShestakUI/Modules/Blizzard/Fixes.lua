local T, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Fix blank tooltip
----------------------------------------------------------------------------------------
local bug = nil
local FixTooltip = CreateFrame("Frame")
FixTooltip:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
FixTooltip:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
FixTooltip:SetScript("OnEvent", function()
	if GameTooltip:IsShown() then
		bug = true
	end
end)

local FixTooltipBags = CreateFrame("Frame")
FixTooltipBags:RegisterEvent("BAG_UPDATE_DELAYED")
FixTooltipBags:SetScript("OnEvent", function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		if GameTooltip:IsShown() then
			bug = true
		end
	end
end)

GameTooltip:HookScript("OnTooltipCleared", function(self)
	if self:IsForbidden() then return end
	if bug and self:NumLines() == 0 then
		self:Hide()
		bug = false
	end
end)

----------------------------------------------------------------------------------------
--	Fix RemoveTalent() taint
----------------------------------------------------------------------------------------
FCF_StartAlertFlash = T.dummy

----------------------------------------------------------------------------------------
--	Fix DeclensionFrame strata
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	_G["DeclensionFrame"]:SetFrameStrata("HIGH")
end

----------------------------------------------------------------------------------------
--	Fix SearchLFGLeave() taint
----------------------------------------------------------------------------------------
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function()
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)

----------------------------------------------------------------------------------------
-- Taint workarounds by townlong-yak.com (rearranged by Simpy)
----------------------------------------------------------------------------------------
do
	-- HonorFrameLoadTaint	- https://www.townlong-yak.com/bugs/afKy4k-HonorFrameLoadTaint
	if _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION or 0 < 2 then _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION = 2 end
	-- CommunitiesUI			- https://www.townlong-yak.com/bugs/Kjq4hm-DisplayModeTaint
	if _G.UIDROPDOWNMENU_OPEN_PATCH_VERSION or 0 < 1 then _G.UIDROPDOWNMENU_OPEN_PATCH_VERSION = 1 end
	-- CommunitiesUI #2		- https://www.townlong-yak.com/bugs/YhgQma-SetValueRefreshTaint
	if _G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION or 0 < 1 then _G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION = 1 end
	-- RefreshOverread		- https://www.townlong-yak.com/bugs/Mx7CWN-RefreshOverread
	if _G.UIDD_REFRESH_OVERREAD_PATCH_VERSION or 0 < 1 then _G.UIDD_REFRESH_OVERREAD_PATCH_VERSION = 1 end

	if _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION == 2 or _G.UIDROPDOWNMENU_OPEN_PATCH_VERSION == 1 or _G.UIDD_REFRESH_OVERREAD_PATCH_VERSION == 1 then
		local function drop(t, k)
			local c = 42
			t[k] = nil
			while not issecurevariable(t, k) do
				if t[c] == nil then
					t[c] = nil
				end
				c = c + 1
			end
		end

		hooksecurefunc('UIDropDownMenu_InitializeHelper', function(frame)
			if _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION == 2 or _G.UIDD_REFRESH_OVERREAD_PATCH_VERSION == 1 then
				for i=1, _G.UIDROPDOWNMENU_MAXLEVELS do
					for j=1, _G.UIDROPDOWNMENU_MAXBUTTONS do
						local b, _ = _G['DropDownList' .. i .. 'Button' .. j]
						if _G.UIDROPDOWNMENU_VALUE_PATCH_VERSION == 2 and not (issecurevariable(b, 'value') or b:IsShown()) then
							b.value = nil
							repeat j, b['fx' .. j] = j+1, nil
							until issecurevariable(b, 'value')
						end
						if _G.UIDD_REFRESH_OVERREAD_PATCH_VERSION == 1 then
							_ = issecurevariable(b, 'checked')      or drop(b, 'checked')
							_ = issecurevariable(b, 'notCheckable') or drop(b, 'notCheckable')
						end
					end
				end
			end

			if _G.UIDROPDOWNMENU_OPEN_PATCH_VERSION == 1 then
				if _G.UIDROPDOWNMENU_OPEN_MENU and _G.UIDROPDOWNMENU_OPEN_MENU ~= frame and not issecurevariable(_G.UIDROPDOWNMENU_OPEN_MENU, 'displayMode') then
					_G.UIDROPDOWNMENU_OPEN_MENU = nil
					local prefix, i = ' \0', 1
					repeat i, _G[prefix .. i] = i + 1, nil
					until issecurevariable(_G.UIDROPDOWNMENU_OPEN_MENU)
				end
			end
		end)
	end

	if _G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION == 1 then
		local function CleanDropdowns()
			if _G.COMMUNITY_UIDD_REFRESH_PATCH_VERSION == 1 then
				local f, f2 = _G.FriendsFrame, _G.FriendsTabHeader
				local s = f:IsShown()
				f:Hide()
				f:Show()
				if not f2:IsShown() then
					f2:Show()
					f2:Hide()
				end
				if not s then
					f:Hide()
				end
			end
		end

		hooksecurefunc('Communities_LoadUI', CleanDropdowns)
		hooksecurefunc('SetCVar', function(n)
			if n == 'lastSelectedClubId' then
				CleanDropdowns()
			end
		end)
	end
end