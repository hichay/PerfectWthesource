console.log("Ready")
    var isInTable = false;
    var DecksData = [];
    window.addEventListener("message", function(e){
        DecksData = e.data.data;
        console.log(JSON.stringify(DecksData))
        $(".main").empty();
        $.each(DecksData, function(k, v){
            var el = $(`
            <div class="col-6 main-table">
                <div class="main-table-item"></div>
                <div class="main-table-item">
                    <div class="player">${checkSlot(0, v.slot)}</div>
                </div>
                <div class="main-table-item"></div>  
                <div class="main-table-item">
                    <div class="player">${checkSlot(1, v.slot)}</div>
                </div>
                <div class="main-table-item">
                    ${canJoin(k, v.slot)}
                </div>
                <div class="main-table-item">
                    <div class="player">${checkSlot(2, v.slot)}</div>
                </div>  
                <div class="main-table-item"></div>
                <div class="main-table-item">
                    <div class="player">${checkSlot(3, v.slot)}</div>
                </div>
                <div class="main-table-item"></div> 
            </div>
            `)
            console.log(JSON.stringify(v))
            $(".main").append(el);
        })
        $('.joinTable').on("click", function(){
            console.log($(this).data("table"))
        })
    })

    function checkSlot(index, data){
        if (data[index].playerId != undefined){
            return `Người chơi: ${data[index].playerId}`
        }else{
            return "Trống"
        }
    }
    function canJoin(tb, data){
        $.each(data, function(k, v){
            if (v.playerId == undefined){
                return `<button type="button" data-table=${tb} class="btn btn-success joinTable" disabled>Tham gia</button>`
            }
        })
        return `<button type="button" data-table=${tb} class="btn btn-success joinTable">Tham gia</button>`
    }

    function joinTable(){
        console.log(this)
    }