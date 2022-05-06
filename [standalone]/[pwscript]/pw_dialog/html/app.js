const APP = new Vue({
  el: "#app",
  data: {
    show: false,
    ped_name: null,
    ped_question: null,
    buttons: [],
  },
  methods: {
    setPedName(ped_name) {
      this.ped_question = null;
      this.ped_name = ped_name;
    },
    setPedQuestion(question) {
      this.ped_question = null;
      this.ped_question = question;
    },
    isEmpty(obj) {
      for (var prop in obj) {
        if (obj.hasOwnProperty(prop)) {
          return false;
        }
      }

      return JSON.stringify(obj) === JSON.stringify({});
    },
    setButtons(payload) {
      this.buttons = [];
      payload.forEach((item) => {
        if (item != null) {
                  this.buttons.push({
                    text: item.text,
                    triggerEvent: item.event,
                    args1: item.args1,
                    args2: item.args2,
                    args3: item.args3,
                    args4: item.args4,

                    server: item.server,
                  });
        }

      });
    },
    setShow(toggle) {
      this.show = toggle;
    },

    handleButtons(e, btn) {
      let event = btn.triggerEvent;
      let args1 = btn.args1;
      let args2 = btn.args2;
      let args3 = btn.args3;
      let args4 = btn.args4;

      let server = btn.server;
	  
      if (event == "close") {
        this.resetContent();
        $.post("http://pw_dialog/close");
      } else {
        $.post(
          "http://pw_dialog/triggerevent",
          JSON.stringify({
            event,
            args1,
            args2,
            args3,
            args4,
            server,
          })
        );
      }
    },
    resetContent() {
      this.show = false;
      this.ped_name = null;
      this.ped_question = null;
      this.buttons = [];
    },
  },
  
  
  
  
});



window.addEventListener("message", function (event) {
  let item = event.data;
  switch (event.data.action) {
    case "setdialog":

      APP.setPedName(item.name);
      APP.setPedQuestion(item.question);
      APP.setButtons(item.buttons);
      APP.setShow(true);
      break;
    case "close":
      APP.resetContent();
      break;
    default:
      break;
  }
  
 
  
});

addEventListener("keydown", function (event) {
    if ( event.keyCode == 27) {
		console.log('asc')
		$.post("http://pw_dialog/close");
		APP.resetContent()
	}
	if ( event.keyCode == 49) {
		setButtons(1);
	}
		
});


