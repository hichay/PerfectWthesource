var activeGarage = "";
var activeParkings = [];
var activePayout = [];
var currentType = "";
var nuiOpened = false;

addEventListener("message", function (event) {
    let item = event.data;

    if (item.open == true) {
        nuiOpened = true;
        if (item.type == "open-garage") {
            $("#page-top").fadeIn(250);
            $(".garage-container").fadeIn(250);
            $(".impound-container").fadeOut(0);
			$(".payModal").hide();

            activeGarage = item.garage;
            currentType = item.key;
            document.getElementById("garage-name").innerHTML =
                item.garage + " ";

            var c = 0;
            if (item.vehicles != undefined && item.vehicles != null) {
                var table = $("#dataTable").DataTable();
                table.clear().draw();
    
                for (i = 0; i < item.vehicles.length; i++) {
                    var vehicle = item.vehicles[i];
                    table.row
                        .add([
                            vehicle[0],
                            vehicle[1],
                            vehicle[2],
                            getFormttedList(vehicle[3]),
                            vehicle[4],
                            vehicle[5],
                        ])
                        .draw(false);
                    table.rows(i).nodes().to$().addClass(vehicle[6]);
                    
                    if (vehicle[7] != undefined && vehicle[7] != null) {
                        activeParkings.push([vehicle[1], vehicle]);
                    }
                }
            }

            if (item.slots != undefined && item.slots != null) {
                document.getElementById("garage-slots").innerHTML =
                    item.slots + "%";
                document.getElementById("garage-slots-bar").style.width =
                    item.slots + "%";
            }

            if (item.key == 'garages') {
                if (item.vehicledata != undefined && item.vehicledata != null) {
                    if (item.vehicledata[0] == true) {
                        if (item.vehicledata[2]["onetime"] == true) {
                            document.getElementById("quick-park-name").innerHTML = "Đỗ xe " + item.vehicledata[1];
                            document.getElementById("quick-park-payment").innerHTML = item.vehicledata[2]["price"] + "$ Mỗi giờ";
                        } else {
                            document.getElementById("quick-park-name").innerHTML = "Đỗ xe " + item.vehicledata[1];
                            document.getElementById("quick-park-payment").innerHTML = item.vehicledata[2]["price"] + "$ Giá cố định";
                        }
                    } else {
                        document.getElementById("quick-park-name").innerHTML = "Đây không phải xe của bạn";
                        document.getElementById("quick-park-payment").innerHTML = "";
                    }
                } else {
                    document.getElementById("quick-park-name").innerHTML = "Không tìm thấy xe nào!";
                    document.getElementById("quick-park-payment").innerHTML = "";
                }
            } else {
                if (item.key == 'houses') {
                    if (item.vehicledata != undefined && item.vehicledata != null) {
                        if (item.vehicledata[0] == true) {
                            document.getElementById("quick-park-name").innerHTML = "Đỗ xe " + item.vehicledata[1];
                            document.getElementById("quick-park-payment").innerHTML = "";
                        } else {
                            document.getElementById("quick-park-name").innerHTML = "Đây không phải xe của bạn";
                            document.getElementById("quick-park-payment").innerHTML = "";
                        }
                    } else {
                        document.getElementById("quick-park-name").innerHTML = "Không tìm thấy xe nào";
                        document.getElementById("quick-park-payment").innerHTML = "";
                    }
                }
            }
        } else {
            currentType = "impounds";
            $("#page-top").fadeIn(250);
            $(".garage-container").fadeOut(0);
            $(".impound-container").fadeIn(250);
			$(".payModal").hide();

            activeGarage = item.impound;
            document.getElementById("garage-name").innerHTML =
                item.impound + " Menu";

            if (item.vehicles != undefined && item.vehicles != null) {
                var table = $("#ImpounddataTable").DataTable();
                table.clear().draw();

                for (i = 0; i < item.vehicles.length; i++) {
                    var vehicle = item.vehicles[i];
                    table.row
                        .add([vehicle[0], vehicle[1], vehicle[2], vehicle[3]])
                        .draw(false);
                    activeParkings.push([vehicle[1], vehicle]);
                }
            }
        }
    }
});

$(document).on("click", "#button", function (e) {
    var btnType = $(this).attr("btn-type");
    var btnPlate = $(this).attr("btn-plate");
    if (btnType == "park") {
        $.post(
            "https://pw-garages/park",
            JSON.stringify({
                typ: currentType,
                plate: btnPlate,
                garage: activeGarage,
            })
        );
        close();
    } else if (btnType == "pay") {
		$(".payModal").show();
        var vehicle = [];
        for (var i = 0; i < activeParkings.length; i++) {
            if (activeParkings[i][0] == btnPlate) {
                vehicle = activeParkings[i][1];
                break;
            }
        }
        if (vehicle != undefined && vehicle != null) {
            
            activePayout = vehicle;
            if (currentType == 'garages') {
                document.getElementById("pay-text").innerHTML =
                    "Chiếc xe (" + vehicle[0] + " / " + vehicle[1] +
                    ") cất tại " + vehicle[7][1] + " trong " + vehicle[7][3] +
                    " giờ.\nChi phí " + vehicle[7][4] +
                    "$ cho tiền thuê chỗ.";
            } else {
                if (currentType == 'houses') {
                    document.getElementById("pay-text").innerHTML = "Chiếc (" + vehicle[0] + " / " + vehicle[1] + ") sẽ được lấy ra.";
                } else {
                    document.getElementById("pay-text").innerHTML =
                    "Chiếc (" + vehicle[0] + " / " + vehicle[1] +
                    ") đã bị giam một khoảng thời gian.\nChi phí chi trả là: " + vehicle[4] + "$";
                }
            } 
        }
	} else if (btnType == "cancel-this") {
            $(".payModal").hide();
    } else if (btnType == "proccess-payment") {
        if (currentType == 'garages') {
            $.post("https://pw-garages/payout", JSON.stringify({
                    garage: activeGarage,
                    plate: activePayout[1],
                    price: activePayout[7][4],
                    type: currentType,
                })
            );
        } else {
            $.post("https://pw-garages/payout", JSON.stringify({
                    garage: activeGarage,
                    plate: activePayout[1],
                    price: activePayout[4],
                    type: currentType,
                })
            );
        }

        activePayout.length = 0;
        close();
    } else if (btnType == "garage" || btnType == "impound") {
        var btnName = $(this).attr("btn-name");
        $.post("https://pw-garages/waypoint", JSON.stringify({
            name: btnName,
            type: btnType,
        }));
    } else if (btnType == 'unknown') {
        $('#button[btn-plate=' + btnPlate + '] .text').html("Đang định vị..");
        setTimeout(() => { 
            $('#button[btn-plate=' + btnPlate + '] .text').html("Đã nhận vị trí");
            $.post("https://pw-garages/vehicleblip", JSON.stringify({
                plate: btnPlate,
        }));
        }, 2000);  
    } else if (btnType == 'rename') {   
        /* console.log('work') */    
        $.post("https://pw-garages/rename",JSON.stringify({btnPlate}));
        close();           
        
    }
});

function close() {
    $("#page-top").fadeOut(500);
    activeGarage = "";
    activeParkings.length = 0;
    $.post("https://pw-garages/close");
    currentType = "";
}

function getFormttedList(list) {
    var str = "";
    str += "Xăng: " + list["fuel"] + ", ";
    str +=
        "Hư hỏng: " +
        (((list["body_damage"] + list["engine_damage"]) / 10 / 2) | 0) +
        "%, ";
    str += "Độ bẩn: " + (list["dirty"] | 0) + "%";
    return str;
}

addEventListener("keydown", function (event) {
    if (nuiOpened && event.which == 27) close();
});

(function ($) {
    "use strict"; // Start of use strict

    // Toggle the side navigation
    $("#sidebarToggle, #sidebarToggleTop").on("click", function (e) {
        $("body").toggleClass("sidebar-toggled");
        $(".sidebar").toggleClass("toggled");
        if ($(".sidebar").hasClass("toggled")) {
            $(".sidebar .collapse").collapse("hide");
        }
    });

    // Close any open menu accordions when window is resized below 768px
    $(window).resize(function () {
        if ($(window).width() < 768) {
            $(".sidebar .collapse").collapse("hide");
        }

        // Toggle the side navigation when window is resized below 480px
        if ($(window).width() < 480 && !$(".sidebar").hasClass("toggled")) {
            $("body").addClass("sidebar-toggled");
            $(".sidebar").addClass("toggled");
            $(".sidebar .collapse").collapse("hide");
        }
    });

    // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
    $("body.fixed-nav .sidebar").on(
        "mousewheel DOMMouseScroll wheel",
        function (e) {
            if ($(window).width() > 768) {
                var e0 = e.originalEvent,
                    delta = e0.wheelDelta || -e0.detail;
                this.scrollTop += (delta < 0 ? 1 : -1) * 30;
                e.preventDefault();
            }
        }
    );

    // Scroll to top button appear
    $(document).on("scroll", function () {
        var scrollDistance = $(this).scrollTop();
        if (scrollDistance > 100) {
            $(".scroll-to-top").fadeIn();
        } else {
            $(".scroll-to-top").fadeOut();
        }
    });

    // Smooth scrolling using jQuery easing
    $(document).on("click", "a.scroll-to-top", function (e) {
        var $anchor = $(this);
        $("html, body")
            .stop()
            .animate(
                {
                    scrollTop: $($anchor.attr("href")).offset().top,
                },
                1000,
                "easeInOutExpo"
            );
        e.preventDefault();
    });
})(jQuery);