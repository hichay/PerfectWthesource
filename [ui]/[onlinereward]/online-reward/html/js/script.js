var _0x4252 = ['KeaRj', 'bell', 'srrgZ', 'onkeyup', 'which', 'bgDto', './sound/bell.wav', 'floor', 'random', 'ready', '.header-close', 'click', 'LJRzW', 'displayDialog', 'data', 'title', 'message', 'post', 'stringify', '.menu', 'fadeOut', '.dialog', 'type', 'load_data', 'Jbgot', 'xJyOj', 'taken', 'desc', '.daily-grid', 'empty', 'csBKs', 'text', 'btn', '.notification', 'fadeIn', '<div\x20class=\x22date-box\x22></div>', '<img\x20class=\x22date-box-item\x22\x20src=\x22./images/promo/', 'error', 'zBqhY', 'remove', 'tooltip', 'createTooltip', '</span>', 'append', '<div\x20class=\x22date-text\x22>', '</div>', 'PgfIo', './sound/gick.mp3', 'volume', 'play', '/Checkin', 'ogMta', 'HmCUV', 'lIiIJ', 'PYtXk', '.header-text', '.header-desc', 'noti', 'KwBgZ', '/Close', 'state', '#input_btn', 'YovlH', 'dialog', 'bALyf'];
(function(_0x50235e, _0xbc89b2) {
    var _0x507626 = function(_0x24c946) {
        while (--_0x24c946) {
            _0x50235e['push'](_0x50235e['shift']());
        }
    };
    _0x507626(++_0xbc89b2);
}(_0x4252, 0xca));
var _0x1cd5 = function(_0x7a5e1f, _0x34c4eb) {
    _0x7a5e1f = _0x7a5e1f - 0x0;
    var _0x188b0e = _0x4252[_0x7a5e1f];
    return _0x188b0e;
};

function randomMath(_0x13c85e, _0x262654) {
    return Math[_0x1cd5('0x0')](Math[_0x1cd5('0x1')]() * _0x262654 + _0x13c85e);
}
$(document)[_0x1cd5('0x2')](function() {
    $(_0x1cd5('0x3'))[_0x1cd5('0x4')](function() {
        if (_0x1cd5('0x5') === _0x1cd5('0x5')) {
            CloseMenu();
        } else {
            $[_0x1cd5('0x6')]({
                'title': event[_0x1cd5('0x7')][_0x1cd5('0x8')],
                'message': event[_0x1cd5('0x7')][_0x1cd5('0x9')]
            });
        }
    });
});
var im = 'https://online-reward';
function CloseMenu() {
    $[_0x1cd5('0xa')](im + '/Close', JSON[_0x1cd5('0xb')]({}));
    $(_0x1cd5('0xc'))[_0x1cd5('0xd')](0xc8);
    $(_0x1cd5('0xe'))['remove']();
}
window['addEventListener'](_0x1cd5('0x9'), function(_0x5cc56a) {
    if (_0x5cc56a['data'][_0x1cd5('0xf')] == _0x1cd5('0x10')) {
        if (_0x1cd5('0x11') === _0x1cd5('0x12')) {
            CloseMenu();
        } else {
            var _0x1139a8 = _0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x7')];
            var _0x277643 = _0x5cc56a[_0x1cd5('0x7')]['day'];
            var _0x480249 = _0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x13')];
            var _0x411e7b = _0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x8')];
            var _0x4affb7 = _0x5cc56a['data'][_0x1cd5('0x14')];
            $(_0x1cd5('0x15'))[_0x1cd5('0x16')]();
            var _0x560788 = _0x277643 + 0x1;
            var _0x105382;
            for (_0x105382 = 0x1; _0x105382 <= 0x1c; _0x105382++) {
                if (_0x1cd5('0x17') === 'YdpbF') {
                    $('#input_btn')[_0x1cd5('0x18')](_0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x19')]);
                    $(_0x1cd5('0x1a'))[_0x1cd5('0x1b')](0x96);
                } else {
                    var _0x42287e = $(_0x1cd5('0x1c'));
                    var _0x558a1c = $(_0x1cd5('0x1d') + _0x105382 + '.png\x22></img>');
                    _0x558a1c['on'](_0x1cd5('0x1e'), function() {
                        if (_0x1cd5('0x1f') === _0x1cd5('0x1f')) {
                            $(this)[_0x1cd5('0x20')]();
                        } else {
                            var _0x179bde = _0x1139a8[_0x105382 - 0x1];
                            if (_0x179bde[_0x1cd5('0x21')] !== undefined) $[_0x1cd5('0x22')](_0x42287e, '<span>' + _0x179bde[_0x1cd5('0x21')] + _0x1cd5('0x23'));
                        }
                    });
                    _0x42287e[_0x1cd5('0x24')](_0x558a1c);
                    _0x42287e[_0x1cd5('0x24')]('<div\x20class=\x22date-box-gra\x22></div>');
                    _0x42287e[_0x1cd5('0x24')](_0x1cd5('0x25') + _0x105382 + _0x1cd5('0x26'));
                    _0x42287e['on']('mouseenter', function() {
                        if ('PgfIo' === _0x1cd5('0x27')) {
                            var _0x32d352 = new Audio(_0x1cd5('0x28'));
                            _0x32d352[_0x1cd5('0x29')] = 0.3;
                            _0x32d352[_0x1cd5('0x2a')]();
                        } else {
                            _0x42287e[_0x1cd5('0x4')](function() {
                                $['post'](im + _0x1cd5('0x2b'), JSON[_0x1cd5('0xb')]({}));
                            });
                        }
                    });
                    if (_0x105382 <= _0x277643) _0x42287e[_0x1cd5('0x24')]('<div\x20class=\x22date-box-taken\x22><img\x20src=\x22./images/check.png\x22></div>');
                    if (_0x105382 == _0x560788) {
                        if (_0x1cd5('0x2c') === _0x1cd5('0x2d')) {
                            return Math[_0x1cd5('0x0')](Math[_0x1cd5('0x1')]() * max + min);
                        } else {
                            _0x42287e[_0x1cd5('0x4')](function() {
                                if (_0x1cd5('0x2e') !== _0x1cd5('0x2e')) {
                                    $[_0x1cd5('0xa')](im + _0x1cd5('0x2b'), JSON['stringify']({}));
                                } else {
                                    $[_0x1cd5('0xa')](im + _0x1cd5('0x2b'), JSON[_0x1cd5('0xb')]({}));
                                }
                            });
                        }
                    }
                    $(_0x1cd5('0x15'))[_0x1cd5('0x24')](_0x42287e);
                    if (_0x1139a8[_0x105382 - 0x1] !== null) {
                        if (_0x1cd5('0x2f') === _0x1cd5('0x2f')) {
                            var _0x5767d6 = _0x1139a8[_0x105382 - 0x1];
                            if (_0x5767d6[_0x1cd5('0x21')] !== undefined) $[_0x1cd5('0x22')](_0x42287e, '<span>' + _0x5767d6['tooltip'] + _0x1cd5('0x23'));
                        } else {
                            var _0x5e9a76 = new Audio(_0x1cd5('0x28'));
                            _0x5e9a76[_0x1cd5('0x29')] = 0.3;
                            _0x5e9a76[_0x1cd5('0x2a')]();
                        }
                    }
                }
            }
            $(_0x1cd5('0x30'))[_0x1cd5('0x18')](_0x411e7b);
            $(_0x1cd5('0x31'))[_0x1cd5('0x18')](_0x4affb7);
            $(_0x1cd5('0xc'))[_0x1cd5('0x1b')](0xfa);
        }
    } else if (_0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0xf')] == _0x1cd5('0x32')) {
        if (_0x1cd5('0x33') !== _0x1cd5('0x33')) {
            $[_0x1cd5('0xa')](im + _0x1cd5('0x34'), JSON['stringify']({}));
            $(_0x1cd5('0xc'))['fadeOut'](0xc8);
            $('.dialog')[_0x1cd5('0x20')]();
        } else {
            if (_0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x35')]) {
                if ('NVrbV' === 'dALBU') {
                    $('.header-close')[_0x1cd5('0x4')](function() {
                        CloseMenu();
                    });
                } else {
                    $(_0x1cd5('0x36'))['text'](_0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x19')]);
                    $(_0x1cd5('0x1a'))[_0x1cd5('0x1b')](0x96);
                }
            } else {
                if (_0x1cd5('0x37') === _0x1cd5('0x37')) {
                    $(_0x1cd5('0x1a'))[_0x1cd5('0xd')](0x96);
                } else {
                    $(_0x1cd5('0x1a'))['fadeOut'](0x96);
                }
            }
        }
    } else if (_0x5cc56a['data'][_0x1cd5('0xf')] == _0x1cd5('0x38')) {
        if (_0x1cd5('0x39') !== _0x1cd5('0x3a')) {
            $[_0x1cd5('0x6')]({
                'title': _0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x8')],
                'message': _0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0x9')]
            });
        } else {
            CloseMenu();
        }
    } else if (_0x5cc56a[_0x1cd5('0x7')][_0x1cd5('0xf')] == _0x1cd5('0x3b')) {
        if ('srrgZ' !== _0x1cd5('0x3c')) {
            $(this)[_0x1cd5('0x20')]();
        } else {
            var _0x346c04 = new Audio('./sound/bell.wav');
            _0x346c04['volume'] = 0.3;
            _0x346c04[_0x1cd5('0x2a')]();
        }
    }
});
document[_0x1cd5('0x3d')] = function(_0x1fcc5f) {
    if (_0x1fcc5f[_0x1cd5('0x3e')] == 0x1b) {
        if (_0x1cd5('0x3f') !== _0x1cd5('0x3f')) {
            var _0x10b69b = new Audio(_0x1cd5('0x40'));
            _0x10b69b[_0x1cd5('0x29')] = 0.3;
            _0x10b69b[_0x1cd5('0x2a')]();
        } else {
            CloseMenu();
        }
    }
};