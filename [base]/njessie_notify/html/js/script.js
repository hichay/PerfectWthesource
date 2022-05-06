var _stillRequestShowHelper = false;
var _currentNotify = [];

$(function(){
  toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-container toast-bottom-left",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };
  window.addEventListener("message", function(event){   
    if(event.data.type == "notify"){
      // START Notify
      // Set toast option
      toastr.options.positionClass = "toast-container toast-bottom-left";
      toastr.options.containerId = "toast-container-notify";
      var _msg = formatMsg(event.data.message);
      if(!checkNotifyExist(_msg)) {
        if(event.data.title != "") {
          toastr["info"](_msg, event.data.title);
        } else {
          toastr["info"](_msg);
        }
        addNotifyToCurrent(_msg);
      }
      // END Notify
    } else if(event.data.type == "info") {
      // START Info
      var msg = formatMsg(event.data.message);
      $('#toast_info_ui .toast-message').html(msg);
      // END info
    } else if(event.data.type == "inventory") {
      // START Inventory
      // Set toast option
      toastr.options.positionClass = "toast-container toast-bottom-right";
      toastr.options.containerId = "toast-container-inventory";
      // End set toast option
      var _msg = "";
      if(event.data.add) {
        _msg = "➕";
      } else {
        _msg = "➖";
      }
      _msg += event.data.count + " " + event.data.item;
      if(!checkNotifyExist(_msg)) {
        if(event.data.title != "") {
          toastr["info"](_msg, event.data.title);
        } else {
          toastr["info"](_msg);
        }
        addNotifyToCurrent(_msg);
      }
      // END Inventory
    } else {
      // START Helper
      var msg = formatMsg(event.data.message);
      $('#toast_helper_ui .toast-message').html(msg);
      if(!_stillRequestShowHelper) {
        _stillRequestShowHelper = true;
        $('#toast_helper_ui').show();
        checkRequestHeler();
      }
      // END Helper
    }
  });
});

/*** Notification ***/
function addNotifyToCurrent(_msg) {
  setTimeout(() => {
    for (let i = _currentNotify.length - 1; i >= 0; i--) {
      if(_currentNotify[i] === _msg) {
        _currentNotify.splice(i, 1);
        break;
      }
    }
  }, parseInt(toastr.options.timeOut));
}

function checkNotifyExist(_msg) {
  var _result = false;
  for (let i = 0; i < _currentNotify.length; i++) {
    if(_msg == _currentNotify[i]) {
      _result = true;
      break;
    }
  }
  return _result;
}
/*** Info UI ***/

/*** Helper UI ***/
function checkRequestHeler() {
  setTimeout(() => {
    if(_stillRequestShowHelper) {
      setTimeout(() => {
        _stillRequestShowHelper = false;
        checkRequestHeler();  
      }, 250);
    } else {
      $('#toast_helper_ui').hide();
    }
  }, 100);
}

function formatMsg(_msg) {
  // Formatting keyboard view
  for (let i = 0; i < keyboardFormatList.length; i++) {
    if(_msg.includes(keyboardFormatList[i].key)) {
      _msg = _msg.replaceAll(keyboardFormatList[i].key, keyboardFormatList[i].value);
    }
  }
  // Formatting style not working right now
  for (let i = 0; i < stringFormatList.length; i++) {
    if(_msg.includes(stringFormatList[i].key)) {
      _msg = _msg.replaceAll(stringFormatList[i].key, stringFormatList[i].value);
    }
  }
  // Completed formatting
  return _msg;
}

var keyboardFormatList = [
  {
    key  : "~INPUT_PICKUP~",
    value: "<span class=\"ui label helper\">E</span>"
  },
  {
    key  : "~INPUT_CONTEXT~",
    value: "<span class=\"ui label helper\">E</span>"
  },
  {
    key  : "~INPUT_VEH_FLY_ROLL_LEFT_ONLY~",
    value: "<span class=\"ui label helper\">Numpad 4</span>"
  },
  {
    key  : "~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~",
    value: "<span class=\"ui label helper\">Numpad 6</span>"
  },
  
];

/**
  ~r~ → Red
  ~b~ → Blue
  ~g~ → Green
  ~y~ → Yellow
  ~p~ → Purple
  ~o~ → Orange
  ~c~ → Grey
  ~m~ → Dark Grey
  ~u~ → Black
  ~n~ → New Line
  ~s~ → White (Default)
  ~w~ → White
  ~h~ → Bold
  ~nrt~ → 
 */
var stringFormatList = [
  {
    key : "~r~",
    value: "<span class=\"t-color red\">"
  },
  {
    key : "~b~",
    value: "<span class=\"t-color blue\">"
  },
  {
    key : "~g~",
    value: "<span class=\"t-color green\">"
  },
  {
    key : "~y~",
    value: "<span class=\"t-color yellow\">"
  },
  {
    key : "~p~",
    value: "<span class=\"t-color purple\">"
  },
  {
    key : "~o~",
    value: "<span class=\"t-color orange\">"
  },
  {
    key : "~c~",
    value: "<span class=\"t-color grey\">"
  },
  {
    key : "~m~",
    value: "<span class=\"t-color grey\">"
  },
  {
    key : "~u~",
    value: "<span class=\"t-color black\">"
  },
  {
    key : "~n~",
    value: "</br><span>"
  },
  {
    key : "~s~",
    value: "</span>"
  },
  {
    key : "~w~",
    value: "<span class=\"t-color white\">"
  },
  {
    key : "~h~",
    value: "<span style=\"font-weight:600;\">"
  },
  {
    key : "~nrt~",
    value: "<span>"
  },
];
//
String.prototype.replaceAll = function(search, replacement) {
  var target = this;
  return target.replace(new RegExp(search, 'g'), replacement);
};