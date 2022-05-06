function menuToggle(state, send) {
    if(state) {
        // $(".container").show();
        $(".joblist-table").css("display", "inline");
    } else {
        // $(".container").hide();
        $(".joblist-table").css("display", "none");
    }
    if(send){
        $.post("http://pw-huongdan/toggle",JSON.stringify({state:state}));
    }
}

$(function(){
    menuToggle(false,false);
    $(document).on("click",".btn-block",function(){
        var data = $(this).attr("data");
        if(data!=null) {
            $.post("http://pw-huongdan/acceptjob",JSON.stringify({data}));
            menuToggle(false,true);
            /* --location.reload(); */
        }
    });
    document.onkeyup = function (data) {
        if (data.which == 27) {
            menuToggle(false,true);
            /* location.reload(); */
            
        }
    };
	window.addEventListener('message', function(event){
        if(event.data.type == "toggle"){
            menuToggle(event.data.state,false);
        }
	});
});
