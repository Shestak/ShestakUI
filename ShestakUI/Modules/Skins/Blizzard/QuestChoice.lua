local T, C, L, _ = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest Choice skin
----------------------------------------------------------------------------------------

local function LoadSkin()
	for i = 1, 2 do
		local option = QuestChoiceFrame["Option"..i]
		local rewards = option.Rewards
		local icon = rewards.Item.Icon
		local currencies = rewards.Currencies

		T.HandleIcon(icon)

		for j = 1, 3 do
			local cu = currencies["Currency"..j]
			T.HandleIcon(cu.Icon)
		end
	end

	QuestChoiceFrame:CreateBackdrop("Transparent")
	QuestChoiceFrame.Option1.OptionButton:SkinButton()
	QuestChoiceFrame.Option2.OptionButton:SkinButton()
	QuestChoiceFrame.Option3.OptionButton:SkinButton()
	T.SkinCloseButton(QuestChoiceFrame.CloseButton)
	QuestChoiceFrame.CloseButton:SetFrameLevel(10)
end

T.SkinFuncs["Blizzard_QuestChoice"] = LoadSkin
