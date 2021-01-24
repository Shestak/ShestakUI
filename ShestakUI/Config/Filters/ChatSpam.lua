local T, C, L, _ = unpack(select(2, ...))
if C.chat.enable ~= true or C.chat.spam ~= true then return end

T.ChatSpamList = {
	"золото",
	"з0л0т0",
	"з0л0то",
	"золота",
	"голд",
	"г0лд",
	"золотишко",
	"золатишко",
	"блестяшки",
	"блестяшkи",
	"блестяхи",
	"монетки",
	"м0нетки",
	"монеты",
	"visа",
	"mastercard",
	"webmoney",
	"вебмани",
	"qiwi",
	"qiwі",
	"яндекс",
	"skype",
	"skуpe",
	"skуpе",
	"скайп",
	"скаип",
	"sкайп",
	"портал",
	"анус",
	"анальное"
}

for word in gmatch(C.chat.spam_list, "%S+") do
	tinsert(T.ChatSpamList, word)
end