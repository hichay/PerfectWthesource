// MOXHA - Really Spagetti Code...

let PlayersMotels = {};
let EmployeeMotels = {};
let MotelsMoney = {};
let ClosestPlayers = {};
let MotelsBill = {};
let MenuEmployeers = {};
let Requests = {};
let nowMotel = '';
let isOwner = true;
let SelectClass = '';
let CurrentPlayer = 0;
let nowNotification = '';
let Identifier = '';
let SelectedMotel = 0;
let _U = {};
let Cfg = {};
let MX = {};
let CurrentData = {};
let nowType = '';
let Transactions = {};
let CurrentUpTimeMethod = 0;
let nowSound = null;

$(function() {
    setInterval(() => {
        if (PlayersMotels[Identifier]) {
            $.post('http://pw-motelsbusiness/GetTimer', JSON.stringify({
                target: Identifier
            }), function(time) {
                $('.SelfManSecName.CurRem').html(`${time}`);
            });
        }   
        if (PlayersMotels[CurrentPlayer]) {
            $.post('http://pw-motelsbusiness/GetTimer', JSON.stringify({
                target: CurrentPlayer
            }), function(time) {
                $('.CustomerManNameFirstLastName.Rem').html(`${_U['reception_remTime']} ${time}`);
            });
        }
    }, 9000);

    setInterval(() => {
        var time = new Date();
        $('.time-utc').html(time.getHours() + ':' + time.getMinutes() + ' ' + 'UTC');
    }, 100);

    window.addEventListener('message', (event) => {
        switch (event.data.type) {
            case 'StartSound':
                if (nowSound != null) {
                    nowSound.pause();
                }
                nowSound = new Audio("./assets/sounds/lock.mp3");
                nowSound.volume = 0.4;
                nowSound.play();
                break;
            case 'reception':
                PlayersMotels = event.data.PlayersMotels;
                EmployeeMotels = event.data.EmployeeMotels;
                MotelsMoney = event.data.MotelsMoney;
                MenuEmployeers = event.data.MenuEmployeers;
                ClosestPlayers = event.data.ClosestPlayers;
                MotelsBill = event.data.MotelsBill;
                MenuPlayers = event.data.MenuPlayers;
                nowMotel = event.data.nowMotel;
                isOwner = event.data.isOwner;
                Requests = event.data.Requests;
                Identifier = event.data.Identifier;
                MX = event.data.buildData;
                $('.playername').html(event.data.myName);
                $('.name').html(event.data.nowMotel);
                SetProperties();
                OpenMenu('owner');
                break;
            case 'customer':
                PlayersMotels = event.data.PlayersMotels;
                EmployeeMotels = event.data.EmployeeMotels;
                MotelsMoney = event.data.MotelsMoney;
                MenuEmployeers = event.data.MenuEmployeers;
                ClosestPlayers = event.data.ClosestPlayers;
                MotelsBill = event.data.MotelsBill;
                MenuPlayers = event.data.MenuPlayers;
                nowMotel = event.data.nowMotel;
                isOwner = event.data.isOwner;
                Requests = event.data.Requests;
                Identifier = event.data.Identifier;
                $('.playername').html(event.data.myName);
                $('.name').html(event.data.nowMotel);
                OpenMenu('customer');
                break;
            case 'notification':
                Information(event.data.msg, event.data.ms);
                break;
            case 'transaction':
                AddTransaction(event.data.method, event.data.data);
                break;
            case 'getMainData':
                _U = event.data.language;
                Cfg = event.data.config;
                MX = event.data.buildData;
                SetGeneralData();
                break;
            case 'RefreshDatas':
                PlayersMotels = event.data.PlayersMotels;
                EmployeeMotels = event.data.EmployeeMotels;
                MotelsMoney = event.data.MotelsMoney;
                ClosestPlayers = event.data.ClosestPlayers;
                MotelsBill = event.data.MotelsBill;
                MenuEmployeers = event.data.MenuEmployeers;
                MenuPlayers = event.data.MenuPlayers;
                Requests = event.data.Requests;
                SetProperties();
                break;
            case 'UpdateTime':
                $('.time').html(event.data.hour + ':' + event.data.minute);
                break;
            default: break;
        }
    });
});

$(document).on('change', '.select', function(){
    let value = $('input[name=test]:checked').val();
    if (nowMotel && MX[nowMotel]) {
        if (value == 'minute') {
            $('.takeCustomerPrice-input').attr("placeholder", "Minimum 0 Max 60");
            $('.takeCustomerTime-input').attr("placeholder", "Minimum 1 Max 60");
        }else if (value == 'hour') {
            $('.takeCustomerTime-input').attr("placeholder", "Minimum 1");
        }
    }
});

$(document).on('change', '.CustomerManMsg-input', function(){
    if ($('.CustomerManMsg-input').val() != null && $('.CustomerManMsg-input').val() != '') {
            $('.fa-comment').addClass('hovered');
        }else {
            $('.fa-comment').removeClass('hovered');
    }
});

function SetGeneralData(){
    $('.home-msg').html(_U['reception_dashboard']);
    $('.EmployeeMan-msg').html(_U['reception_employees']);
    $('.customerMan-msg').html(_U['reception_customers']);
    $('.nearby-msg').html(_U['reception_nearby']);
    $('.bank-msg').html(_U['reception_motel_money']);
    $('.request-msg').html(_U['reception_requests']);
    $('.sell-msg').html(_U['reception_sellMotel']);
    $('.self-msg').html(_U['reception_myRoom']);

    let bankMain = `
    <div class="currentMoney-container">
                        <div class="currentMoney">${_U['society_menu']}
                            <div class="motelMoney">0</div>
                            <i class="fas fa-wallet fa-2x"></i>
                        </div>
                    </div>
                    <div class="depositMoney-container">
                        <div class="depositMoney">${_U['society_deposit']}
                            <br>
                            <input autocomplete="off" class='depositAmount-input' type="number" name="depositAmount" placeholder="${_U['reception_writeNumber']}">
                            <i class="fas fa-donate fa-2x"></i>
                            <span class="focus-border"></span>
                        </div>
                    </div>
                    <div class="withdrawMoney-container">
                        <div class="withdrawMoney">${_U['society_withdraw']}    
                            <br>
                            <input autocomplete="off" class='withdrawAmount-input' type="number" name="withdrawAmount" placeholder="${_U['reception_writeNumber']}">
                            <i class="far fa-money-bill-alt fa-2x"></i>
                            <span class="focus-border"></span>
                        </div>
                    </div>
    `
    $('.bankManagementMenu').html(bankMain);

    let selfManMain = `<div class="selfManContainer">
    <div class="SelfManName">${_U['reception_payRoom']}
        <br>
        <div class="SelfManSecName CurRent">${_U['reception_reqPay']}: $0</div>
        <input class='SelfManSec-input' type="number" placeholder="Amount">
        <i class="fas fa-money-check-alt fa-2x"></i>
    </div>
</div>
<div class="selfManContainer">
    <div class="SelfManName">${_U['reception_selfTime']}
        <br>
        <div class="SelfManSecName CurRem">Current: 0</div>
        <i class="fas fa-clock fa-2x"></i>
    </div>
</div>
<div class="selfManContainer">
    <div class="SelfManName">${_U['reception_leftRoom']}
        <br>
        <div class="SelfManSecName">${_U['reception_leftedRoomz']}</div>
        <i class="fas fa-sign-out-alt fa-2x"></i>
    </div>
</div>
<div class="selfManRequestContainer">
    <div class="RequestTopic">${_U['reception_requestMain']}</div>
    <div class="checkboxes2">
        <input type="checkbox" id="reqEmployee">
        <label for="reqEmployee">${_U['reception_requestgetEmployee']}</label>
        <input type="checkbox" id="reqKey">
        <label for="reqKey">${_U['reception_requestKey']}</label>
        <input type="checkbox" id="reqChangeRoom">
        <label for="reqChangeRoom">${_U['reception_requestChangeRoom']}</label>
        <br>
        <input type="checkbox" id="reqRefreshTime">
        <label for="reqRefreshTime">${_U['reception_requestRefreshTime']}</label>
    </div>
</div>
    `
    $('.selfManagementMenu').html(selfManMain);

    let WelcomeMain = `
    <div class="employee-container">
                        <div class="employees">${_U['employeeNum']}
                            <div class="employeeNum">0</div>
                            <i class="fas fa-user-circle fa-2x"></i>
                        </div>
                    </div>
                    <div class="motels-container">
                        <div class="motels">${_U['emptyRoomsNum']}
                            <div class="motelsNum">0</div>
                            <i class="fas fa-hotel fa-2x"></i>
                        </div>
                    </div>
                    <div class="customer-container">
                        <div class="customer">${_U['customersNum']}
                            <div class="customerNum">0</div>
                            <i class="far fa-user-circle fa-2x"></i>
                        </div>
                    </div>
                    <div class="transaction-container">
                        <span class="transaction-name">Last Transactions</span>
                        <div class="last-transaction">
                            <!-- <div class="transaction-box">Admin Banned $5000 kirasını ödedi.</div>
                            <span class="transaction-line"></span>
                            <i class="fas fa-calendar-alt"></i>  -->
                        </div>
                        <br><br>
                    </div>`
    $('.Welcome').html(WelcomeMain);        
};

$(document).on('change', '.takeCustomerTime-input', function(){
    let value = $('input[name=test]:checked').val();
    if (value == 'hour') {
        if (nowMotel && MX[nowMotel]) {
            if ($('.takeCustomerTime-input').val()) {
                $('.takeCustomerPrice-input').attr("placeholder", "Minimum " + MX[nowMotel].expense.min + " Max " + Number(MX[nowMotel].expense.max) * $('.takeCustomerTime-input').val());
            }
        }
    }else {
        if (nowMotel && MX[nowMotel]) {
            if ($('.takeCustomerTime-input').val()) {
                $('.takeCustomerPrice-input').attr("placeholder", "Minimum 0" + " Max " + Number(MX[nowMotel].expense.min));
            }
        }
    }
});

$(document).on('click', '.popup-yes-containerTakeCustomer',  function() {
    if (CurrentUpTimeMethod == 1) {
        CurrentData = {};
        var expense = $('.takeCustomerPrice-input').val();
        var time = $('.takeCustomerTime-input').val();
        var method = $('input[name=test]:checked').val();
        if (expense && time) {
            if (method == 'hour') {
                var currentTime = 3600000 
                if (Number(expense) >= Number(MX[nowMotel].expense.min) && Number(expense) <= Number(MX[nowMotel].expense.max) * Number(time)) {
                    let foundx = false;
                    if (MotelsBill[CurrentPlayer] && MotelsBill[CurrentPlayer].data) {
                        $.each(MotelsBill[CurrentPlayer].data, function(k,v) {
                            if (v.price && v.price != 0) {
                                foundx = true
                                return
                            };
                        });
                        if (foundx) {
                            CurrentData.CurrentPlayer = CurrentPlayer
                            CurrentData.motel = nowMotel
                            CurrentData.motelid = currentRoom
                            CurrentData.time = (currentTime*time)
                            CurrentData.expense = Number(expense)
                            AreYouSure(_U['motel_yousureWillBill']);
                            nowNotification = 'WillBill';
                            $('#popup-container').fadeOut(300);
                            $('#core').css({'filter':'brightness(1)'});
                        }else {
                            $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
                                method: 'buy',
                                data: {
                                    target: CurrentPlayer,
                                    motel: nowMotel,
                                    motelid: currentRoom,
                                    time: (currentTime*time),
                                    expense: Number(expense)
                                }
                            }));
                            $('#popup-container').fadeOut(300);
                            $('#core').css({'filter':'brightness(1)'});
                        }
                    }else {
                        $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
                            method: 'buy',
                            data: {
                                target: CurrentPlayer,
                                motel: nowMotel,
                                motelid: currentRoom,
                                time: (currentTime*time),
                                expense: Number(expense)
                            }
                        }));
                        $('#popup-container').fadeOut(300);
                        $('#core').css({'filter':'brightness(1)'});
                    }
                    
                }else {
                    Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].expense.min} Max ${Number(MX[nowMotel].expense.max) * Number(time)} `)
                }
            }else if (method == 'minute') {
                var currentTime = 60000;
                if (time > 60) {
                    $('#popup-container').fadeOut(300);
                    $('#core').css({'filter':'brightness(1)'});
                    Notification(_U['motel_not>60']);
                    return;
                }
                if (Number(expense) >= 0 && Number(expense) <= Number(MX[nowMotel].expense.min)) {
                    let foundx = false;
                    if (MotelsBill[CurrentPlayer] && MotelsBill[CurrentPlayer].data) {
                        $.each(MotelsBill[CurrentPlayer].data, function(k,v) {
                            if (v.price && v.price != 0) {
                                foundx = true
                                return;
                            };
                        });
                        if (foundx) {
                            CurrentData.CurrentPlayer = CurrentPlayer
                            CurrentData.motel = nowMotel
                            CurrentData.motelid = currentRoom
                            CurrentData.time = (currentTime*time)
                            CurrentData.expense = Number(expense)
                            AreYouSure(_U['motel_yousureWillBill']);
                            nowNotification = 'WillBill';
                            $('#popup-container').fadeOut(300);
                            $('#core').css({'filter':'brightness(1)'});
                        }else {
                            $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
                                method: 'buy',
                                data: {
                                    target: CurrentPlayer,
                                    motel: nowMotel,
                                    motelid: currentRoom,
                                    time: (currentTime*time),
                                    expense: Number(expense)
                                }
                            }));
                            $('#popup-container').fadeOut(300);
                            $('#core').css({'filter':'brightness(1)'});
                        }
                    }else {
                        $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
                            method: 'buy',
                            data: {
                                target: CurrentPlayer,
                                motel: nowMotel,
                                motelid: currentRoom,
                                time: (currentTime*time),
                                expense: Number(expense)
                            }
                        }));
                        $('#popup-container').fadeOut(300);
                        $('#core').css({'filter':'brightness(1)'});
                    }
                }else {
                    Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].expense.min} Max ${MX[nowMotel].expense.max} `)
                }
            }
        }else {
            Information(`${_U['reception_notTakeSalary']}`)
        }
    }else if (CurrentUpTimeMethod == 2) {
        CurrentData = {};
        var expense = $('.takeCustomerPrice-input').val();
        var time = $('.takeCustomerTime-input').val();
        var method = $('input[name=test]:checked').val();
        if (expense && time) {
            if (method == 'hour') {
                if (Number(expense) >= Number(MX[nowMotel].expense.min) && Number(expense) <= Number(MX[nowMotel].expense.max) * Number(time)) {
                    $.post('http://pw-motelsbusiness/RefreshTime', JSON.stringify({
                        current: CurrentPlayer,
                        time: time,
                        method: 2,
                        expense: Number(expense)
                    }));
                    $('#popup-container').fadeOut(300);
                    $('#core').css({'filter':'brightness(1)'});
                    CloseMenu()
                }else {
                    Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].expense.min} Max ${Number(MX[nowMotel].expense.max) * Number(time)} `)
                }
            }else if (method == 'minute') {
                if (time > 60) {
                    $('#popup-container').fadeOut(300);
                    $('#core').css({'filter':'brightness(1)'});
                    Notification(_U['motel_not>60']);
                    return;
                }
                if (Number(expense) >= 0 && Number(expense) <= Number(MX[nowMotel].expense.min)) {
                    $.post('http://pw-motelsbusiness/RefreshTime', JSON.stringify({
                        current: CurrentPlayer,
                        time: time,
                        method: 1,
                        expense: Number(expense)
                    }));
                    $('#popup-container').fadeOut(300);
                    $('#core').css({'filter':'brightness(1)'});
                    CloseMenu();

                }else {
                    Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].expense.min} Max ${MX[nowMotel].expense.max} `)
                }
            }
        }else {
            Information(`${_U['reception_notTakeSalary']}`)
        }
    }
});

$(document).on('click', '.popup-no-containerTakeCustomer', () => {
    CurrentData = {};
    $('#popup-container').fadeOut(300, 'linear');
    DefaultCSSValue();
    
    SelectClass = 'home';
    $('.home-msg').css({'color':'rgb(73, 102, 153)'});
    $('.fa-home').css({'color':'rgb(73, 102, 153)'});
    $('.home').css({'background-color':'rgb(61, 63, 80)'});
    $('.home').css({'border-radius':'8px'});
    RefreshMenu();
    $('.welcome').fadeIn(400);
    $('#core').css({'filter':'brightness(1)'});
});

$(document).on('click', '.nearbyPlayer-container', function(e) {
    $('.nearbyManagementMenux2').html('');
    $('.nearbyManagementMenu').fadeOut(300);
    CurrentPlayer = $(this).attr('id');
    let app = `<div class="nearby-selectedName">${$('.nearbyPlayer-firstlastname').html()}</div>  <div class="nearbyContainer takeEmployee">    <div class="nearbyMenuName">${_U['closesest_employeersMenu']} <br>        <div class="NearbyNameFirstLastName">${_U['closest_takeTargetEmployee']}</div>        <i class="fas fa-handshake fa-2x"></i>    </div></div><div class="nearbyContainer takeCustomer">    <div class="nearbyMenuName">${_U['closesest_playersMenu']}   <br>        <div class="NearbyNameFirstLastName">${_U['closest_takePlayerEmployee']}</div>        <i class="fas fa-address-book fa-2x"></i>    </div></div>`
    $('.nearbyManagementMenux2').append(app);
    $('.nearbyManagementMenux2').fadeIn(500);
});

$(document).on('click', '.popup-yes-container', function(e) {
    var salary = $('.takeEmployeeSal-input').val();
    if (salary) {
        if (salary >= MX[nowMotel].salary.min && salary <= MX[nowMotel].salary.max) {
            $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
                method: 'takeemployee',
                data: {
                    target: CurrentPlayer,
                    motel: nowMotel,
                    salary: salary
                }
            }));
            $('#popup-container').fadeOut(300);
            $('#core').css({'filter':'brightness(1)'});
        }else {
            $('#popup-container').fadeOut(300);
            $('#core').css({'filter':'brightness(1)'});
            Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].salary.min} Max ${MX[nowMotel].salary.max} `)
        };
    }else {
        $('#popup-container').fadeOut(300);
        $('#core').css({'filter':'brightness(1)'});
        Information(`${_U['reception_notTakeSalary']}`)
    }
});

$(document).on('click', '.popup-no-container', function(e) {
    $('#popup-container').fadeOut(300);
    $('#core').css({'filter':'brightness(1)'});
});

$(document).on('click', '#reqEmployee', function(){
    $.post('http://pw-motelsbusiness/SendRequest', JSON.stringify({
        currentReq: 'reqEmployee',
        upval: $('.checkboxes2 input[id=reqEmployee]').prop('checked')
    }));
    Information(_U['reception_sendedRequest'])
});

$(document).on('click', '#reqKey', function(){
    $.post('http://pw-motelsbusiness/SendRequest', JSON.stringify({
        currentReq: 'reqKey',
        upval: $('.checkboxes2 input[id=reqKey]').prop('checked')
    }));
    Information(_U['reception_sendedRequest'])
});

$(document).on('click', '#reqChangeRoom', function(){
    $.post('http://pw-motelsbusiness/SendRequest', JSON.stringify({
        currentReq: 'reqChangeRoom',
        upval: $('.checkboxes2 input[id=reqChangeRoom]').prop('checked')
    }));
    Information(_U['reception_sendedRequest'])
});

$(document).on('click', '#reqRefreshTime', function(){
    $.post('http://pw-motelsbusiness/SendRequest', JSON.stringify({
        currentReq: 'reqRefreshTime',
        upval: $('.checkboxes2 input[id=reqRefreshTime]').prop('checked')
    }));
    Information(_U['reception_sendedRequest'])
});

function Information(msg, ms){
    $('.inform-msg').html(msg);
    $('#information-container').fadeIn(300);
    $('#information-container').animate({
        left: '0'
    });
    setTimeout(() => {
        $('#information-container').animate({
            left: '-100%'
        }); 
    }, ms || 4500);
}

function SetProperties(){
    $('.CustomersManagementMenu').html('');
    $('.CustomersManagementMenux2').html('');
    $('.EmployeeManagementMenu').html('');
    $('.EmployeeManagementMenux2').html('');
    $('.nearbyManagementMenu').html('');
    $('.nearbyManagementMenux2').html('');
    $('.requestsManagementMenu').html('');
    $('.requestsManagementMenux2').html('');
    $('.EmptyMotels').html('');
    var close = {};
    var motelNum = 0;
    var customerNum = 0;
    var employeeNum = 0;
    if (MX && MX[nowMotel] && MX[nowMotel].doors) {
        $.each(MX[nowMotel].doors, function(i, z){
            $.each(PlayersMotels, function(k,v) {
                if (v.motel == nowMotel && v.motelid == i+1) {
                    close[i+1] = true;
                }
            });
            if (close[i+1] == null) {
                motelNum++;
            }
        });
    }
    $.each(PlayersMotels, function(k,v) {
        if (v.motel == nowMotel) {
            customerNum++;
        }
    });
    $.each(EmployeeMotels, function(k,v) {
        if (v.motel == nowMotel) {
            employeeNum++;
        }
    });
    $('.employeeNum').html(employeeNum); 
    $('.motelsNum').html(motelNum);
    $('.customerNum').html(customerNum);
    $('.motelMoney').html(MotelsMoney[nowMotel].money ? MotelsMoney[nowMotel].money : 0);  
    $.each(MenuPlayers, function(k, v) {
        let html = `<div class="customers-container" id="${k}"><div class="customers-name">${_U['reception_payAmount']} : ${PlayersMotels[k].pay ? PlayersMotels[k].pay : '0'} <br><div class="customers-firstlastname">${v.firstname} ${v.lastname}</div><i class="fas fa-address-card fa-2x"></i></div></div>`;
        $('.CustomersManagementMenu').append(html);
    });
    $.each(MenuEmployeers, function(k, v) {
        let html = `<div class="employees-container" id="${k}"><div class="employees-name">${_U['reception_employee']}<br><div class="employees-firstlastname">${v.firstname} ${v.lastname}</div><i class="fas fa-address-card fa-2x"></i></div></div>`
        $('.EmployeeManagementMenu').append(html);
    });
    $.each(ClosestPlayers, function(k,v) {
        let html = `<div class="nearbyPlayer-container" id=${k}><div class="nearbyPlayer-name">${_U['reception_nearbyPlayer']}<br><div class="nearbyPlayer-firstlastname">${v.firstname} ${v.lastname}</div><i class="fas fa-address-card fa-2x"></i></div></div>`
        $('.nearbyManagementMenu').append(html);
    });
    $.each(Requests, function(k,v) {
        if (MenuPlayers[k] && MenuPlayers[k].firstname) {
            let html = `<div class="requestPlayer-container" id="${k}"><div class="requestPlayer-name">${_U['reception_requests']}<br><div class="requestPlayer-firstlastname">${MenuPlayers[k].firstname} ${MenuPlayers[k].lastname}</div><i class="fas fa-address-card fa-2x"></i></div></div>`
            $('.requestsManagementMenu').append(html);
        };
    });
    var ClosedMotels = {};
    if (MX[nowMotel] && MX[nowMotel].doors) {
        $.each(MX[nowMotel].doors, function(i, z){
            $.each(PlayersMotels, function(k,v) {
                if (v.motel == nowMotel && v.motelid == i+1) {
                    ClosedMotels[i+1] = true
                }
            });
            if (ClosedMotels[i+1] == null) {
                let html = `<div class="motel-container" id="${i+1}"><div class="motel-name">Motel<br><div class="motel-id">${_U['reception_room']} ${i+1}</div><i class="fas fa-save fa-2x"></i></div></div>`
                $('.EmptyMotels').append(html);
            }
        });
    }
    if (PlayersMotels[Identifier]) {
        if (PlayersMotels[Identifier].requests['requestEmployee']) {
            $('.checkboxes2 input[id=reqEmployee]').prop('checked', true);
        }else if(PlayersMotels[Identifier].requests['requestEmployee'] == null || PlayersMotels[Identifier].requests['requestEmployee'] == false) {
            $('.checkboxes2 input[id=reqEmployee]').prop('checked', false);
        }
        if (PlayersMotels[Identifier].requests['requestKey']) {
            $('.checkboxes2 input[id=reqKey]').prop('checked', true);
        }else {
            $('.checkboxes2 input[id=reqKey]').prop('checked', false);
        }
        if (PlayersMotels[Identifier].requests['requestChangeRoom']) {
            $('.checkboxes2 input[id=reqChangeRoom]').prop('checked', true);
        }else {
            $('.checkboxes2 input[id=reqChangeRoom]').prop('checked', false);
        }
        if (PlayersMotels[Identifier].requests['requestRefreshTime']) {
            $('.checkboxes2 input[id=reqRefreshTime]').prop('checked', true);
        }else {
            $('.checkboxes2 input[id=reqRefreshTime]').prop('checked', false);
        }
        $('.SelfManSecName.CurRent').html(_U['reception_reqPay'] + ' $' + PlayersMotels[Identifier].pay);
    }
    
};

function OpenMenu(method){
    DefaultCSSValue();
    RefreshMenu();
    $('#core').fadeIn(700);
    if (method == 'owner') {
        $('.home').fadeIn(0);
        $('.EmployeeMan').fadeIn(0);
        $('.customerMan').fadeIn(0);
        $('.nearby').fadeIn(0);
        $('.bankMan').fadeIn(0);
        $('.requests').fadeIn(0);
        $('.SellMotel').fadeIn(0);
        $('.selfMan').fadeOut(0);
        $('.home-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-home').css({'color':'rgb(73, 102, 153)'});
        $('.home').css({'background-color':'rgb(61, 63, 80)'});
        $('.home').css({'border-radius':'8px'});
        $('.welcome').fadeIn(500);
        SelectClass = 'home';
        $(".last-transaction").html('');
        $.each(Transactions, function(k,v){
            if (v.motel == nowMotel) {
                $(".last-transaction").append(v.msg);
            }
        });
    }else if (method == 'customer') {
        $('.home').fadeOut(0);
        $('.EmployeeMan').fadeOut(0);
        $('.customerMan').fadeOut(0);
        $('.nearby').fadeOut(0);
        $('.bankMan').fadeOut(0);
        $('.requests').fadeOut(0);
        $('.SellMotel').fadeOut(0);
        $('.selfManagementMenu').fadeIn(500);
        $('.selfMan').fadeIn(0);
        $('.self-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-cog').css({'color':'rgb(73, 102, 153)'});
        $('.selfMan').css({'background-color':'rgb(61, 63, 80)'});
        $('.selfMan').css({'border-radius':'8px'});
        if (PlayersMotels[Identifier]) {
            $('.SelfManSecName.CurRent').html(_U['reception_reqPay'] + ' $' + PlayersMotels[Identifier].pay);
            $.post('http://pw-motelsbusiness/GetTimer', JSON.stringify({
                target: Identifier
            }), function(time) {
                $('.SelfManSecName.CurRem').html(`${time}`);
            });
        }
        SelectClass = 'selfMan';
    }
}

$(document).on('click', '.fa-power-off', function(e) {
    CloseMenu();
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        CloseMenu()
        return;
    }
};

function CloseMenu(){
    $('#core').fadeOut(700);
    $.post('http://pw-motelsbusiness/CloseMotel', JSON.stringify({
        motel: nowMotel
    }));
}

$(document).on('click', '.fa-address-book', function(){
    if (PlayersMotels[CurrentPlayer] == null) {
        Popup('takeCustomer');
    }else {
        Information(_U['not_alreadyMotel']);
    }
});

$(document).on('click', '.fa-handshake', function(){
    if (EmployeeMotels[CurrentPlayer] == null) {
        Popup('takeEmployee');
    }else {
        Information(_U['not_alreadyEmployee']);
    }
});

$(document).on('click', '#RequestEmployee', function(){
    nowType = 'RequestEmployee';
    ConfirmContainer(MenuPlayers[CurrentPlayer].firstname + ' ' + MenuPlayers[CurrentPlayer].lastname)
});

$(document).on('click', '#reqMotelKey', function(){
    nowType = 'reqMotelKey';
    ConfirmContainer(MenuPlayers[CurrentPlayer].firstname + ' ' + MenuPlayers[CurrentPlayer].lastname)
});

$(document).on('click', '#RequestChangeRoom', function(){
    nowType = 'reqChangeRoom';
    ConfirmContainer(MenuPlayers[CurrentPlayer].firstname + ' ' + MenuPlayers[CurrentPlayer].lastname)
});

$(document).on('click', '#RequestRefreshTime', function(){
    nowType = 'RequestRefreshTime';
    ConfirmContainer(MenuPlayers[CurrentPlayer].firstname + ' ' + MenuPlayers[CurrentPlayer].lastname)
});

function Popup(method) {
    $('#popup-container').html('');
    $('#core').css({'filter':'brightness(0.5)'});
    if (method == 'takeEmployee') {
        let data = `<div id="popup-containerTakeEmployee"><span class="popup-msg">${$('.nearby-selectedName').html()}</span><br><div class="popup-yes-container">    <span class="popup-yes">${_U['confirm']}</span></div><div class="popup-no-container">    <span class="popup-no">${_U['refuse']}</span></div><h3 class="takeEmployeeSal-msg">${_U['reception_writesalary']}</h3><input autocomplete="off" class='takeEmployeeSal-input' type="number" placeholder="Min ${MX[nowMotel].salary.min} Max ${MX[nowMotel].salary.max}"></div>`
        $('#popup-container').html(data);
        $('#popup-container').fadeIn(300);
    }else if (method == 'takeCustomer') {
        $('.nearbyManagementMenux2').fadeOut(300);
        $('#core').css({'filter':'brightness(1)'});
        $('.EmptyMotels').fadeIn(500);
        nowType = 'takeCustomer';
    }else if (method == 'RefreshTime') {
        CurrentUpTimeMethod = 2;
        let data = `<div id="popup-containerTakeCustomer"><span class="popup-msgTakeCustomer">${MenuPlayers[CurrentPlayer].firstname} ${MenuPlayers[CurrentPlayer].lastname}</span><br><div class="popup-yes-containerTakeCustomer"><span class="popup-yes">${_U['confirm']}</span></div><span class="select-method">${_U['reception_time']}</span><div class="select" tabindex="1">    <input class="selectopt" name="test" type="radio" value='minute' id="opt1" checked>    <label for="opt1" class="option">${_U['minute']}</label>    <input class="selectopt" name="test" type="radio" value='hour' id="opt2">    <label for="opt2" class="option">${_U['hour']}</label></div><div class="popup-no-containerTakeCustomer">    <span class="popup-no">${_U['refuse']}</span></div><input autocomplete="off" class='takeCustomerTime-input' type="number" placeholder="Minimum 0 Max 60"><h4 class="takeCustomerPriceText">${_U['enter_price']}</h4><input autocomplete="off" class='takeCustomerPrice-input' type="number" placeholder="Minimum 0 Max  ${MX[nowMotel].expense.min} "></div>`
        $('#popup-container').html(data);
        $('#popup-container').fadeIn(300);
    }
}

$(document).on('click', '.motel-container', function() {
    currentRoom = $(this).attr('id');
    if (nowType == 'takeCustomer') {
        CurrentUpTimeMethod = 1;
        let data = `<div id="popup-containerTakeCustomer"><span class="popup-msgTakeCustomer">${$('.nearby-selectedName').html()}</span><br><div class="popup-yes-containerTakeCustomer"><span class="popup-yes">${_U['confirm']}</span></div><span class="select-method">${_U['reception_time']}</span><div class="select" tabindex="1">    <input class="selectopt" name="test" type="radio" value='minute' id="opt1" checked>    <label for="opt1" class="option">${_U['minute']}</label>    <input class="selectopt" name="test" type="radio" value='hour' id="opt2">    <label for="opt2" class="option">${_U['hour']}</label></div><div class="popup-no-containerTakeCustomer">    <span class="popup-no">${_U['refuse']}</span></div><input autocomplete="off" class='takeCustomerTime-input' type="number" placeholder="Minimum 0 Max 60"><h4 class="takeCustomerPriceText">${_U['enter_price']}</h4><input autocomplete="off" class='takeCustomerPrice-input' type="number" placeholder="Minimum 0 Max  ${MX[nowMotel].expense.min} "></div>`
        $('#popup-container').html(data);
        $('#popup-container').fadeIn(300);
    }else if (nowType == 'ChangeRoom') {
        $('.EmptyMotels').fadeOut(300);
        SelectClass = 'CustomerMan';
        $('.customerMan-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-user-friends').css({'color':'rgb(73, 102, 153)'});
        $('.customerMan').css({'background-color':'rgb(61, 63, 80)'});
        $('.customerMan').css({'border-radius':'8px'});
        $('.CustomersManagementMenu').fadeIn(400);
        $.post('http://pw-motelsbusiness/ChangeRoom', JSON.stringify({
            current: CurrentPlayer,
            motel: currentRoom
        }));
        CloseMenu()
    }
    nowType = '';
    setTimeout(() => {
        $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
            motel: nowMotel
        }));
    }, 500);
});

$(document).on('click', '.checkboxes2 input[type=checkbox]', function(){
    $.post('http://pw-motelsbusiness/SendRequest', JSON.stringify({
        currentReq: $(this).attr('id')
    }));
    if (this.checked) {
        Information(_U['reception_sendedRequest'])
    }else {
        Information(_U['reception_canceledRequest'])
    }
});

$(document).on('click', '.fa-user-times', function(){
    AreYouSure(_U['areyouDeleteRoom'])
    nowNotification = 'deleteRoom'
 
});

$(document).on('click', '#EmployeeMsg', function(){
    if (Cfg.receptionMethods.sendMessage) {
        if (HasPermission(isOwner, Identifier, 'sendmessage')) {
            let value = $('.EmployeeManMsg-input').val();
            if (value != '' && value != null) {
                $.post('http://pw-motelsbusiness/SendMessageFromRecetion', JSON.stringify({
                    target: CurrentPlayer,
                    msg: value
                }));
            }else {
                Notification(_U['reception_notEmptyMsg']);
            };
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '#CustomerMsg', function(){
    if (Cfg.receptionMethods.sendMessage) {
        if (HasPermission(isOwner, Identifier, 'sendmessage')) {
            let value = $('.CustomerManMsg-input').val();
            if (value != '' && value != null) {
                $.post('http://pw-motelsbusiness/SendMessageFromRecetion', JSON.stringify({
                    target: CurrentPlayer,
                    msg: value
                }));
            }else {
                Notification(_U['reception_notEmptyMsg']);
            };
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.fa-exclamation-triangle', function(){
    if (Cfg.receptionMethods.kick) {
        if (HasPermission(isOwner, Identifier, 'kick')) {
            AreYouSure(_U['reception_kickAreyouSure']);
            nowNotification = 'kickEmployee';
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.fa-user-edit', function(){
    if (Cfg.receptionMethods.updateSuspened) {
        if (HasPermission(isOwner, Identifier, 'updateStatus')){
            AreYouSure(_U['areyouChangeStatus']);
            nowNotification = 'changeStatus';
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.employees-container', function(){
    $('.EmployeeManagementMenu').fadeOut(300);
    $('.EmployeeManagementMenux2').html('');
    CurrentPlayer = $(this).attr('id');
    let app = `<div class="selectedName">${MenuEmployeers[CurrentPlayer].firstname} ${MenuEmployeers[CurrentPlayer].lastname}</div>  <div class="EmployeeManagementContainer kick">    <div class="EmployeeManName">${_U['reception_kickEmployee']}<br><div class="EmployeeManFirstLastName">${_U['log_kickedEmployee']}</div><i class="fas fa-exclamation-triangle fa-2x"></i>    </div></div><div class="EmployeeManagementContainer msg">    <div class="EmployeeManName">${_U['reception_sendMessage']} <br> <input autocomplete="off" class='EmployeeManMsg-input' type="" placeholder="${_U['reception_writeMsg']}">  <i class="fas fa-comment fa-2x" id="EmployeeMsg"></i>    </div></div><div class="EmployeeManagementContainer prim">    <div class="EmployeeManName">${_U['reception_reward']}<br><input autocomplete="off" class='Prim-input' type="number" placeholder="${_U['reception_rewardMsg']}"><i class="fas fa-arrow-alt-circle-up fa-2x"></i>    </div></div><div class="EmployeeManagementContainer update">    <div class="EmployeeManName">${_U['reception_updateSalary']} <br>        <div class="EmployeeManBalanceInput">${_U['reception_salary']} $${EmployeeMotels[CurrentPlayer].salary ? EmployeeMotels[CurrentPlayer].salary: 0}</div>        <input autocomplete="off" class='Maas-input' type="number" placeholder="${_U['reception_writeNumber']}"> <i class="fas fa-money-bill-wave-alt fa-2x"></i>    </div></div><div class="EmployeePermissionContainer">    <div class="permissionTopic">${_U['reception_permissions']}</div> <div class="checkboxes"> <input type="checkbox" id="permKick">        <label for="permKick">${_U['reception_employeeKickGrade']}</label>        <input type="checkbox" id="permChangeRoom"> <label for="permChangeRoom">${_U['reception_employeeChangeGrade']}</label> <br> <input type="checkbox" id="permRefreshTime"> <label for="permRefreshTime">${_U['reception_employeeTimeRefGrade']}</label>  <input type="checkbox" id="permCreateNewKey"> <label for="permCreateNewKey">${_U['reception_employeeCreateNewKeyGrade']}</label> <br> <input type="checkbox" id="permSendMessage">  <label for="permSendMessage">${_U['reception_employeeSendMessageGrade']}</label>  <input type="checkbox" id="permRentRoom"> <label for="permRentRoom">${_U['reception_employeeTakePlayer']}</label> <br>  <input type="checkbox" id="permShowRequests">   <label for="permShowRequests">${_U['reception_employeeShowRequests']}</label>  <input type="checkbox" id="permWithdrawMoney"> <label for="permWithdrawMoney">${_U['reception_employeeTakeSocietyMoney']}</label> <br>  <input type="checkbox" id="permDepositMoney">  <label for="permDepositMoney">${_U['reception_employeeDepositSocietyMoney']}</label>        <input type="checkbox" id="permChangeStatus">        <label for="permChangeStatus">${_U['reception_employeeUpdateStatus']}</label>    </div></div>`
    $('.EmployeeManagementMenux2').append(app);
    $('.EmployeeManagementMenux2').fadeIn(500);
    if (EmployeeMotels[CurrentPlayer].permissions.kick) {
        $('.checkboxes input[id=permKick]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.change) {
        $('.checkboxes input[id=permChangeRoom]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.timerefresh) {
        $('.checkboxes input[id=permRefreshTime]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.createnewkey) {
        $('.checkboxes input[id=permCreateNewKey]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.sendmessage) {
        $('.checkboxes input[id=permSendMessage]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.takeplayer) {
        $('.checkboxes input[id=permRentRoom]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.showrequests) {
        $('.checkboxes input[id=permShowRequests]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.takeMoney) {
        $('.checkboxes input[id=permWithdrawMoney]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.depositMoney) {
        $('.checkboxes input[id=permDepositMoney]').prop('checked', true);
    }
    if (EmployeeMotels[CurrentPlayer].permissions.updateStatus) {
        $('.checkboxes input[id=permChangeStatus]').prop('checked', true);
    }
});

$(document).on('click', '#permKick', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permKick',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permChangeRoom', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permChangeRoom',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permRefreshTime', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permRefreshTime',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permCreateNewKey', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permCreateNewKey',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permSendMessage', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permSendMessage',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permRentRoom', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permRentRoom',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permShowRequests', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permShowRequests',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permWithdrawMoney', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permWithdrawMoney',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permDepositMoney', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permDepositMoney',
        target: CurrentPlayer
    }));
});

$(document).on('click', '#permChangeStatus', function(){
    $.post('http://pw-motelsbusiness/AddPermission', JSON.stringify({
        currentReq: 'permChangeStatus',
        target: CurrentPlayer
    }));
});

$(document).on('click', '.customers-container', function(){
    $('.CustomersManagementMenu').fadeOut(300);
    CurrentPlayer = $(this).attr('id');
    let msg = 'Normal';
    if (PlayersMotels[CurrentPlayer].suspended == 0) {
        msg = _U['reception_beat']
    }else if (PlayersMotels[CurrentPlayer].suspended == 1) {
        msg = _U['reception_suspended']
    }
    $.post('http://pw-motelsbusiness/GetTimer', JSON.stringify({
        target: CurrentPlayer
    }), function(time) {
        let app = `<div class="Customer-selectedName">${MenuPlayers[CurrentPlayer].firstname} ${MenuPlayers[CurrentPlayer].lastname}</div>  <div class="CustomerManagamentContainer update">    <div class="CustomerManName">${_U['reception_roomStatus']}<br>        <div class="CustomerManNameFirstLastName Status">${msg}</div>        <i class="fas fa-user-edit fa-2x"></i>    </div></div><div class="CustomerManagamentContainer delete">    <div class="CustomerManName">${_U['reception_kick']}<br><div class="CustomerManNameFirstLastName">${_U['reception_employeeKickGrade']}</div> <i class="fas fa-user-times fa-2x"></i>    </div></div><div class="CustomerManagamentContainer">    <div class="CustomerManName">${_U['reception_changeRoom']} <br>        <div class="CustomerManNameFirstLastName">${_U['reception_room']}${PlayersMotels[CurrentPlayer].motelid}</div>        <i class="fas fa-user-cog fa-2x"></i>    </div></div><div class="CustomerManagamentContainer refresh">    <div class="CustomerManName">${_U['reception_timeRefresh']}  <br>        <div class="CustomerManNameFirstLastName Rem">${_U['reception_remTime']} ${time}</div> <i class="fas fa-user-clock fa-2x"></i>    </div></div><div class="CustomerManagamentContainer">    <div class="CustomerManName">${_U['reception_createNewKey']} <br> <div class="CustomerManNameFirstLastName">${_U['reception_employeeCreateNewKeyGrade']}</div>  <i class="fas fa-plus-square fa-2x"></i>    </div></div><div class="CustomerManagamentContainer">    <div class="CustomerManName"> ${_U['reception_sendMessage']} <br><input class='CustomerManMsg-input' type="" placeholder="${_U['reception_writeMsg']}">  <i class="fas fa-comment fa-2x" id="CustomerMsg"></i>    </div></div>`;
        $('.CustomersManagementMenux2').html(app);
        $('.CustomersManagementMenux2').fadeIn(500);
    });
});

$(document).on('click', '.fa-user-cog', function(){
    SelectedMotel = $(this).attr('id');
    $('.CustomersManagementMenux2').fadeOut(300);
    $('.EmptyMotels').fadeIn(500);
    nowType = 'ChangeRoom';
});

$(document).on('click', '.fa-plus-square', function(){
    if (Cfg.receptionMethods.createNewKey && (Cfg.metasystem || Cfg.QBCore)) {
        if (HasPermission(isOwner, Identifier, 'createnewkey')) {
            nowNotification = 'createKey';
            AreYouSure(_U['areyouCreateKey'])
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.fa-user-clock', function(){
    Popup('RefreshTime');
});

$(document).on('click', '.requestPlayer-container', function(){
    $('.requestsManagementMenu').fadeOut(300);
    $('.requestsManagementMenux2').html('');
    CurrentPlayer = $(this).attr('id');
    let app = `<div class="requests-selectedName">${MenuPlayers[CurrentPlayer].firstname} ${MenuPlayers[CurrentPlayer].lastname}</div> <div class="allRequests"></div>`
    $('.requestsManagementMenux2').append(app);
    if (Requests[CurrentPlayer].requestKey) {
        let app2 = `
        <div class="requestsContainer">
        <div class="requestsMenuName">${_U['reception_requestedKey']}
            <br>
            <div class="RequestsNameFirstLastName">${_U['reception_requestMain']}</div>
            <i id="reqMotelKey" class="fas fa-user-alt fa-2x"></i>
        </div>
    </div>`
        $('.allRequests').append(app2);
    }
    if (Requests[CurrentPlayer].requestChangeRoom) {
        let app2 = `<div class="requestsContainer">
        <div class="requestsMenuName">${_U['reception_requestedChangeRoom']}
            <br>
            <div class="RequestsNameFirstLastName">${_U['reception_requestMain']}</div>
            <i id="RequestChangeRoom" class="fas fa-user-alt fa-2x"></i>
        </div>
    </div>`
    $('.allRequests').append(app2);
    }
    if (Requests[CurrentPlayer].requestRefreshTime) {
       let app2 = `
       <div class="requestsContainer">
        <div class="requestsMenuName">${_U['reception_requestedRefreshTime']}
            <br>
            <div class="RequestsNameFirstLastName">${_U['reception_requestMain']}</div>
            <i id="RequestRefreshTime" class="fas fa-user-alt fa-2x"></i>
        </div>
    </div>` 
    $('.allRequests').append(app2);
    }
    if (Requests[CurrentPlayer].requestEmployee) {
        let app2 = `<div class="requestsContainer">
        <div class="requestsMenuName">${_U['reception_requestedgetEmployee']}
            <br>
            <div class="RequestsNameFirstLastName">${_U['reception_requestMain']}</div>
            <i id="RequestEmployee" class="fas fa-user-alt fa-2x"></i>
        </div>
    </div>`
    $('.allRequests').append(app2);
    }
    $('.requestsManagementMenux2').fadeIn(500);
});

function Notification(msg) {
    $('#core').css({'filter':'brightness(0.5)'});
    $('.notify-msg').html(msg ? msg : 'ACCESS DENIED');
    $('#notification-container').fadeIn(400);
    $('body').css({'cursor':'none'});
    setTimeout(() => {
        $('#notification-container').fadeOut(400, function(){
            $('#core').css({'filter':'brightness(1)'});
            $('body').css({'cursor':'auto'});
        });
    }, 1500);
};

function AreYouSure(msg) {
    $('#core').css({'filter':'brightness(0.5)'})
    $('.areyousure-msg').html(msg ? msg : 'NOT MSG')
    $('#areyousure-container').fadeIn(400);
};

function ConfirmContainer(msg) {
    $('#core').css({'filter':'brightness(0.5)'})
    $('.confirm-msg').html(msg ? msg : 'NOT MSG')
    $('#confirm-container').fadeIn(400);
    $('.confirm-yes-container').click(function(){
        $('#core').css({'filter':'brightness(1)'})
        $('#confirm-container').fadeOut(400);
        if (nowType == 'reqChangeRoom') {
            $.post('http://pw-motelsbusiness/RejectRequest', JSON.stringify({
                currentReq: 'reqChangeRoom',
                current: CurrentPlayer
            }));
        }else if (nowType == 'RequestRefreshTime') {
            $.post('http://pw-motelsbusiness/ConfirmRequest', JSON.stringify({
                currentReq: 'reqRefreshTime',
                current: CurrentPlayer
            }));
        }else if (nowType == 'reqMotelKey') {
            $.post('http://pw-motelsbusiness/ConfirmRequest', JSON.stringify({
                currentReq: 'reqKey',
                current: CurrentPlayer
            }));
        }else if (nowType == 'RequestEmployee') {
            $.post('http://pw-motelsbusiness/ConfirmRequest', JSON.stringify({
                currentReq: 'reqEmployee',
                current: CurrentPlayer
            }));
        }
        nowType = '';
        $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
            motel: nowMotel
        }));
    });
    $('.confirm-no-container').click(function(){
        $('#core').css({'filter':'brightness(1)'})
        $('#confirm-container').fadeOut(400);
        if (nowType == 'reqChangeRoom') {
            $.post('http://pw-motelsbusiness/RejectRequest', JSON.stringify({
                currentReq: 'reqChangeRoom',
                current: CurrentPlayer
            }));
        }else if (nowType == 'RequestRefreshTime') {
            $.post('http://pw-motelsbusiness/RejectRequest', JSON.stringify({
                currentReq: 'reqRefreshTime',
                current: CurrentPlayer
            }));
        }else if (nowType == 'reqMotelKey') {
            $.post('http://pw-motelsbusiness/RejectRequest', JSON.stringify({
                currentReq: 'reqKey',
                current: CurrentPlayer
            }));
        }else if (nowType == 'RequestEmployee') {
            $.post('http://pw-motelsbusiness/RejectRequest', JSON.stringify({
                currentReq: 'reqEmployee',
                current: CurrentPlayer
            }));
        }
        nowType = '';
        $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
            motel: nowMotel
        }));
    });

    $('.confirm-cancel').click(function(){
        $('#core').css({'filter':'brightness(1)'})
        $('#confirm-container').fadeOut(400);
        nowType = '';
    });
    

};

$(document).on('click', '.areyousure-yes-container', function(veri){
    $('#core').css({'filter':'brightness(1)'});
    $('#areyousure-container').fadeOut(400);
    if (nowNotification == 'sellMotel') {
        $.post('http://pw-motelsbusiness/SellMotel', JSON.stringify({
            motel: nowMotel
        }));
        CloseMenu();
    }else if (nowNotification == 'kickEmployee') {
            $.post('http://pw-motelsbusiness/KickEmployee', JSON.stringify({
                current: CurrentPlayer,
                motel: nowMotel
            }));
            DefaultCSSValue();
            SelectClass = 'EmployeeMan';
            $('.EmployeeMan-msg').css({'color':'rgb(73, 102, 153)'});
            $('.fa-id-card-alt').css({'color':'rgb(73, 102, 153)'});
            $('.EmployeeMan').css({'background-color':'rgb(61, 63, 80)'});
            $('.EmployeeMan').css({'border-radius':'8px'});
            RefreshMenu();
            $('.EmployeeManagementMenu').fadeIn(400);
            $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
                motel: nowMotel
            }));
    }else if (nowNotification == 'leftRoom') {
        $.post('http://pw-motelsbusiness/LeftRoom');
        CloseMenu();
    }else if (nowNotification == 'WillBill') {
        $.post('http://pw-motelsbusiness/SendFromReceptionReq', JSON.stringify({
            method: 'buy',
            data: {
                target: CurrentData.CurrentPlayer,
                motel: CurrentData.motel,
                motelid: CurrentData.motelid,
                time: (CurrentData.time),
                expense: CurrentData.expense
            }
        }));
        $('#popup-container').fadeOut(300);
        $('#core').css({'filter':'brightness(1)'});
    }else if (nowNotification == 'createKey') {
        $.post('http://pw-motelsbusiness/CreateNewKey', JSON.stringify({
            target: CurrentPlayer
        }));
    }else if (nowNotification == 'changeStatus') {
        $.post('http://pw-motelsbusiness/UpdateSuspend', JSON.stringify({
            target: CurrentPlayer
        }));
        if (PlayersMotels[CurrentPlayer].suspended == 0) {
            PlayersMotels[CurrentPlayer].suspended = 1
        }else if (PlayersMotels[CurrentPlayer].suspended == 1) {
            PlayersMotels[CurrentPlayer].suspended = 0
        }
        let msg = 'Normal';
        if (PlayersMotels[CurrentPlayer].suspended == 0) {
            msg = _U['reception_beat']
        }else if (PlayersMotels[CurrentPlayer].suspended == 1) {
            msg = _U['reception_suspended']
        }
        $('.CustomerManNameFirstLastName.Status').html(msg);
    }else if (nowNotification == 'deleteRoom') {
        $.post('http://pw-motelsbusiness/DeleteMotel', JSON.stringify({
            target: CurrentPlayer
        }));
        CloseMenu();
    }
    nowNotification = '';
});

$(document).on('click', '.fa-sign-out-alt', function(){
    AreYouSure(_U['reception_areYouSureLeft'])
    nowNotification = 'leftRoom'
});

$(document).on('click', '.areyousure-no-container', function(){
    if (nowNotification != 'leftRoom') {
        $('#core').css({'filter':'brightness(1)'});
        $('#areyousure-container').fadeOut(400);
        DefaultCSSValue();
        SelectClass = 'home';
        $('.home-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-home').css({'color':'rgb(73, 102, 153)'});
        $('.home').css({'background-color':'rgb(61, 63, 80)'});
        $('.home').css({'border-radius':'8px'});
        RefreshMenu();
        $('.welcome').fadeIn(400);
        nowNotification = '';
    }else {
        $('#core').css({'filter':'brightness(1)'});
        $('#areyousure-container').fadeOut(400);
        nowNotification = '';
    }
});

function DefaultCSSValue() {
    if (SelectClass == 'home') {
        $('.home').removeAttr('style'); 
        $('.home-msg').removeAttr('style');
        $('.fa-home').removeAttr('style');
    }else if (SelectClass == 'EmployeeMan') {
        $('.EmployeeMan').removeAttr('style');
        $('.fa-id-card-alt').removeAttr('style');
        $('.EmployeeMan-msg').removeAttr('style');
    }else if (SelectClass == 'CustomerMan') { 
        $('.customerMan').removeAttr('style');
        $('.customerMan-msg').removeAttr('style');
        $('.fa-user-friends').removeAttr('style');
    }else if (SelectClass == 'nearby') { 
        $('.nearby-msg').removeAttr('style');
        $('.fa-user-circle').removeAttr('style');
        $('.nearby').removeAttr('style');
    }else if (SelectClass == 'bankMan') {  
        $('.bank-msg').removeAttr('style');
        $('.fa-hand-holding-usd').removeAttr('style');
        $('.bankMan').removeAttr('style');
    }else if (SelectClass == 'selfMan') {  
        $('.selfMan').removeAttr('style');
        $('.fa-cog').removeAttr('style');
        $('.self-msg').removeAttr('style');
    }else if (SelectClass == 'requests') {
        $('.requests').removeAttr('style');
        $('.fa-info-circle').removeAttr('style');
        $('.request-msg').removeAttr('style');
    }
    SelectClass = '';
    CurrentPlayer = 0;

    // $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
    //     motel: nowMotel
    // }));
};

function RefreshMenu(){
    $('.CustomersManagementMenu').fadeOut(300);
    $('.nearbyManagementMenu').fadeOut(300);
    $('.EmployeeManagementMenu').fadeOut(300);
    $('.welcome').fadeOut(300);
    $('.EmployeeManagementMenux2').fadeOut(300);
    $('.CustomersManagementMenux2').fadeOut(300);
    $('.nearbyManagementMenux2').fadeOut(300);
    $('.bankManagementMenu').fadeOut(300);
    $('.selfManagementMenu').fadeOut(300);
    $('.requestsManagementMenu').fadeOut(300);
    $('.requestsManagementMenux2').fadeOut(300);
    $('.EmptyMotels').fadeOut(300);
}

$(document).on('click', '.customerMan', function(){
    if (HasPermission(isOwner, Identifier, 'takeplayer')) {
        DefaultCSSValue();
        SelectClass = 'CustomerMan';
        $('.customerMan-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-user-friends').css({'color':'rgb(73, 102, 153)'});
        $('.customerMan').css({'background-color':'rgb(61, 63, 80)'});
        $('.customerMan').css({'border-radius':'8px'});
        RefreshMenu();
        $('.CustomersManagementMenu').fadeIn(400);
    }else {
        Notification(_U['reception_accessdenied']);
    }
});

$(document).on('click', '.nearby', function(){
    if (HasPermission(isOwner, Identifier, 'takeplayer')) {
        DefaultCSSValue();
        SelectClass = 'nearby';
        $('.nearby-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-user-circle').css({'color':'rgb(73, 102, 153)'});
        $('.nearby').css({'background-color':'rgb(61, 63, 80)'});
        $('.nearby').css({'border-radius':'8px'});
        RefreshMenu();
        $('.nearbyManagementMenu').fadeIn(400);
    }else {
        Notification(_U['reception_accessdenied']);
    }
});

$(document).on('click', '.EmployeeMan', function() {
    if (Cfg.Employee.active) {
        if (isOwner) {
            DefaultCSSValue();
            SelectClass = 'EmployeeMan';
            $('.EmployeeMan-msg').css({'color':'rgb(73, 102, 153)'});
            $('.fa-id-card-alt').css({'color':'rgb(73, 102, 153)'});
            $('.EmployeeMan').css({'background-color':'rgb(61, 63, 80)'});
            $('.EmployeeMan').css({'border-radius':'8px'});
            RefreshMenu();
            $('.EmployeeManagementMenu').fadeIn(400);
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.home', function() {
    DefaultCSSValue();
    SelectClass = 'home';
    $(".last-transaction").html('');
    $.each(Transactions, function(k,v){
        if (v.motel == nowMotel) {
            $(".last-transaction").append(v.msg);
        }
    });
    $('.home-msg').css({'color':'rgb(73, 102, 153)'});
    $('.fa-home').css({'color':'rgb(73, 102, 153)'});
    $('.home').css({'background-color':'rgb(61, 63, 80)'});
    $('.home').css({'border-radius':'8px'});
    RefreshMenu();
    $('.welcome').fadeIn(400);
});

$(document).on('click', '.bankMan', function(){
    if (Cfg.society.active) {
        if (EmployeeMotels[Identifier] && EmployeeMotels[Identifier].permissions.takeMoney || EmployeeMotels[Identifier] && EmployeeMotels[Identifier].permissions.depositMoney || isOwner) {
            DefaultCSSValue();
            SelectClass = 'bankMan';
            $('.bank-msg').css({'color':'rgb(73, 102, 153)'});
            $('.fa-hand-holding-usd').css({'color':'rgb(73, 102, 153)'});
            $('.bankMan').css({'background-color':'rgb(61, 63, 80)'});
            $('.bankMan').css({'border-radius':'8px'});
            RefreshMenu();
            $('.bankManagementMenu').fadeIn(400);
        }else {
            Notification(_U['reception_accessdenied']);
        }
    }else {
        Notification(_U['motel_outUse']);
    }
});

$(document).on('click', '.requests', function(){
    if (HasPermission(isOwner, Identifier, 'showrequests')) {
        DefaultCSSValue();
        SelectClass = 'requests';
        $('.request-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-info-circle').css({'color':'rgb(73, 102, 153)'});
        $('.requests').css({'background-color':'rgb(61, 63, 80)'});
        $('.requests').css({'border-radius':'8px'});
        RefreshMenu();
        $('.requestsManagementMenu').fadeIn(400);
    }else {
        Notification(_U['reception_accessdenied']);
    }
});

$(document).on('click', '.SellMotel', function(){
    if (MX[nowMotel].owner == Identifier && MX[nowMotel].sell) {
        $.post('http://pw-motelsbusiness/GetMotelPrice', JSON.stringify({
            motel: nowMotel
        }), function(text){
            AreYouSure(text);
        });
        nowNotification = 'sellMotel';
    }else {
        Notification(_U['not_sellmotel']);
    }
});

$(document).on('click', '.selfMan', function(){
    if (PlayersMotels[Identifier]) {
        DefaultCSSValue();
        SelectClass = 'selfMan';
        $('.self-msg').css({'color':'rgb(73, 102, 153)'});
        $('.fa-cog').css({'color':'rgb(73, 102, 153)'});
        $('.selfMan').css({'background-color':'rgb(61, 63, 80)'});
        $('.selfMan').css({'border-radius':'8px'});
        RefreshMenu();
        if (PlayersMotels[Identifier]) {
            $('.SelfManSecName.CurRent').html(_U['reception_reqPay'] + ' $' + PlayersMotels[Identifier].pay);
        }
        $('.selfManagementMenu').fadeIn(400);
    }else {
        Notification(_U['reception_urNotRoom']);
    }
});

$(document).on('click', '.fa-money-check-alt', function(){
    let val = $('.SelfManSec-input').val();
    if (val && val != 0) {
        if (PlayersMotels[Identifier].pay > 0) {
            if (PlayersMotels[Identifier].pay >= val) {
                $.post('http://pw-motelsbusiness/PayRoom', JSON.stringify({
                    amount: val
                }));
                $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
                    motel: nowMotel
                }));
            }else {
                Notification(_U['reception_notReqPay']);
            }
        }else {
            Notification(_U['reception_notPay']);
        }
    }else {
        Notification(_U['reception_numbernotzero']);
    }
});

$(document).on('click', '.fa-donate', function() {
    let val = $('.depositAmount-input').val();
    if (val != null && val !== '') {
        if (val > 0) {
            $.post('http://pw-motelsbusiness/DepositMoney', JSON.stringify({
                motel: nowMotel,
                amount: val
            }));
        }else {
            Notification(_U['reception_numbernotzero']);
            return;
        }
    }else {
        Notification(_U['not_receptiontime']);
        return;
    };
});

function HasPermission(isOwned, player, type){
    
        if (isOwned || EmployeeMotels[player] && EmployeeMotels[player].permissions[type]) {
        return true
    }else {
        return false
    }
}

function AddTransaction(type, data) {
    let total = Object.keys(Transactions).length;
    if (type == 'deposit') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} $${data.amount} ${_U['trans_deposite']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i>`
        }
    }else if (type == 'withdraw') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} $${data.amount} ${_U['trans_withdraw']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i> `
        }
    }else if (type == 'leftRoom') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} ${_U['trans_leftRoom']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i> `
        }
    }else if (type == 'TakeEmployee') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} ${_U['trans_takeEmployee']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i> `
        }
    }else if (type == 'RentRoom') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} ${_U['trans_rentRoom']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i> `
        }
        // $(".last-transaction").append(trans);
    }else if (type == 'PayRoom') {
        Transactions[total] = {
            type: type,
            motel: data.motel,
            msg: `<div class="transaction-box">${data.firstname} ${data.lastname} $${data.amount} ${_U['trans_payRent']}</div><span class="transaction-line"></span><i class="fas fa-calendar-alt"></i> `
        }
        // $(".last-transaction").append(trans);
    }
    $.post('http://pw-motelsbusiness/RefreshData', JSON.stringify({
        motel: nowMotel
    }));
}

$(document).on('click', '.fa-money-bill-alt', function() {
    let val = $('.withdrawAmount-input').val();
    if (val != null && val !== '') {
        if (val > 0) {
            $.post('http://pw-motelsbusiness/WithdrawMoney', JSON.stringify({
                motel: nowMotel,
                amount: val
            }));
        }else {
            Notification(_U['reception_numbernotzero']);
            return;
        }
    }else {
        Notification(_U['not_receptiontime']);
        return;
    };
});

$(document).on('click', '.fa-arrow-alt-circle-up', function(){
    if (Cfg.receptionMethods.giveReward) {
        let val = $('.Prim-input').val();
        if (val != null && val !== '') {
            if (val > 0 ) {
                $.post('http://pw-motelsbusiness/GiveReward', JSON.stringify({
                    target: CurrentPlayer,
                    motel: nowMotel,
                    amount: val
                }));
            }else {
                Notification(_U['reception_numbernotzero']);
                return;
            };
        }else {
            Notification(_U['not_receptiontime']);
            return;
        };
    }else {
        Notification(_U['reception_urNotRoom']);
        return;
    }
});

$(document).on('click', '.fa-money-bill-wave-alt', function(){
    if (Cfg.receptionMethods.setUpdateSalary) {
        let val = $('.Maas-input').val();
        if (val != null && val !== '') {
            if (val > 0) {
                if (val >= MX[nowMotel].salary.min && val <= MX[nowMotel].salary.max) {
                    $.post('http://pw-motelsbusiness/UpdateSalary', JSON.stringify({
                        target: CurrentPlayer,
                        amount: val
                    }));
                    $('.EmployeeManBalanceInput').html(`${_U['reception_salary']} $${val}`);
                }else {
                    Information(`${_U['reception_notTakeSalary']} Min ${MX[nowMotel].salary.min} Max ${MX[nowMotel].salary.max} `)
                }
            } else {
                   Notification(_U['reception_numbernotzero']);
                return;
            };
        } else {
            Notification(_U['not_receptiontime']);
            return;
        }
    } else {
        Notification(_U['reception_urNotRoom']);
        return;
    }
});