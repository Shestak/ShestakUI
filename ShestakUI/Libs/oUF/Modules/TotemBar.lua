local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_totem_bar ~= true or T.class ~= "SHAMAN" then return end

----------------------------------------------------------------------------------------
--	Based on oUF_TotemBar(by Soeters)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local _, pClass = UnitClass("player")
local total = 0
local delay = 0.01

-- In the order, fire, earth, water, air
local colors = {
	[1] = {0.58, 0.23, 0.10},
	[2] = {0.23, 0.45, 0.13},
	[3] = {0.19, 0.48, 0.60},
	[4] = {0.42, 0.18, 0.74},
}

local GetTotemInfo, SetValue, GetTime = GetTotemInfo, SetValue, GetTime

local Abbrev = function(name)
	local newname = (string.len(name) > 11) and string.gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name
	return T.UTF(newname, 11, false)
end

local function TotemOnClick(self,...)
	local id = self.ID
	local mouse = ...

	if IsShiftKeyDown() then
		for j = 1, 4 do 
			DestroyTotem(j)
		end 
	else 
		DestroyTotem(id) 
	end
end

local function InitDestroy(self)
	local totem = self.TotemBar
	for i = 1, 4 do
		local Destroy = CreateFrame("Button",nil, totem[i])
		Destroy:SetAllPoints(totem[i])
		Destroy:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		Destroy.ID = i
		Destroy:SetScript("OnClick", TotemOnClick)
	end
end

local function UpdateSlot(self, slot)
	local totem = self.TotemBar
	local haveTotem, name, startTime, duration, totemIcon = GetTotemInfo(slot)

	totem[slot]:SetStatusBarColor(unpack(totem.colors[slot]))
	totem[slot]:SetValue(0)

	-- Multipliers
	if (totem[slot].bg.multiplier) then
		local mu = totem[slot].bg.multiplier
		local r, g, b = totem[slot]:GetStatusBarColor()
		r, g, b = r*mu, g*mu, b*mu
		totem[slot].bg:SetVertexColor(r, g, b) 
	end

	totem[slot].ID = slot

	-- If we have a totem then set his value 
	if haveTotem then
		
		if totem[slot].Name then
			totem[slot].Name:SetText(Abbrev(name))
		end
		if duration >= 0 then
			totem[slot]:SetValue(1 - ((GetTime() - startTime) / duration))
			-- Status bar update
			totem[slot]:SetScript("OnUpdate", function(self, elapsed)
					total = total + elapsed
					if total >= delay then
						total = 0
						haveTotem, name, startTime, duration, totemIcon = GetTotemInfo(self.ID)
							if ((GetTime() - startTime) == 0) then
								self:SetValue(0)
							else
								self:SetValue(1 - ((GetTime() - startTime) / duration))
							end
					end
				end)
		else
			-- There's no need to update because it doesn't have any duration
			totem[slot]:SetScript("OnUpdate", nil)
			totem[slot]:SetValue(0)
		end 
	else
		-- No totem = no time 
		if totem[slot].Name then
			totem[slot].Name:SetText(" ")
		end
		totem[slot]:SetValue(0)
	end

end

local function Update(self, unit)
	-- Update every slot on login, still have issues with it
	for i = 1, 4 do 
		UpdateSlot(self, i)
	end
end

local function Event(self, event, ...)
	if event == "PLAYER_TOTEM_UPDATE" then
		UpdateSlot(self, ...)
	end
end

local function Enable(self, unit)
	local totem = self.TotemBar

	if totem then
		self:RegisterEvent("PLAYER_TOTEM_UPDATE", Event)
		totem.colors = setmetatable(totem.colors or {}, {__index = colors})
		delay = totem.delay or delay
		if totem.Destroy then
			InitDestroy(self)
		end
		TotemFrame:UnregisterAllEvents()
		return true
	end
end

local function Disable(self,unit)
	local totem = self.TotemBar
	if totem then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Event)

		TotemFrame:Show()
	end
end

oUF:AddElement("TotemBar", Update, Enable, Disable)