local _E
if IsClassicBuild() then return end

local hooked

local updateContents = function(self)
	if not IsAddOnLoaded("Blizzard_VoidStorageUI") then return end

	for slot = 1, VOID_WITHDRAW_MAX or 80 do
		local slotFrame = _G["VoidStorageStorageButton"..slot]
		local page = VoidStorageFrame.page
		self:CallFilters("voidstore", slotFrame, _E and (GetVoidItemInfo(page, slot)))
	end

	for slot = 1, VOID_WITHDRAW_MAX or 9 do
		local slotFrame = _G["VoidStorageWithdrawButton"..slot]
		self:CallFilters("voidstore", slotFrame, _E and GetVoidTransferWithdrawalInfo(slot))
	end
end

local updateDeposit = function(self, event, slot)
	if not IsAddOnLoaded("Blizzard_VoidStorageUI") then return end

	local slotFrame = _G["VoidStorageDepositButton"..slot]
	self:CallFilters("voidstore", slotFrame, _E and GetVoidTransferDepositInfo(slot))
end

local update = function(self)
	if not IsAddOnLoaded("Blizzard_VoidStorageUI") then return end

	for slot = 1, VOID_DEPOSIT_MAX or 9 do
		updateDeposit(self, nil, slot)
	end

	return updateContents(self)
end

local function hookCheck(self)
	if not (IsAddOnLoaded("Blizzard_VoidStorageUI") and oGlow:IsPipeEnabled"voidstore") then return end

	if not hooked then
		hooksecurefunc("VoidStorage_SetPageNumber", function()
			updateContents(self)
		end)
		hooked = true

		self:UnregisterEvent("VOID_STORAGE_OPEN", hookCheck)
	end
end

local enable = function(self)
	_E = true

	self:RegisterEvent("VOID_STORAGE_CONTENTS_UPDATE", updateContents)
	self:RegisterEvent("VOID_STORAGE_DEPOSIT_UPDATE", updateDeposit)
	self:RegisterEvent("VOID_STORAGE_UPDATE", update)
	self:RegisterEvent("VOID_TRANSFER_DONE", update)
	self:RegisterEvent("VOID_STORAGE_OPEN", update)
	self:RegisterEvent("VOID_STORAGE_OPEN", hookCheck)
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent("VOID_STORAGE_CONTENTS_UPDATE", updateContents)
	self:UnregisterEvent("VOID_STORAGE_DEPOSIT_UPDATE", updateDeposit)
	self:UnregisterEvent("VOID_STORAGE_UPDATE", update)
	self:UnregisterEvent("VOID_TRANSFER_DONE", update)
	self:UnregisterEvent("VOID_STORAGE_OPEN", update)
	self:UnregisterEvent("VOID_STORAGE_OPEN", hookCheck)
end

oGlow:RegisterPipe("voidstore", enable, disable, update, "Void storage frame")