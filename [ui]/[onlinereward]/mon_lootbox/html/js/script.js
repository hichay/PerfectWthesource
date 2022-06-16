var _0x42f3 = ['start', 'data', 'wheel', 'target', 'duration', 'vehicle', 'Sdzzb', 'RtTMy', './images/vehicle/', 'attr', 'src', 'append', '<text></text>', 'background', 'color', 'gray', 'name', '<div></div>', './sound/roll.mp3', 'fadeIn', 'sJxyi', '70%', '100%', 'font-size', '0vw', 'ZULce', 'click', '://', 'hap', './sound/unbox.mp3', 'animate', 'easeInOutCubic', 'exqmH', 'KwPEn', 'clone', '0.5s', 'absolute', '50%', 'translate(-50%,-50%)', 'animation', 'white-glow 2s linear infinite', './sound/preview.mp3', 'text', 'Nhận được ', '1.5vw', 'EXoAg', 'gvQbD', 'TrDHB', 'run', 'nLnMX', 'IAZSG', 'ready', 'GPpBI', 'kdFrG', 'message', './sound/', 'play', 'volume', 'each', 'Bogvy', 'RFsyr', '.exit-button', 'fadeOut', '.bg', 'remove', 'css', '.container', 'height', '.wheel', 'empty', '.receive-text', 'hide', 'post', 'https', 'sco', 'gac', 'on/', 'stringify', 'chance', 'push', 'random', 'ECmps', 'ExeML', 'log', 'bottom', 'ZsTWt', 'fohlU', '<div class="box"></div>', '<img>', 'type', 'item', 'WHRGT', 'aHlDn', 'image', '.png', 'width', 'money', 'jMUWX', './images/items/', 'action'];
(function(_0x536072, _0x2efb) {
    var _0xe5fb4a = function(_0x524d83) {
        while (--_0x524d83) {
            _0x536072['push'](_0x536072['shift']());
        }
    };
    _0xe5fb4a(++_0x2efb);
}(_0x42f3, 0xff));
var _0x3f11 = function(_0x521dba, _0x23a0ea) {
    _0x521dba = _0x521dba - 0x0;
    var _0x1f7986 = _0x42f3[_0x521dba];
    return _0x1f7986;
};
var display_item;

function PlaySound(_0x18760f, _0x30f180) {
    var _0x357258 = new Howl({
        'src': [_0x3f11('0x0') + _0x18760f],
        'volume': 0x1
    });
    var _0x30f180 = _0x30f180 !== undefined ? _0x30f180 : 0.5;
    console['log'](_0x3f11('0x1'));
    _0x357258[_0x3f11('0x2')](_0x30f180);
    _0x357258[_0x3f11('0x1')]();
}

function randF(_0x5c8c01) {
    var _0x131e91 = [];
    var _0x37d6b1 = 0x0;
    $[_0x3f11('0x3')](_0x5c8c01, function(_0x3454e0, _0x3f5471) {
        if (_0x3f11('0x4') === _0x3f11('0x5')) {
            $(_0x3f11('0x6'))[_0x3f11('0x7')](0xfa);
            $(_0x3f11('0x8'))['fadeOut'](0xfa, function() {
                display_item[_0x3f11('0x9')]();
                $('.container')[_0x3f11('0xa')]('width', '0%');
                $(_0x3f11('0xb'))[_0x3f11('0xa')](_0x3f11('0xc'), '0%');
                $(_0x3f11('0xd'))[_0x3f11('0xe')]();
                $(_0x3f11('0xf'))[_0x3f11('0x10')]();
            });
            $[_0x3f11('0x11')](_0x3f11('0x12') + '://' + 'm' + 'on' + '_' + 'loo' + 'tbox' + '/' + 'Close', JSON[_0x3f11('0x16')]({}));
        } else {
            var _0x1b98f6 = _0x3f5471[_0x3f11('0x17')];
            var _0x3078d3 = _0x37d6b1;
            _0x37d6b1 += _0x1b98f6;
            _0x131e91[_0x3f11('0x18')]({
                'bottom': _0x3078d3,
                'chance': _0x37d6b1
            });
        }
    });
    var _0x26a563 = Math[_0x3f11('0x19')]() * _0x37d6b1;
    var _0x28f3a6;
    $[_0x3f11('0x3')](_0x131e91, function(_0x55485b, _0x2b70b1) {
        if (_0x3f11('0x1a') === _0x3f11('0x1b')) {
            var _0x4ffad7 = new Howl({
                'src': [_0x3f11('0x0') + path],
                'volume': 0x1
            });
            var _0x1ada51 = _0x1ada51 !== undefined ? _0x1ada51 : 0.5;
            console[_0x3f11('0x1c')](_0x3f11('0x1'));
            _0x4ffad7[_0x3f11('0x2')](_0x1ada51);
            _0x4ffad7[_0x3f11('0x1')]();
        } else {
            if (_0x26a563 > _0x2b70b1[_0x3f11('0x1d')] && _0x26a563 <= _0x2b70b1[_0x3f11('0x17')]) {
                if (_0x3f11('0x1e') === _0x3f11('0x1e')) {
                    _0x28f3a6 = _0x5c8c01[_0x55485b];
                } else {
                    if (_0x26a563 > _0x2b70b1[_0x3f11('0x1d')] && _0x26a563 <= _0x2b70b1['chance']) {
                        _0x28f3a6 = _0x5c8c01[_0x55485b];
                    }
                }
            }
        }
    });
    return _0x28f3a6;
}

function GenerateWheel(_0xde0ccd, _0x4da209) {
    var _0x2651bb = [];
    var _0xf71e7e;
    for (_0xf71e7e = 0x0; _0xf71e7e < 0x64; _0xf71e7e++) {
        if ('agmBL' === 'agmBL') {
            var _0x3da0c1 = randF(_0xde0ccd);
            if (_0xf71e7e == 0x4e) {
                if (_0x3f11('0x1f') === 'BXyKz') {
                    var _0x25ef81 = [];
                    var _0x1d45a2 = 0x0;
                    $[_0x3f11('0x3')](_0xde0ccd, function(_0x15cd1c, _0x4f9603) {
                        var _0x5826b6 = _0x4f9603[_0x3f11('0x17')];
                        var _0xab063f = _0x1d45a2;
                        _0x1d45a2 += _0x5826b6;
                        _0x25ef81[_0x3f11('0x18')]({
                            'bottom': _0xab063f,
                            'chance': _0x1d45a2
                        });
                    });
                    var _0x4ebe73 = Math['random']() * _0x1d45a2;
                    var _0x3bd073;
                    $[_0x3f11('0x3')](_0x25ef81, function(_0x3c59b2, _0x3b154f) {
                        if (_0x4ebe73 > _0x3b154f[_0x3f11('0x1d')] && _0x4ebe73 <= _0x3b154f[_0x3f11('0x17')]) {
                            _0x3bd073 = _0xde0ccd[_0x3c59b2];
                        }
                    });
                    return _0x3bd073;
                } else {
                    _0x3da0c1 = _0xde0ccd[_0x4da209];
                }
            }
            var _0x42ffc9 = $('<div class="item"></div>');
            var _0x56af88 = $(_0x3f11('0x20'));
            var _0x4b3b2a = $(_0x3f11('0x21'));
            var _0xbaf78 = '';
            if (_0x3da0c1[_0x3f11('0x22')] == _0x3f11('0x23')) {
                if (_0x3f11('0x24') !== _0x3f11('0x25')) {
                    _0xbaf78 = './images/items/' + (_0x3da0c1[_0x3f11('0x26')] ? _0x3da0c1[_0x3f11('0x26')] : _0x3da0c1[_0x3f11('0x23')]) + _0x3f11('0x27');
                    _0x4b3b2a[_0x3f11('0xa')](_0x3f11('0x28'), '70%');
                } else {
                    _0x3da0c1 = _0xde0ccd[_0x4da209];
                }
            } else if (_0x3da0c1['type'] == _0x3f11('0x29')) {
                if (_0x3f11('0x2a') === _0x3f11('0x2a')) {
                    _0xbaf78 = _0x3f11('0x2b') + (_0x3da0c1[_0x3f11('0x26')] ? _0x3da0c1[_0x3f11('0x26')] : _0x3da0c1[_0x3f11('0x29')]) + '.png';
                } else {
                    if (event['data'][_0x3f11('0x2c')] == _0x3f11('0x2d')) {
                        var _0x8e6a7e = event[_0x3f11('0x2e')][_0x3f11('0x2f')];
                        var _0x4d7965 = event[_0x3f11('0x2e')][_0x3f11('0x30')];
                        var _0x3355ec = event[_0x3f11('0x2e')][_0x3f11('0x31')];
                        StartWheel(_0x8e6a7e, _0x4d7965 - 0x1, _0x3355ec);
                    }
                }
            } else if (_0x3da0c1[_0x3f11('0x22')] == _0x3f11('0x32')) {
                if (_0x3f11('0x33') !== _0x3f11('0x34')) {
                    _0xbaf78 = _0x3f11('0x35') + (_0x3da0c1[_0x3f11('0x26')] ? _0x3da0c1[_0x3f11('0x26')] : _0x3da0c1[_0x3f11('0x32')]) + _0x3f11('0x27');
                } else {
                    first = ![];
                }
            }
            _0x4b3b2a[_0x3f11('0x36')](_0x3f11('0x37'), _0xbaf78);
            _0x56af88['append'](_0x4b3b2a);
            _0x42ffc9[_0x3f11('0x38')](_0x56af88);
            var _0x111b61 = $(_0x3f11('0x39'));
            _0x111b61[_0x3f11('0xa')](_0x3f11('0x3a'), _0x3da0c1['color'] ? _0x3da0c1[_0x3f11('0x3b')] : _0x3f11('0x3c'));
            var _0x3fd6cd = $('<span></span>');
            _0x3fd6cd['text'](_0x3da0c1[_0x3f11('0x3d')]);
            var _0x4dfc97 = $(_0x3f11('0x3e'));
            _0x111b61[_0x3f11('0x38')](_0x4dfc97);
            _0x111b61[_0x3f11('0x38')](_0x3fd6cd);
            _0x42ffc9[_0x3f11('0x38')](_0x111b61);
            $(_0x3f11('0xd'))['append'](_0x42ffc9);
            _0x2651bb[_0x3f11('0x18')](_0x42ffc9);
            _0x42ffc9[_0x3f11('0x36')]('name', _0x3da0c1[_0x3f11('0x3d')]);
        } else {
            var _0x29419f = new Audio(_0x3f11('0x3f'));
            _0x29419f[_0x3f11('0x2')] = 0.2;
            _0x29419f[_0x3f11('0x1')]();
        }
    }
    return _0x2651bb;
}

function StartWheel(_0x119933, _0x1dcf53, _0x93765) {
    $(_0x3f11('0x8'))[_0x3f11('0x40')](0xfa, function() {
        if (_0x3f11('0x41') === 'BOLmr') {
            sc = _0x3f11('0x2b') + (v[_0x3f11('0x26')] ? v['image'] : v[_0x3f11('0x23')]) + _0x3f11('0x27');
            img[_0x3f11('0xa')](_0x3f11('0x28'), _0x3f11('0x42'));
        } else {
            $(_0x3f11('0xb'))[_0x3f11('0xa')](_0x3f11('0x28'), _0x3f11('0x43'));
            $(_0x3f11('0xb'))[_0x3f11('0xa')](_0x3f11('0xc'), '25%');
            $(_0x3f11('0xf'))[_0x3f11('0x10')]();
            $(_0x3f11('0xf'))['css'](_0x3f11('0x44'), _0x3f11('0x45'));
            var _0x3a0c64 = GenerateWheel(_0x119933, _0x1dcf53);
            setTimeout(function() {
                if (_0x3f11('0x46') !== 'ZULce') {
                    $('.exit-button')[_0x3f11('0x47')](function() {
                        $(_0x3f11('0x6'))[_0x3f11('0x7')](0xfa);
                        $(_0x3f11('0x8'))[_0x3f11('0x7')](0xfa, function() {
                            display_item['remove']();
                            $(_0x3f11('0xb'))[_0x3f11('0xa')](_0x3f11('0x28'), '0%');
                            $('.container')[_0x3f11('0xa')](_0x3f11('0xc'), '0%');
                            $(_0x3f11('0xd'))[_0x3f11('0xe')]();
                            $(_0x3f11('0xf'))['hide']();
                        });
						 
                        $['post'](_0x3f11('0x12') + 's://' + 'm' + 'on' + '_' + 'loo' + 'tbox' + '/' + 'Close', JSON[_0x3f11('0x16')]({}));
                    });
                } else {
                    var _0x1dcf53 = _0x3a0c64[0x4e];
                    var _0x5ce9ce = $('.wheel')['width']();
                    var _0x5bc6f7 = _0x1dcf53['width']() + 0xa;
                    var _0xe1b96b = _0x5bc6f7 * 0x4e - _0x5ce9ce / 0x2 + _0x5bc6f7 * 0.025;
                    var _0x3fef18 = _0x5bc6f7 * 0.95;
                    _0xe1b96b += Math[_0x3f11('0x19')]() * _0x3fef18;
                    var _0x5b605e = new Audio(_0x3f11('0x4a'));
                    _0x5b605e['volume'] = 0.4;
                    _0x5b605e[_0x3f11('0x1')]();
                    var _0x5b3f1c = !![];
                    var _0x1ae495 = $('.wheel-pin');
                    $(_0x3f11('0xd'))[_0x3f11('0x4b')]({
                        'scrollLeft': _0xe1b96b
                    }, {
                        'duration': _0x93765 !== undefined ? _0x93765 : 0x1770,
                        'easing': _0x3f11('0x4c'),
                        'complete': function() {
                            if (_0x3f11('0x4d') !== _0x3f11('0x4e')) {
                                display_item = _0x1dcf53[_0x3f11('0x4f')]();
                                display_item[_0x3f11('0xa')]({
                                    'width': '0',
                                    'height': '0',
                                    'transition': _0x3f11('0x50'),
                                    'position': _0x3f11('0x51'),
                                    'left': '50%',
                                    'top': _0x3f11('0x52'),
                                    'transform': _0x3f11('0x53')
                                });
                                $(_0x3f11('0x8'))[_0x3f11('0x38')](display_item);
                                display_item[_0x3f11('0xa')](_0x3f11('0x28'), _0x1dcf53['width']() * 1.5);
                                display_item[_0x3f11('0xa')](_0x3f11('0xc'), _0x1dcf53[_0x3f11('0xc')]() * 1.5);
                                display_item['css'](_0x3f11('0x54'), _0x3f11('0x55'));
                                var _0x5b605e = new Audio(_0x3f11('0x56'));
                                _0x5b605e[_0x3f11('0x2')] = 0.35;
                                _0x5b605e[_0x3f11('0x1')]();
                                $('.receive-text')[_0x3f11('0x57')](_0x3f11('0x58') + _0x1dcf53['attr']('name') + '!');
                                $(_0x3f11('0xf'))[_0x3f11('0x40')](0x12c);
                                $(_0x3f11('0xf'))[_0x3f11('0xa')](_0x3f11('0x44'), _0x3f11('0x59'));
                                $('.exit-button')[_0x3f11('0x40')](0x1f4);
                            } else {
                                display_item['remove']();
                                $(_0x3f11('0xb'))[_0x3f11('0xa')](_0x3f11('0x28'), '0%');
                                $(_0x3f11('0xb'))[_0x3f11('0xa')]('height', '0%');
                                $(_0x3f11('0xd'))[_0x3f11('0xe')]();
                                $('.receive-text')['hide']();
                            }
                        },
                        'progress': function(_0x276e27, _0x5a2f21, _0x4fda84) {
                            if (_0x3f11('0x5a') !== 'MjdkV') {
                                var _0x155479 = $(this)['scrollLeft']();
                                var _0x111c33 = 0x0;
                                for (_0x111c33 = 0x0; _0x111c33 < 0x64; _0x111c33++) {
                                    if (_0x3f11('0x5b') === 'gvQbD') {
                                        var _0x45ac82 = _0x3a0c64[_0x111c33];
                                        var _0xd7810b = _0x5bc6f7 * (_0x111c33 + 0x1) - _0x5ce9ce / 0x2;
                                        var _0xc5091c = _0xd7810b;
                                        if (!_0x3a0c64[_0x111c33]['run'] && _0x155479 < _0xc5091c && _0x155479 > _0xc5091c - _0x5bc6f7) {
                                            if (_0x3f11('0x5c') === _0x3f11('0x5c')) {
                                                _0x3a0c64[_0x111c33][_0x3f11('0x5d')] = !![];
                                                if (!_0x5b3f1c) {
                                                    if (_0x3f11('0x5e') !== _0x3f11('0x5e')) {
                                                        sc = _0x3f11('0x2b') + (v[_0x3f11('0x26')] ? v[_0x3f11('0x26')] : v[_0x3f11('0x29')]) + _0x3f11('0x27');
                                                    } else {
                                                        var _0x5b605e = new Audio('./sound/roll.mp3');
                                                        _0x5b605e[_0x3f11('0x2')] = 0.2;
                                                        _0x5b605e[_0x3f11('0x1')]();
                                                    }
                                                } else {
                                                    if (_0x3f11('0x5f') === _0x3f11('0x5f')) {
                                                        _0x5b3f1c = ![];
                                                    } else {
                                                        var _0x14fd22 = v[_0x3f11('0x17')];
                                                        var _0xe53d42 = _0x3fef18;
                                                        _0x3fef18 += _0x14fd22;
                                                        tbl_chance['push']({
                                                            'bottom': _0xe53d42,
                                                            'chance': _0x3fef18
                                                        });
                                                    }
                                                }
                                                break;
                                            } else {
                                                var _0x1dc14b = event[_0x3f11('0x2e')][_0x3f11('0x2f')];
                                                var _0x1cf6f6 = event['data'][_0x3f11('0x30')];
                                                var _0x3ac91a = event[_0x3f11('0x2e')][_0x3f11('0x31')];
                                                StartWheel(_0x1dc14b, _0x1cf6f6 - 0x1, _0x3ac91a);
                                            }
                                        }
                                    } else {
                                        display_item = _0x1dcf53[_0x3f11('0x4f')]();
                                        display_item[_0x3f11('0xa')]({
                                            'width': '0',
                                            'height': '0',
                                            'transition': '0.5s',
                                            'position': _0x3f11('0x51'),
                                            'left': _0x3f11('0x52'),
                                            'top': _0x3f11('0x52'),
                                            'transform': _0x3f11('0x53')
                                        });
                                        $(_0x3f11('0x8'))['append'](display_item);
                                        display_item[_0x3f11('0xa')](_0x3f11('0x28'), _0x1dcf53[_0x3f11('0x28')]() * 1.5);
                                        display_item[_0x3f11('0xa')](_0x3f11('0xc'), _0x1dcf53[_0x3f11('0xc')]() * 1.5);
                                        display_item[_0x3f11('0xa')](_0x3f11('0x54'), _0x3f11('0x55'));
                                        var _0x408d23 = new Audio(_0x3f11('0x56'));
                                        _0x408d23[_0x3f11('0x2')] = 0.35;
                                        _0x408d23[_0x3f11('0x1')]();
                                        $(_0x3f11('0xf'))[_0x3f11('0x57')](_0x3f11('0x58') + _0x1dcf53[_0x3f11('0x36')]('name') + '!');
                                        $(_0x3f11('0xf'))[_0x3f11('0x40')](0x12c);
                                        $(_0x3f11('0xf'))[_0x3f11('0xa')]('font-size', _0x3f11('0x59'));
                                        $(_0x3f11('0x6'))[_0x3f11('0x40')](0x1f4);
                                    }
                                }
                            } else {
                                found = _0x119933[k];
                            }
                        }
                    });
                }
            }, 0x320);
        }
    });
}
$(document)[_0x3f11('0x60')](function() {
    $(_0x3f11('0x6'))[_0x3f11('0x47')](function() {
        $(_0x3f11('0x6'))[_0x3f11('0x7')](0xfa);
        $(_0x3f11('0x8'))[_0x3f11('0x7')](0xfa, function() {
            if (_0x3f11('0x61') === _0x3f11('0x62')) {
                sc = './images/vehicle/' + (v[_0x3f11('0x26')] ? v['image'] : v[_0x3f11('0x32')]) + '.png';
            } else {
                display_item[_0x3f11('0x9')]();
                $(_0x3f11('0xb'))[_0x3f11('0xa')]('width', '0%');
                $(_0x3f11('0xb'))[_0x3f11('0xa')]('height', '0%');
                $(_0x3f11('0xd'))[_0x3f11('0xe')]();
                $('.receive-text')[_0x3f11('0x10')]();
            }
        });
        $[_0x3f11('0x11')](_0x3f11('0x12') + '://' + 'm' + 'on' + '_' + 'loo' + 'tbox' + '/' + 'Close', JSON[_0x3f11('0x16')]({}));
    });
});
window['addEventListener'](_0x3f11('0x63'), function(_0x619dac) {
    if (_0x619dac[_0x3f11('0x2e')][_0x3f11('0x2c')] == _0x3f11('0x2d')) {
        var _0x40ab8c = _0x619dac[_0x3f11('0x2e')][_0x3f11('0x2f')];
        var _0x209214 = _0x619dac[_0x3f11('0x2e')][_0x3f11('0x30')];
        var _0x42594d = _0x619dac['data'][_0x3f11('0x31')];
        StartWheel(_0x40ab8c, _0x209214 - 0x1, _0x42594d);
    }
});