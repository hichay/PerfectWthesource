var activeGarage = "";
var activeDeads = [];
var currentType = "";
var nuiOpened = false;

addEventListener("message", function (event) {
    let item = event.data;

    console.log(item.playerlist)
    if (item.open == true) {
        nuiOpened = true;
        
            currentType = "impounds";
            $("#page-top").fadeIn(250);
            $(".garage-container").fadeOut(0); 
            $(".impound-container").fadeIn(250);
			$(".payModal").hide(); 

            activeGarage = item.impound;
            /* document.getElementById("garage-name").innerHTML =
                item.impound + " Menu"; */

            if (item.playerlist != undefined && item.playerlist != null) {
                var table = $("#ListDeadPlayerTable").DataTable();
                table.clear().draw();

                 for (i = 0; i < item.playerlist.length; i++) {
                    var playerlist = item.playerlist[i];
                    table.row
                        .add([playerlist.name, playerlist.reciver, playerlist.status, playerlist.button])
                        .draw(false);
                        activeDeads.push([playerlist.playerid, playerlist]); 
                }
            }
    }
});

$(document).on("click", "#button", function (e) {
    var btnType = $(this).attr("btn-type");
    var btnId = $(this).attr('btn-id');
    console.log(btnId)
    console.log(btnType)
    if (btnType == "accept") {
        $.post(
            "https://esx_ambulancejob/accept",
            JSON.stringify({
                btnId
            })
        );
        close();
	} else if (btnType == "canceltextt") {
            $(".payModal").show();
            var playerlist = [];
            for (var i = 0; i < activeDeads.length; i++) {
                if (activeDeads[i][0] == btnId) {
                    playerlist = activeDeads[i][1];
                    id = playerlist.playerid
                    break;
                }
            }
            document.getElementById("pay-text").innerHTML =
                    "Bạn có chắc chắn muốn thông tin của (" + playerlist.playerid + " / " + playerlist.name +
                    ") hay không";

    } else if (btnType == "cancel-this") {
        $(".payModal").hide();
    } else if (btnType == "proccess-payment") {
        $.post(
            "https://esx_ambulancejob/cancel",
            JSON.stringify({
                idPlayer: id
            })
        );
        close();
    } else if (btnType == "garage" || btnType == "impound") {
        var btnName = $(this).attr("btn-name");
        $.post("https://bb-garages/waypoint", JSON.stringify({
            name: btnName,
            type: btnType,
        }));
    }
});

function close() {
    $("#page-top").fadeOut(500);
    activeGarage = "";
    activeDeads.length = 0;
    $.post("https://esx_ambulancejob/close");
    currentType = "";
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