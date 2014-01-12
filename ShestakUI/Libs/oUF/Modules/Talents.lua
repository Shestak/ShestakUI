local T, C, L = unpack(select(2, ...))
if C.unitframe.enable ~= true or C.unitframe.plugins_talents ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_Talents(by Fernir)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local function Update(object, event, unit)
	if object.unit ~= unit or unit == "player" or unit:find("pet") then return end
	object.Talents:SetText("")
	if UnitIsFriend("player", unit) or not UnitIsPlayer(unit) then return end
	local _, instanceType = IsInInstance()
	if instanceType == "pvp" then
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, _, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
			if GetUnitName(unit, true) == name then
				object.Talents:SetText(talentSpec)
			end
		end
	elseif instanceType == "arena" then
		local ID = object.unit:match('arena(%d)') or object:GetID() or 0
		local specID = GetArenaOpponentSpec(tonumber(ID))
		if specID and specID > 0 then
			local _, name = GetSpecializationInfoByID(specID)
			object.Talents:SetText(name)
		end
	end
end

local function Enable(object)
	if not object.Talents then return end
	object:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", Update)
	object:RegisterEvent("ARENA_OPPONENT_UPDATE", Update)
	return true
end

local function Disable(object)
	if object.Talents then
		object:UnregisterEvent("UPDATE_BATTLEFIELD_SCORE", Update)
		object:UnregisterEvent("ARENA_OPPONENT_UPDATE", Update)
	end
end

oUF:AddElement("Talents", Update, Enable, Disable)
for i, frame in ipairs(oUF.objects) do Enable(frame) end