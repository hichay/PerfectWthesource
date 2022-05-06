Config = {}
Config.RepeatTimeout = 2000
Config.CallRepeats = 10
Config.OpenPhone = 288

-- Configs
Config.Language = 'en' -- You have more translations in html.
Config.Webhook = '' -- Your Webhook.
Config.Tokovoip = false -- If it is true it will use Tokovoip, if it is false it will use Mumblevoip.
Config.Job = 'police' -- If you want, you can choose another job and it is the job that will appear in the 'Police' application, modify the html to make it another job.
Config.UseESXLicense = true
Config.UseESXBilling = true

Config.Languages = {
    ['en'] = {
        ["NO_VEHICLE"] = "Không có xe xung quanh!",
        ["NO_ONE"] = "Không có ai xung quanh!",
        ["ALLFIELDS"] = "Ô trống phải được điền!",

        ["RACE_TITLE"] = "Cuộc đua",

        ["WHATSAPP_TITLE"] = "Whatsapp",
        ["WHATSAPP_NEW_MESSAGE"] = "Tin nhắn mới từ ",
        ["WHATSAPP_MESSAGE_TOYOU"] = "Tại sao bạn lại gửi tin nhắn cho chính bản thân?",
        ["WHATSAPP_LOCATION_SET"] = "Vị trí đã được thiết lập!",
        ["WHATSAPP_SHARED_LOCATION"] = "Vị trí đã được Chia sẻ",
        ["WHATSAPP_BLANK_MSG"] = "Bạn không thể gửi một tin nhắn trống!",

        ["MAIL_TITLE"] = "Mail",
        ["MAIL_NEW"] = "Bạn đã nhận được một email từ: ",

        ["ADVERTISEMENT_TITLE"] = "Yellow Pages",
        ["ADVERTISEMENT_NEW"] = "Có một quảng cáo trên các trang yellow pages!",
        ["ADVERTISEMENT_EMPY"] = "Bạn phải nhập một tin nhắn!",

        ["TWITTER_TITLE"] = "Twitter",
        ["TWITTER_NEW"] = "Tweet mới",
        ["TWITTER_POSTED"] = "Tweet đã được đăng !",
        ["TWITTER_GETMENTIONED"] = "Bạn được gắn thẻ trong một tweet!",
        ["MENTION_YOURSELF"] = "Bạn không thể gắn thẻ bản thân!",
        ["TWITTER_ENTER_MSG"] = "Bạn phải nhập một tin nhắn!",

        ["PHONE_DONT_HAVE"] = "Bạn không có điện thoại !",
        ["PHONE_TITLE"] = "Hướng Dẫn",
        ["PHONE_CALL_END"] = "Cuộc gọi đã kết thúc",
        ["PHONE_NOINCOMING"] = "Bạn không có cuộc gọi đến!",
        ["PHONE_STARTED_ANON"] = "Bạn đã bắt đầu một cuộc gọi ẩn danh!",
        ["PHONE_BUSY"] = "Máy Bận!",
        ["PHONE_PERSON_TALKING"] = "Người này đang có cuộc gọi khác!",
        ["PHONE_PERSON_UNAVAILABLE"] = "Người này không đăng nhập!",
        ["PHONE_YOUR_NUMBER"] = "Bạn không thể gọi cho bản thân!",
        ["PHONE_MSG_YOURSELF"] = "Bạn không thể nhắn tin cho bản thân!",

        ["CONTACTS_REMOVED"] = "Người Này đã bị xóa khỏi danh bạ!",
        ["CONTACTS_NEWSUGGESTED"] = "Bạn Có một địa chỉ liên hệ được đề xuất mới!",
        ["CONTACTS_EDIT_TITLE"] = "Chỉnh Sửa danh bạ",
        ["CONTACTS_ADD_TITLE"] = "Hướng Dẫn",

        ["BANK_TITLE"] = 'Bank',
        ["BANK_DONT_ENOUGH"] = 'Bạn không có đủ tiền!',
        ["BANK_NOIBAN"] = "Không có IBAN nào được liên kết với người này!",

        ["CRYPTO_TITLE"] = "Crypto",

        ["GPS_SET"] = "GPS Location set: ",

        ["NUI_SYSTEM"] = 'System',
        ["NUI_NOT_AVAILABLE"] = 'is not available!',
        ["NUI_MYPHONE"] = 'Phone Number',
        ["NUI_INFO"] = 'Information',

        ["SETTINGS_TITLE"] = 'Settings',
        ["PROFILE_SET"] = 'Bộ ảnh hồ sơ riêng!',
        ["POFILE_DEFAULT"] = 'Ảnh hồ sơ đã được đặt lại về mặc định!',
        ["BACKGROUND_SET"] = 'Bộ ảnh nền riêng!',

        ["RACING_TITLE"] = "Racing",
        ["RACING_CHOSEN_TRACK"] = "Bạn chưa chọn một Đường đua.",
        ["RACING_ALREADY_ACTIVE"] = "Bạn đã có một cuộc đua đang hoạt động.",
        ["RACING_ENTER_ROUNDS"] = "Nhập số lượng vòng.",
        ["RACING_CANT_THIS_TIME"] = "Không có cuộc đua nào có thể được thực hiện vào lúc này.",
        ["RACING_ALREADY_STARTED"] = "Cuộc đua đã bắt đầu.",
        ["RACING_ALREADY_INRACE"] = "Bạn đã tham gia một cuộc đua.",
        ["RACING_ALREADY_CREATED"] = "Bạn đã tạo một Đường đua.",
        ["RACING_INEDITOR"] = "Bạn đang trong quá trình tạo đường đua.",
        ["RACING_INRACE"] = "Bạn đang trong một cuộc đua .",
        ["RACING_CANTSTART"] = "Bạn không có quyền tạo Đường đua.",
        ["RACING_CANTTHISNAME"] = "Tên này không khả dụng.",
        ["RACING_ENTER_TRACK"] = "Bạn phải nhập tên đường đua.",

        ["MEOS_TITLE"] = "MEOS",
        ["MEOS_CLEARED"] = "Tất cả các thông báo đã bị xóa!",
        ["MEOS_GPS"] = "Tin nhắn này không có Vị trí GPS!",
        ["MEOS_NORESULT"] = "Không có kết quả!",

	},
	
}

Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipText = "Điện thoại",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fab fa-whatsapp",
        tooltipText = "Tin nhắn",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#1da1f2",
        icon = "fab fa-twitter",
        tooltipText = "Toác tơ",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cog",
        tooltipText = "Cài đặt",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#575fcf",
        icon = "fas fa-warehouse",
        tooltipText = "Gara",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ff002f",
        icon = "fas fa-envelope",
        tooltipText = "Hộp thư",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ff8f1a",
        icon = "fas fa-ad",
        tooltipText = "Quảng Cáo",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        icon = "fas fa-university",
        tooltipText = "Ngân hàng",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },
    ["racing"] = {
        app = "racing",
        color = "#353b48",
        icon = "fas fa-flag-checkered",
        tooltipText = "Cuộc đua",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
    },
    ["lawyers"] = {
        app = "lawyers",
        color = "#0061e0",
        icon = "fas fa-building",
        tooltipText = "Cảnh sát",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    ["spotify"] = {
        app = "spotify",
        color = "#82c91e",
        icon = "fab fa-spotify",
        tooltipText = "Spotify",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },  
    -- ["bbc"] = {
        -- app = "bbc",
        -- color = "#ff0000",
        -- icon = "fas fa-newspaper",
        -- tooltipText = "Qbus News",
        -- job = false,
        -- blockedjobs = {},
        -- slot = 12,
        -- Alerts = 0,
    -- },
    ["snake"] = {
        app = "snake",
        color = "#609",
        icon = "fas fa-ghost",
        tooltipText = "Snake Game",
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },
    ["solitary"] = {
        app = "solitary",
        color = "#e6bb12",
        icon = "fas fa-crown",
        tooltipText = "Solitary",
        job = false,
        blockedjobs = {},
        slot = 13,
        Alerts = 0,
    },

    ["meos"] = {
        app = "meos",
        color = "#004682",
        icon = "fas fa-ad",
        tooltipText = "PDT",
        job = "police",
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
    },  
    ["occasion"] = {
        app = "occasion",
        color = "#f1c40f",
        icon = "fas fa-car-side",
        tooltipText = "Bán xe",
        job = false,
        blockedjobs = {},
        slot = 14,
        Alerts = 0,
    },
}