-- TODO:
--  - Possibly clean-up the dupe code.
--  - Write a description.

local hook
local stack = {}

local send = function(self)
	if(not SendMailFrame:IsShown()) then return end

	for i=1, ATTACHMENTS_MAX_SEND do
		local slotLink = GetSendMailItemLink(i)
		local slotFrame = _G["SendMailAttachment"..i]
		self:CallFilters('mail', slotFrame, slotLink)
	end
end

local inbox = function()
	if(oGlow:IsPipeEnabled'mail') then
		local numItems = GetInboxNumItems()
		local index = ((InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY) + 1

		for i=1, INBOXITEMS_TO_DISPLAY do
			local slotFrame = _G["MailItem"..i.."Button"]
			if (index <= numItems) then
				for j=1, ATTACHMENTS_MAX_RECEIVE do
					local attachLink = GetInboxItemLink(index, j)
					if(attachLink) then
						table.insert(stack, attachLink)
					end
				end
			end

			oGlow:CallFilters('mail', slotFrame, unpack(stack))
			wipe(stack)

			index = index + 1
		end
	end
end

local letter = function()
	if(oGlow:IsPipeEnabled'mail') then
		if(not InboxFrame.openMailID) then return end

		for i=1, ATTACHMENTS_MAX_RECEIVE do
			local itemLink = GetInboxItemLink(InboxFrame.openMailID, i)
			if(itemLink) then
				local slotFrame = _G["OpenMailAttachmentButton"..i]

				oGlow:CallFilters('mail', slotFrame, itemLink)
			end
		end
	end
end

local enable = function(self)
	self:RegisterEvent('MAIL_SHOW', send)
	self:RegisterEvent('MAIL_SEND_INFO_UPDATE', send)
	self:RegisterEvent('MAIL_SEND_SUCCESS', send)

	if(not hook) then
		hooksecurefunc("OpenMail_Update", letter)
		hooksecurefunc("InboxFrame_Update", inbox)
		hook = true
	end
end

local disable = function(self)
	self:UnregisterEvent('MAIL_SHOW', send)
	self:UnregisterEvent('MAIL_SEND_INFO_UPDATE', send)
	self:UnregisterEvent('MAIL_SEND_SUCCESS', send)

	for i=1, INBOXITEMS_TO_DISPLAY do
		oGlow:CallFilters('mail', _G["MailItem"..i.."Button"])
	end

	for i=1, ATTACHMENTS_MAX_RECEIVE do
		oGlow:CallFilters('mail', _G["OpenMailAttachmentButton"..i])
	end
end

local update = function(self)
	send(self)
	inbox()
	letter()
end

oGlow:RegisterPipe('mail', enable, disable, update, 'Mail frame', nil)
