window.addEventListener('message', function (event) {
    var data = event.data;
	
	if (data !== undefined && data.display == true) {
		
		if(event.data.newi <= 10 && event.data.firstname !== '')
		{
			$(".rankbar_list").append(`
			<div class="rankbar">
				<div id="rankbar_name">
					<img id="rankbar_XP_IMG" src="img/`+event.data.newi+`.png">
					`+event.data.lastname+` `+event.data.firstname+`
					<span id="rankbar_XP">LV.[<span style="color:#ec8e22;">`+event.data.lv_rank+`</span>]
					</span>
				</div>
			</div>
			`);
		}
		else if (event.data.firstname !== '')
		{
			$(".rankbar_list").append(`
			<div class="rankbar">
				<div id="rankbar_name">
					`+event.data.lastname+` `+event.data.firstname+`
					<span id="rankbar_XP">LEVEL[<span style="color:#ec8e22;">`+event.data.lv_rank+`</span>]
					</span>
				</div>
			</div>
			`);
		}
		
		$(".container").show();	
		$(".container").mousedown(function (e) {
		if (e.which == 3 || e.key === "Escape") {
				$(".rankbar_list").empty();
				$(".container").fadeOut(100);
				$.post('http://od_rankbar/NUIFocusOff');
			}
		});
	}
	
	if (data.display == false) {
		$(".rankbar_list").empty();
		$(".container").fadeOut(100);
    }
});
	
document.addEventListener('DOMContentLoaded', function () {
    $(".container").hide();
});

