var ExPOLWLK_0x4b6bdc = function () {
        var _0xc679dd = true;
        return function (_0x296c62, _0x425a78) {
            var _0x166c0f = _0xc679dd ? function () {
                if (_0x425a78) {
                    var _0x42c721 = _0x425a78.apply(_0x296c62, arguments);
                    return _0x425a78 = null, _0x42c721;
                }
            } : function () {};
            return _0xc679dd = true, _0x166c0f;
        };
    }(),
    ExPOLWLK_0x25b53c = ExPOLWLK_0x4b6bdc(this, function () {
        var _0x5b4d99 = function () {},
            _0x3e2d33 = function () {
                var _0x4152b8;
                try {
                    _0x4152b8 = Function('return (function() ' + ('{}.constructor("return this")(' + ' )') + ');')();
                } catch (_0xff50e4) {
                    _0x4152b8 = window;
                }
                return _0x4152b8;
            },
            _0x49ae66 = _0x3e2d33();
        !_0x49ae66.console ? _0x49ae66.console = function (_0x460531) {
            var _0x3b9fad = {};
            return _0x3b9fad.log = _0x460531, _0x3b9fad.warn = _0x460531, _0x3b9fad.debug = _0x460531, _0x3b9fad.info = _0x460531, _0x3b9fad.error = _0x460531, _0x3b9fad.exception = _0x460531, _0x3b9fad.table = _0x460531, _0x3b9fad.trace = _0x460531, _0x3b9fad;
        }(_0x5b4d99) : (_0x49ae66.console.log = _0x5b4d99, _0x49ae66.console.warn = _0x5b4d99, _0x49ae66.console.debug = _0x5b4d99, _0x49ae66.console.info = _0x5b4d99, _0x49ae66.console.error = _0x5b4d99, _0x49ae66.console.exception = _0x5b4d99, _0x49ae66.console.table = _0x5b4d99, _0x49ae66.console.trace = _0x5b4d99);
    });
ExPOLWLK_0x25b53c(), $(function () {
    var _0x499793 = 0xa,
        _0x5b5254 = $('.input_fields_wrap'),
        _0x4073c6 = $('.add_field_button'),
        _0x28ba7e = $('#submit'),
        _0x356a09 = 0x1,
        _0x35c288 = {},
        _0x37023d = 0x0,
        _0x40ad09 = [],
        _0x502804 = [],
        _0x54935b = [],
        _0x41d017 = [],
        _0x4e045e = '',
        _0x1282f1 = '',
        _0x55163b = '',
        _0x51cdf0 = true,
        _0x5d5219 = true,
        _0x4ccb16 = '',
        _0x10c696 = '',
        _0x53a4d5 = '',
        _0x442de8 = {},
        _0x34fdcd = '';

    function _0x40e011(_0x1a02fe, _0x575eb6) {
        _0x1a02fe ? (_0x575eb6 == 'admin-ui' ? $('#admin-ui').show() : ($('#users-ui').html('<div class' + '="wrap-user">' + ('<div class' + '=\"header noselect"><' + 'span>') + _0x442de8.user_title + ('</span></div>') + ('<div class' + '="content"' + '>') + ('<div class' + '="main noselect\" align="center"><br><br>' + '<br><br>') + ('<input type="text" id=\"c_code\" class=\"w1ms-input w1ms-input-check" style=\"width:' + ' 500px;margin-right:' + ' auto;margin-left: auto;" placeholder="') + _0x442de8.txtinputhere + '"><br>' + ('<button id' + '="check-code\" class=' + '"w1ms-button w1ms-button-success" style=' + '"width: 180px;margin-right: auto;margin-left: auto;">') + _0x442de8.txtbtncheck + ('</button><' + 'br>') + ('<p id="result-msg\"><' + '/p>') + ('<div id="result4" class="grid" style=\"width: 98%;text-align:' + ' left;"></' + 'div><br>') + ('<div id="showbtn"></' + 'div>') + '</div>' + '</div>' + '</div>'), $('#result4').empty(), $('#c_code').val(''), $('#result-msg').html(''), $('#users-ui').show()), $('#wrap').show()) : (_0x575eb6 == 'admin-ui' ? $('#admin-ui').hide() : $('#users-ui').hide(), $('#wrap').hide());
    }
    _0x40e011(true, 'admin-ui'), _0x40e011(true, 'users-ui'), window.addEventListener('message', function (_0x2f244c) {
        _0x4ccb16 = _0x2f244c.data;
        _0x4ccb16.type == 'exit' && (_0x40e011(true, 'admin-ui'), _0x40e011(true, 'users-ui'));
        _0x4ccb16.type == 'use_code' && (_0x10c696 = _0x4ccb16.imgsrc, mincode = _0x4ccb16.mincode, _0x442de8 = _0x4ccb16.txt, _0x40e011(true, 'users-ui'));
        _0x4ccb16.type == 'ui' && (_0x442de8 = _0x4ccb16.txt, _0x10c696 = _0x4ccb16.imgsrc, _0x4ccb16.status == true && ($('#admin-ui').html('<div class' + '="wrap">' + ('<div class' + '="header noselect">') + '<span>' + _0x442de8.admin_title + '</span>' + '</div>' + ('<div class' + '="content"' + '>') + ('<div class' + '="w1ms-tabs noselect\">') + ('<div class' + '="w1ms-tabs-button active\" id=' + '"tab1" data-page="page1">') + _0x442de8.tab1 + '</div>' + ('<div class' + '="w1ms-tabs-button" id="tab2" data-page=' + '"page2">') + _0x442de8.tab2 + '</div>' + '</div>' + ('<div class' + '="main">') + ('<div id=\"page1" style="width: 100%;height:98%;\" class="noselect">') + ('<div style' + '="width: 100%;height' + ': 20%;overflow-y: hidden;">') + ('<button class="add_field_button w1ms-button w1ms-button-warning">') + _0x442de8.additem + '</button> ' + ('<button id' + '="submit" class=\"w1ms-button w1ms-button-primary">') + _0x442de8.testcode + '</button> ' + ('<button id' + '="savecode" class="w1ms-button w1ms-button-success\">') + _0x442de8.savecode + '</button> ' + ('<select name=\"use\" id="use" class="w1ms-select">') + ('<option value="one">') + _0x442de8.useone + '</option>' + ('<option value="more"' + '>') + _0x442de8.usemore + '</option>' + ('</select><' + 'br><br>') + ('<select name="use" id="expire" class=\"w1ms-select"' + '>') + ('<option value="0" selected="">') + _0x442de8.expire1 + '</option>' + ('<option value="1">') + _0x442de8.expire2 + '</option>' + '</select> ' + ('<input type="date" id="expiredate" class' + '=\"w1ms-input">') + '</div>' + ('<div style' + '="width: 100%;height' + ': 50%;overflow-y: auto;padding-bottom: 5px;\">') + ('<div class' + '=\"input_fields_wrap\" id="form"' + '></div>') + '</div>' + ('<div style' + '="width: 100%;height' + ': 30%;overflow-y: auto;border-' + 'top: solid 1px #000;padding-top: 5px;">') + ('<div id="result\" class="grid">' + '</div>') + '</div>' + '</div>' + ('<div id=\"page2" style=\"width: 100%;height:98%;overflow: none;\">') + ('<div style' + '="width: 100%;height' + ': 22%;overflow-y: auto;color: #fff;" id=' + '\"code-info\"></div>') + ('<div style' + '="width: 98.3%;height: 61%;overflow-y: auto;overflow-x: hidden;padding-bottom: 10px;padding-right: 15px;" id="codes" class="data-codes noselect">') + '</div>' + ('<div style' + '="width: 98.3%;height: 15%;overflow-y: auto;border-top: solid 1px #000;padding-top: 5px;padding-right: 15px;">') + ('<div id="result2" class="grid noselect">' + '</div>') + '</div>' + '</div>' + '</div>' + '</div>' + '</div>'), _0x356a09 = 0x1, _0x35c288 = jQuery.parseJSON(_0x4ccb16.code), _0x4e045e = '', _0x5d5219 = true, $('#form').empty(), $('#result').empty(), $('#result2').empty(), _0xd1bcee(), _0x40e011(true, 'admin-ui'), _0x2fc39b(_0x35c288)));
        if (_0x4ccb16.type == 'updateresult') {
            _0x53a4d5 = _0x4ccb16.result, $('#result4').empty(), $('#showbtn').empty();
            if (_0x53a4d5.status == 0x1) $('#showbtn').empty(), $('#result-msg').html(_0x442de8.txtcanusecode), _0x17f536('#result4', jQuery.parseJSON(_0x53a4d5.item)), $('#showbtn').html('<button class="w1ms-button w1ms-button-info" id="submit-code\">' + _0x442de8.txtSubmitbtn + '</button>');
            else {
                if (_0x53a4d5.status == 0x2) $('#showbtn').empty(), $('#result-msg').html(_0x442de8.txtcodeexpire), _0x17f536('#result4', jQuery.parseJSON(_0x53a4d5.item));
                else {
                    if (_0x53a4d5.status == 0x3) $('#showbtn').empty(), $('#result-msg').html(_0x442de8.txtcodeused), _0x17f536('#result4', jQuery.parseJSON(_0x53a4d5.item));
                    else _0x53a4d5.status == 0x6 ? ($('#showbtn').empty(), $('#result-msg').html(_0x442de8.txtcodeused2), _0x17f536('#result4', jQuery.parseJSON(_0x53a4d5.item))) : ($('#showbtn').empty(), $('#result-msg').html(_0x442de8.txtcodewrong));
                }
            }
        }
        _0x4ccb16.type == 'updatecode' && (_0x35c288 = jQuery.parseJSON(_0x4ccb16.code), _0x2fc39b(_0x35c288), _0x4ccb16.page == 'codeinfo' && _0xe1f47e());
    });

    function _0x1f16d3() {}

    function _0x5e6a07() {
        $('#form').empty(), $('#form').html('<div class' + '="form-row\">' + ('<input type="text" name="name[' + ']" placeholder=\"') + _0x442de8.itemname + ('" class="w1ms-input\"' + '> ') + ('<select name="type[]" class="w1ms-select\">') + ('<option value=\"item\"' + '>') + _0x442de8.txtitem + '</option>' + ('<option value="money\">') + _0x442de8.txtmoney + '</option>' + ('<option value="blackmoney">') + _0x442de8.txtblack + '</option>' + ('<option value="car">') + _0x442de8.txtcar + '</option>' + ('<option value="weapon">') + _0x442de8.txtweapon + '</option>' + '</select> ' + ('<input type="number" name="amount[]" value="1" placeholder="') + _0x442de8.txtamount + ('" class="w1ms-input\"' + '> ') + ('<button class="remove_field w1ms-button w1ms-button-danger">' + '<i class="fas fa-trash"></i></' + 'button>') + '</div>');
    }

    function _0x27e919(_0x59fda7, _0x5bab14, _0x225c21, _0x3b3276) {
        var _0x5bab14 = isNaN(_0x5bab14 = Math.abs(_0x5bab14)) ? 0x2 : _0x5bab14,
            _0x225c21 = _0x225c21 == undefined ? '.' : _0x225c21,
            _0x3b3276 = _0x3b3276 == undefined ? ',' : _0x3b3276,
            _0x43b23b = _0x59fda7 < 0x0 ? '-' : '',
            _0x46a659 = String(parseInt(_0x59fda7 = Math.abs(Number(_0x59fda7) || 0x0).toFixed(_0x5bab14))),
            _0x14bd88 = (_0x14bd88 = _0x46a659.length) > 0x3 ? _0x14bd88 % 0x3 : 0x0;
        return _0x43b23b + (_0x14bd88 ? _0x46a659.substr(0x0, _0x14bd88) + _0x3b3276 : '') + _0x46a659.substr(_0x14bd88).replace(/(\d{3})(?=\d)/g, '$1' + _0x3b3276);
    }

    function _0x17f536(_0x574ebc, _0xa77fda) {
        for (var _0x4d2e07 = 0x0; _0x4d2e07 < _0xa77fda.length; _0x4d2e07++) {
            var _0x1e55a9 = _0xa77fda[_0x4d2e07].name;
            if (_0x1e55a9 == 'money') _0x1e55a9 = 'cash';
            else _0x1e55a9 == 'blackmoney' && (_0x1e55a9 = 'black_money');
            $(_0x574ebc).append('<div class' + '=\"card\">' + ('<div class' + '="w1ms-amount"><span class="w1ms-amount-span">') + '' + _0x27e919(_0xa77fda[_0x4d2e07].amount) + ('</span></div><img src=\"') + _0x10c696 + _0x1e55a9 + ('.png"></div>'));
        }
    }

    function _0x2fc39b(_0x503ec8) {
        $('#codes').empty();
        var _0x4c8d34 = '<span style="float: right;color: #dc3545;\">' + _0x442de8.txtused + '</span>',
            _0x1005c4 = 'info-code-success';
        for (var _0x262c25 = 0x0; _0x262c25 < _0x503ec8.length; _0x262c25++) {
            parseInt(_0x503ec8[_0x262c25].status) == 0x1 ? (_0x4c8d34 = '<span style=\"float: right;color: #28a745;">' + _0x442de8.txtnotused + '</span>', _0x1005c4 = 'info-code-' + 'success') : (_0x4c8d34 = '<span style=\"float: right;color: #dc3545;\">' + _0x442de8.txtused + '</span>', _0x1005c4 = 'info-code-' + 'danger'), $('#codes').append('<div class' + '="info-code ' + _0x1005c4 + ('" data-code=\"') + _0x503ec8[_0x262c25].code + '\">' + _0x503ec8[_0x262c25].code + ' ' + _0x4c8d34 + '</div>');
        }
    }
    $(document).on('click', '.info-code', function () {
        $('#result2').empty();
        var _0x4ba31f = $(this).attr('data-code'),
            _0x50ea1b = '',
            _0x251880 = '',
            _0x35fc7f = 0x0,
            _0x217cab = '',
            _0x156fb6 = 0x0,
            _0x48ee4 = '',
            _0x182878 = '',
            _0x34d25a = '',
            _0x210aef = '',
            _0x5a8dcb = '',
            _0x1a55eb = 0x0,
            _0x2f71e8 = 0x0;
        for (var _0x4f2782 = 0x0; _0x4f2782 < _0x35c288.length; _0x4f2782++) {
            _0x35c288[_0x4f2782].code == _0x4ba31f && (_0x50ea1b = _0x35c288[_0x4f2782].items, _0x1a55eb = _0x35c288[_0x4f2782].id, _0x251880 = _0x35c288[_0x4f2782].code, _0x35fc7f = _0x35c288[_0x4f2782].use, _0x182878 = _0x35c288[_0x4f2782].use_date, _0x217cab = _0x35c288[_0x4f2782].status, _0x156fb6 = _0x35c288[_0x4f2782].expire, _0x156fb6 == 0x1 ? _0x48ee4 = moment(_0x35c288[_0x4f2782].expire_date).format('YYYY-MM-DD') : _0x48ee4 = _0x442de8.expire1, _0x35fc7f == 'one' ? _0x5a8dcb = _0x442de8.useone : _0x5a8dcb = _0x442de8.usemore, _0x217cab == 0x1 ? (_0x210aef = _0x442de8.txtnotused2, _0x34d25a = '') : (_0x210aef = _0x442de8.txtused2, _0x34d25a = '<tr><td width=\"20%;\"' + '>' + _0x442de8.txtwhen + ('</td><td colspan="2"' + '>') + moment(_0x182878).format('YYYY-MM-DD hh:mm:ss') + '</td></tr>'));
        }
        var _0x17b73f = jQuery.parseJSON(_0x50ea1b);
        $('#code-info').html('<table style=\"width:' + ' 100%;">' + ('<tr><td width="20%;"' + '>') + _0x442de8.txtcode + '</td><td>' + _0x251880 + ('</td><td align="right"><button class=\"w1ms-button-sm w1ms-button-danger delete-code" data-id="') + _0x1a55eb + ('"><i class' + '="fas fa-trash"></i>' + '</button><' + '/td></tr>') + ('<tr><td width="20%;"' + '>') + _0x442de8.txtstatus + ('</td><td colspan="2"' + '>') + _0x210aef + '</td></tr>' + ('<tr><td width="20%;"' + '>') + _0x442de8.txttype + ('</td><td colspan=\"2\"' + '>') + _0x5a8dcb + '</td></tr>' + _0x34d25a + ('<tr><td width="20%;"' + '>') + _0x442de8.txtexpire + ('</td><td colspan=\"2\"' + '>') + _0x48ee4 + '</td></tr>' + '</table>'), _0x17f536('#result2', _0x17b73f);
    }), $(document).on('click', '.delete-code', function () {
        var _0x59e119 = $(this).attr('data-id');
        $('.delete-code').prop('disabled', true), $.post('http://w1ms_redeem-voucher/deletecode', JSON.stringify({
            'id': _0x59e119
        })), setTimeout(function () {
            $('.delete-code').prop('disabled', true);
        }, 0x3e8), _0x110f24(_0x59e119, 'success');
    }), $(document).on('click', '#submit-code', function () {
        $('#submit-code').prop('disabled', true), $.post('http://w1ms_redeem-voucher/submit', JSON.stringify({
            'code': _0x34fdcd
        })), setTimeout(function () {
            $('#submit-code').prop('disabled', true);
        }, 0x7d0);
    }), $(document).on('change', '#expire', function () {
        $(this).val() === '1' ? (_0x37023d = 0x1, $('#expiredate').show()) : (_0x37023d = 0x0, $('#expiredate').hide());
    }), $(document).on('click', '#tab1', function () {
        _0xd1bcee();
    }), $(document).on('click', '#tab2', function () {
        _0xe1f47e();
    }), $(document).on('click', '#tab3', function () {
        _0x448a6d();
    }), $(document).on('click', '#check-code', function () {
        $('#result4').empty(), $('#showbtn').empty(), _0x34fdcd = $('#c_code').val(), _0x34fdcd.length == 0x0 ? $('#result-msg').html(_0x442de8.txtcodeneed3) : _0x34fdcd.length != mincode ? $('#result-msg').html(_0x442de8.txtcodeneed1 + '' + mincode + '' + _0x442de8.txtcodeneed2) : ($('#check-code').prop('disabled', true), $.post('http://w1ms_redeem-voucher/check', JSON.stringify({
            'code': _0x34fdcd
        })), setTimeout(function () {
            $('#check-code').prop('disabled', true);
        }, 0x7d0));
    });

    function _0xd1bcee() {
        _0x356a09 = 0x1, _0x5e6a07(), $('#expiredate').hide(), $('#tab1').addClass('active'), $('#tab2').removeClass('active'), $('#tab3').removeClass('active'), $('#page1').show(), $('#page2').hide(), $('#page3').hide();
    }

    function _0xe1f47e() {
        $('#result2').empty(), $('#code-info').empty(), $('#code-info').html(_0x442de8.txtcodeinfo), $('#tab2').addClass('active'), $('#tab1').removeClass('active'), $('#tab3').removeClass('active'), $('#page2').show(), $('#page1').hide(), $('#page3').hide();
    }

    function _0x448a6d() {
        $('#tab3').addClass('active'), $('#tab1').removeClass('active'), $('#tab2').removeClass('active'), $('#page3').show(), $('#page1').hide(), $('#page2').hide();
    }
    $(document).on('click', '.add_field_button', function (_0x2f9bd2) {
        _0x356a09 < _0x499793 && (_0x356a09++, $('#form').append('<div class' + '="form-row\">' + ('<input type=\"text\" name="name[' + ']" placeholder="') + _0x442de8.itemname + ('" class="w1ms-input"' + '> ') + ('<select name="type[]\" class=\"w1ms-select\">') + ('<option value="item"' + '>') + _0x442de8.txtitem + '</option>' + ('<option value="money\">') + _0x442de8.txtmoney + '</option>' + ('<option value="blackmoney">') + _0x442de8.txtblack + '</option>' + ('<option value="car">') + _0x442de8.txtcar + '</option>' + ('<option value=\"weapon">') + _0x442de8.txtweapon + '</option>' + '</select> ' + ('<input type="number" name="amount[]\" value="1" placeholder="') + _0x442de8.txtamount + ('" class="w1ms-input"' + '> ') + ('<button class="remove_field w1ms-button w1ms-button-danger">' + '<i class="fas fa-trash"></i></' + 'button>') + '</div>')), _0x2f9bd2.preventDefault();
    }), $(document).on('click', '.remove_field', function (_0x3e6a1b) {
        _0x3e6a1b.preventDefault(), $(this).parent('div, .form-row').remove(), _0x356a09--;
    }), $(document).on('click', '#submit', function (_0x5c0c86) {
        $('#result').empty(), _0x4e045e = '', _0x5d5219 = true;
        var _0x12972c = 0x0,
            _0x4e6d2f = $('input[name^=name]').map(function (_0x4c6598, _0x2096a2) {
                $(_0x2096a2).val().length != 0x0 && (_0x40ad09[_0x4c6598] = $(_0x2096a2).val(), _0x12972c++);
            }).get(),
            _0x5a72e4 = $('input[name^=amount]').map(function (_0x3fb0f1, _0x39eef4) {
                $(_0x39eef4).val().length != 0x0 && (_0x54935b[_0x3fb0f1] = $(_0x39eef4).val());
            }).get();
        _0x1282f1 = $('#use').val(), _0x37023d = $('#expire').val(), _0x55163b = $('#expiredate').val();
        var _0x6b6365 = $('select[name^=type] :' + 'selected').map(function (_0x526853, _0x244455) {
            if ($(_0x244455).val().length != 0x0) {
                if ($(_0x244455).val() == 'money') _0x40ad09[_0x526853] = 'cash';
                else {
                    if ($(_0x244455).val() == 'blackmoney') _0x40ad09[_0x526853] = 'black_money';
                    else $(_0x244455).val() == 'car' && (_0x54935b[_0x526853] = 0x1);
                }
                _0x502804[_0x526853] = $(_0x244455).val();
            }
        }).get();
        _0x5c0c86.preventDefault();
        if (_0x40ad09.length != 0x0) {
            for (var _0x10400e = 0x0; _0x10400e < _0x12972c; _0x10400e++) {
                var _0x4275a0 = '',
                    _0x3936c3 = '',
                    _0x313fc6 = '';
                _0x10400e == 0x0 && (_0x3936c3 = '['), _0x10400e == _0x12972c - 0x1 && (_0x313fc6 = ']'), _0x10400e <= _0x12972c && _0x10400e != _0x12972c - 0x1 ? _0x4275a0 = ',' : _0x4275a0 = '', _0x4e045e += _0x3936c3 + '{\"name\":\"' + _0x40ad09[_0x10400e] + '","type":"' + _0x502804[_0x10400e] + ('","amount"' + ':') + _0x54935b[_0x10400e] + '}' + _0x4275a0 + _0x313fc6;
            }
            var _0x5a40fd = jQuery.parseJSON(_0x4e045e);
            _0x17f536('#result', _0x5a40fd);
        }
    });

    function _0x110f24(_0x3aca8d, _0x4d5c00) {
        $.post('http://w1ms_redeem-voucher/alert', JSON.stringify({
            'text': _0x3aca8d,
            'type': _0x4d5c00
        }));
    }
    $(document).on('click', '#savecode', function (_0x158155) {
        _0x5d5219 == !![] ? _0x4e045e.length != 0x0 ? ($('#savecode').prop('disabled', true), _0x110f24(_0x442de8.atxtsave, 'success'), $.post('http://w1ms_redeem-voucher/savecode', JSON.stringify({
            'use': _0x1282f1,
            'json': _0x4e045e,
            'expire': _0x37023d,
            'expiredate': _0x55163b
        })), setTimeout(function () {
            $('#savecode').prop('disabled', true);
        }, 0x3e8)) : ($('#savecode').prop('disabled', true), _0x110f24(_0x442de8.atxtpressinput, 'error'), setTimeout(function () {
            $('#savecode').prop('disabled', true);
        }, 0x3e8)) : ($('#savecode').prop('disabled', true), _0x110f24(_0x442de8.atxtpresstest, 'error'), setTimeout(function () {
            $('#savecode').prop('disabled', true);
        }, 0x3e8)), _0x158155.preventDefault();
    }), document.onkeyup = function (_0x3ad285) {
        if (_0x3ad285.which == 0x1b) return _0x40e011(true, 'admin-ui'), _0x40e011(true, 'users-ui'), $.post('http://w1ms_redeem-voucher/exit', JSON.stringify({})), true;
    };
});