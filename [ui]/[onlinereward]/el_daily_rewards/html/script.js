var timeout = new Date().getTime() + 86400000;
$(function() {
    // $("#main").hide();
    // $("#header").html(Config.header);
    $("button").html(Config.buttomn);
    $('#countdown').countdown(timeout, { elapse: true }).on('update.countdown', function(event) {
        if (event.elapsed) {
            // $(this).text(Config.countdown_done);
            $.post('https://el_daily_rewards/collect', JSON.stringify({ "t": new Date().getTime() }));
            // $("#submitbtn").attr("disabled", false);
        } else {
            // $(this).text(Config.remaining + (event.strftime('%D') != "00" ? event.strftime(' %D:%H:%M:%S') : event.strftime(' %H:%M:%S')));
            // var percent = 100-(parseInt(event.strftime(' %T'))*1000*100)/3600000;
            // $('#countdown').children().css("width",percent);
            // $('#countdown').children().text(percent);
            // $("#submitbtn").attr("disabled", true);
        }
    });
    $('#countdown').countdown(0);
    var hue = 0;
    setInterval(function() {
        $(".rainbow").css({ "borderColor": "hsl(" + hue + ",70%,70%)" })
        hue = hue++ <= 360 ? hue : 0;
    }, 50);

    window.addEventListener('message', function(event) {
        if (event.data.type == "toggleshow") {
            toggleshow(event.data.enable);
            if (event.data.enable && event.data.timeout != null) {
                timeout = event.data.timeout;
                $('#countdown').countdown(event.data.timeout, { elapse: true });
                // $('#countdown').children().css("width","25%");
                // $('#countdown').children().text(event.data.timeout);
            }
        }
        if (event.data.type == "settimeout") {
            $('#countdown').countdown(event.data.timeout);
            var percent = ((parseInt(event.data.counttime)*100)/21600);
            if(percent < 16){
                $('#item1').css("opacity","0.5");
                $('#item2').css("opacity","0.5");
                $('#item3').css("opacity","0.5");
                $('#item4').css("opacity","0.5");
                $('#item5').css("opacity","0.5");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 16){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","0.5");
                $('#item3').css("opacity","0.5");
                $('#item4').css("opacity","0.5");
                $('#item5').css("opacity","0.5");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 33){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","1");
                $('#item3').css("opacity","0.5");
                $('#item4').css("opacity","0.5");
                $('#item5').css("opacity","0.5");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 49){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","1");
                $('#item3').css("opacity","1");
                $('#item4').css("opacity","0.5");
                $('#item5').css("opacity","0.5");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 66){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","1");
                $('#item3').css("opacity","1");
                $('#item4').css("opacity","1");
                $('#item5').css("opacity","0.5");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 82){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","1");
                $('#item3').css("opacity","1");
                $('#item4').css("opacity","1");
                $('#item5').css("opacity","1");
                $('#item6').css("opacity","0.5");
            }
            if(percent >= 99){
                $('#item1').css("opacity","1");
                $('#item2').css("opacity","1");
                $('#item3').css("opacity","1");
                $('#item4').css("opacity","1");
                $('#item5').css("opacity","1");
                $('#item6').css("opacity","1");
            }
            if(percent > 100){percent = 100}
            $('#countdown').children().css("width",percent+"%");
                // $('#countdown').children().text(event.data.timeout);
        }
    });

    $("#freeform").submit(function(e) {
        e.preventDefault();
        $.post('http://el_daily_rewards/collect', JSON.stringify({ "t": new Date().getTime() }));
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://el_daily_rewards/hidemenu', JSON.stringify({}));
        }
    };
});

function toggleshow(show) {
    if (false) {
        $("#main").delay(100).animate({ height: 0 }, 700, "swing", function() { $("#main").hide(); });
    } else {
        $("#main").show();
        $("#main").delay(100).animate({ height: 210 }, 700);
    }
}

