local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest Choice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestChoiceFrame:CreateBackdrop("Transparent")
	T.SkinCloseButton(QuestChoiceFrame.CloseButton)

	for i = 1, 4 do
		local option = QuestChoiceFrame["Option"..i]
		local rewards = option.Rewards
		local icon = rewards.Item.Icon
		local currencies = rewards.Currencies

		option.OptionButton:SkinButton()
		rewards.Item.IconBorder:SetAlpha(0)
		T.HandleIcon(icon)

		for j = 1, 3 do
			local cu = currencies["Currency"..j]
			T.HandleIcon(cu.Icon)
		end
	end
end

T.SkinFuncs["Blizzard_QuestChoice"] = LoadSkin