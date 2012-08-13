local T, C, L = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.talents ~= true then return end

----------------------------------------------------------------------------------------
--	Target Talents
----------------------------------------------------------------------------------------
local ttt = CreateFrame("Frame", "GameTooltipTalents")
local maxtree, left, leftText

local function TalentQuery()
	if CanInspect("mouseover") then
		if UnitLevel("mouseover") > 9 then
			local talentline = nil
			for i = 1, GameTooltip:NumLines() do
				local left, leftText
				left = _G["GameTooltipTextLeft"..i]
				leftText = left:GetText()
				if leftText == TALENTS..": " then
					talentline = 1
				end
			end
			if not talentline then
				if InspectFrame and InspectFrame:IsShown() then
					GameTooltip:AddLine(TALENTS..": |cffff0000Inspect Frame is open|r")
				elseif Examiner and Examiner:IsShown() then
					GameTooltip:AddLine(TALENTS..": |cffff0000Examiner Frame is open|r")
				else
					talentsGUID = UnitGUID("mouseover")
					NotifyInspect("mouseover")
					ttt:RegisterEvent("INSPECT_READY")
					GameTooltip:AddLine(SPECIALIZATION..": |cffffffff"..L_TOOLTIP_LOADING.."|r")
				end
				GameTooltip:Show()
			end
		end
	end
end

local function TalentText()
	if UnitExists("mouseover") then
		maxtree = GetInspectSpecialization("mouseover")
		if maxtree and maxtree > 0 then
			for i = 1, GameTooltip:NumLines() do
				left = _G[GameTooltip:GetName().."TextLeft"..i]
				leftText = left:GetText() or ""
				if leftText:match("^"..SPECIALIZATION) then
					left:SetText(SPECIALIZATION..": |cffffffff"..select(2, GetSpecializationInfoByID(maxtree)).."|r")
				end
				GameTooltip:Show()
			end
		end
	end
	GameTooltip:UnregisterEvent("INSPECT_READY")
	maxtree = nil
end

ttt:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
ttt:SetScript("OnEvent", function(_, event, arg)
	if event == "UPDATE_MOUSEOVER_UNIT" then
		TalentQuery()
	elseif event == "INSPECT_READY" then
		if talentsGUID == arg then
			TalentText()
		end
	end
end)