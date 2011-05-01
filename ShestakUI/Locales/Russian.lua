local T, C, L = unpack(select(2, ...))
if T.client ~= "ruRU" then return end

----------------------------------------------------------------------------------------
--	Localization for ruRU client
----------------------------------------------------------------------------------------
-- Tooltip
L_TOOLTIP_NO_TALENT = "Нет талантов"
L_TOOLTIP_LOADING = "Загрузка..."
L_TOOLTIP_ACH_STATUS = "Ваш статус:"
L_TOOLTIP_ACH_COMPLETE = "Ваш статус: Получено "
L_TOOLTIP_ACH_INCOMPLETE = "Ваш статус: Не завершено"
L_TOOLTIP_SPELL_ID = "Номер заклинания:"
L_TOOLTIP_ITEM_ID = "Номер предмета:"
L_TOOLTIP_WHO_TARGET = "Выбран целью"

-- Misc
L_MISC_UNDRESS = "Раздеть"
L_MISC_DRINKING = " пьёт."

-- Raid Utility
L_RAID_UTIL_DISBAND = "Распустить группу"

-- Zone name
L_ZONE_WINTERGRASP = "Озеро Ледяных Оков"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Ссылка на Wowhead"

-- Toogle Menu
L_TOGGLE_ADDON = "Модификация "
L_TOGGLE_ADDONS = " модификации"
L_TOGGLE_EXPAND = "Показать "
L_TOGGLE_COLLAPSE = "Скрыть "
L_TOGGLE_RCLICK = "ПКМ - Включить или выключить "
L_TOGGLE_LCLICK = "ЛКМ - Показать окно "
L_TOGGLE_RELOAD = " (необходимо перезагрузить интерфейс)"

-- UnitFrame
L_UF_GHOST = "Призрак"
L_UF_DEAD = "Мёртв"
L_UF_OFFLINE = "Не в сети"
L_UF_MANA = "Мало маны"
L_UF_TRINKET_READY = "Аксессуар готов: "
L_UF_TRINKET_USED = "Аксессуар задействован: "
L_UF_WOTF_USED = "WotF задействован: "

-- Map
L_MAP_CURSOR = "Курсор: "
L_MAP_BOUNDS = "Вне карты!"

-- Minimap
L_MINIMAP_CALENDAR = "Календарь"

-- Addons list
L_ALOAD_RL = "Перезагрузить"
L_ALOAD_TRADE = "Торговля"
L_ALOAD_SOLO = "Соло"
L_ALOAD_DEP = "Зависимые ресурсы: "

-- Chat
L_CHAT_WHISPER = "От"
L_CHAT_BN_WHISPER = "От"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "Г"
L_CHAT_PARTY = "Гр"
L_CHAT_PARTY_LEADER = "Лгр"
L_CHAT_RAID	= "Р"
L_CHAT_RAID_LEADER = "ЛР"
L_CHAT_RAID_WARNING	= "ОР"
L_CHAT_BATTLEGROUND	= "ПБ"
L_CHAT_BATTLEGROUND_LEADER = "ЛПБ"
L_CHAT_OFFICER = "О"
L_CHAT_COME_ONLINE = "входит в игровой мир."
L_CHAT_GONE_OFFLINE = "выходит из игрового мира."
L_CHAT_COME_ONLINE_COLOR = "|cff298F00входит|r в игровой мир!"
L_CHAT_GONE_OFFLINE_COLOR = "|cffff0000выходит|r из игрового мира!"

-- Errors frame
L_ERRORFRAME_L = "Щелкните, чтобы посмотреть ошибки."

-- Bags
L_BAG_BANK = "Банк"
L_BAG_NO_SLOTS = "Невозможно купить еще ячеек!"
L_BAG_COSTS = "Цена: %.2f золотых"
L_BAG_BUY_SLOTS = "Купить новую ячейку командой /bags purchase yes"
L_BAG_OPEN_BANK = "Сначала откройте банк."
L_BAG_SORT = "Сортировать предметы в сумке или банке, если они открыты."
L_BAG_STACK = "Заполнить неполные стопки в сумках или банке, если они открыты."
L_BAG_BUY_BANKS_SLOT = "Купить банковскую ячейку (банк должен быть открыт)."
L_BAG_SORT_MENU = "Сортировать"
L_BAG_SORT_SPECIAL = "Сортировать в спецсумках"
L_BAG_STACK_MENU = "Сложить"
L_BAG_STACK_SPECIAL = "Сложить в спецсумках"
L_BAG_SHOW_BAGS = "Показать сумки"
L_BAG_SORTING_BAGS = "Сортировка завершена."
L_BAG_NOTHING_SORT = "Нечего сортировать."
L_BAG_BAGS_BIDS = "Использование сумок: "
L_BAG_STACK_END = "Заполнение завершено."
L_BAG_RIGHT_CLICK_SEARCH = "ПКМ для поиска"

-- Grab mail
L_MAIL_STOPPED = "Сбор почты приостановлен из-за заполненных сумок."
L_MAIL_COMPLETE = "Сбор почты окончен."
L_MAIL_NEED = "Нужен почтовый ящик."
L_MAIL_MESSAGES =  "сообщений"

-- Loot
L_LOOT_RANDOM = "Случайному игроку"
L_LOOT_SELF = "Забрать себе"
L_LOOT_UNKNOWN = "Неизвестно"
L_LOOT_FISH = "Рыбалка"
L_LOOT_MONSTER = ">> Добыча с "
L_LOOT_CHEST = ">> Добыча из сундука"
L_LOOT_ANNOUNCE = "Объявить"
L_LOOT_TO_RAID = "  рейду"
L_LOOT_TO_PARTY = "  группе"
L_LOOT_TO_GUILD = "  гильдии"
L_LOOT_TO_SAY = "  сказав"
L_LOOT_CANNOT = "Невозможно выбрать"

-- LitePanels AFK module
L_PANELS_AFK = "Вы отсутствуете!"
L_PANELS_AFK_RCLICK = "Нажмите пкм, чтобы скрыть."
L_PANELS_AFK_LCLICK = "Нажмите лкм, чтобы вернуться."

-- Cooldowns
L_COOLDOWNS = "Перезарядка: "

-- Autoinvite
L_INVITE_ENABLE = "Авто приглашение включено: "
L_INVITE_DISABLE = "Авто приглашение выключено"

-- Bind key
L_BIND_SAVED = "Все назначения клавиш сохранены."
L_BIND_DISCARD = "Все новые назначения клавиш были отменены."
L_BIND_INSTRUCT = "Наведите указатель мыши на кнопку действия, чтобы назначить клавишу. Нажмите клавишу ESC или правую кнопку мыши, чтобы убрать назначение."
L_BIND_CLEARED = "Все назначения были отменены для клавиши"
L_BIND_BINDING = "Назначение"
L_BIND_KEY = "Клавиша"
L_BIND_NO_SET = "Не назначено"

-- Talent spec
L_PLANNER_DEATHKNIGHT_1 = "Кровь"
L_PLANNER_DEATHKNIGHT_2 = "Холод"
L_PLANNER_DEATHKNIGHT_3 = "Нечестивость"
L_PLANNER_WARRIOR_1 = "Оружие"
L_PLANNER_WARRIOR_2 = "Неистовство"
L_PLANNER_WARRIOR_3 = "Защита"
L_PLANNER_ROGUE_1 = "Ликвидация"
L_PLANNER_ROGUE_2 = "Бой"
L_PLANNER_ROGUE_3 = "Скрытность"
L_PLANNER_MAGE_1 = "Тайная магия"
L_PLANNER_MAGE_2 = "Огонь"
L_PLANNER_MAGE_3 = "Лед"
L_PLANNER_PRIEST_1 = "Послушание"
L_PLANNER_PRIEST_2 = "Свет"
L_PLANNER_PRIEST_3 = "Темная магия"
L_PLANNER_WARLOCK_1 = "Колдовство"
L_PLANNER_WARLOCK_2 = "Демонология"
L_PLANNER_WARLOCK_3 = "Разрушение"
L_PLANNER_HUNTER_1 = "Чувство зверя"
L_PLANNER_HUNTER_2 = "Стрельба"
L_PLANNER_HUNTER_3 = "Выживание"
L_PLANNER_DRUID_1 = "Баланс"
L_PLANNER_DRUID_2 = "Сила зверя"
L_PLANNER_DRUID_3 = "Исцеление"
L_PLANNER_SHAMAN_1 = "Стихии"
L_PLANNER_SHAMAN_2 = "Совершенствование"
L_PLANNER_SHAMAN_3 = "Исцеление"
L_PLANNER_PALADIN_1 = "Свет"
L_PLANNER_PALADIN_2 = "Защита"
L_PLANNER_PALADIN_3 = "Возмездие"

-- BG stats
L_DATATEXT_BASESASSAULTED = "Штурмы баз:"
L_DATATEXT_BASESDEFENDED = "Оборона баз:"
L_DATATEXT_TOWERSASSAULTED = "Штурмы башен:"
L_DATATEXT_TOWERSDEFENDED = "Оборона башен:"
L_DATATEXT_FLAGSCAPTURED = "Захваты флага:"
L_DATATEXT_FLAGSRETURNED = "Возвраты флага:"
L_DATATEXT_GRAVEYARDSASSAULTED = "Штурмы кладбищ:"
L_DATATEXT_GRAVEYARDSDEFENDED = "Оборона кладбищ:"
L_DATATEXT_DEMOLISHERSDESTROYED = "Разрушителей уничтожено:"
L_DATATEXT_GATESDESTROYED = "Врат разрушено:"
L_DATATEXT_CONTROL = " под контролем:"

-- Class script
L_CLASS_HUNTER_UNHAPPY = "Ваш питомец несчастлив!"
L_CLASS_HUNTER_CONTENT = "Ваш питомец доволен!"
L_CLASS_HUNTER_HAPPY = "Ваш питомец счастлив!"

-- Info text
L_INFO_ERRORS = "Ошибок не обнаружено."
L_INFO_INVITE = "Приглашение принято от: "
L_INFO_DUEL = "Дуэль отклонена от: "
L_INFO_DISBAND = "Роспуск группы..."
L_INFO_ADDON_SETS1 = "Введите /addons <solo/party/raid/pvp/trade/quest>, чтобы загрузить предустановленный набор модификаций."
L_INFO_ADDON_SETS2 = "Вы можете добавить, удалить или изменить списки модификаций, изменив файл wtf.lua в папке modules."
L_INFO_SETTINGS_DBM = "Введите /settings dbm, чтобы применить настройки DBM."
L_INFO_SETTINGS_MSBT = "Введите /settings msbt, чтобы применить настройки MSBT."
L_INFO_SETTINGS_SKADA = "Введите /settings skada, чтобы применить настройки Skada."
L_INFO_SETTINGS_RECOUNT = "Введите /settings recount, чтобы применить настройки Recount. После этого в настройках Recount выберите профиль *Default*."
L_INFO_SETTINGS_DXE = "Введите /settings dxe, чтобы применить настройки DXE. После этого в настройках DXE выберите профиль *Default*."
L_INFO_SETTINGS_ALL = "Введите /settings all, чтобы применить настройки для всех модификаций."

-- Popups
L_POPUP_INSTALLUI = "Это первый запуск ShestakUI для этого персонажа. Необходимо перезагрузить интерфейс для его настройки."
L_POPUP_RESETUI = "Вы уверены, что хотите сбросить настройки ShestakUI?"
L_POPUP_RESETSTATS = "Вы уверены, что хотите сбросить статистику проведенного времени в игре и золота?"
L_POPUP_SWITCH_RAID = "Обе рейдовые раскладки активны, пожалуйста, выберите одну."
L_POPUP_DISBAND_RAID = "Вы уверены, что хотите распустить группу?"
L_POPUP_DISABLEUI = "ShestakUI не работает на этом разрешении, хотите отключить ShestakUI? (Отмена если хотите попробовать другое разрешение)"
L_POPUP_SETTINGS_ALL = "Применить настройки для всех модификаций? (DBM/DXE, Skada/Recount и MSBT)"
L_POPUP_SETTINGS_DBM = "Необходимо изменить позиции элементов DBM."
L_POPUP_SETTINGS_BW = "Необходимо изменить позиции элементов BigWigs."

-- Welcome message
L_WELCOME_LINE_1 = "Добро пожаловать в ShestakUI "
L_WELCOME_LINE_2_1 = "Введите /cfg для входа в настройки интерфейса, или посетите страницу http://shestak.org"
L_WELCOME_LINE_2_2 = "для получения дополнительной информации."

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "Смерт. Удар"
L_COMBATTEXT_ALREADY_UNLOCKED = "Текст боя уже разблокирован."
L_COMBATTEXT_ALREADY_LOCKED = "Текст боя уже заблокирован."
L_COMBATTEXT_TEST_DISABLED = "Тестовый режим текста боя выключен."
L_COMBATTEXT_TEST_ENABLED = "Тестовый режим текста боя включен."
L_COMBATTEXT_TEST_USE_UNLOCK = "Введите /xct unlock, чтобы передвинуть или изменить размер области текста боя."
L_COMBATTEXT_TEST_USE_LOCK = "Введите /xct lock, чтобы заблокировать области текста боя."
L_COMBATTEXT_TEST_USE_TEST = "Введите /xct test, чтобы включить тестовый режим текста боя."
L_COMBATTEXT_POPUP = "Для сохранения позиций текста боя необходимо перезагрузить интерфейс."
L_COMBATTEXT_UNSAVED = "Позиции текста боя не сохранены, не забудьте перезагрузить интерфейс."
L_COMBATTEXT_UNLOCKED = "Текст боя разблокирован."

-- LiteStats
L_STATS_ACC_PLAYED = "Время игры персонажем"
L_STATS_ADDED_JUNK = "Добавлено нежелательное исключение"
L_STATS_REMOVE_EXCEPTION = "Добавить/удалить исключения."
L_STATS_ALT = "ALT"
L_STATS_AUTO_REPAIR = "Авто починка"
L_STATS_AUTO_SELL = "Авто продажа"
L_STATS_BANDWIDTH = "Скорость:"
L_STATS_DOWNLOAD = "Загрузка:"
L_STATS_CLEARED_JUNK = "Очищен нежелательный список исключений."
L_STATS_CLEAR_EXCEPTIONS = "Очистить список исключений."
L_STATS_WORLD_MAP = "Нажатие открывает карту."
L_STATS_CURRENT_XP = "Текущий/Макс. опыт"
L_STATS_MEMORY_USAGE = "Использование памяти:"
L_STATS_GARBAGE_COLLECTED = "Память очищена"
L_STATS_CHANGE_SORTING = "(Гильдия) ПКМ изменяет сортировку, Шифт+ПКМ изменяет порядок сортировки."
L_STATS_HIDDEN = "Скрытые"
L_STATS_VIEW_NOTES = "Зажмите ALT для просмотра званий, заметок и офицерских заметок."
L_STATS_HR = "ч"
L_STATS_INF = "бесконечный"
L_STATS_ALREADY_EXCEPTIONS = "Уже в списке исключений."
L_STATS_NOT_JUNK = "не является нежелательной."
L_STATS_ITEMLINK = "Ссылка на предмет"
L_STATS_JUNK_EXCEPTIONS = "Нежелательные исключения"
L_STATS_JUNK_LIST = "Нежелательный список"
L_STATS_JUNK_PROFIT = "Прибыль с продажи"
L_STATS_KILLS = "У"
L_STATS_OPEN_CALENDAR = "ЛКМ открывает календарь(/календарь)."
L_STATS_OPEN_CHARACTER = "ЛКМ открывает окно персонажа."
L_STATS_OPEN_CURRENCY = "ЛКМ открывает окно валюты."
L_STATS_OPEN_TALENT = "ЛКМ открывает окно талантов."
L_STATS_XP_RATE = "Уровень ставки XP"
L_STATS_IGNORED_ITEMS = "Список игнорируемых предметов."
L_STATS_TOGGLE_TIME = "Местный / области и 24 часов времени могут быть переключены с момента управлять."
L_STATS_LOCATION = "Зона/Координаты"
L_STATS_MEMORY = "Память"
L_STATS_ON = "ВКЛ."
L_STATS_OTHER_OPTIONS = "Другие настройки вы можете изменить в %s"
L_STATS_PLAYED_LEVEL = "Время игры на этом уровне"
L_STATS_PLAYED_SESSION = "Время игры на этой сессии"
L_STATS_PLAYED_TOTAL = "Общее время игры"
L_STATS_QUEST = "З"
L_STATS_QUESTS_TO = "Заданий/Убийств до %s"
L_STATS_REMAINING_XP = "Осталось опыта"
L_STATS_REMOVED_JUNK = "Удалено нежелательное исключение"
L_STATS_RESTED_XP = "Опыт отдыха"
L_STATS_RC_COLLECTS_GARBAGE = "ПКМ очищает память от lua мусора."
L_STATS_RC_TIME_MANAGER = "ПКМ открывает часы."
L_STATS_RC_EXPERIENCE = "ПКМ циклу на основе опыта, время играл, и фракция часы."
L_STATS_RC_AUTO_REPAIRING = "ПКМ переключает авто починку."
L_STATS_RC_AUTO_SELLING = "ПКМ переключает авто продажу."
L_STATS_RC_TALENT = "ПКМ переключает ваш набор талантов."
L_STATS_SERVER_GOLD = "Золото на сервере"
L_STATS_SESSION_GAIN = "Получено/Потрачено за сессию"
L_STATS_SESSION_XP = "Оценить сессия XP"
L_STATS_INSERTS_COORDS = "Шифт+ПКМ по модулю координат для вставки в чат ваших текущих координат."
L_STATS_EQUIPMENT_CHANGER = "Шифт+ЛКМ или СКМ показывает комплекты экипировки."
L_STATS_SORTING_BY = "Сортировка по"
L_STATS_TIPS = "cоветы:"
L_STATS_TOTAL = "Всего"
L_STATS_TOTAL_MEMORY_USAGE = "Всего использовано памяти:"
L_STATS_NOT_TO_SELL = "Введите /junk что бы настроить какие предметы не продавать."
L_STATS_WATCH_CURRENCY = "Показывает отображаемую валюту в подсказке."
L_STATS_WATCH_FACTIONS = "Просмотр фракций из окна репутации."
L_STATS_TOOLTIP_TIME_PLAYED = "Когда уровень максимальный, подсказка будет показывать время игры персонажей."
L_STATS_TOOLTIP_EXPERIENCE = "Когда уровень не максимальный, подсказка будет показывать подробности опыта."

-- Slash commands
L_SLASHCMD_HELP = {
	"Available slash commands:",
	"/rl - Перезагружает интерфейс.",
	"/rc - Провести проверку готовности группы/рейда.",
	"/gm - Связаться с ГМ. Помощь по игре.",
	"/dis ADDON_NAME - Выключение эддона.",
	"/en ADDON_NAME - Включение эддона.",
	"/rd - Расформировать группу/рейд.",
	"/toraid - Описание не готово.",
	"/luaerror - Включение/выключение lua ошибок.",
	"/spec - Переключение набора талантов.",
	"/clfix - Исправляет журнал боя.",
	"/heal - Переключает на 'Heal' раскладку.",
	"/dps - Переключает на 'DPS' раскладку.",
	"/frame - Описание не готово.",
	"/addons solo|party|raid|pvp|trade - Переключение между списками эддонов.",
	"/farmmode - Увеличивает миникарту.",
	"/moveui - Перемещение элементов интерфейса.",
	"/resetui - Сброс общих настроек на стандартные.",
	"/resetuf - Сброс позиций юнит фреймов.",
	"/resetconfig - Сброс настроек ShstakUI_config.",
	"/resetstats - Сброс статистики золота и проведенного времени.",
	"/settings ADDON_NAME - Описание не готово.",
	"/ls - Описание не готово.",
	"/bags - Управление сумками.",
	"/xct - Управление текстом боя.",
	"/raidcd - Тест рейдовых перезарядок.",
	"/enemycd - Тест вражеских перезарядок.",
	"/pulsecd - Тест своих перезарядок.",
	"/threat - Тест списка угрозы.",
	"/tt - Описание не готово.",
	"/invite - Описание не готово.",
	"/testuf - Тест юнит фреймов",
	"/cfg - Открыть настройки интерфейса.",
}