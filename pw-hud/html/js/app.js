$(document).on('keydown', function () {
    switch (event.keyCode) {
        case 27: // ESC
            //Inventory.Close();
            break;
    }
});

var moneyTimeout = null;
var CurrentProx = 0;

(() => {
    QBHud = {};

    QBHud.Open = function (data) {
        $(".money-cash").css("display", "block");
        // $(".money-bank").css("display", "block");
        $("#cash").html(data.cash);
        // $("#bank").html(data.bank);
    };

    QBHud.Close = function () {

    };

    QBHud.Show = function (data) {
        if (data.type == "cash") {
            $(".money-cash").fadeIn(150);
            $("#cash").html(data.cash);
            setTimeout(function () {
                $(".money-cash").fadeOut(750);
            }, 3500)
        }
    };

    QBHud.ToggleSeatbelt = function (data) {
        if (data.seatbelt) {
            //$(".car-seatbelt-info img").attr('src', './seatbelt-on.png');
        } else {
            //$(".car-seatbelt-info img").attr('src', './seatbelt.png');
        }
    };

    QBHud.CarHud = function (data) {
        if (data.show) {
            $(".ui-car-container").fadeOut();
            // $(".hnitrous").fadeIn(3000);
        } else {
            $(".ui-car-container").fadeOut();
            // $('.hnitrous').fadeOut(3000);
        }
    };

    QBHud.UpdateHud = function (data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);
            return;
        }
        $(".ui-container").css("display", Show);

        // HP Bar
        Progress(data.health - 100, ".hp");
        if (data.health <= 195) {
            $('.hvida').fadeIn(3000);
        }
        if (data.health >= 196) {
            $('.hvida').fadeOut(3000);
        }
        if (data.health <= 145) {
            $('.vida').css("stroke", "white");
        } else {
            $('.vida').css("stroke", "#498949");
        }
        Progress(data.armor, ".armor");
        if (data.armor > 1) {
            $('.harmor').fadeIn(3000);
        }
        if (data.armor <= 0) {
            $('.harmor').fadeOut(3000);
        }
        if (data.armor <= 45) {
            $('.amr').css("stroke", "white");
        } else {
            $('.amr').css("stroke", "#248bbe");
        }
        Progress(data.hunger, ".hunger");
        if (data.hunger <= 95) {
            $('.hhunger').fadeIn(3000);
        }
        if (data.hunger >= 96) {
            $('.hhunger').fadeOut(3000);
        }
        if (data.hunger <= 45) {
            $('.fome').css("stroke", "white");
        } else {
            $('.fome').css("stroke", "white");
        }
        Progress(data.thirst, ".thirst");
        if (data.thirst <= 95) {
            $('.hthirst').fadeIn(3000);
        }
        if (data.thirst >= 96) {
            $('.hthirst').fadeOut(3000);
        }
        if (data.thirst <= 45) {
            $('.cede').css("stroke", "white");
        } else {
            $('.cede').css("stroke", "white");
        }
        Progress(data.stress, ".stress");
        if (data.stress >= 3) {
            $('.hstress').fadeIn(3000);
        }
        if (data.stress <= 2) {
            $('.hstress').fadeOut(3000);
        }
        // Progress(data.nivel, ".nitrous");
        // if (data.activo) {
        //     $(".nitrous").css({ "stroke": "#fcb80a" });
        // } else {
        //     $(".nitrous").css({ "stroke": "rgb(241, 71, 185)" });
        // }

        setProgressSpeed(data.speed, ".progress-speed");
        setProgressFuel(data.fuel, ".progress-fuel");
        //$('fuel').fadeIn(450);
        //Progress(data.fuel.toFixed(0), ".fuel");
        //$("#speed-amount").html(data.speed);

        if (data.seatbelt) {
            $(".car-seatbelt-info img").fadeOut(750);
        } else {
            $(".car-seatbelt-info img").fadeIn(750);
        }
        if (data.talking && data.radio) {
            $(".mic").css({ "stroke": "#FF0000" });
        } else if (data.talking) {
            $(".mic").css({ "stroke": "#ffaf02" });
        } else {
            $(".mic").css({ "stroke": "rgba(0,0,0,0)" });
        }

        if (data.engine < 600) {
            $(".car-engine-info img").attr('src', './engine-red.png');
            $(".car-engine-info").fadeIn(150);
        } else if (data.engine < 800) {
            $(".car-engine-info img").attr('src', './engine.png');
            $(".car-engine-info").fadeIn(150);
        } else {
            if ($(".car-engine-info").is(":visible")) {
                $(".car-engine-info").fadeOut(150);
            }
        }
    };


    prox = 0
    QBHud.UpdateProximity = function (data) {
        var bodymic = document.querySelector(".bodymic");
        var mic = document.querySelector('.mic');
        if (data.prox == 1) {
            prox = 70
            bodymic.style.strokeDashoffset = -4220.1;
            bodymic.style.strokeDasharray = '4178.32,4178.32';
            mic.style.strokeDasharray = '4178.32,4178.32';
            mic.style.strokeDashoffset = -4220.1;
        } else if (data.prox == 2) {
            prox = 150
            bodymic.style.strokeDashoffset = -9043.07;
            bodymic.style.strokeDasharray = '8953.54,8953.54';
            mic.style.strokeDasharray = '8953.54,8953.54';;
            mic.style.strokeDashoffset = -9043.07;
        } else if (data.prox == 3) {
            prox = 200
            bodymic.style.strokeDashoffset = 0.0;
            bodymic.style.strokeDasharray = '0,0';
            mic.style.strokeDasharray = '0,0';
            mic.style.strokeDashoffset = 0.0;
        }
        CurrentProx = data.prox;
    }

    QBHud.Update = function (data) {
        if (data.type == "cash") {
            $(".money-cash").css("display", "block");
            $("#cash").html(data.cash);
            if (data.minus) {
                $(".money-cash").append('<p class="moneyupdate minus">-<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="minus-changeamount">' + data.amount + '</span></span></p>')
                $(".minus").css("display", "block");
                setTimeout(function () {
                    $(".minus").fadeOut(750, function () {
                        $(".minus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            } else {
                $(".money-cash").append('<p class="moneyupdate plus">+<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="plus-changeamount">' + data.amount + '</span></span></p>')
                $(".plus").css("display", "block");
                setTimeout(function () {
                    $(".plus").fadeOut(750, function () {
                        $(".plus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            }
        }
    };

    function Progress(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;

        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;

        const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
    }

    function setProgressSpeed(value, element){
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find('span');
        var percent = value*100/450;
    
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
    
        const offset = circumference - ((-percent*73)/100) / 100 * circumference;
        circle.style.strokeDashoffset = -offset;
    
        html.text(value);
      }

    function setProgressFuel(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find("span");

        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;

        const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;

        html.text(Math.round(percent));
    }

    window.onload = function (e) {
        window.addEventListener('message', function (event) {
            switch (event.data.action) {
                case "open":
                    QBHud.Open(event.data);
                    break;
                case "close":
                    QBHud.Close();
                    break;
                case "update":
                    QBHud.Update(event.data);
                    break;
                case "show":
                    QBHud.Show(event.data);
                    break;
                case "hudtick":
                    QBHud.UpdateHud(event.data);
                    break;
                case "car":
                    QBHud.CarHud(event.data);
                    break;
                case "seatbelt":
                    QBHud.ToggleSeatbelt(event.data);
                    break;
                case "proximity":
                    QBHud.UpdateProximity(event.data);
                    break;
                // case "talking":
                //     QBHud.SetTalkingState(event.data);
                //     break;
            }
        })
    }

})();


