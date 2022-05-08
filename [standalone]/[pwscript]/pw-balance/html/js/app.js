$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            //Inventory.Close();
            break;
    }
});

window.addEventListener("message", function (event) {
	data = event.data;
	if (data.type == "cash") {
		$(".wrapper-cashcommand #content #amount").html(
			data.casheData.amount.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
		);
		$(".wrapper-cashcommand").show();
		$('.cashevent-addons #log').hide();
		setTimeout(() => {
			$(".wrapper-cashcommand").fadeOut(750);
		}, 7500);
	} else if (data.type == "cashe") {
		$(".wrapper-cashcommand #content #amount").html(
			data.casheData.amount.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
		);
		$(".cashevent-addons #log #amount").html(
			data.casheData.addedamount.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
		);
		$(".cashevent-addons #log").show();
		$(".wrapper-cashcommand").show();
		setTimeout(() => {
			$(".wrapper-cashcommand").fadeOut(750);
			$(".cashevent-addons #log").hide();
		}, 7500);
	}
		

});	


   