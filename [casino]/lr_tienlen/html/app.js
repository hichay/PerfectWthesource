var cards = [[8,3],[5,2],[9,1],[9,3],[13,2],[8,4],[10,1],[3,4],[3,1],[6,3],[4,4],[12,3],[5,4],[9,4],[7,1],[12,1],[13,3],[12,2],[7,3],[4,1],[4,3],[3,2],[8,2],[10,2],[7,2],[13,1]]

var Table = (function(){
    var opt = {
        cardSize: {
          width: 69,
          height: 94,
          padding: 18
        },
        animationSpeed: 500,
        table: 'body',
        cardback: 'red',
        acesHigh: true,
        cardsUrl: 'img/cards.png',
    };
    var zIndexCounter = 1;
    var all = [];
    function mouseEvent(ev) {
        var card = $(this).data('card');
        if (card.container) {
            var handler = card.container._click;
            if (handler) {
                handler.func.call(handler.context || window, card, ev);
            }
        }
    }
    function init(options){
        if(options){
            for (var i in options) {
				if (opt.hasOwnProperty(i)) {
					opt[i] = options[i];
				}
			}
        }
    }  
    opt.table = $(opt.table)[0];
    if ($(opt.table).css('position') == 'static') {
        $(opt.table).css('position', 'relative');
    }
    function syncCards(cards){
        this.all = [];
        for (var i in cards){
            this.all.push(new Card(cards[i][2], cards[i][0], cards[i][1], opt.table))
        }
        $('.card').click(mouseEvent);
    }
    

    class Card{
        constructor(index, rank, suit, table){
            this.shortName = rank+suit;
            this.rank = rank;
            this.suit = suit;
            this.index = index;
            this.name = (rank+suit);
            this.faceUp = false;
            this.isChoosed = false;
            this.el = $('<div/>').css({
				width: opt.cardSize.width,
				height: opt.cardSize.height,
				"background-image": 'url(' + opt.cardsUrl + ')',
				position: 'absolute',
				cursor: 'pointer'
			}).addClass('card').data('card', this).appendTo($(table));
        };
        toString(){
            return this.name;
        };
        moveTo(x, y, speed, callback){
            var props = {
                top: y - (opt.cardSize.height / 2),
				left: x - (opt.cardSize.width / 2)
            };
            $(this.el).animate(props, speed || opt.animationSpeed, callback);
        };
        rotate(angle){
            $(this.el)
				.css('-webkit-transform', 'rotate(' + angle + 'deg)')
				.css('-moz-transform', 'rotate(' + angle + 'deg)')
				.css('-ms-transform', 'rotate(' + angle + 'deg)')
				.css('transform', 'rotate(' + angle + 'deg)')
				.css('-o-transform', 'rotate(' + angle + 'deg)');
        };
        showCard(){
            var offsets = {
                "3": 0,
                "2": 1,
                "1": 2,
                "4": 3
            };
            var self = this;
            if (!this.faceUp){
                $.post("https://lr_tienlen/getCardData", JSON.stringify({index: this.index}), function(data){
                    var xpos, ypos;
                    var rank = data.rank;
                    xpos = -rank * opt.cardSize.width;
                    ypos = -offsets[data.suit]*opt.cardSize.height;
                    self.rotate(0);
                    self.faceUp = true
                    $(self.el).css('background-position', xpos + 'px ' + ypos + 'px');
                })
            }
            /* var xpos, ypos;
            var rank = this.rank;
            xpos = -rank * opt.cardSize.width;
            ypos = -offsets[this.suit]*opt.cardSize.height;
            self.rotate(0);
            $(self.el).css('background-position', xpos + 'px ' + ypos + 'px'); */
        };
        hideCard(){
            var y = opt.cardback == 'red' ? 0 * opt.cardSize.height : -1 * opt.cardSize.height;
            $(this.el).css('background-position', '0px ' + y + 'px');
            this.rotate(0)
        };
        moveToFront(){
            $(this.el).css('z-index', zIndexCounter++);
        };
        destroy(){
            $(this.el).remove()
        }
    }

    class Container{
        constructor(){
            this.cards = []
        }
        addCard(card){
            this.addCards([card])
        };
        addCards(cards){
            for (var i = 0; i < cards.length; i++) {
				var card = cards[i];
				if (card.container) {
					card.container.removeCard(card);
				}
				this.cards.push(card);
				card.container = this;
			}
        };
        removeCard(card){
            for (var i = 0; i < this.cards.length; i++) {
				if (this.cards[i] == card) {
					this.cards.splice(i, 1);
					return true;
				}
			}
			return false;
        };
        init(options){
            options = options || {};
            this.x = options.x || $(opt.table).width() /2;
            this.y = options.y || $(opt.table).height() /2;
            this.faceUp = options.faceUp;
        };
        click(func, context){
            this._click = {
                func: func,
                context : context
            }
        };
        mousedown(func, context){
            this._mousedown = {
                func: func,
                context : context
            }
        };
        mouseup(func, context){
            this._mouseup = {
                func: func,
                context : context
            }
        };
        render(options){
            options = options || {};
            var speed = options.speed || opt.animationSpeed;
            this.calcPosition(options);
            for (var i = 0; i<this.cards.length; i++){
                var card = this.cards[i];
                zIndexCounter++;
                card.moveToFront();
                var top = parseInt($(card.el).css('top'));
                var left = parseInt($(card.el).css('left'));
                if (top != card.targetTop || left != card.targetLeft){
                    var props = {
                        top: card.targetTop,
                        left: card.targetLeft,
                        queue: false
                    }
                    if (options.immediate){
                        $(card.el).css(props);
                    }else{
                        $(card.el).animate(props, speed)
                    }
                }
            }
            var me = this;
            var flip = function(){
                for (var i = 0; i < me.cards.length; i++) {
                    if (me.faceUp) {
                        me.cards[i].showCard();
                    } else {
                        me.cards[i].hideCard();
                    }
                }
            }
            if (options.immediate) {
				flip();
			} else {
				setTimeout(flip, speed / 2);
			}

			if (options.callback) {
				setTimeout(options.callback, speed);
			}
        };
        topCard() {
			return this.cards[this.cards.length - 1];
		}

		toString() {
			return 'Container';
		}
        destroy(){
            for (var i = 0; i<this.cards.length; i++){
                var card = this.cards[i];
                card.destroy()
            }
            this.cards = []
        }
    }

    class Deck extends Container{
        constructor(options){
            super();
            this.init(options)
        }
        calcPosition(options){
            options = options || {};
            var left = Math.round(this.x - opt.cardSize.width / 2, 0);
			var top = Math.round(this.y - opt.cardSize.height / 2, 0);
			var condenseCount = 6;
			for (var i = 0; i < this.cards.length; i++) {
				if (i > 0 && i % condenseCount == 0) {
					top -= 1;
					left -= 1;
				}
				this.cards[i].targetTop = top;
				this.cards[i].targetLeft = left;
			}
        }
        toString(){
            return "Deck"
        }
        deal(count, hands, speed, callback){
            var me = this;
            var i = 0;
            var totalCount = count * hands.length;
            function dealOne(){
                if(me.length == 0 || i == totalCount){
                    if(callback){
                        callback()
                    }
                    return;
                }
                hands[i % hands.length].addCard(me.topCard());
				hands[i % hands.length].render({
					callback: dealOne,
					speed: speed
				});
				i++;
            }
            dealOne();
        }
    }

    class Hand extends Container{
        constructor(options){
            super();
            this.init(options)
        }
        calcPosition(options){
            options = options || {};
            var width = opt.cardSize.width + (this.cards.length - 1) * opt.cardSize.padding;
			var left = Math.round(this.x - width / 2);
			var top = Math.round(this.y - opt.cardSize.height / 2, 0);
			for (var i = 0; i < this.cards.length; i++) {
				this.cards[i].targetTop = top;
				this.cards[i].targetLeft = left + i * opt.cardSize.padding;
			}
        }
        sort(slot){
            var me = this;
            $.post("https://lr_tienlen/Sort", JSON.stringify({slot: slot}), function(sorted){
                //console.log(JSON.stringify(sorted[0]))
                //console.log(hands[parseInt(slot)].toString())
                //hands[parseInt(slot)].addCards(sorted)
                for (var j = 0; j<sorted.length; j++){
                    var sortedCard = sorted[j]
                    for (var i = 0; i < me.cards.length; i++){
                        //var card2 = hands[parseInt(slot)].cards[i];
                        ////console.log(`[${card2.rank}, ${card2.suit}, ${card2.index}] ${i}`)
                        if(me.cards[i].index == sortedCard[2]){
                            var card = me.cards[i];
                            card.isChoosed = false;
                            //console.log(`[${card.rank}, ${card.suit}, ${card.index}]`)
                            me.addCard(card)
                            
                            break;
                        }
                    }
                }
                me.render()
                
            })
        }
        toString(){
            return "Hand"
        }
    }

    class Pile extends Container{
        constructor(options){
            super();
            this.init(options);
            this.lastCards = []
        };
        calcPosition(options){
            options = options || {};
            var width = opt.cardSize.width + (this.cards.length - 1) * opt.cardSize.padding;
			var left = Math.round(this.x - width / 2);
			var top = Math.round(this.y - opt.cardSize.height / 2, 0);
			for (var i = 0; i < this.cards.length; i++) {
				this.cards[i].targetTop = top;
				this.cards[i].targetLeft = left + i * opt.cardSize.padding;
			}
        }
		toString() {
			return 'Pile';
		};
        addCards(cards){
            for (var i = 0; i<this.lastCards.length; i++){
                this.lastCards[i].hideCard()
                this.removeCard(this.lastCards[i])
            }
            this.lastCards = cards;
            for (var i = 0; i < cards.length; i++) {
				var card = cards[i];
				if (card.container) {
					card.container.removeCard(card);
				}
				this.cards.push(card);
				card.container = this;
			}
        };
        hideCard(){
            for (var i = 0; i<this.lastCards.length; i++){
                this.lastCards[i].hideCard()
            }
        }
    }
    return {
        init: init,
        syncCards: syncCards,
        all: all,
        options: opt,
        SIZE: opt.cardSize,
        Card: Card,
        Container: Container,
        Deck: Deck,
        Hand: Hand,
        Pile: Pile
    }
})()



$(document).ready(function(){
    var isJoined = false;
    var currentTable;
    var currentSlot;
    var isReady = false;
    var started = false;
    Table.init({table:'#card-table'});
    deck = new Table.Deck({x:190, y:190})
    hands = {
        1: new Table.Hand({faceUp:true, y:123.3}),
        2: new Table.Hand({faceUp:true, x:1080, y:370}),
        3: new Table.Hand({faceUp:true, y:616.6}),
        4: new Table.Hand({faceUp:true, x:220, y:370})
    }
    tableCards = new Table.Pile({faceUp: true})
    for(var i in hands){
        //console.log(hands[i].toString())
        hands[i].click(function(card){
            var top = parseInt($(card.el).css('top'));
            if (!card.isChoosed){
                card.isChoosed = true
                var props = {
                    top: top - 10,
                }
            }else{
                card.isChoosed = false
                var props = {
                    top: top + 10,
                }
            }
            
            $(card.el).animate(props, 100)
        })
    }
    $(".sort").click(function(e){
        var slot = $(this).data("slot");
        hands[slot].sort(slot)
    })
    $(".danh").click(function(e){
        var slot =parseInt($(this).data("slot"));
        var selectedCards = []
        for (var i = 0; i<hands[slot].cards.length; i++){
            if (hands[slot].cards[i].isChoosed){
                selectedCards.push(hands[slot].cards[i].index)
            }
        }
        $.post("https://lr_tienlen/Hit", JSON.stringify({slot: slot, cards: selectedCards}))
    })
    $(".next").click(function(e){
        var slot =parseInt($(this).data("slot"));
        $.post("https://lr_tienlen/Next", JSON.stringify(slot))
    })
    $(".ready").click(function(e){
        var slot =parseInt($(this).data("slot"));
        var self = this;
        $.post("https://lr_tienlen/Ready", JSON.stringify({}), function(canReady){
            if (canReady){
                $(self).hide();
            }
        });
        
    })
    $(".quit").click(function(e){
        $.post("https://lr_tienlen/Leave");
        isJoined = false;
        currentTable = null;
        currentSlot = null;
        isReady = false;
        started = false;
        $("#main").show();
        $("#card-table").hide();
        deck.destroy();
        tableCards.destroy();
        for(var i in hands){
            hands[i].destroy()
        }
    })
    $(".kick").click(function(e){
        var slot =parseInt($(this).data("slot"));
        $.post("https://lr_tienlen/Kick", JSON.stringify({slot:slot}))
    })
    $(document).keyup(function (event) {
        if (event.which == 27){
            $.post("https://lr_tienlen/Close")
        }
    });
    $(".grid-item.slot").animate({opacity: 0}, 0);
    $(".money-animation").bind('oanimationend animationend webkitAnimationEnd', function() { 
        console.log("doneeeeee")
     });
    window.addEventListener("message", function(e){
        var event = e.data.event;
        var data = e.data.data;
        switch(event){
            case "syncCards":
                Table.syncCards(data);
                deck.addCards(Table.all);
                deck.render({immediate:true});
                break;
            case "deal":
                for (var i = 0; i < Table.all.length; i++) {
                    if(Table.all[i].index == data.card){

                        card = Table.all[i]
                        hands[data.slot].addCard(card);
                        hands[data.slot].render();
                    }
                }
                break;
            case "turn":
                $(".grid-item").each(function(index){
                    $(this).removeClass("active")
                });
                $(".grid-item.slot-"+data).addClass("active")
                break;
            case "time":
                $(".time").text(data)
                break;
            case "hit":
                var slot = parseInt(data.slot);
                var cards = data.card;
                var chosedCards = [];
                for (var j = 0; j<cards.length; j++){
                    var serverCard = cards[j]
                    for (var i=0; i<hands[slot].cards.length; i++){
                        var card = hands[slot].cards[i];
                        if (card.index == serverCard){
                            chosedCards.push(card)
                        }
                    }
                }
                tableCards.addCards(chosedCards);
                tableCards.render()
                hands[slot].sort(slot)
                break;
            case "flipDesk":
                tableCards.hideCard()
                break;
            case "toggle":
                if(data == true){
                    if (isJoined){
                        $("#main").hide();
                        $("#card-table").show();
                    }else{
                        $("#main").show();
                        $("#card-table").hide();
                    }
                }else{
                    $("#main").hide();
                    $("#card-table").hide();
                }
                break;
            case "initTables":
                $(".main").empty();
                $.each(data, function(k, v){
                    var el = $(`
                    <div class="col-6 main-table">
                        <div class="main-table-item"></div>
                        <div class="main-table-item">
                            <div class="player text-white">${checkSlot("1", v.slot, k)}</div>
                        </div>
                        <div class="main-table-item"></div>  
                        <div class="main-table-item">
                            <div class="player text-white">${checkSlot("4", v.slot, k)}</div>
                        </div>
                        <div class="main-table-item text-white">
                            <i class="fas fa-inbox"></i> ${k+1}
                            <div class="tables-info">[${v.nhat} - ${v.nhi}] </div>
                            
                        </div>
                        <div class="main-table-item">
                            <div class="player text-white">${checkSlot("2", v.slot, k)}</div>
                        </div>  
                        <div class="main-table-item"></div>
                        <div class="main-table-item">
                            <div class="player text-white">${checkSlot("3", v.slot, k)}</div>
                        </div>
                        <div class="main-table-item"></div> 
                    </div>
                    `)
                    //console.log(JSON.stringify(v))
                    $(".main").append(el);
                })
                $('.joinTable').on("click", function(){
                    //console.log($(this).data("table")+1)
                    //console.log($(this).data("slot"));
                    $.post("https://lr_tienlen/JoinTable", JSON.stringify({tableIndex: $(this).data("table")+1, slot: $(this).data("slot")}), function(result){
                        if(result != false){
                            //console.log(JSON.stringify(result))
                            isJoined = true;
                            currentSlot = result.currentSlot;
                            currentTable = result.currentTable;
                            isReady = false;
                            $(".grid-item button").each(function(index){
                                $(this).hide()
                            })
                            $(".grid-item .ready").each(function(index){
                                //console.log($(this).data("slot"), currentSlot)
                                if ($(this).data("slot") == currentSlot){
                                    $(this).show()
                                }
                            })
                            $(".grid-item .kick").each(function(index){
                                //console.log($(this).data("slot"), currentSlot)
                                if ($(this).data("slot") != currentSlot){
                                    $(this).show()
                                }
                            })
                            $("#main").hide();
                            $("#card-table").show();
                        }
                    })
                })
                break;
            case "syncPlayerData":
                $(`.slot`).each(function(index){
                    $(this).animate({opacity: 0}, 0)
                    $(this).removeClass("active")
                })
                for(var i in data.data){
                    $(`.slot-${i}`).animate({opacity: 100}, 0)
                    $(`.slot-${i} .name`).html(`<i class="fas fa-male"></i> ${data.data[i].name}`)
                    $(`.slot-${i} .money`).html(`<i class="fas fa-wallet"></i> ${data.data[i].money}`)
                    if(data.data[i].ready && !started){
                        $(`.slot-${i}`).addClass("active")
                    }
                }
                for(var i in data.result){
                    if (data.result[i] != undefined){
                        $(`.slot-${data.result[i]} .result`).show()
                        $(`.slot-${data.result[i]} .result`).css({"background-image": `url(img/${i}.png)`})
                    }
                }
                break;
            case "start":
                started = true;
                $(".grid-item .result").hide();
                $(".grid-item button").each(function(index){
                    $(this).hide()
                })
                $(".grid-item button").each(function(index){
                    //console.log($(this).data("slot"), currentSlot)
                    if ($(this).data("slot") == currentSlot){
                        if(!$(this).hasClass("ready") && !$(this).hasClass("kick")){
                            $(this).show()
                        }
                    }
                })

                break;
            case "removeAllCards":
                isReady = false;
                started = false;
                deck.destroy();
                tableCards.destroy();
                for(var i in hands){
                    hands[i].destroy()
                }
                $(".grid-item button").each(function(index){
                    $(this).hide()
                })
                $(".grid-item .ready").each(function(index){
                    //console.log($(this).data("slot"), currentSlot)
                    if ($(this).data("slot") == currentSlot){
                        $(this).show()
                    }
                })
                $(".grid-item .kick").each(function(index){
                    //console.log($(this).data("slot"), currentSlot)
                    if ($(this).data("slot") != currentSlot){
                        $(this).show()
                    }
                })
                $(".grid-item .result").hide();
                break;
            case "end":
                for(var i in hands){
                    for (var j = 0; j < hands[i].cards.length; j++) {
                        hands[i].cards[j].showCard();
                    } 
                }
                break;
            case "addMoney":
                console.log(data.slot, data.money)
                $(`.slot-${data.slot}`).append(`<div class="money-animation-add">+${data.money}</div>`)

                break;
            case "removeMoney":
                $(`.slot-${data.slot}`).append(`<div class="money-animation-remove">-${data.money}</div>`)

                break;
            case "requestKick":
                $("body").append(`
                <div class="modal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                  <div class="modal-content bg-danger">
                    <div class="modal-body text-light text-center">
                      <p>Người chơi ${data.name} muốn đuổi ${data.slotName} ra khỏi phòng</p>
                      <p>Bạn có đồng ý?</p>
                      <h1 class="request-time text-warning">15</h1>
                    </div>
                    <div class="modal-footer">
                      <button type="button" data-slot="${data.slot}" class="btn btn-primary yes">Đồng ý</button>
                      <button type="button" data-slot="${data.slot}" class="btn btn-secondary no" data-dismiss="modal">Không</button>
                    </div>
                  </div>
                </div>
              </div>
                `)
                var modalInteval = setInterval(() => {
                    var time = parseInt($(".request-time").text()) - 1;
                    $(".request-time").text(time)
                    if ($(".request-time").text() == "0"){
                        $(".modal").remove();
                        clearInterval(modalInteval)
                    }
                }, 1000);
                $(".yes").click(function(e){
                    var slot =parseInt($(this).data("slot"));
                    $.post("https://lr_tienlen/AcceptRequest", JSON.stringify({slot: slot}));
                    clearInterval(modalInteval)
                    $(".modal").remove();
                })
                $(".no").click(function(e){
                    clearInterval(modalInteval)
                    $(".modal").remove();
                })
                
                break;
            case "kicked":
                $.post("https://lr_tienlen/Leave");
                isJoined = false;
                currentTable = null;
                currentSlot = null;
                isReady = false;
                started = false;
                $("#main").show();
                $("#card-table").hide();
                deck.destroy();
                tableCards.destroy();
                for(var i in hands){
                    hands[i].destroy()
                }
                break;
            default :
        }
    })
    function checkSlot(index, data, tb){
        if (data[index].playerId != undefined){
            return `<i class="fas fa-male"></i>: ${data[index].name} [${data[index].playerId}]`
        }else{
            return `<button type="button" data-table=${tb} data-slot=${index} class="btn btn-success joinTable">Tham gia</button>`
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
})