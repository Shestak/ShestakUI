local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest Choice skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestChoiceFrame:CreateBackdrop("Transparent")
	T.SkinCloseButton(QuestChoiceFrame.CloseButton)

	for i = 1, 4 do
		local option = QuestChoiceFrame["Option"..i]
		local rewards = option.Rewards
		local item = rewards.Item
		local icon = item.Icon
		local currencies = rewards.Currencies
		local container = option.OptionButtonsContainer

		item.IconBorder:SetAlpha(0)
		icon:SkinIcon()

		for j = 1, 3 do
			local cu = currencies["Currency"..j]
			cu.Icon:SkinIcon()
		end

		for j = 1, 2 do
			local button = container["OptionButton"..j]
			button:SkinButton()
		end
	end
end

T.SkinFuncs["Blizzard_QuestChoice"] = LoadSkin