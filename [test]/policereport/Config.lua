-- The key that opens to register a report.
key_report = 104

-- the npc coordinates
npc_coords = {
    vector3(442.77746, -981.9169, 30.689582),
    -- vector3(440.1102, -983.692, 30.68959)
}

-- rotation of npc
npc_heading = {
    90.87,
    -- 0.0
}
-- Distance between player and npc to Show Notify
distance_to_show_notify_npc = 2.5
-- Model NPC
model_npc = 's_f_y_cop_01'

-- Waiting time to perform a new registration. 
time_wait_new = 60*5 -- 5 minutes






-- The key that the police officer uses on the computer to view all police reports.
key_police = 38
-- the computer coordinates
computer_coords = {
    vector3(443.95312, -979.6359, 30.68958)
}
-- Distance between player and computer to Show Notify
distance_to_show_notify_computer = 1.5

jobs = {
    "police"
}

-- Change letters according to your preference
-- d = days
-- m = month
-- y = year
date_format = "%d/%m/%y"

WEBHOOK = {
    DISCORD_URL = "",
    DISCORD_TITLE = "New Police Report:",
    COLOR = 3066993,

    SIMBOL_IMG = 'https://imgur.com/PYxH92F.png',
    HEIGHT_SIMBOL = '10',
    WIDTH_SIMBOL = '10',

    -- Put Footer with a name you want and your server image.
    DISCORD_IMAGE       = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/2fbe8cb923d1f82c29f6b4ef71b9dbe1c917af7b.png",
    DISCORD_FOOTER      = "Legendary Team",
    DISCORD_FOOTER_IMG  = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/2fbe8cb923d1f82c29f6b4ef71b9dbe1c917af7b.png",
}


translate = {
    TR_NAME = "Tên:",
    TR_PHONE = "Số điện thoại:",
    TR_REPORT = "Báo cáo:",
    TR_ANONYMOUS = "Nặc danh?",
    TR_TOREPORT = "To Report",
    TR_POLICEREPORT = "Police Report:",
    TR_REPORTS = "Báo cáo:",
    TR_DESCRIPTION = "Mô tả:",
    TR_BACK = "Quay lại",

    TR_NOTIFY_REPORT = "Successful report!",
    TR_NEW_REPORT = "New registered police report!",
    TR_PROXIMITY_NPC = "Nhấn [E] để báo cáo.",
    TR_PROXIMITY_COMPUTER = "Nhấn [E] đọc toàn bộ báo cáo.",
    TR_WAIT = "You need to wait to make a new police report."
}



