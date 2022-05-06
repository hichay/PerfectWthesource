(function () {
  function b() {
    window.addEventListener("message", function (d) {
      var c = d.data;
      if (c.scuba !== undefined) {
        if (c.scuba === true) {
          $(".scuba-container").css({display: c.pause});
          var e = c.oxygen / c.max * 100;
          var b = c.max * 10 / 100;
          if (c.oxygen > b) {
            $("#scuba-val").css("width", e + "%");
            $("#scuba-alert").css("animation", "blinker-stop");
            $("#scuba-alert").css("background-color", "transparent");
          } else {
            $("#scuba-val").css("width", e + "%");
            $("#scuba-alert").css("animation", "blinker 1s linear infinite");
            $("#scuba-alert").css("background-color", "rgb(255, 0, 0, 0.5)");
          }
          ;
          if (Number.isNaN(e)) {
            document.getElementById("scuba-text").innerHTML = "Loading...";
          } else {
            document.getElementById("scuba-text").innerHTML = Math.ceil(e);
          }
        } else {
          if (c.scuba === false) {
            $(".scuba-container").css({display: c.pause});
          }
        }
      } else {
        if (c.snorkelling !== undefined) {
          if (c.snorkelling === true) {
            $(".snorkelling-container").css({display: c.pause});
            if (c.depth) {
              var e = c.depth.val / c.depth.max * 100;
              if (e > 10) {
                $("#snorkelling-val-depth").css("width", e + "%");
                $("#snorkelling-alert-depth").css("animation", "blinker-stop");
                $("#snorkelling-alert-depth").css("background-color", "transparent");
              } else {
                $("#snorkelling-val-depth").css("width", e + "%");
                $("#snorkelling-alert-depth").css("animation", "blinker 1s linear infinite");
                $("#snorkelling-alert-depth").css("background-color", "rgb(255, 0, 0, 0.5)");
              }
              ;
              if (Number.isNaN(c.depth.val)) {
                document.getElementById("snorkelling-text-depth").innerHTML = "Loading...";
              } else {
                if (c.depth.val < 0) {
                  document.getElementById("snorkelling-text-depth").innerHTML = 0;
                } else {
                  document.getElementById("snorkelling-text-depth").innerHTML = Math.ceil(c.depth.val);
                }
              }
            }
            ;
            if (c.timer) {
              var e = c.timer.val / c.timer.max * 100;
              if (e > 10) {
                $("#snorkelling-val-timer").css("width", e + "%");
                $("#snorkelling-alert-timer").css("animation", "blinker-stop");
                $("#snorkelling-alert-timer").css("background-color", "transparent");
              } else {
                $("#snorkelling-val-timer").css("width", e + "%");
                $("#snorkelling-alert-timer").css("animation", "blinker 1s linear infinite");
                $("#snorkelling-alert-timer").css("background-color", "rgb(255, 0, 0, 0.5)");
              }
              ;
              if (Number.isNaN(c.timer.val)) {
                document.getElementById("snorkelling-text-timer").innerHTML = "Loading...";
              } else {
                document.getElementById("snorkelling-text-timer").innerHTML = Math.ceil(c.timer.val);
              }
            }
          } else {
            if (c.snorkelling === false) {
              $(".snorkelling-container").css({display: c.pause});
            }
          }
        }
      }
    });
  }
  $(document).ready(b);
}());
