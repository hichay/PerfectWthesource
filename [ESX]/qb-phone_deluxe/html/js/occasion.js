// CAR DETAILS
$(document).on('click', '.occasion-vehicle', function(e){
    e.preventDefault();

    $(".occasion-homescreen").animate({
        left: 30+"vh"
    }, 200);
    $(".occasion-detailscreen").animate({
        left: 0+"vh"
    }, 200);

    var Id = $(this).attr('id');
    var CarData = $("#"+Id).data('CarData');
    SetupCarDet(CarData);  
});

$(document).on('click', '.occasion-cardetails-footer', function(e){
    e.preventDefault();

    $(".occasion-homescreen").animate({
        left: 00+"vh"
    }, 200);
    $(".occasion-detailscreen").animate({
        left: -30+"vh"
    }, 200);
});

MI.Phone.Functions.RefreshAutoscout = function(Cars) {
    var CarsObject = $(".occasion-vehicles");
    $(CarsObject).html("");

    if (Cars !== null) {
        $.each(Cars, function(i, car){
            CarsElement = '<div class="occasion-vehicle" id="car-'+car.plate+'"><div class="occasion-vehicle-name">'+car.vehicle+'</div><div class="occasion-vehicle-price">$'+car.salePrice+'</div><div class="occasion-vehicle-plate">Biển số: '+car.plate+'</div></div>'

            $(CarsObject).append(CarsElement);
            $("#car-"+car.plate).data('CarData', car);
        });
    }
}

SetupCarDet = function(data) {
    $(".occasion-bsn").find(".vehicle-answer").html(data.citizenid)
	$(".occasion-name").find(".vehicle-answer").html(data.name)
    $(".occasion-model").find(".vehicle-answer").html(data.vehicle)
    $(".occasion-plate").find(".vehicle-answer").html(data.plate)
    $(".occasion-cardetails-footer2").data("plate", data.plate);
    $(".occasion-cardetails-footer2").data("price", data.salePrice);
    $(".occasion-cardetails-footer2").data("citizenid", data.citizenid);
}

$(document).on('click', '#buy-veh', function(e){
    e.preventDefault();

    forSaleVehicle = $(".occasion-cardetails-footer2").data("plate")
    forSaleCitizenid = $(".occasion-cardetails-footer2").data("citizenid")
    forSalePrice = $(".occasion-cardetails-footer2").data("price")
    if (forSaleVehicle !== "") {
        $(".occasion-homescreen").animate({
            left: 00+"vh"
        }, 200);
        $(".occasion-detailscreen").animate({
            left: -30+"vh"
        }, 200);

        $.post('http://qb-phone_deluxe/BuyVehicle', JSON.stringify({
            plate: forSaleVehicle,
            citizenid: forSaleCitizenid,
            price: forSalePrice,
        }));
        $.post('http://qb-phone_deluxe/LoadAutoscout', JSON.stringify({}), function(Cars){
            MI.Phone.Functions.RefreshAutoscout(Cars);
        });
    } else {
        MI.Phone.Notifications.Add("fas fa-times-circle", "Lỗi...", "Đã xảy ra sự cố, vui lòng thử lại sau...", "#e74c3c", 2000);
    }
});
