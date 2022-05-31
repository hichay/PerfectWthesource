local allowdamage = true
local StoringEnabled = false

local CurrentDamageList = {}
local CurrentLocationList = {}

local armor = false
local lasthealth = GetEntityHealth(PlayerPedId())
local lastarmor = GetPedArmour(PlayerPedId())
local lasthealth2 = lasthealth

local bleedmulti = 1
local bleedcount = 0
local heavybleed = false
local lightbleed = false
local lightestbleed = false
local initialbleed = false
local bleeddamage = false
local bleeddamage2 = false

local sweatTriggered = false
local bodySweat = 0

local lastTarget = nil
local target = nil
local targetLastHealth = nil

local passingout = false
local fading = false
local maxfade = 0.0
local curfading = 0

local legsdisabled = false
local armsdisabled = false

local bleedLevel = 0
local setBleedLevel = 0

local stresslevel = 0
local clipchanged = false
local myboneActive = false
local indamagefunction = false

local inbed = false
local injurycount = 0
local bonesUpdatingServer = false

local sleeping = false
local showInteraction = true

local healing = false

local bonesTarget = {}
local healTargetBoneId = 0
local targetidsend = 0

local disKeys = {
	[1] = 140,
	[2] = 141,
	[3] = 142,
	[4] = 37,
}

local Currentstates = {
	[1] = { ["text"] = "Tay Bị Đỏ", ["status"] = false, ["timer"] = 0 },
	[2] = { ["text"] = "Giãn Đồng Tử", ["status"] = false, ["timer"] = 0 },
	[3] = { ["text"] = "Đau Mắt Đỏ", ["status"] = false, ["timer"] = 0 },
	[4] = { ["text"] = "Có Mùi Của Cần Sa", ["status"] = false, ["timer"] = 0 },
	[5] = { ["text"] = "Vừa Mới Băng Bó", ["status"] = false, ["timer"] = 0 },
	[6] = { ["text"] = "Bị Kích Động", ["status"] = false, ["timer"] = 0 },
	[7] = { ["text"] = "Bủn Rủn Tay Chân", ["status"] = false, ["timer"] = 0 },
	[8] = { ["text"] = "Hơi Thở Có Mùi Cồn", ["status"] = false, ["timer"] = 0 },
	[9] = { ["text"] = "Có Mùi Của Xăng Dầu", ["status"] = false, ["timer"] = 0 },
	[10] = { ["text"] = "Có Vết Của Thuốc Súng", ["status"] = false, ["timer"] = 0 },
	[11] = { ["text"] = "Mùi Của Hóa Chất ", ["status"] = false, ["timer"] = 0 },
	[12] = { ["text"] = "Mùi Của Dầu / Kim Loại", ["status"] = false, ["timer"] = 0 },
	[13] = { ["text"] = "Tay Dính Mực", ["status"] = false, ["timer"] = 0 },
	[14] = { ["text"] = "Có Mùi Của Khói", ["status"] = false, ["timer"] = 0 },
	[15] = { ["text"] = "Đã Cài Thiết Bị Cấm Trại", ["status"] = false, ["timer"] = 0 },
	[16] = { ["text"] = "Có Mùi Cháy Của Sắt - Nhôm", ["status"] = false, ["timer"] = 0 },
	[17] = { ["text"] = "Có Mẫu Kim Loại Trên Quần Áó", ["status"] = false, ["timer"] = 0 },
	[18] = { ["text"] = "Mùi Của Thuốc Lá", ["status"] = false, ["timer"] = 0 },
	[19] = { ["text"] = "Hơi Thở Gấp", ["status"] = false, ["timer"] = 0 },
	[20] = { ["text"] = "Đỗ Mồ Hôi", ["status"] = false, ["timer"] = 0 },
	[21] = { ["text"] = "Bồ Đồ Bị Ướt .", ["status"] = false, ["timer"] = 0 },
    [22] = { ["text"] = "Cắt Dây", ["status"] = false, ["timer"] = 0 },
	[23] = { ["text"] = "Ngấm Vào Quần Áo", ["status"] = false, ["timer"] = 0 },
    [24] = { ["text"] = "Bị Chóng Mặt", ["status"] = false, ["timer"] = 0 },
    [25] = { ["text"] = "Bị Chán Nản", ["status"] = false, ["timer"] = 0 },
    [26] = { ["text"] = "Có Vết Xước Trên Cánh Tay", ["status"] = false, ["timer"] = 0 },
    [27] = { ["text"] = "Chú Ý Đề Phòng.", ["status"] = false, ["timer"] = 0 },
}

InjuryIndexList = { 
	{ "Hông","4103","11816" },
	{ "Đùi Trái","4103","58271" },
	{ "Bắp Chân Trái","4103","63931" },
	{ "Chân Trái","4103","14201" },
	{ "Đầu Gối Trái","119","46078" },
	{ "Đùi Phải","4103","51826" },
	{ "Bắp Chân Phải","4103","36864" },
	{ "Chân Phải","4103","52301" },
	{ "Đầu Gối Phải","119","16335" },
	{ "Xương Sống","4103","23553" },
	{ "Thắt Lưng","4103","24816" },
	{ "Phần Cột Sống Giữa","4103","24817" },
	{ "Xương Sống Cổ","4103","24818" },
	{ "Xương Đòn Trái","4103","64729" },
	{ "Bắp Tay Trên Bên Trái","4103","45509" },
	{ "Cẳng Tay Bên Trái","4215","61163" },
	{ "Tay Trái ","4215","18905" },
	{ "Ngón Út Bên Tay Trái","4103","26610" },
	{ "Ngón Trỏ Bên Tay Trái","4103","26611" },
	{ "Ngón Giữa Bên Tay Trái","4103","26612" },
	{ "Ngón Áp Út Bên Tay Trái","4103","26613" },
	{ "Ngón Cái Bên Tay Trái","4103","26614" },
	{ "Tay Trái","119","60309" },
	{ "Cẳng Tay Trái","7","61007" },
	{ "Cánh Tay Trái","7","5232" },
	{ "Khủyu Tay Trái","119","22711" },
	{ "Xương Đòn Phải","4103","10706" },
	{ "Bắp Tay Bên Phải","4103","40269" },
	{ "Cẳng Tay Bên Phải","4215","28252" },
	{ "Tay Phải","4215","57005" },
	{ "Ngón Út Bên Tay Phải","4103","58866" },
	{ "Ngón Trỏ Bên Tay Phải","4103","58867" },
	{ "Ngón Giữa Bên Tay Phải","4103","58868" },
	{ "Ngón Áp Út Bên Tay Phải","4103","58869" },
	{ "Ngón Cái Bên Tay Phải","4103","58870" },
	{ "Tay Phải","119","28422" },
	{ "Tay Phải","119","6286" },
	{ "Cẳng Tay Phải","7","43810" },
	{ "Cánh Tay Phải","7","37119" },
	{ "Khuỷu Tay Phải","119","2992" },
	{ "Cổ","4103","39317" },
	{ "Đầu","4103","31086" },
	{ "Đầu","119","12844" },
	{ "Chân Mày Trái","1799","58331" },
	{ "Lông Mi Trái","1911","45750" },
	{ "Mắt Trái","1799","25260" },
	{ "Gò Má Trái","1799","21550" },
	{ "Khóe Môi Trái","1911","29868" },
	{ "Khóe Môi Phải","1911","43536" },
	{ "Mặt Bên Phải Mắt","1799","27474" },
	{ "Khóe Môi Bên Phải","1911","11174" },
	{ "Khúc Giữa Của Chân Mày ","1799","37193" },
	{ "khóe Môi","5895","20178" },
	{ "Khóe Môi Trên","6007","61839" },
	{ "Môi Trên Trái","1911","20279" },
	{ "Môi Trên Phải","1911","17719" },
	{ "Hàm Mặt","5895","46240" },
	{ "Lòng Môi","5895","17188" },
	{ "Môi Dưới","6007","20623" },
	{ "Môi Trong Trái","1911","47419" },
	{ "Môi Trong Bên Phải","1911","49979" },
	{ "Lưỡi","1911","47495" },
	{ "Cổ","7","35731" }
}

local InjuryList = {
	[1] = { "WEAPON_UNARMED","-1569615261", "Dấu Đấm Tay" },
	[2] = { "WEAPON_ANIMAL","-100946242", "Vết Cắn Và Móng Vuốt Động Vật" },
	[3] = { "WEAPON_COUGAR","148160082", "Vết Cắn Và Móng Vuốt Động Vật" },
	[4] = { "WEAPON_KNIFE","-1716189206", "Vết Thương Của Dao" },
	[5] = { "WEAPON_NIGHTSTICK","1737195953", "Vết Xước Từ Đồ Vật (Kim Loại)" },
	[6] = { "WEAPON_HAMMER","1317494643", "Vết Xước Từ Đồ Vật Nhỏ (Kim Loại)" },
	[7] = { "WEAPON_BAT","-1024456158", "Vết Xước Từ Đồ Vật To" },
	[8] = { "WEAPON_GOLFCLUB","1141786504", "Vết Xước Từ Đồ Vật Dài" },
	[9] = { "WEAPON_CROWBAR","-2067956739", "Vết Vật Thể Kim Loại Có Răng Cưa Trung Bình" },
	[10] = { "WEAPON_PISTOL","453432689", "Vết Đạn Súng Lục" },
	[11] = { "WEAPON_COMBATPISTOL","1593441988", "Vết Đạn Combat Pistol" },
	[12] = { "WEAPON_APPISTOL","584646201", "Vết Đạn AP Pistol" },
	[13] = { "WEAPON_PISTOL50","-1716589765", "Vệt Đạn 50 Cal Pistol" },
	[14] = { "WEAPON_MICROSMG","324215364", "Vết Đạn Micro SMG" },
	[15] = { "WEAPON_SMG","736523883", "Vết Đạn SMG" },
	[16] = { "WEAPON_ASSAULTSMG","-270015777", "Vết Đạn Assault SMG" },
	[17] = { "WEAPON_ASSAULTRIFLE","-1074790547", "Vết Đạn Assault Rifle" },
	[18] = { "WEAPON_CARBINERIFLE","-2084633992", "Vết Đạn Carbine Rifle" },
	[19] = { "WEAPON_ADVANCEDRIFLE","-1357824103", "Vết Đạn Advanced Rifle" },
	[20] = { "WEAPON_MG","-1660422300", "Vết Đạn Machine Gun" },
	[21] = { "WEAPON_COMBATMG","2144741730", "Vết Đạn Combat MG" },
	[22] = { "WEAPON_PUMPSHOTGUN","487013001", "Vết Đạn Pump Shotgun" },
	[23] = { "WEAPON_SAWNOFFSHOTGUN","2017895192", "Vết Đạn Sawn Off" },
	[24] = { "WEAPON_ASSAULTSHOTGUN","-494615257", "Vết Đạn Assault Shotgun" },
	[25] = { "WEAPON_BULLPUPSHOTGUN","-1654528753", "Vết Đạn Bullpup Shotgun" },
	[26] = { "WEAPON_STUNGUN","911657153", "Vết Đạn Súng Điện" },
	[27] = { "WEAPON_SNIPERRIFLE","100416529", "Vết Đạn Sniper Rifle Wounds" },
	[28] = { "WEAPON_HEAVYSNIPER","205991906", "Vết Đạn Sniper Rifle Wounds" },
	[29] = { "WEAPON_REMOTESNIPER","856002082", "Vết Đạn Sniper Rifle Wounds" },
	[30] = { "WEAPON_GRENADELAUNCHER","-1568386805", "Vụ Nổ To (Lựu Đạn)" },
	[31] = { "WEAPON_GRENADELAUNCHER_SMOKE","1305664598", "Khói Độc" },
	[32] = { "WEAPON_RPG","-1312131151", "Sát Thương Từ RPG" },
	[33] = { "WEAPON_STINGER","1752584910", "Sát Thương Từ RPG" },
	[34] = { "WEAPON_MINIGUN","1119849093", "Vết Thương Từ Minigun" },
	[35] = { "WEAPON_GRENADE","-1813897027", "Vết Thương Từ Lựu Đạn" },
	[36] = { "WEAPON_STICKYBOMB","741814745", "Vết Thương Sticky Bomb" },
	[37] = { "WEAPON_SMOKEGRENADE","-37975472", "Bị Ngẹt Bởi Khói" },
	[38] = { "WEAPON_BZGAS","-1600701090", "Bị Thương Do Dính Gas" },
	[39] = { "WEAPON_MOLOTOV","615608432", "Bị Bỏng Bởi Molotov / Accelerant Burns" },
	[40] = { "WEAPON_FIREEXTINGUISHER","101631238", "Bị Thương Bởi Bình Chữa Cháy" },
	[41] = { "WEAPON_PETROLCAN","883325847", "Bị Bỏng Bởi Can Xăng Dầu" },
	[42] = { "WEAPON_FLARE","1233104067", "Vết Đạn Flare" },
	[43] = { "WEAPON_BARBED_WIRE","1223143800", "Bị Thương Bởi Dây Thép Gai" },
	[44] = { "WEAPON_DROWNING","-10959621", "Bị Chết Đuối" },
	[45] = { "WEAPON_DROWNING_IN_VEHICLE","1936677264", "Chết Đuối Trong Xe" },
	[46] = { "WEAPON_BLEEDING","-1955384325", "Chết Vì Bị Rỉa Máu" },
	[47] = { "WEAPON_ELECTRIC_FENCE","-1833087301", "Vết Thương Hàng Rào Điện" },
	[48] = { "WEAPON_EXPLOSION","539292904", "Bị Thương Do Nổ" },
	[49] = { "WEAPON_FALL","-842959696", "Bị Thương Bởi Va / Chạm / Đập" },
	[50] = { "WEAPON_EXHAUSTION","910830060", "Chết Vì Kiệt Sức" },
	[51] = { "WEAPON_HIT_BY_WATER_CANNON","-868994466", "Bị Thương Bởi Vòi Rồng" },
	[52] = { "WEAPON_RAMMED_BY_CAR","133987706", "Bị Thương Bởi Xe Cộ" },
	[53] = { "WEAPON_RUN_OVER_BY_CAR","-1553120962", "Bị Thương Bởi Chạy Qua Xe" },
	[54] = { "WEAPON_HELI_CRASH","341774354", "Bị Thương Bởi Té Đồi" },
	[55] = { "WEAPON_FIRE","-544306709", "Bị Thương Bởi Cháy" },
	[56] = { "WEAPON_ASSAULTSMG","4024951519", "Vết Đạn Assault SMG"},
	[57] = { "WEAPON_GUSENBERG","1627465347", "Vết Đạn Gusenberg"},
	[58] = { "WEAPON_COMBATPDW","171789620", "Vết Đạn Combat PDW"},
	[59] = { "WEAPON_HEAVYSHOTGUN","984333226", "Vết Đạn Heavy Shotgun"},
	[60] = { "WEAPON_AUTOSHOTGUN","317205821", "Vết Đạn Autoshotgun"},
	[61] = { "WEAPON_BULLPUPSHOTGUN","2640438543", "Vết đạnBullpup Shotgun"},
	[62] = { "WEAPON_ASSAULTSHOTGUN","3800352039", "Vết Đạn Assault Shotgun"},
	[63] = { "WEAPON_BULLPUPRIFLE","2132975508", "Vết Đạn Bullpup Rifle"},
	[64] = { "WEAPON_ASSAULTRIFLE","3220176749", "Vết Đạn Assault Rifle"},
	[65] = { "WEAPON_PISTOL_MK2","3219281620", "Vết Đạn PD Pistol"}
}

local function getInjuryReplacements()
	local list = {
		"Injury",
		"Is wearing body armor",
		"Very noticable",
		"Noticable",
		"Very light",
	}
	for _, data in pairs(InjuryList) do
		list[#list + 1] = data[3]
	end
	return list
end

local tier1 = {
    ["37193"] = true,
    ["31086"] = true,
    ["39317"] = true,
    ["47495"] = true,
    ["61839"] = true,
    ["20623"] = true,
    ["21550"] = true,
    ["19336"] = true,
}

local tier2 = {
    ["10706"] = true,
    ["64729"] = true,
    ["11816"] = true,
    ["58271"] = true,
    ["51826"] = true,
    ["24816"] = true,
    ["24817"] = true,
    ["24818"] = true,
}

local bones = {
    [1] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Chậu",               ["boneIndex"] = 11816, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.35, ["zone"] = 0 },
    [2] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đùi Trái",           ["boneIndex"] = 58271, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.8,  ["zone"] = 4 },
    [3] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Miệng",                ["boneIndex"] = 47495, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1 },
    [4] =  { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Chân Trái",            ["boneIndex"] = 14201, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 4 },
    [5] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu Gối Trái",            ["boneIndex"] = 46078, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.55, ["zone"] = 4 },
    [6] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đùi Phải",          ["boneIndex"] = 51826, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.8,  ["zone"] = 5 },
    [7] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cột Sống Dưới",          ["boneIndex"] = 24816, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.35, ["zone"] = 0 },
    [8] =  { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Chân Phải",           ["boneIndex"] = 52301, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 5 },
    [9] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu Gối Phải",           ["boneIndex"] = 16335, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.55, ["zone"] = 5 },
    [10] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cót Sống Giữa",            ["boneIndex"] = 24817, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.55, ["zone"] = 0 },
    [11] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Tay Trái",            ["boneIndex"] = 60309, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [12] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Khuỷu Tay Trái",           ["boneIndex"] = 22711, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 2 },
    [13] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Tay Phải",           ["boneIndex"] = 57005, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [14] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Khủy Tay Phải",          ["boneIndex"] = 2992,  ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 3 },
    [15] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cổ",                 ["boneIndex"] = 39317, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.95, ["zone"] = 0 },
    [16] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu",                 ["boneIndex"] = 31086, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 2, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 1 },
    [17] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cột Sống Trên",           ["boneIndex"] = 24818, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.85, ["zone"] = 0 },
    [18] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Đòn Trái",        ["boneIndex"] = 64729, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.15, ["offset2"] = 0.75, ["zone"] = 0 },
    [19] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Út Trái",    ["boneIndex"] = 26610, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [20] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Trái",    ["boneIndex"] = 26611, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [21] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Giữa Trái",   ["boneIndex"] = 26612, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [22] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Áp Út Trái",     ["boneIndex"] = 26613, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [23] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Trái",    ["boneIndex"] = 26614, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
    [24] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Đòn Phải",       ["boneIndex"] = 10706, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 0 },
    [25] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Út Phải",   ["boneIndex"] = 58866, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [26] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Phải",   ["boneIndex"] = 58867, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [27] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Giữa Phải",  ["boneIndex"] = 58868, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [28] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Áp Út Phải",    ["boneIndex"] = 58869, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [29] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Phải",   ["boneIndex"] = 58870, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
    [30] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Gò Má Trái",  ["boneIndex"] = 21550, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.55, ["offset2"] = 0.45, ["zone"] = 1 },
    [31] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Gò Má Phải", ["boneIndex"] = 19336, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.45, ["zone"] = 1 },
    [32] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Trán",             ["boneIndex"] = 37193, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 2, ["offset1"] = 0.45, ["offset2"] = 0.75, ["zone"] = 1  },
    [33] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Môi Trên",        ["boneIndex"] = 61839, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1  },
    [34] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Môi Dưới",        ["boneIndex"] = 20623, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1  },
}

lightwounds = {
	[1] = { ["text"] = "Rỉ Máu" },
	[2] = { ["text"] = "Rỉ Máu" },
	[3] = { ["text"] = "Rỉ Máu" },
	[4] = { ["text"] = "Chảy Máu" },
	[5] = { ["text"] = "Chảy Máu" },
	[6] = { ["text"] = "Máu Chảy Nhanh" },	
}
-- maxStatus == 2
concussions = {
	[1] = { ["text"] = "Rỉ Máu" },
	[2] = { ["text"] = "Chảy Máu" },
	[3] = { ["text"] = "Choáng Nhẹ" },
	[4] = { ["text"] = "Choáng" },
	[5] = { ["text"] = "Choáng Nặng" },
	[6] = { ["text"] = "Choáng Chuẩn Bị Ngất" },
}

-- maxStatus == 3 to 5
movement = {
	[1] = { ["text"] = "Di Chuyển Bình Thường" },
	[2] = { ["text"] = "Di Chuyển " },
	[3] = { ["text"] = "Di Chuyển Nghiêm Trọng" },
	[4] = { ["text"] = "Di Chuyển Rất Nghiêm Trọng" },
	[5] = { ["text"] = "Di Chuyển Bị Cực Đoan" },
	[6] = { ["text"] = "Di Chuyển Bị Suy Giảm Hoàn Toàn" },
}

local bedcoords = {
	-- Pillbox Hospital Beds Coords
	[1] =  { ['x'] = 309.55,['y'] = -577.49,['z'] = 44.21,['h'] = 224.78},
    [2] =  { ['x'] = 310.26,['y'] = -577.63,['z'] = 43.29,['h'] = 53.16 },   
    [3] =  { ['x'] = 321.9,['y'] = -585.86,['z'] = 43.29,['h'] = 193.55 },
    [4] =  { ['x'] = 318.56,['y'] = -580.69,['z'] = 43.29,['h'] = 245.66 },
    [5] =  { ['x'] = 316.87,['y'] = -584.93,['z'] = 43.29,['h'] = 247.1 },
    [6] =  { ['x'] = 313.56,['y'] = -583.83,['z'] = 43.29,['h'] = 250.0 },
    [7] =  { ['x'] = 314.91,['y'] = -579.39,['z'] = 43.29,['h'] = 68.7 },
	[8] =  { ['x'] = 312.01,['y'] = -583.34,['z'] = 43.29,['h'] = 66.16 },
	
	-- Vespucci Hospital Beds Coords
	[9] =  { ['x'] = -809.03,['y'] = -1221.09,['z'] = 8.26,['h'] = 223.85}, -- VespucciHospitalBed1
	[10] =  { ['x'] = -805.55,['y'] = -1224.1,['z'] = 8.26,['h'] = 237.63}, -- VespucciHospitalBed2
	[11] =  { ['x'] = -801.29,['y'] = -1227.72,['z'] = 8.26,['h'] = 221.34}, -- VespucciHospitalBed3
	[12] =  { ['x'] = -797.37,['y'] = -1230.99,['z'] = 8.26,['h'] = 227.98}, --  VespucciHospitalBed4
	[13] =  { ['x'] = -800.08,['y'] = -1234.65,['z'] = 8.26,['h'] = 40.09}, -- VespucciHospitalBed5
	[14] =  { ['x'] = -803.84,['y'] = -1231.24,['z'] = 8.26,['h'] = 46.73}, -- VespucciHospitalBed6
	[15] =  { ['x'] = -806.42,['y'] = -1229.09,['z'] = 8.26,['h'] = 42.52}, -- VespucciHospitalBed7
	[16] =  { ['x'] = -809.23,['y'] = -1226.82,['z'] = 8.26,['h'] = 50.09}, -- VespucciHospitalBed8
	[17] =  { ['x'] = -811.93,['y'] = -1224.65,['z'] = 8.26,['h'] = 44.64}, -- VespucciHospitalBed9

	-- Sandy Hospital Beds Coords
	[18] = { ['x'] = 1827.084, ['y'] = 3677.80, ['z'] = 33.82, ['h'] = 23.95 }, --SandyHospitalBed1
	[19] = { ['x'] = 1830.02, ['y'] = 3683.18, ['z'] = 33.82, ['h'] = 23.95 }, --SandyHospitalBed2
	[20] = { ['x'] = 1828.05, ['y'] = 3683.18, ['z'] = 33.82, ['h'] = 194.66 }, --SandyHospitalBed3
	[21] = { ['x'] = 1824.95, ['y'] = 3681.44, ['z'] = 33.82, ['h'] = 194.66 }, --SandyHospitalBed4
}
local beds = {
    2117668672,
    1631638868,
    -1787305376,
    666470117,
    -1182962909,
    -1519439119, -- operation
    -289946279, -- mri
    -1091386327,
}

local InjuryTypes = {
	[1] = "Băng",
	[2] = "Vết Khâu Hình Bướm",
	[3] = "Băng Ép",
	[4] = "Khử Trùng Vết Thương Sâu",
	[5] = "Thuốc Giảm Đau",
	[6] = "Nẹp",
}

sleepanim = 0
RegisterNetEvent('sleepinjuryanim')
AddEventHandler('sleepinjuryanim', function()
    if sleepanim > 0 then
        sleepanim = 1500
        return
    end
    sleepanim = 500
    while sleepanim > 0 do
        sleepanim = sleepanim - 1
        Citizen.Wait(1)
    end
    sleepanim = 0
end)
RegisterCommand("sate", function(source, args, rawCommand)
    StoringEnabled = true
end, false)

RegisterCommand("show", function(source, args, rawCommand)
    TriggerEvent('Evidence:CurrentDamageList')
end, false)

function updateStates()
    
	if not StoringEnabled then
		return
	end
	CurrentDamageList = {}
	for i = 1, #InjuryList do
		if HasPedBeenDamagedByWeapon(PlayerPedId(), GetHashKey(InjuryList[i][1]),0) then
			table.insert( CurrentDamageList, InjuryList[i][3] )
		end
	end

    for i = 1, #Currentstates do
    	if Currentstates[i]["timer"] > 0 then
    		local msg = Currentstates[i]["text"] .. " " 
	    	if Currentstates[i]["timer"] > 360 then
	    		msg = msg .. "(Rất đáng chú ý)"
	    	elseif Currentstates[i]["timer"] > 180 then
	    		msg = msg .. "(Đáng chú ý)"
	    	elseif Currentstates[i]["timer"] > 60 then
	    		msg = msg .. "(Rất nhẹ)"
	    	end
	    	 CurrentDamageList[# CurrentDamageList+1]= msg
	    end
    end

    if GetPedArmour(PlayerPedId()) > 1 and armor then
	    table.insert( CurrentDamageList, "Is wearing body armor." )
	elseif armor then
		armor = false
	end
end

function bulletUpdate()
    for i = 1, #InjuryList do
        if HasPedBeenDamagedByWeapon(PlayerPedId(), GetHashKey(InjuryList[i][1]),0) then
            bleedmulti = 1       
            if not lightestbleed and (GetWeapontypeGroup(GetHashKey(InjuryList[i][1])) == 970310034 or GetWeapontypeGroup(GetHashKey(InjuryList[i][1])) == 416676503 or GetWeapontypeGroup(GetHashKey(InjuryList[i][1])) == -957766203 or GetWeapontypeGroup(GetHashKey(InjuryList[i][1])) == 860033945) then
                lightestbleed = true
                bleedMulti(1)
                bleedcount = 120
                myBleeds()
            end 
        end
    end
end


function bleedMulti(WeaponValue)

    local injured,part = GetPedLastDamageBone( PlayerPedId() )  
    if tier1[""..part..""] then

        Wait(2000)
        if WeaponValue == 1 then
            initialbleed = true
        end
        bleedmulti = math.ceil(2 * WeaponValue)
    end

    if tier2[""..part..""] then
        bleedmulti = WeaponValue
    end  

    if healing then
        bleedmulti = bleedmulti / 2
    end

    if bleedmulti == WeaponValue then
        bleedmulti = 1
    end
end

function myBleeds()
    bleedcount = bleedcount - 1
    bleeddamage2 = true

    if not initialbleed and math.random(100) < 100 then
        if lightbleed or heavybleed or lightestbleed then
            TriggerEvent("DoLongHudText","You notice blood oozing from your body the more you move.",2)
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - bleedmulti)
        end
    end

    if initialbleed then
        TriggerEvent("DoLongHudText","You notice blood oozing from your body the more you move.",2)
        for i = 1, 7 do
             if lightbleed or heavybleed or lightestbleed then
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - bleedmulti)
                Citizen.Wait(350)
            end
        end
    end

    bleeddamage2 = false

    initialbleed = false
    if bleedcount < 1 then
        bleedcount = 0
        lightbleed = false
        heavybleed = false
        lightestbleed = false
        initialbleed = false        
    end
end

function myPains()
    bleedLevel = 0
    
	if armsdisabled then
		if bones[12]["hitcount"] == 0 and bones[14]["hitcount"] == 0 and bones[18]["hitcount"] == 0 and bones[24]["hitcount"] == 0 then
			armsdisabled = false
            
		end
	end

    if legsdisabled then
        if bones[1]["hitcount"] == 0 and bones[2]["hitcount"] == 0 and bones[5]["hitcount"] == 0 and bones[6]["hitcount"] == 0 and bones[7]["hitcount"] == 0 and bones[9]["hitcount"] == 0 and bones[10]["hitcount"] == 0 and bones[15]["hitcount"] == 0 and bones[17]["hitcount"] == 0 then
            legsdisabled = false
            
        end
    end
    
    
	if armsdisabled or GetEntityHealth(PlayerPedId()) < (stresslevel + 80) or legsdisabled then

		
        if not clipchanged then
            clipchanged = true
    	    TriggerEvent("AnimSet:Set:temp",true,"move_m@injured")
        end
        

	elseif clipchanged then
		TriggerEvent("AnimSet:Set:temp",false,"move_m@injured")
        clipchanged = false
	end

	local injured,part = GetPedLastDamageBone(PlayerPedId())
    --print(injured,part)
	for o = 1, #bones do
        --print(bones[16]["hitcount"])
		if bones[o] and bones[o]["timer"] < 1 and bones[o]["hitcount"] > 0 then
			bones[o]["hitcount"] = 0
			bones[o]["timer"] = 0
            bones[o]["applied"] = false
		end		

		if bones[o] and bones[o]["timer"] > 0 then
			bones[o]["timer"] = bones[o]["timer"] - 1
            if bones[o]["hitcount"] > 0 then
                bleedLevel = bleedLevel + 1
            else
                bones[o]["timer"] = 0
            end
		end

		if bones[o] and bones[o]["hitcount"] > 0 then
			
			if not myboneActive then
				TriggerEvent("myboneIssuesTarget")
			end
            if not bones[o]["applied"] then
                Citizen.InvokeNative(0xEF0D582CBF2D9B0F,PlayerPedId(), bones[o]["zone"], bones[o]["offset1"], bones[o]["offset2"], 0.0, 1.0, -1, 0.0, "BasicSlash");
                bones[o]["applied"] = true
            end
			local chance = 9999
			--Citizen.Trace(GetEntitySpeed(PlayerPedId()))
			if GetEntitySpeed(PlayerPedId()) < 1.4 then
       			chance = 9995
			else
				chance = 5000
			end

			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				
				local veh = GetVehiclePedIsIn(PlayerPedId(),false)

       			if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
       				chance = 10000 / 2
       			else
       				chance = 9500
       			end
				
			end

			if IsPedRunning(PlayerPedId()) or IsPedSwimming(PlayerPedId()) or IsPedJumping(PlayerPedId()) or IsPedInMeleeCombat(PlayerPedId()) then
				chance = chance / 2
			end
			if math.random(10000) > chance and not passingout and not indamagefunction then
				if math.random(50) > 10 then
					TriggerEvent("DoDamageFunction",bones[o]["injuryType"],bones[o]["hitcount"],bones[o]["boneIndex"])
				end
			end

		end

		if passingout then
			while passingout do
				Citizen.Wait(1)
			end
			lasthealth2 = GetEntityHealth(PlayerPedId())
		end

		if bones[o] and bones[o]["boneIndex"] == part and ( (lasthealth2 > GetEntityHealth(PlayerPedId()) and ( lasthealth2 - GetEntityHealth(PlayerPedId())) > 1 ) or lastarmor > GetPedArmour(PlayerPedId()) ) then
			
            if allowdamage then
                local hitdamage = math.ceil( ( lasthealth2 - GetEntityHealth( PlayerPedId() ) ) / 20 )
                if lastarmor > GetPedArmour(PlayerPedId()) then
                    hitdamage = math.ceil( ( lastarmor - GetPedArmour( PlayerPedId() ) ) / 20 )
                end	


    			
    			if bones[o]["timer"] > 2000 then
    				bones[o]["hitcount"] = bones[o]["hitcount"] + hitdamage
    			else
    				bones[o]["hitcount"] = hitdamage
    			end

    			if bones[o]["hitcount"] > 6 then
    				bones[o]["hitcount"] = 6
    			end

                if not bones[o]["applied"] then
                    Citizen.InvokeNative(0xEF0D582CBF2D9B0F,PlayerPedId(), bones[o]["zone"], bones[o]["offset1"], bones[o]["offset2"], 0.0, 1.0, -1, 0.0, "BasicSlash");
                    bones[o]["applied"] = true
                end

    			bones[o]["timer"] = bones[o]["hitcount"] * 2000

    			if not bonesUpdatingServer then
    				TriggerEvent("bones:client:updateServer")
    			end

            end

            lasthealth2 = GetEntityHealth(PlayerPedId())
            lastarmor = GetPedArmour(PlayerPedId())
		end

		if lastarmor ~= 100  and GetPedArmour(PlayerPedId()) == 100 then
			lastarmor = 100
		end

        Citizen.Wait(10)
	end

end

RegisterNetEvent("breaklegs")
AddEventHandler("breaklegs",function()
    bones[5]["hitcount"] = bones[5]["hitcount"] + math.random(3,6)
    bones[9]["hitcount"] = bones[9]["hitcount"] + math.random(3,6)
    bones[6]["hitcount"] = bones[6]["hitcount"] + math.random(1,6)
    bones[5]["timer"] = 600
    bones[9]["timer"] = 600
    bones[6]["timer"] = 600
end)

function DoScreenFade(length, todark)
	if passingout then
		return
	end

    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.01)

    opacity = 0
	passingout = true

    if not todark then
		opacity = 255

		while length > 0 or opacity > 0 do
			if math.random(199) > 81 then
				DisableControlAction(2, 59, true)
				DisableControlAction(2, 60, true)
			end

			DrawRect(0, 0, 10.0, 10.0, 1, 1, 1, opacity)

            if math.random(100) < 45 then
				opacity = opacity - 1
			end

            Citizen.Wait(1)

            if opacity < 0 then
				opacity = 0
            end

            length = length - 1
		end
	else
		opacity = curfading

		while length > 0 or opacity < 255 do
			if math.random(199) > 81 then
				DisableControlAction(2, 59, true)
				DisableControlAction(2, 60, true)
			end

            DrawRect(0, 0, 10.0, 10.0, 1, 1, 1, opacity)

			opacity = opacity + 1

			if opacity > 253 then
				length = length - 10
				opacity = math.random(253, 255)
			end

			length = length - 1

			Citizen.Wait(1)
		end

        local distcheckhsp2 = #(vector3(304.77590942383, -589.34625244141, 43.29186630249) - GetEntityCoords(PlayerPedId()))
		local distcheckhsp = #(vector3(347.80456542969, -588.97180175781, 43.30224609375) - GetEntityCoords(PlayerPedId()))

        if distcheckhsp < 30.0 or distcheckhsp2 < 30.0 then
			if not (IsPedInAnyVehicle(PlayerPedId(), false)) then
				--findBed(false)
                TriggerEvent('bed:checkin')
			end
		end
	end

	passingout = false
end

local function HealInjuries()
	local count, injury = 0, nil

	if bones ~= nil then
		for i = 1, #bones do
			if bones[i]["timer"] > 0 then
				bones[i]["timer"] = 0
				count = count + bones[i]["hitcount"]
				bones[i]["hitcount"] = 0
				bones[i]["applied"] = false
				Citizen.Wait(1000)

				injury = bones[i]["part"] .. " Vết thương"
			end
		end
	end

	return count, injury
end

function findBed(fadein, skipServices)
    local distance
    if not inbed then
      myinjury = "General Checkups"
      local mybedx,mybedy,mybedz --= 363.86135864258,-593.99725341797,43.389274597168
      for i = 1, #bedcoords do	
        distance = #((vector3(bedcoords[i]["x"],bedcoords[i]["y"],bedcoords[i]["z"])) - GetEntityCoords(PlayerPedId()))
        if distance < 40.0 then
          --print(distance)
          if CheckBeds(bedcoords[i]["x"],bedcoords[i]["y"],bedcoords[i]["z"]) and not inbed then
            inbed = true
            mybedx,mybedy,mybedz = bedcoords[i]["x"],bedcoords[i]["y"],bedcoords[i]["z"]
            break
          end
          
        end
      end
  
      if inbed then
        SetEntityCoords(PlayerPedId(),mybedx,mybedy,mybedz)
        
        TriggerEvent("client:bed")
        if skipServices then
          inbed = false
          return
        end
        TriggerEvent("inbedrect",fadein)
        local count, injury = HealInjuries()
  
        myinjury = injury or myinjury
        injurycount = count and count + injurycount or injurycount
        Citizen.Wait(5000)
  
        if not bonesUpdatingServer then
          TriggerEvent("bones:client:updateServer")
        end
        TriggerEvent("chatMessage", "Service ", 5, "Trị thương thành công!", "feed", false )
        SetEntityHealth(PlayerPedId(), 200)
        Citizen.Wait(1000)
        inbed = false
        injurycount = 0
      else
        TriggerEvent('DoLongHudText',"All beds are busy please take a seat ", 101)
        return
      end
    end
  end

--[[ function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end

    return players
end ]]

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        players[#players + 1] = i
    end

    return players
end

function CheckBeds(x,y,z)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(x,y,z))
			if(distance < 3) then
				return false
			end
		end
	end
	return true
end

function MovementImpair(impairLevel,impairType)

	if impairType == 4 then
		-- leg movement		
		local fct = math.ceil(impairLevel * (stresslevel + 1))

		if impairLevel > 2 then
			legsdisabled = true
		end
	end

	if impairLevel > 2 and impairType == 3 then
		-- arm movement
		armsdisabled = true
      
	end

	if impairLevel > 2 and impairType == 5 then
		-- full body
        legsdisabled = true
        
		TriggerEvent("eventConc",20)
	end

end

function HealSlow(time)
    Citizen.CreateThread(function()
        if not healing then
            healing = true
        else
            return
        end

        local healtime = time or 30
        while healtime > 0 do
            Citizen.Wait(1000)
            healtime = healtime - 1
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
        end

        if math.random(100) > 80 and bleedcount > 0 then
            bleedcount = 0
        end

        initialbleed = false
        healing = false
    end)
end

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.2, 0.2)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 95)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function DrawText3DsInjured(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 185)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 340
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 155, 55, 55, 168)
end

function DrawText3DsInjured2(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.22, 0.22)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 185)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("CUSTOM_TEXT1")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 820
    DrawRect(_x, _y + 0.0095, 0.015 + factor, 0.015, 155, 55, 55, 118)
end

function map_range(s, a1, a2, b1, b2)
    return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end

function boneIssuesTarget(bt,targetid)
	active = false
	Citizen.Wait(100)
	bonesTarget = bt
	targetidsend = targetid
	targetChar = GetPlayerPed(GetPlayerFromServerId(targetid))
	active = true
	while active do
		Citizen.Wait(1)
		
		if not healing then
			healTargetBoneId = 0
		end
		for i = 1, #bonesTarget do
			local crds = GetPedBoneCoords(targetChar, bonesTarget[i]["boneIndex"], 0.0, 0.0, 0.0)
			if bonesTarget[i]["timer"] > 0 then
				local onScreen2,x2,y2=World3dToScreen2d(crds["x"], crds["y"],crds["z"])
			    if x2 > 0.33 and x2 < 0.66 and y2 > 0.33 and y2 < 0.66 then

			    	DrawText3DsInjured(crds["x"], crds["y"],crds["z"], bonesTarget[i]["part"] .. " (" .. InjuryTypes[bonesTarget[i]["hitcount"]] .. ")")
			    	if not healing then
			    		healTargetBoneId = i
			    	end			    	
			    else
			    	DrawText3DsInjured2(crds["x"], crds["y"],crds["z"], bonesTarget[i]["part"])
			    end	
			else
				--DrawText3Ds(crds["x"], crds["y"],crds["z"], bonesTarget[i]["part"])
			end	
			if IsControlJustReleased(0,38) and not healing and healTargetBoneId ~= 0 then
				TriggerEvent("healTargetsBoneId")
			end	

	        local pos = GetEntityCoords(targetChar)
	        local playerCoords = GetEntityCoords(PlayerPedId())
	        local distance = #(playerCoords - pos)

			if distance > 5 or IsControlJustReleased(0,47) then
				active = false
			end
		end
	end
end

function runHealAnim()
	if not IsEntityPlayingAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 3) then
		loadAnimDict("mini@cpr@char_a@cpr_str")
		TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, -8, -1, 49, 0, 0, 0, 0)
	end
end

function camOn()
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(cam,  true)
        RenderScriptCams(true,  false,  0,  true,  true)
    end
end

function camOff()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

--[[

    Events

]]

RegisterNetEvent("pw-evidence:reset")
AddEventHandler("pw-evidence:reset",function()
    allowdamage = false
    StoringEnabled = false

    CurrentDamageList = {}
    CurrentLocationList = {}

    armor = false
    lasthealth = GetEntityHealth(PlayerPedId())
    lastarmor = GetPedArmour(PlayerPedId())
    lasthealth2 = lasthealth

    bleedmulti = 1
    bleedcount = 0
    heavybleed = false
    lightbleed = false
    lightestbleed = false
    initialbleed = false
    bleeddamage = false
    bleeddamage2 = false

    sweatTriggered = false
    bodySweat = 0

    lastTarget = nil
    target = nil
    targetLastHealth = nil

    passingout = false
    fading = false
    maxfade = 0.0
    curfading = 0

    legsdisabled = false
    armsdisabled = false

    bleedLevel = 0
    setBleedLevel = 0

    stresslevel = 0
    clipchanged = false
    myboneActive = false
    indamagefunction = false

    inbed = false
    injurycount = 0
    bonesUpdatingServer = false

    sleeping = false
    showInteraction = true

    healing = false

    bonesTarget = {}
    healTargetBoneId = 0
    targetidsend = 0

    Currentstates = {
        [1] = { ["text"] = "Bàn Tay Bị Đỏ", ["status"] = false, ["timer"] = 0 },
        [2] = { ["text"] = "Giãn Nở Đồng Tử", ["status"] = false, ["timer"] = 0 },
        [3] = { ["text"] = "Đau Mắt Đở", ["status"] = false, ["timer"] = 0 },
        [4] = { ["text"] = "Có Mùi Của Cần Sa", ["status"] = false, ["timer"] = 0 },
        [5] = { ["text"] = "Vừa Mới Băng Bó", ["status"] = false, ["timer"] = 0 },
        [6] = { ["text"] = "Bị Kích Động", ["status"] = false, ["timer"] = 0 },
        [7] = { ["text"] = "Bủn Rủn Tay Chân", ["status"] = false, ["timer"] = 0 },
        [8] = { ["text"] = "Hơi Thở Có Mùi Cồn", ["status"] = false, ["timer"] = 0 },
        [9] = { ["text"] = "Có Mùi Của Xăng Dầu", ["status"] = false, ["timer"] = 0 },
        [10] = { ["text"] = "Có Vết Của Thuốc Súng", ["status"] = false, ["timer"] = 0 },
        [11] = { ["text"] = "Có Mùi Của Hóa Chất", ["status"] = false, ["timer"] = 0 },
        [12] = { ["text"] = "Mùi Của Dầu / Kim Loại", ["status"] = false, ["timer"] = 0 },
        [13] = { ["text"] = "Tay Dính Mực", ["status"] = false, ["timer"] = 0 },
        [14] = { ["text"] = "Có Mùi Của Khói", ["status"] = false, ["timer"] = 0 },
        [15] = { ["text"] = "Đã Cài Thiết Bị Cấm Trại", ["status"] = false, ["timer"] = 0 },
        [16] = { ["text"] = "Có Mùi Cháy Của Sắt - Nhôm", ["status"] = false, ["timer"] = 0 },
        [17] = { ["text"] = "Có Mẫu Kim Loại Trên Quần Áo", ["status"] = false, ["timer"] = 0 },
        [18] = { ["text"] = "Có Mùi Của Thuốc Lá.", ["status"] = false, ["timer"] = 0 },
        [19] = { ["text"] = "Hơi Thở Gấp", ["status"] = false, ["timer"] = 0 },
        [20] = { ["text"] = "Đỗ Mồ Hôi", ["status"] = false, ["timer"] = 0 },
        [21] = { ["text"] = "Quần Áo Bị Ướt", ["status"] = false, ["timer"] = 0 },
        [22] = { ["text"] = "Cắt Dây", ["status"] = false, ["timer"] = 0 },
        [23] = { ["text"] = "Ngấm Vào Quần Áo", ["status"] = false, ["timer"] = 0 },
        [24] = { ["text"] = "Bị Chóng Mặt.", ["status"] = false, ["timer"] = 0 },
        [25] = { ["text"] = "Bị Chán Nản", ["status"] = false, ["timer"] = 0 },
        [26] = { ["text"] = "Có Vết Xước Trên Cánh Tay", ["status"] = false, ["timer"] = 0 },
        [27] = { ["text"] = "Chú Ý Đề Phòng", ["status"] = false, ["timer"] = 0 },
    }

    bones = {
        [1] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Chậu",               ["boneIndex"] = 11816, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.35, ["zone"] = 0 },
        [2] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đùi Trái",           ["boneIndex"] = 58271, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.8,  ["zone"] = 4 },
        [3] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Miệng",                ["boneIndex"] = 47495, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1 },
        [4] =  { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Chân Trái",            ["boneIndex"] = 14201, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 4 },
        [5] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu Gối Trái",            ["boneIndex"] = 46078, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.55, ["zone"] = 4 },
        [6] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đùi Phải",          ["boneIndex"] = 51826, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.8,  ["zone"] = 5 },
        [7] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cột Sống Dưới",          ["boneIndex"] = 24816, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.35, ["zone"] = 0 },
        [8] =  { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Chân Phải",           ["boneIndex"] = 52301, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 5 },
        [9] =  { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu Gối Phải",           ["boneIndex"] = 16335, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 4, ["offset1"] = 0.35, ["offset2"] = 0.55, ["zone"] = 5 },
        [10] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cột Sống Giữa",            ["boneIndex"] = 24817, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.55, ["zone"] = 0 },
        [11] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Tay Trái",            ["boneIndex"] = 60309, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [12] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Khuỷu Tay Trái",           ["boneIndex"] = 22711, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 2 },
        [13] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Tay Phải",           ["boneIndex"] = 57005, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [14] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Khuỷu Tay Phải",          ["boneIndex"] = 2992,  ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 3 },
        [15] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cổ",                 ["boneIndex"] = 39317, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.95, ["zone"] = 0 },
        [16] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Đầu",                 ["boneIndex"] = 31086, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 2, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 1 },
        [17] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Cột Sống Cao",           ["boneIndex"] = 24818, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 5, ["offset1"] = 0.25, ["offset2"] = 0.85, ["zone"] = 0 },
        [18] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Đòn Trái",        ["boneIndex"] = 64729, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.15, ["offset2"] = 0.75, ["zone"] = 0 },
        [19] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Út Trái",    ["boneIndex"] = 26610, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [20] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Trái",    ["boneIndex"] = 26611, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [21] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Giữa Trái",   ["boneIndex"] = 26612, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [22] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Áp Út Trái",     ["boneIndex"] = 26613, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [23] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Cái Trái",    ["boneIndex"] = 26614, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 2 },
        [24] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Xương Đòn Phải",       ["boneIndex"] = 10706, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 3, ["offset1"] = 0.35, ["offset2"] = 0.75, ["zone"] = 0 },
        [25] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Út Phải",   ["boneIndex"] = 58866, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [26] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Trỏ Phải",   ["boneIndex"] = 58867, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [27] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Giữa Phải",  ["boneIndex"] = 58868, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [28] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Áp Út Phải",    ["boneIndex"] = 58869, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [29] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Ngón Cái Phải",   ["boneIndex"] = 58870, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.2,  ["zone"] = 3 },
        [30] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Gò Má Trái",  ["boneIndex"] = 21550, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.55, ["offset2"] = 0.45, ["zone"] = 1 },
        [31] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Gò Má Phải", ["boneIndex"] = 19336, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.35, ["offset2"] = 0.45, ["zone"] = 1 },
        [32] = { ["applied"] = false, ["maxhit"] = false, ["part"] = "Trán",             ["boneIndex"] = 37193, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 2, ["offset1"] = 0.45, ["offset2"] = 0.75, ["zone"] = 1  },
        [33] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Môi Trên",        ["boneIndex"] = 61839, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1  },
        [34] = { ["applied"] = false, ["maxhit"] = true,  ["part"] = "Môi Dưới",        ["boneIndex"] = 20623, ["timer"] = 0, ["hitcount"] = 0, ["injuryType"] = 1, ["offset1"] = 0.45, ["offset2"] = 0.35, ["zone"] = 1  },
    }
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    StoringEnabled = true
    TriggerServerEvent("LoadPlayerDamaged")
end)


RegisterNetEvent("enabledamage")
AddEventHandler("enabledamage",function(toggle)
    allowdamage = toggle
end)

RegisterNetEvent("Evidence:isDead")
AddEventHandler("Evidence:isDead",function()
	StoringEnabled = false
end)

RegisterNetEvent("pw-death:dead")
AddEventHandler("pw-death:dead", function()
    lightbleed = false
    heavybleed = false
    lightestbleed = false
	lasthealth = GetEntityHealth(PlayerPedId())
end)

RegisterNetEvent("Evidence:isAlive")
AddEventHandler("Evidence:isAlive",function()
	StoringEnabled = true
	CurrentDamageList = {}
	CurrentLocationList = {}
end)

RegisterNetEvent("DoHealthFading")
AddEventHandler("DoHealthFading",function()
	local health = GetEntityHealth(PlayerPedId())
	local maxHealth = GetEntityMaxHealth(PlayerPedId())
	if health > maxHealth - 10 then
		Wait(100)
		return
	end

	fading = true

    maxfade = math.ceil(maxHealth - (health)) + (50 + (200 - maxHealth))
	if maxfade > 240 then
		maxfade = 240
	end

	while curfading < maxfade and not passingout do
		Citizen.Wait(1)
		DrawRect(0,0, 10.0, 10.0, 1, 1, 1, curfading)
		curfading = curfading + 1
	end

	while curfading > 0 and not passingout do
		Citizen.Wait(1)
		DrawRect(0,0, 10.0, 10.0, 1, 1, 1, curfading)
		curfading = curfading - 1
	end
	Wait(2000 + math.floor(health * 50))
	curfading = 0
	fading = false
end)

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
	stresslevel = newStress / 100
end)

RegisterNetEvent("myboneIssuesTarget")
AddEventHandler("myboneIssuesTarget",function()
	myboneActive = true
    local damagereport = ""
    local effectedcount = 0
	for i = 1, #bones do
		if bones[i]["timer"] > 0 and bones[i]["hitcount"] > 0 then
			if bones[i]["hitcount"] > 2 then
                effectedcount = effectedcount + 1
                if damagereport == "" then
                    damagereport = damagereport .. "" .. bones[i]["part"] .. " rất đau đớn"
                else
                    damagereport = damagereport .. " | " .. bones[i]["part"] .. " rất đau đớn"
                end
			elseif bones[i]["hitcount"] == 2 then
                effectedcount = effectedcount + 1
                if damagereport == "" then
                    damagereport = damagereport .. "" .. bones[i]["part"] .. " cảm thấy ấm với máu"
                else
                    damagereport = damagereport .. " | " .. bones[i]["part"] .. " cảm thấy ấm với máu"
                end 
			elseif bones[i]["hitcount"] == 1 then
                effectedcount = effectedcount + 1
                if damagereport == "" then
                    damagereport = damagereport .. "" .. bones[i]["part"] .. " cảm thấy khó chịu"
                else
                    damagereport = damagereport .. " | " .. bones[i]["part"] .. " cảm thấy khó chịu"
                end
			end
		end	

        if armsdisabled and not legsdisabled then
            TriggerEvent("DoLongHudText","Tôi cảm thấy khó sử dụng cánh tay của mình đúng cách.",2)
        elseif legsdisabled and not armsdisabled then
            TriggerEvent("DoLongHudText","Tôi cảm thấy khó sử dụng chân của mình đúng cách.",2)
        elseif legsdisabled and armsdisabled then
            TriggerEvent("DoLongHudText","Tôi cảm thấy khó sử dụng tay và chân của mình.",2)
        end

        if effectedcount > 3 then
            damagereport = "Tôi cảm thấy nhiều cơn đau"
        end
        if damagereport ~= "" then
            TriggerEvent("DoLongHudText",damagereport, 155)
        end

	end

    Citizen.Wait(15000)
    myboneActive = false

end)

RegisterNetEvent("DoDamageFunction")
AddEventHandler("DoDamageFunction",function(InjuryType, CurrentHitCount, boneIndex)
	indamagefunction = true

    if true then
        bleeddamage = true
		local curhealth = GetEntityHealth(PlayerPedId())
        
		if InjuryType == 1 then
			if math.random(50) > 45 then
				curhealth = curhealth - (CurrentHitCount * 3)
				lasthealth2 = curhealth
				-- SetEntityHealth(PlayerPedId(), curhealth)
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.02)
			    -- ApplyPedBlood(PlayerPedId(), boneIndex, 0.0, 0.0, 0.0, "wound_sheet")
			end
		elseif InjuryType == 2 then
			if math.random(50) > 20 then
				curhealth = curhealth - (CurrentHitCount * 4)
				lasthealth2 = curhealth
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.02)
				-- SetEntityHealth(PlayerPedId(), curhealth)
				-- ApplyPedBlood(PlayerPedId(), boneIndex, 0.0, 0.0, 0.0, "wound_sheet")
			end

            if CurrentHitCount == 3 then
				TriggerEvent("eventConc", 3)
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.02)
			elseif CurrentHitCount == 4 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.025)
				TriggerEvent("eventConc", 4)
			elseif CurrentHitCount == 5 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.03)
				TriggerEvent("eventConc", 5)
			elseif CurrentHitCount == 6 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.035)
				TriggerEvent("eventConc", 6)
			end
		else
            if math.random(50) > 40 then
                curhealth = curhealth - (CurrentHitCount*3)
                lasthealth2 = curhealth
                -- SetEntityHealth(PlayerPedId(),curhealth)
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.02)
                -- ApplyPedBlood(PlayerPedId(), boneIndex, 0.0, 0.0, 0.0, "wound_sheet")
            end

			MovementImpair(CurrentHitCount,InjuryType)
		end

        bleeddamage = false
	end

    Citizen.Wait(5000)

    indamagefunction = false
end)

RegisterNetEvent('eventConc')
AddEventHandler('eventConc', function(level)
	
	if math.random(100) > 40 then

		local levelset = math.ceil(level * (stresslevel + 1))
		local fullcol = false


		if not fullcol then
			DoScreenFade(levelset,true)
			Wait(100)
			DoScreenFade(levelset,false)
		end

	end

end)

RegisterNetEvent("inbedrect")
AddEventHandler("inbedrect",function(fadein)
	local opacityc

    if fadein then
		opacityc = 0
	else
		opacityc = 255
	end

	while inbed do
		if opacityc < 255 then
			opacityc = opacityc + 1
		end

		DrawRect(0, 0, 10.0, 10.0, 1, 1, 1, opacityc)

		Citizen.Wait(1)
	end
end)

function redflash(enable)
    if enable then
        StartScreenEffect("SuccessTrevor", 1.0, 0)
        StopScreenEffect("SuccessTrevor")   
        Citizen.Wait(50)     
        StartScreenEffect("SuccessTrevor", 1.0, 0)
    else
        StartScreenEffect("SuccessTrevor", 1.0, 0)
        StopScreenEffect("SuccessTrevor")
    end
end



RegisterNetEvent("bed:checkin")
AddEventHandler("bed:checkin",function()
	local canHeal = RPC.execute("pw-ems:canHeal")
    if canHeal then
        findBed(true)
    end
end)

RegisterNetEvent("client:bed")
AddEventHandler("client:bed",function()
    local objFound = nil
    local near = 999

    for i, v in ipairs(beds) do
        local curobjFound = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 3.0, v, 0, 0, 0)
        if curobjFound ~= 0 then
            local dist = #(GetEntityCoords(curobjFound) - GetEntityCoords(PlayerPedId()))

            if DoesEntityExist(curobjFound) then
                if dist ~= 0 and dist < near then
                    near = dist
                    objFound = curobjFound
                end
            end
        end
    end

    if DoesEntityExist(objFound) then
        loadAnimDict("missfinale_c1@")

        Citizen.Wait(500)

        sleeping = true
        showInteraction = true

        local bedOffset = vector3(-0.2, 0.1, 1.4)
        if GetEntityModel(objFound) == -289946279 or GetEntityModel(objFound) == -1519439119 then
            TaskPlayAnim( PlayerPedId(), "anim@gangops@morgue@table@", "body_search", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
            bedOffset = vector3(0, 0.05, 2)
        else
            TaskPlayAnim(PlayerPedId(), "missfinale_c1@", "lying_dead_player0", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
        end

        Citizen.CreateThread(function()
            Citizen.Wait(3000)
            exports["pw-interaction"]:showInteraction("[E] Rời giường [F] Từ chối")

            while sleeping do
                if IsControlJustReleased(0, 38) then
                    sleeping = false
                    DetachEntity(PlayerPedId(), 1, true)
                end

                if IsControlJustReleased(0, 75) then
                    showInteraction = false
                end

                Citizen.Wait(1)
            end
        end)

        while sleeping do
            AttachEntityToEntity(PlayerPedId(), objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z, 0.0, 0.0, 180.0, true, true, true, true, 1, true)
            -- camOn()

            if not showInteraction then
                exports["pw-interaction"]:hideInteraction()
            end

            Citizen.Wait(1000)

            -- SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(objFound, 0.0, 1.0, bedOffset.z + 0.8))
            -- SetCamRot(cam, -50.0, 0.0, GetEntityHeading(objFound) + 180)
        end

        exports["pw-interaction"]:hideInteraction()

        local counter = 0

        SetEntityHeading(GetEntityHeading(PlayerPedId() - 90))
        TriggerEvent("animation:PlayAnimation", "getup")

        local count = 0
        while counter < 400 do
            counter = counter + 1

            if counter > 250 then
                count = count + 0.004
                AttachEntityToEntity(ped, objFound, 1, bedOffset.x+count, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
            else
                AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
            end

            Citizen.Wait(1)
        end

        camOff()
        DetachEntity(PlayerPedId(), 1, true)
    end
end)

RegisterNetEvent("Evidence:StateSet")
AddEventHandler("Evidence:StateSet",function(stateId,stateLength)
	if Currentstates[stateId]["timer"] < 10 and stateLength ~= 0 then
		-- TriggerEvent("chatMessage", "STATUS: ", {207, 181, 59}, Currentstates[stateId]["text"])
	end

	Currentstates[stateId]["timer"] = stateLength
end)

RegisterNetEvent("bones:client:updateServer")
AddEventHandler("bones:client:updateServer",function()
	bonesUpdatingServer = true
	Citizen.Wait(30000)
	TriggerServerEvent("bones:server:updateServer", bones)
	bonesUpdatingServer = false
end)

RegisterNetEvent("Hospital:HealInjuries")
AddEventHandler("Hospital:HealInjuries", HealInjuries)

RegisterNetEvent("UseBodyArmor")
AddEventHandler("UseBodyArmor", function()
    armor = true
    lastarmor = GetPedArmour(PlayerPedId())
    lasthealth = GetEntityHealth(PlayerPedId())
    lasthealth2 = lasthealth
    TriggerEvent("hud:saveCurrentMeta")
end)

RegisterNetEvent("ems:healpassed")
AddEventHandler("ems:healpassed", HealSlow)



RegisterNetEvent("Evidence:CurrentDamageList")
AddEventHandler("Evidence:CurrentDamageList",function()
	updateStates()
	for i = 1, #CurrentDamageList do
		TriggerEvent('chatMessage', 'STATUS: ', 1, CurrentDamageList[i], "feed", false)
	end
	
	for i = 1, #bones do
		if bones[i]["timer"] > 0 then
			TriggerEvent('chatMessage', 'STATUS: ', 1, bones[i]["part"] .. " Injury", "feed", false)
		end
		
	end

end)

RegisterNetEvent("bones:client:updatefromDB")
AddEventHandler("bones:client:updatefromDB",function(newbones)
	bones = newbones
end)

RegisterNetEvent("healed:useOxy")
AddEventHandler("healed:useOxy", function(isOxy, ignoreAddiction)
    for i = 1, #bones do
        bones[i]["applied"] = false
        if bones[i]["hitcount"] > 0 then
            bones[i]["hitcount"] = 0
            bones[i]["timer"] = 0
        end
    end

    ClearPedBloodDamage(PlayerPedId())

    if isOxy and isOxy ~= -1 and (not ignoreAddiction) then
      TriggerEvent("addiction:drugTaken", "oxy")
      local addictionFactor = exports["pw-fx"]:getOwnAddictionFactor("oxy")
      local healtime = map_range(addictionFactor, 0.0, 5.0, 30, 0)

      if healtime < 0 then
        healtime = 0
      else
        healtime = math.ceil(healtime)
      end

		HealSlow(healtime)
    elseif ignoreAddiction then
		HealSlow(10, 6)
	else
		HealSlow()
	end

    bleedcount = 0
    lightbleed = false
    heavybleed = false
    lightestbleed = false
    initialbleed = false
    lasthealth = GetEntityHealth(PlayerPedId())
    lasthealth2 = lasthealth

    if not bonesUpdatingServer then
        TriggerEvent("bones:client:updateServer")
    end
end)

RegisterNetEvent("healed:minors")
AddEventHandler("healed:minors", function()
    for i = 1, #bones do
        bones[i]["applied"] = false
        if bones[i]["hitcount"] > 0 and bones[i]["hitcount"] < 3 then
            bones[i]["hitcount"] = 0
            bones[i]["timer"] = 0
        end
    end


    ClearPedBloodDamage(PlayerPedId())

    HealSlow()

    lasthealth = GetEntityHealth(PlayerPedId())
    lasthealth2 = lasthealth

    if not bonesUpdatingServer then
        TriggerEvent("bones:client:updateServer")
    end
    
end)

RegisterNetEvent("randomBoneDamage")
AddEventHandler("randomBoneDamage",function()
    local b1 = math.random(34)
    local b2 = math.random(34)
    local b3 = math.random(34)
    bones[b1]["hitcount"] = bones[b1]["hitcount"] + math.random(2,6)
    bones[b2]["hitcount"] = bones[b2]["hitcount"] + math.random(2,6)
    bones[b3]["hitcount"] = bones[b3]["hitcount"] + math.random(1,3)
    bones[b1]["timer"] = 600
    bones[b2]["timer"] = 300
    bones[b3]["timer"] = 300
end)

RegisterNetEvent("Evidence:ClearDamageStates")
AddEventHandler("Evidence:ClearDamageStates",function()
	local plyPos = GetEntityCoords(PlayerPedId(),  true)
	local plyHead = GetEntityHeading(PlayerPedId())
	TriggerEvent("resurrect:relationships")
	ClearPedTasks(PlayerPedId())
	CurrentDamageList = {}
	CurrentLocationList = {}
end)

RegisterNetEvent("Evidence:GiveWounds")
AddEventHandler("Evidence:GiveWounds",function(id)
	updateStates()
	TriggerServerEvent("Evidence:GiveWoundsFinish", CurrentDamageList, id, bones)
end)


RegisterNetEvent("Evidence:CurrentDamageListTarget")
AddEventHandler("Evidence:CurrentDamageListTarget",function(CurrentDamageListTarget,bt,targetid)
    for i = 1, #CurrentDamageListTarget do
      TriggerEvent('chatMessage', 'STATUS: ', 1, CurrentDamageListTarget[i], "feed", false)
    end
    local myJob = ESX.PlayerData.job.name
    if myJob == "police" or myJob == "ambulance" or myJob == "doctor" or myJob == "doc" then
    	boneIssuesTarget(bt,targetid)
    end
end)

RegisterNetEvent("Evidence:CurrentPainList")
AddEventHandler("Evidence:CurrentPainList",function()
	myPains()
	for i = 1, #CurrentLocationList do
		TriggerEvent('chatMessage', 'STATUS: ', 1, CurrentLocationList[i])
	end
end)

RegisterNetEvent("updateHealLocation:client")
AddEventHandler("updateHealLocation:client",function(newinfo)
	bones = newinfo

    if not bonesUpdatingServer then
		TriggerEvent("bones:client:updateServer")
	end
end)

RegisterNetEvent("healTargetsBoneId")
AddEventHandler("healTargetsBoneId",function()
	healing = true
	runHealAnim()
	Citizen.Wait(2000)
	ClearPedTasks(PlayerPedId())
	bonesTarget[healTargetBoneId]["hitcount"] = bonesTarget[healTargetBoneId]["hitcount"] - 1
	if bonesTarget[healTargetBoneId]["hitcount"] == 0 then
		bonesTarget[healTargetBoneId]["timer"] = 0
	end
	TriggerServerEvent("updateHealLocation",bonesTarget,targetidsend)
	healing = false
end)

RegisterNetEvent("requestWounds")
AddEventHandler("requestWounds", function(pArgs, pEntity)
	local targetPed = nil

    if not pEntity then
		targetPed = exports["pw-interact"]:GetCurrentEntity()
	else
		targetPed = pEntity
	end

	if not targetPed then
		return
	end

	TriggerServerEvent("Evidence:GetWounds", GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed)))
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(10000)
        for i = 1, #Currentstates do
        	if Currentstates[i]["timer"] > 0 then
        		Currentstates[i]["timer"] = Currentstates[i]["timer"] - 10
	        	if Currentstates[i]["timer"] < 0 then
	        		Currentstates[i]["timer"] = 0
	        	end
        	end
        end

    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        if StoringEnabled then
        	updateStates()
        end
    end
end)

Citizen.CreateThread(function()
	local firstspawn = false
    local lastbone = 0
    local saveHealth = GetEntityHealth(PlayerPedId())
    local entityModel = GetEntityModel(PlayerPedId())
    lasthealth = GetEntityHealth(PlayerPedId())
    lastarmor = GetPedArmour(PlayerPedId())
    local saveFlag = 0
    while true do
        Citizen.Wait(100)

        if GetEntityHealth(PlayerPedId()) ~= saveHealth then

            if entityModel == GetEntityModel(PlayerPedId()) then       
                saveHealth = GetEntityHealth(PlayerPedId())
                saveFlag = 50
            else
                entityModel = GetEntityModel(PlayerPedId())
                saveHealth = GetEntityHealth(PlayerPedId())
                saveFlag = 0
            end
        end

        if GetPedArmour(PlayerPedId()) ~= lastarmor then
            
            if entityModel == GetEntityModel(PlayerPedId()) then   
                lastarmor = GetPedArmour(PlayerPedId())
                saveFlag = 50
            else
                entityModel = GetEntityModel(PlayerPedId())
                lastarmor = GetPedArmour(PlayerPedId())
                saveFlag = 0
            end
        end

        if GetEntityHealth(PlayerPedId()) < lasthealth and GetPedArmour(PlayerPedId()) < 1 then
            TriggerEvent("evidence:bleeding",false)
        	lasthealth = GetEntityHealth(PlayerPedId())
            local injured,part = GetPedLastDamageBone( PlayerPedId() )
            if lastbone ~= part and not bleeddamage and not bleeddamage2 then
                if (lightbleed or heavybleed or lightestbleed) then
                    lightbleed = false
                    heavybleed = false
                    lightestbleed = false
                    initialbleed = false
                end
            end
            bulletUpdate()	
            local injured,part = GetPedLastDamageBone( PlayerPedId() )
            lastbone = part
	    end

        if saveFlag > 0 then
            saveFlag = saveFlag - 1
            if saveFlag == 0 then
                TriggerEvent("hud:saveCurrentMeta")
            end
        end
    end
end)

local bleeders = {}
RegisterNetEvent("blood")
AddEventHandler("blood", function(x,y,z)
    local particleDictionary = "core"
    local particleName = "blood_stab"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local particle = StartParticleFxLoopedAtCoord(particleName, x, y, z-0.9, 0.0, 0.0, 0.0, 1.0, 0, 0, 0, 0)
    StopParticleFxLooped(particle, true)
end)

RegisterNetEvent("bleeder:alter")
AddEventHandler("bleeder:alter", function(bleedid,bleedon)
    local bleedid = tonumber(bleedid)
    local idlol = 0
    if bleedon then
        bleeders[#bleeders+1]={ ["id"] = bleedid }
    else
        checkingbleedid = 0

        for i = 1, #bleeders do
            checkingbleedid = bleeders[i]["id"]
            assadf = tonumber(checkingbleedid)
            if assadf == bleedid then
                idlol = i
            end
        end

        table.remove(bleeders,idlol)
    end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(300)

        if IsPedInAnyVehicle(PlayerPedId(), false) then
        	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )
        	local speed = GetEntitySpeed(vehicle)
        	if bicycle and speed > 0 then
        		sweatTriggered = true
        		if bodySweat < 180000 then
        			bodySweat = bodySweat + (150 + math.ceil(speed * 40))
        		else
        			bodySweat = bodySweat + (150 + math.ceil(speed * 11))
        		end

        		if bodySweat > 300000 then
	        		bodySweat = 300000
	        	end
        	end
        end        

        if IsPedInMeleeCombat(PlayerPedId()) then
        	bodySweat = bodySweat + 4000
        	sweatTriggered = true
        	target = GetMeleeTargetForPed(PlayerPedId())
        	if target == lastTarget or lastTarget == nil then
        		if IsPedAPlayer(target) then
        			lastTarget = target
        		end
        	else
        		if IsPedAPlayer(target) then
	        		targetLastHealth = GetEntityHealth(target)
	        		lastTarget = target
	        	end
        	end
        end

        if IsPedSwimming(PlayerPedId()) then
        	local speed = GetEntitySpeed(PlayerPedId())
        	if speed > 0 then
        		sweatTriggered = true
        		TriggerEvent("Evidence:StateSet",20,0)
        		TriggerEvent("Evidence:StateSet",21,0)
        		TriggerEvent("Evidence:StateSet",23,600)
        		if bodySweat < 180000 then
        			bodySweat = bodySweat + (150 + math.ceil(speed * 40))
        		else
        			bodySweat = bodySweat + (150 + math.ceil(speed * 11))
        		end
        		

        		if bodySweat > 210000 then
        			TriggerEvent("Evidence:StateSet",19,600)
	        		bodySweat = 210000
	        	end
        	end
        end

        if IsPedRunning(PlayerPedId()) then
        	bodySweat = bodySweat + 3000
        	if bodySweat > 800000 then
        		bodySweat = 800000
        	end
        elseif bodySweat > 0.0 then
        	if not sweatTriggered then
        		bodySweat = 0.0
        	end
        	if bodySweat < 100000 then
        		bodySweat = bodySweat - 1500
        	end
        	bodySweat = bodySweat - 100
        	if bodySweat == 0.0 then
        		sweatTriggered = false
        	end
        end
        if bodySweat > 200000 and not IsPedSwimming(PlayerPedId()) then
			TriggerEvent("Evidence:StateSet",19,300)
        end  

        if bodySweat > 300000 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then
			TriggerEvent("Evidence:StateSet",20,450)
        end 
        if bodySweat > 800000 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then
        	sweatTriggered = true
			TriggerEvent("Evidence:StateSet",21,600)
        end

    end
end)

local weather = ""

RegisterNetEvent("pw_weather:weatherHasChanged")
AddEventHandler("pw_weather:weatherHasChanged", function(pWeatherProgression)
	weather = pWeatherProgression.weathers[1]
end)

function getDropChance(startingChance)
	local chance = startingChance

	if weather == "RAIN" then
		chance = startingChance + 10
	elseif weather == "THUNDER" then
		chance = startingChance + 20
	end
	
	if chance > 95 then chance = 95 end
	return chance
end

weaponCheck = {
    -1716189206,
    1317494643,
    -1786099057,
    -2067956739,
    1141786504 ,
    -102323637,
    -1834847097,
    -102973651 ,
    -656458692 ,
    -581044007,
    -1951375401,
    -538741184 ,
	-1810795771 ,
	-1024456158,
    419712736 
}

RegisterNetEvent("Evidence:dropdna")
AddEventHandler("Evidence:dropdna",function(dna,dropType)
	local pos = GetEntityCoords(PlayerPedId())
    local sendPos = {pos.x,pos.y,pos.z-0.7}

	if dropType == 1 then

        local information = {
          ["data"] = dna,
          ["name"] = "blood",
          ["Desc"] = "Blood drop's."
        }

        --TriggerEvent("inv:CreatedropItem",56,1,sendPos,information)
	elseif dropType == 2 then

        local information = {
          ["data"] = dna,
          ["name"] = "blood",
          ["Desc"] = "Broken Lockpick with blood."
        }
        
        --TriggerEvent("inv:CreatedropItem",56,1,sendPos,information)
	end
end)

RegisterNetEvent("Evidence:wipe")
AddEventHandler("Evidence:wipe",function()
	CurrentDamageList = {}
	StoredDamageList = {}
end)

local fadeEnabled = true
RegisterNetEvent("police:setFadeState", function(pState)
	fadeEnabled = pState
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(300)
        if fadeEnabled and not passingout and not fading then
        	TriggerEvent("DoHealthFading")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if legsdisabled or armsdisabled then
            if armsdisabled then
                if math.random(100) > 5 then
                    DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
                    DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
                end
            end
            if legsdisabled then
                DisableControlAction( 0, 21, true ) -- sprint
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        myPains()

        --[[ if (heavybleed or lightbleed or lightestbleed) then
            TriggerEvent("evidence:bleeding",false)
            Wait(50)
            if (GetPedArmour(PlayerPedId()) > 1 and math.random(80) > 100) or GetPedArmour(PlayerPedId()) < 35 then
                if GetEntitySpeed(PlayerPedId()) < 1.0 or IsPedSittingInAnyVehicle(PlayerPedId()) or initialbleed or math.random(100) < 45 then
                    myBleeds()
                else
                    myBleeds()
                end
            end
        end ]]
    end
end)