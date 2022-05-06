function CloseMenu() {
    
	$("#wrapper").html('');
	$("#shopmenu").hide();
    $.post('http://esx_ambulancejob/CloseMenu');
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
        CloseMenu()
    }
});



$(document).ready(function() {

    var page = 1;
    var mpage = 0;
    var cars = []
    var result

    function LoadDeadPlayers() {

        
    }


    $("#body").on('click', ':button', function() {
        if ($(this).data('value') == null)
            return;
         $("#shopmenu").hide();
        $("#wrapper").html(''); 

        if ($(this).data('value') == "setlocation")
            $.post('http://esx_ambulancejob/SetLocation', JSON.stringify({
                id: $(this).data('id')
            }));
			

        else if ($(this).data('value') == "test-drive")
            $.post('http://d3x_vehicleshop/TestDrive', JSON.stringify({
                model: $(this).data('model')
            }));
    });

    $('#search').click(function() {
        var min = $('#price_min').val()
        var max = $('#price_max').val()
        console.log(min, max)
        result = players.filter(a => a.distance >= min && a.distance <= max)

        LoadDeadPlayers()
    })

    $("#close").click(function() {
        CloseMenu()
    });

    $("#page-prv").click(function() {

        $("#page-" + page).hide();
        if (page > 1) {
            page--;
        }
        $("#page-" + page).show();
        $('#n-pag').html(page + '/' + mpage)

    });

    $('#brand').on('change', function() {
        var brand = this.value
        if (brand != -1)
            result = cars.filter(c => c.category == brand)
        else
            result = cars
        LoadDeadPlayers()
    })

    $("#page-nxt").click(function() {
        $("#page-" + page).hide();
        if (page < mpage) {
            page++;
        }
        $("#page-" + page).show();
        $('#n-pag').html(page + '/' + mpage)
    });

    window.addEventListener('message', function(event) {
        
		var data = null;
		data = event.data.playerslist
        players = data
        result = players

        let index = 0
        let count = 0
        var html = ``
        page = 1
        mpage = 1

        $("#shopmenu").show();
        $("#wrapper").html(' ');


        mpage = Math.ceil(result.length / 6)
        for (let n_page = 0; n_page < Math.ceil(result.length / 6); n_page++) {
            count = 0;
            html += `
                <div id="page-` + (n_page + 1) + `">
                <div class="row row-cols-1 row-cols-md-3">`
			
            if (players != null) {
                console.log(players[0].id)
                for (row in players) {
                    

                    if (players[row].status == 0) {

                        while (index < result.length && count < 6) {

                           
                            html += `<div class="col-4 mb-4">
                                <div class="card h-100">
                                    
                                    <div class="card-body">
                                        <h5 class="card-title">ID: <b>` + players[row].id + `</b></h5>										
                                        <p class="card-text">Tên: <b>` + players[row].name + `</b></p>
										<p class="card-text">Khoảng cách: <b>` + players[row].distance.toFixed(0) + ` </b></p>
                                        
                                    </div>
									
									<div class="card-footer bg-white border-0 ">
                                        <button type="button" id="action1" data-value="setlocation" data-id="`+ players[row].id + `" class="btn btn-danger w-auto btn-lg buy">Nhận</button>
                                        <button type="button" id="action2" data-value="test-drive" data-id="` + players[row].id + `" class="btn btn-success w-auto float-right btn-lg test-drive">Xoá</button>
                                    </div>
                                    
                                </div>
                            </div>`
                            index++;
                            count++;
                        }


                        html += `</div> </div>`

                        $("#wrapper").append(html)
                        html = ``
                        if (n_page + 1 != page) {
                            $("#page-" + (n_page + 1)).hide();
                        }
					
                    }
					/* else
					{[
						if (players[row].PlayerAccepted == players[row].NameAccepted) {

                        while (index < result.length && count < 6) {

                            var car = result[index];
                            html += `<div class="col-4 mb-4">
                                <div class="card h-100">
                                    
                                    <div class="card-body">
                                        <h5 class="card-title">hello: <b>` + players[row].status + `</b></h5>										
                                        <p class="card-text">id người nhận: <b>` + players[row].idaccepted + `</b></p>
										<p class="card-text">Người nhận tên: <b>` + players[row].PlayerAccepted + ` </b></p>
                                        
                                    </div>
									
									<div class="card-footer bg-white border-0 ">
                                        <button type="button" id="action1" data-value="setlocation" data-id="`+ players[row].id + `" class="btn btn-danger w-auto btn-lg buy">Test</button>
                                        <button type="button" id="action2" data-value="test-drive" data-id="` + car.model + `" class="btn btn-success w-auto float-right btn-lg test-drive">Test</button>
                                    </div>
                                    
                                </div>
                            </div>`
                            index++;
                            count++;
                        }


                        html += `</div> </div>`

                        $("#wrapper").append(html)
                        html = ``
                        if (n_page + 1 != page) {
                            $("#page-" + (n_page + 1)).hide();
                        }
					
                    } 
					}	*/
						

                }
                $('#n-pag').html(page + '/' + mpage)
           
            }
        }
    }); 
});

/* window.addEventListener('message', function(event){
		if(event.data.type == "getpinglist") {
            $(".listplayer").empty();
			if(event.data.playerslist!=null) {
                datacache = event.data.playerslist;
                for(row in datacache){
                    var container = '<tr id="' + datacache[row].id +'">' + 
                                    '<td class="sdt">'+ datacache[row].sdt +'</td>' +
                                    '<td class="name">'+ datacache[row].name +'</td>' +
                                    '<td class="dist">'+ datacache[row].distance.toFixed(0) +'m </td>';
                    if(datacache[row].status == 0){
                        container = container + '<td class="action">' +
                                                '<div class="btn-group" role="group" aria-label="Basic example">' +
                                                    '<button type="button" class="btn btn-success nhan" value="' + datacache[row].id +'" x="'+datacache[row].cords.x+'" y="'+datacache[row].cords.y+'">NHẬN</button>' +
                                                    '<button type="button" class="btn btn-warning huy" value="' + datacache[row].id +'">HUỶ</button>' +
                                                    '<button type="button" class="btn btn-danger xoa" value="' + datacache[row].id +'" gname="'+ datacache[row].name +'">XOÁ</button>' +
                                                '</div>' +
                                            '</td>' +
                                        '</tr>';
                    } else{
                        if(datacache[row].receiver == event.data.myid){
                            container = container + '<td class="action">' +
                                                    '<div class="btn-group" role="group" aria-label="Basic example">' +
                                                        '<button type="button" class="btn btn-success nhan disabled" value="0">NHẬN</button>' +
                                                        '<button type="button" class="btn btn-warning huy" value="' + datacache[row].id +'">HUỶ</button>' +
                                                        '<button type="button" class="btn btn-danger xoa" value="' + datacache[row].id +'" gname="'+ datacache[row].name +'">XOÁ</button>' +
                                                    '</div>' +
                                                '</td>' +
                                            '</tr>';
                        } else{
                            container = container + '<td class="action">' + 
                                                    'Đã nhận bởi <span class="green">' + datacache[row].receiver_name + "</span>&nbsp;" +
                                                    '<button type="button" class="btn btn-danger xoa" value="' + datacache[row].id +'" gname="'+ datacache[row].name +'">XOÁ</button>' +
                                                '</td>' +
                                            '</tr>';
                        }
                    }
                     $(".listplayer").prepend(container); 
					
                }
			}
		}
        if(event.data.type == "toggle"){
            menuToggle(event.data.state,false);
        }
	}); */




 /* function menuToggle(state, send) {
    if(state) {
        $("#shopmenu").show();
    } else {
        $("#shopmenu").hide();
        $(".info").hide();
    }
    if(send){
        $.post("http://esx_ambulancejob/toggle",JSON.stringify({state:state}));
    }
}





$(function(){
    menuToggle(false,false);
    var datacache = null;

    document.onkeyup = function (data) {
        if (data.which == 27) {
            menuToggle(false,true);
        }
    };

    $(document).on("click",".nhan",function(){
        if($(this).val() != 0){
            $.post("http://esx_ambulancejob/nhan",JSON.stringify({id:$(this).val(), x: $(this).attr('x'), y: $(this).attr('y')}));
        }
    });

    $(document).on("click",".huy",function(){
        $.post("http://esx_ambulancejob/huy",JSON.stringify({id:$(this).val()}));
    });

    $(document).on("click",".xoa",function(){
        var data = $(this).val();
        var name = $(this).attr('gname');
        $("body").overhang({
          type: "confirm",
          primary: "#40D47E",
          accent: "#27AE60",
          yesColor: "#3498DB",
          message: "Bạn có muốn xoá " + name + "?",
          yesMessage: "Đồng ý!",
          noMessage: "Huỷ bỏ",
          overlay: true,
          callback: function (value) {
            var response = value ? "Yes" : "No";
            if(response == "Yes"){
                $.post("http://esx_ambulancejob/xoa",JSON.stringify({id:data}));
            }
          }
        });
        
    });

	window.addEventListener('message', function(event){
		
		if(event.data.type == "getpinglist") {
            
			if(event.data.playerslist!=null) {
				
                datacache = event.data.playerslist;
				
                for(row in datacache){
                     var container = `<div class="col-4 mb-4">
                                <div class="card h-100">
                                    
                                    <div class="card-body">
                                        <h5 class="card-title">ID: <b>` + datacache[row].id + `</b></h5>										
                                        <p class="card-text">Name: <b>` + datacache[row].name + `</b></p>
										<p class="card-text">Distance: <b>` + datacache[row].distance + ` </b></p>
                                        
                                    </div>
									
									<div class="card-footer bg-white border-0 ">
                                        <button type="button" id="action1" data-value="setlocation" data-id="`+ datacache[row].id + `" class="btn btn-danger w-auto btn-lg buy">TEST</button>
                                        <button type="button" id="action2" data-value="test-drive" data-id="` + datacache[row].distance + `" class="btn btn-success w-auto float-right btn-lg test-drive">TEST</button>
                                    </div>
                                    
                                </div>
                            </div>`
					
						
							
                     
					$("#wrapper").append(container);
                     	
					
                }
			}
		}
        if(event.data.type == "toggle"){
            menuToggle(event.data.state,false);
        }
	});
});  */
