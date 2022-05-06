$(function(){
    window.addEventListener("message", function(event){   
        if(event.data.type == "show_wp_equipment") {
            $('.character-equipment').show();
        } else if (event.data.type == "set_items") {
            $('#wp_component_list').empty();
            $('.main-wp-list').empty();
            for(var i = 0; i < event.data.itemList.length; i++) {
                if(event.data.itemList[i].type == "item_weapon") {
                    if (event.data.itemList[i].name != "WEAPON_PETROLCAN") 
                    {
                        // Add item to list
                        var _item = `<li class="weapon-item" id="wp_item_${i}">
                            <div class="weapon-info">
                                <p>${event.data.itemList[i].label}</p>
                                <div class="image" style="background:url(\'nui://moon_advancedweapons/html/img/${event.data.itemList[i].name}.png'\) center no-repeat;background-size:contain;"></div>
                            </div>
                            <div class="component-list">
                                <ul>
                                    <li data-wp-name="${event.data.itemList[i].name}"></li>
                                    <li data-wp-name="${event.data.itemList[i].name}"></li>
                                    <li data-wp-name="${event.data.itemList[i].name}"></li>
                                    <li data-wp-name="${event.data.itemList[i].name}"></li>
									<li data-wp-name="${event.data.itemList[i].name}"></li>
                                </ul>
                            </div>
                        </li>`;
                        $('.main-wp-list').append(_item);
                        $(`.main-wp-list #wp_item_${i}`).data("item", event.data.itemList[i]);
                        // Get component cnt
                         for( var j = 0; j < event.data.itemList[i].comCnt; j++) {
                             var _com = `<li></li>`;
                             $(`.main-wp-list #wp_item_${i} .component-list ul`).append(_com);
                         }
                        for(var j = 0; j < event.data.itemList[i].componentList.length; j++) {
                            var _com = `<div class="item-icon" id="wp_${i}_component_${j}" data-wp-name="${event.data.itemList[i].name}" data-com-name="${event.data.itemList[i].componentList[j]}">
                                <div class="image" style="background:url(\'nui://moon_advancedweapons/html/img/${event.data.itemList[i].componentList[j]}.png'\) center no-repeat;background-size:contain;"></div>
                            </div>`;
                            $(`.main-wp-list #wp_item_${i} .component-list ul li`).eq(j).append(_com);
                            $(`.main-wp-list #wp_item_${i} .component-list ul #wp_${i}_component_${j}`).data("key", event.data.itemList[i].componentList[j]);
                        }
                    }
                } else if (event.data.itemList[i].type == "item_standard") {
                    var _itemName = event.data.itemList[i].name;
                    if(_itemName.includes("attach_") || _itemName.includes("ammo_")) {
                        var _useable = "";
                        if(event.data.itemList[i].usable) {
                            _useable = `<div class="fl-r-btn" data-use-id="${event.data.itemList[i].name}">Dùng</div>`;
                        }
                        var _tooltip_text = "";
                        if(tooltips[event.data.itemList[i].name] != undefined) {
                             _tooltip_text = tooltips[event.data.itemList[i].name].desc;
                        }
                        var _item = `<li>
                            <div class="item" id="item_${i}">
                                <div class="item-icon" data-toggle="tooltip" data-placement="right" title="${_tooltip_text}">
                                    <div class="image" data-name="${event.data.itemList[i].name}" style="background:url(\'nui://moon_advancedweapons/html/img/${event.data.itemList[i].name}.png'\) center no-repeat;background-size:contain;"></div>
                                </div>
                                <div class="amount">${event.data.itemList[i].count}</div>
                                <div class="item-info">
                                    <p>${event.data.itemList[i].label}</p>
                                    
                                </div>
                            </div>
                        </li>`;
                        $('#wp_component_list').append(_item);
                        $(`#wp_component_list #item_${i}`).data("item", event.data.itemList[i]);
                    }
                }
            }
            // Completed map item
            initItem();
        }
    });
    document.onkeydown = function (data) {
		if ((data.which == 120 || data.which == 27)) { // || data.which == 8
			$('.character-equipment').hide();
            $.post('http://moon_advancedweapons/closeEquipment',"");
            location.reload();
		}
	};
});

$(document).ready(function(){
    elmnt = document.getElementById("character_weapon_equipment");
    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
    if (document.getElementById(elmnt.id + "header")) {
        // if present, the header is where you move the DIV from:
        document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
    } else {
        // otherwise, move the DIV from anywhere inside the DIV: 
        elmnt.onmousedown = dragMouseDown;
    }

    function dragMouseDown(e) {
        e = e || window.event;
        e.preventDefault();
        // get the mouse cursor position at startup:
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        // call a function whenever the cursor moves:
        document.onmousemove = elementDrag;
    }

    function elementDrag(e) {
        e = e || window.event;
        e.preventDefault();
        // calculate the new cursor position:
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        // set the element's new position:
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    }

    function closeDragElement() {
        // stop moving when mouse button is released:
        document.onmouseup = null;
        document.onmousemove = null;
    }

    initItem();
});

function initItem() {
    $(".item").draggable({
        helper: function(data) {
            return $("<div></div>").append($(this).find('.item-icon').clone());
        },
        cursorAt: { left: 24, top:24 },
        appendTo: 'body',
        zIndex: 99999,
        revert: 'invalid'
    });
    $(".component-list li").droppable({
        drop: function( event, ui ) {
            var _name = $(event.toElement).attr('data-name');
            var _wp_name = $(this).attr('data-wp-name');
            $.post('http://moon_advancedweapons/useAttachment', JSON.stringify({
                com_name: _name,			
                weapon_name: _wp_name
            })).done(function(data){
                if(data == "ok") {
                    //
                    $(event.target).empty();
                    $(event.target).append($(ui.helper[0]).find(".item-icon").clone());
                }
            });
        }
    });
    $('[data-toggle="tooltip"]').tooltip();
}

$(document).on("click", ".component-list li .item-icon", function(event) {
    // Remove item
    var _wp_name = $(this).attr('data-wp-name');
    var _attach_name = $(this).attr('data-com-name');
    $.post('http://moon_advancedweapons/removeAttachment', JSON.stringify({
        com_name: _attach_name,
        weapon_name: _wp_name
    })).done(function(data){
        if(data == "ok") {
            $(this).parent().empty();
			
        }
    });
});

$(document).on("click", ".close-btn", function(){
    $('.character-equipment').hide();
    $.post('http://moon_advancedweapons/closeEquipment',"");
    location.reload();
});
