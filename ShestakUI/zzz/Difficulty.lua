-- [ 小地圖團隊難度標識 ]--
local T, C, L, _ = unpack(select(2, ...))
if  C.zzz.Difficulty ~= true then return end

MiniMapInstanceDifficulty:Hide() 
MiniMapInstanceDifficulty.Show = function() return end 
GuildInstanceDifficulty:Hide() 
GuildInstanceDifficulty.Show = function() return end 

local function CreateFS(parent, size, justify) 
	local f = parent:CreateFontString(nil, "OVERLAY") 
	f:SetFont("Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf", 11, "OUTLINE")         -- 字体路径.   GameFontNormal:GetFont()可以改为具体的字体路径, 例如:   "Fonts\\ARKai_T.ttf" 
	f:SetShadowColor(0, 0, 0, 0)
	if(justify) then
		f:SetJustifyH(justify)
	end
	return f 
end 

local rd = CreateFrame("Frame", nil, Minimap) 
rd:SetSize(22, 11) 
rd:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, -2) 
rd:RegisterEvent("PLAYER_ENTERING_WORLD") 
rd:RegisterEvent("PLAYER_DIFFICULTY_CHANGED") 
rd:RegisterEvent("GUILD_PARTY_STATE_UPDATED") 
rd:RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED") 
rd:RegisterEvent("GROUP_ROSTER_UPDATE")

local rdt = CreateFS(rd, 10, "RIGHT") 
rdt:SetPoint("RIGHT")

local instanceTexts = {
	[0] = { text = "", color = {0, 0, 0, 0}}, 
	[1] = { text = "5", color = {153/255, 217/255, 234/255}},		--"Normal"
	[2] = { text = "5H", color = {0/255, 162/255, 232/255}},		--"Heroic"
	[3] = { text = "10", color = {255/255, 242/255, 0/255}},		--"10 Player"
	[4] = { text = "25", color = {255/255, 201/255, 14/255}},		--"25 Player"
	[5] = { text = "10H", color = {255/255, 127/255, 39/255}},		--"10 Player (Heroic)"
	[6] = { text = "25H", color = {237/255, 28/255, 36/255}},		--"25 Player (Heroic)"
	[7] = { text = "RF", color = {181/255, 230/255, 29/255}},		--"Looking For Raid"查找器 
	[8] = { text = "CM", color = {63/255, 72/255, 204/255}},		--"Challenge Mode"挑战 
	[9] = { text = "40", color = {237/255, 28/255, 36/255}},		--"40 Player"
	[11] = { text = "3H", color = {52/255, 52/255, 52/255}},		--"Heroic Scenario"
	[12] = { text = "3", color = {52/255, 52/255, 52/255}},			--"Normal Scenario"
	[16] = { text = "M", color = {255/255, 125/255, 10/255}},		--"Mythic"M史诗 
	[23] = { text = "5M", color = {255/255, 125/255, 10/255}},		--"Mythic" (Dungeons)史诗地下城 
	[24] = { text = "5T", color = {0/255, 162/255, 232/255}},		--"Timewalker" (Dungeons)时光地下城 
}

rd:SetScript("OnEvent", function()
	local inInstance, instanceType = IsInInstance()
	local _, _, difficultyID, _, _, _, _, _, instanceGroupSize = GetInstanceInfo()

	if instanceTexts[difficultyID] ~= nil then
		rdt:SetText(instanceTexts[difficultyID].text)
		rdt:SetTextColor(unpack(instanceTexts[difficultyID].color))
	else
		if difficultyID == 14 then							--"Normal"
			rdt:SetText(instanceGroupSize.."N") 
			rdt:SetTextColor(255/255, 201/255, 14/255)
		elseif difficultyID == 15 then						--"Heroic"
			rdt:SetText(instanceGroupSize.."H") 
			rdt:SetTextColor(237/255, 28/255, 36/255)
		elseif difficultyID == 17 then						--"Looking For Raid"“进攻奥格瑞玛” 查找器
			rdt:SetText(instanceGroupSize.."RF")
			rdt:SetTextColor(181/255, 230/255, 29/255)
		else
			rdt:SetText("")
		end
	end
   
	if not (inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")) then
		rd:Hide()
	else
		rd:Show()
	end
end)