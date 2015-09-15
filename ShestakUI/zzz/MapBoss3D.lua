--副本地图boss3D
local T, C, L, _ = unpack(select(2, ...))
if  C.zzz.MapBoss3D ~= true then return end

-- Change the below line to "scale" the normal size of 3d model, i.e. 1 = same size as the boss button, .5 = half size of boss button, 2 = double size of boss button (size of clickable area does not change)
local model_scale = 1 -- default = 1
-- Change the below line to change size of the 3d model when moused over. This value is in multibles of normal size, i.e. 1 = same size as it is normal, 2 = double size of normal
local hover_scale = 4 -- default = 4

local function setupAnimation(frame)
	local enlargeGroup = frame:CreateAnimationGroup()
	local enlarge = enlargeGroup:CreateAnimation("Animation")
		enlarge:SetDuration(.25)
		enlarge:SetOrder(1)
		enlarge:SetScript("OnPlay", function(self)
			frame:SetScript('OnSizeChanged', nil)
		end)
		enlarge:SetScript("OnUpdate", function(self)
			local progress = self:GetProgress()
			local newWidth = frame.Width + ((frame.Width * hover_scale) - frame.Width) * progress
			local newHeight = frame.Height + ((frame.Height * hover_scale) - frame.Height) * progress
			frame:SetWidth(newWidth)
			frame:SetHeight(newHeight)
		end)
		enlarge:SetScript("OnFinished", function(self)
			local newWidth = frame.Width * hover_scale
			local newHeight = frame.Height * hover_scale
			frame:SetWidth(newWidth)
			frame:SetHeight(newHeight)
		end)
	enlargeGroup.enlarge = enlarge
	enlargeGroup:SetLooping("NONE")
	frame.enlargeGroup = enlargeGroup

	local reduceGroup = frame:CreateAnimationGroup()
	local reduce = reduceGroup:CreateAnimation("Animation")
		reduce:SetDuration(.25)
		reduce:SetOrder(1)
		reduce:SetScript("OnUpdate", function(self)
			local progress = self:GetProgress()
			local newWidth = frame.Width + ((frame.Width * hover_scale) - frame.Width) * (1 - progress)
			local newHeight = frame.Height + ((frame.Height * hover_scale) - frame.Height) * (1 - progress)
			frame:SetWidth(newWidth)
			frame:SetHeight(newHeight)
		end)
		reduce:SetScript("OnFinished", function(self)
			frame:SetWidth(frame.Width)
			frame:SetHeight(frame.Height)
		end)
	reduceGroup.reduce = reduce
	reduceGroup:SetLooping("NONE")
	frame.reduceGroup = reduceGroup
end


local oldMapID, oldMapLevel -- lets check if we are on a different map before we update
hooksecurefunc("EncounterJournal_AddMapButtons", function(...)
	local MapID = GetCurrentMapAreaID()
	local MapLevel = GetCurrentMapDungeonLevel()
	if oldMapID ~= MapID or oldMapLevel ~= MapLevel then
		oldMapID, oldMapLevel = MapID, MapLevel
		
		if _G["EJMapButton1"] then
			EJ_SelectInstance(_G["EJMapButton1"].instanceID)
			local index = 1;
			local x, y, instanceID, name, description, encounterID = EJ_GetMapEncounter(index);		
			while name do
				local bossButton = _G["EJMapButton"..index];
				local model = bossButton.model
				if not model then
					bossButton:SetAlpha(0)
					model = CreateFrame("PlayerModel",nil,bossButton:GetParent())
					model:SetPoint("CENTER", bossButton)
					model.Width = bossButton:GetWidth() * model_scale
					model:SetWidth(model.Width)
					model.Height = bossButton:GetHeight() * model_scale
					model:SetHeight(model.Height)
					model:SetFrameLevel(100)
					model:SetScale(bossButton:GetScale())

					bossButton:HookScript("OnHide", function() model:Hide() end)
					bossButton:HookScript("OnShow", function() model:Show() end)
					bossButton.model = model
					Model_OnLoad(model)
					
					setupAnimation(model)
					
					bossButton:HookScript("OnEnter", function() 
							model.reduceGroup:Stop()
							model.enlargeGroup:Play()
							model:SetFrameLevel(1000)
						end)
					bossButton:HookScript("OnLeave", function() 
							model.enlargeGroup:Stop()
							model.reduceGroup:Play()
							model:SetFrameLevel(100)
						end)
					
				end
				EJ_SelectEncounter(encounterID);
				local _, _, _, displayInfo = EJ_GetCreatureInfo(1);
				if displayInfo then
					model:SetDisplayInfo(displayInfo)
				end
				index = index + 1;
				x, y, instanceID, name, description, encounterID = EJ_GetMapEncounter(index);
			end
		end
		
		
	end
end)
