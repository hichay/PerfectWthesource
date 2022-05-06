Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "firstname, lastname, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationFingerprint = "firstname, lastname, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

ShowBloodSplatsOnGround = true, -- Show blood on the ground when player is shot
PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = 0, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'E', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(484.44372, -987.8894, 30.689802), -- The place where the evidence will be analyzed and report generated
TimeToAnalyze = 10000, -- Time in miliseconds to analyze the given evidence
TimeToFindFingerprints = 3000, -- Time in miliseconds to find fingerprints in a car

--UPDATE V2
RainRemovesEvidence = true, -- Removes evidence when it starts raining!
TimeBeforeCrimsCanDestory = 300, -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)
EvidenceStorageLocation = vector3(483.89935, -993.2473, 30.689802), -- The place where all evidence are being archived! You can view old evidence or delete it
--

Text = {

	--UPDATE V2
	['not_in_vehicle'] = 'Phải ngồi ở trên xe để thu thập!',
	['remove_evidence'] = 'Phi tang [~r~E~w~]',
	['cooldown_before_pickup'] = 'Bằng chứng còn quá mới để có thể phi tang',
	['evidence_removed'] = 'Phi tang bằng chứng thành công!',
	['open_evidence_archive'] = '[~b~E~w~] Mở kho lưu trữ',
	['evidence_archive'] = 'Kho lưu trữ bằng chứng',
	['view'] = 'Xem',
	['delete'] = 'Xoá',
	['report_list'] = 'Báo cáo #',
	['evidence_deleted_from_archive'] = 'Bằng chứng đã được xoá khỏi kho!',
	--

	['evidence_colleted'] = 'Bằng chứng #{number} đã được thu thập!',
	['no_more_space'] = 'Không có khả năng thu thập thêm bằng chứng 3/3!',
	['analyze_evidence'] = '[~b~E~w~] Phân tích bằng chứng',
	['evidence_being_analyzed'] = 'Bằng chứng đang được pháp y phân tích',
	['evidence_being_analyzed_hologram'] = '~b~Bằng chứng đang được phân tích',
	['read_evidence_report'] = '[~b~E~w~] Đọc báo cáo',
	['analyzing_car'] = 'Đang tìm kiếm bằng chứng',
	['pick_up_evidence_text'] = 'Nhặt bằng chứng [~r~E~w~]',
	['no_fingerprints_found'] = 'Không tìm thấy dấu vân tay nào!',
	['no_evidence_to_analyze'] = "Không có bằng chứng để phân tích!",
	['shell_hologram'] = '~b~ {guncategory} ~w~ Vỏ đạn',
	['blood_hologram'] = '~r~Vệt máu',

	['blood_after_0_minutes'] = 'Tình trạng: ~r~Mới',
	['blood_after_5_minutes'] = 'Tình trạng: ~y~Khá cũ',
	['blood_after_10_minutes'] = 'Tình trạng: ~b~Đã khô',

	['shell_after_0_minutes'] = 'Tình trạng: ~r~Nóng',
	['shell_after_5_minutes'] = 'Tình trạng: ~y~Ấm',
	['shell_after_10_minutes'] = 'Tình trạng: ~b~Lạnh',


	['submachine_category'] = 'Submachine',
	['pistol_category'] = 'Pistol',
	['shotgun_category'] = 'Shotgun',
	['assault_category'] = 'Assault Rifle',
	['lightmachine_category'] = 'Light Machine Gun',
	['sniper_category'] = 'Sniper',
	['heavy_category'] = 'Heavy Weapon'


}
	

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		TriggerEvent("ESX:Notify",msg,"info")
		--EXAMPLE USED IN VIDEO
		--exports['mythic_notify']:SendAlert('inform', msg)

end
