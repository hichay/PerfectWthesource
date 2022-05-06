---------------------------------------------------------------------- อย่าลืมลงสคริป pNotify
Config 			         = {}                      					-- V 1.1
Config.UserLicense       = 'W1MS_XXXXXXXXXXXXXXX'					-- License Key เปลี่ยน IP หรือซื้อสคริป ได้ที่ https://f.w1ms.com



Config.FirstCode         = 'W1MS_'									-- ตัวขึ้นต้นของโค้ด
Config.LastCodeLength    = 20										-- จำนวนตัวอักษรที่จะสร้างขึ้น ไม่รวมกับ ตัวขึ้นต้น

Config.Ammo              = 250										-- จำนวนกระสุนที่จะได้เมื่อมีการได้รับ อาวุธ

Config.OpenAdminUIbykey  = true										-- เปิดใช้งานการใช้ปุ่มกดเปิด UI สำหรับ แอดมิน หรือไม่
Config.OpenUserUIbykey   = true										-- เปิดใช้งานการใช้ปุ่มกดเปิด UI สำหรับ ผู้เล่น หรือไม่

Config.OpenAdminUIkey    = 'PAGEDOWN'								-- ปุ่มที่ใช้ในการกดเปิด UI สำหรับ แอดมิน
Config.OpenUserUIkey     = 'PAGEUP'									-- ปุ่มที่ใช้ในการกดเปิด UI สำหรับ ผู้เล่น

Config.OpenAdminUIbyCMD  = true										-- เปิดใช้งานการใช้ คำสั่ง เปิด UI สำหรับ แอดมิน หรือไม่
Config.OpenUserUIbyCMD   = true										-- เปิดใช้งานการใช้ คำสั่ง เปิด UI สำหรับ ผู้เล่น หรือไม่

Config.OpenAdminUICMD    = 'adminredeem'							-- คำสั่งที่ใช้ในการกดเปิด UI สำหรับ แอดมิน
Config.OpenUserUICMD     = 'redeem'									-- คำสั่งที่ใช้ในการกดเปิด UI สำหรับ ผู้เล่น


Config.OpenAdminUIbyTrigger  = true									-- เปิดใช้งานการใช้ TriggerEvent เปิด UI สำหรับ แอดมิน หรือไม่ (w1ms_redeem-voucher:open-admin)
Config.OpenUserUIbyTrigger   = true									-- เปิดใช้งานการใช้ TriggerEvent เปิด UI สำหรับ ผู้เล่น หรือไม่	(w1ms_redeem-voucher:open-user)

Config.Debug             = true

Config.Image			 = 'nui://esx_inventoryhud/html/img/items/' -- ที่อยู่ของรูปที่ใช้แสดง

Config.DiscordWebhook    = ''                                       -- Discord Webhook URL 

Config.DiscordBotName    = 'Voucher'								-- ชื่อ Bot

Config.DiscordBotTitle   = 'Redeem Voucher!'

Config.DiscordMsgSuccess = '```bash\nคุณ: %s \nใช้งานโค้ด: %s \nสถานะ: สำเร็จ\n```'

Config.DiscordMsgError1  = '```bash\nคุณ: %s \nใช้งานโค้ด: %s \nสถานะ: ไม่สำเร็จ \nเนื่องจาก: โค้ดนี้หมดอายุไปแล้ว\n```'
Config.DiscordMsgError2  = '```bash\nคุณ: %s \nใช้งานโค้ด: %s \nสถานะ: ไม่สำเร็จ \nเนื่องจาก: ได้ใช้งานไปก่อนหน้านี้แล้ว\n```'
Config.DiscordMsgError3  = '```bash\nคุณ: %s \nใช้งานโค้ด: %s \nสถานะ: ไม่สำเร็จ \nเนื่องจาก: โค้ดนี้ถูกใช้งานไปแล้ว\n```'
Config.DiscordMsgError4  = '```bash\nคุณ: %s \nใช้งานโค้ด: %s \nสถานะ: ไม่สำเร็จ \nเนื่องจาก: โค้ดนี้ไม่ถูกต้อง\n```'

Config.Text = {

	admin_title  = 'Redeem Voucher - Admin',
	user_title   = 'Redeem Voucher - User',

	tab1 		 = 'สร้าง Voucher',
	tab2 		 = 'จัดการ Voucher',

	additem 	 = '<i class="fas fa-plus"></i> เพิ่มไอเท็ม ',
	testcode 	 = '<i class="fas fa-check"></i> ทดสอบ ',
	savecode 	 = '<i class="fas fa-save"></i> บันทึก ',
	
	useone 		 = 'ใช้ครั้งเดียว - คนเดียว',
	usemore 	 = 'ใช้ครั้งเดียว - หลายคน',
	expire1 	 = 'ไม่หมดอายุ',
	expire2 	 = 'หมดอายุ',
	itemname 	 = 'ชื่อไอเท็ม',
	txtitem 	 = 'ไอเท็ม',
	txtmoney 	 = 'เงิน',
	txtblack 	 = 'เงินแดง',
	txtcar 		 = 'รถ',
	txtweapon 	 = 'อาวุธ',
	txtamount 	 = 'จำนวน',

	txtused 	 = '<i class="fas fa-times"></i> ใช้แล้ว',
	txtnotused 	 = '<i class="fas fa-check"></i> ยังไม่ใช้',

	txtused2     = 'ใช้แล้ว',
	txtnotused2  = 'ยังไม่ใช้',

	txtcode      = 'Code:',
	txtstatus    = 'สถานะ:',
	txttype      = 'ประเภท:',
	txtexpire    = 'หมดอายุ:',
	txtwhen      = 'เมื่อ:',
	txtcodeinfo  = 'คลิกที่โค้ดเพื่อดูรายละเอียด',

	txtcode      = 'ไม่หมดอายุ',

	atxtsave     = 'บันทึกโค้ดสำเร็จ',
	atxtpressinput = 'ต้องกรอกข้อมูลสักอย่างถึงจะบันทึกได้',
	atxtpresstest  = 'ต้องกดปุ่มทดสอบก่อน',

	txtcanusecode  = '<span style="color: #fff;"> โค้ดนี้สามารถใช้งานได้ </span>',
	txtSubmitbtn   = ' Submit Code ',
	txtcodeexpire  = '<span style="color: #fff;"> โค้ดนี้หมดอายุแล้ว </span>',
	txtcodeused    = '<span style="color: orange;"> โค้ดนี้ถูกใช้งานแล้ว </span>',
	txtcodeused2   = '<span style="color: orange;"> คุณใช้โค้ดนี้ไปแล้ว </span>',
	txtcodewrong   = '<span style="color: red;"> โค้ดไม่ถูกต้อง </span>',

	txtinputhere   = 'กรอกโค้ดที่นี่',

	txtbtncheck    = '<i class="fas fa-check"></i> ตรวจสอบโค้ด',

	txtcodeneed1   = '<span style="color: #fff;"><i class="fas fa-exclamation-triangle"></i> โค้ดต้องมี ',
	txtcodeneed2   = ' ตัวอักษรเท่านั้น</span>',
	txtcodeneed3   = '<span style="color: #fff;"><i class="fas fa-exclamation-triangle"></i> กรอกโค้ดด้วย</span>',
}