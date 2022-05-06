PWScoreboard = {};

$(document).ready(function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "open":
        PWScoreboard.Open(event.data);
        break;
      case "close":
        PWScoreboard.Close();
        break;
    }
  });
});

PWScoreboard.Open = function (data) {
  $(".scoreboard-block").fadeIn(150);
  $("#total-players").html(
    "<p>" + data.players + "/" + data.maxPlayers + "</p>"
  );
  
  $("#total-policeam").html(
    /* "<p> 👮 " + data.currentCops + " / 👨‍⚕️ " + data.currentAmbulance + " / 👨‍🔧️ " + data.currentMechanic + "</p>" */
	"<p> 👨‍⚕️ " + data.currentAmbulance + " / 👨‍🔧️ " + data.currentMechanic + "</p>"
  );

  $.each(data.requiredCops, function (i, category) {
    var beam = $(".scoreboard-info").find('[data-type="' + i + '"]');
    var status = $(beam).find(".info-beam-status");

    if (category.busy) {
      $(status).html('<i class="fas fa-clock"></i>');
    } else if (data.currentCops >= category.minimum) {
      $(status).html('<i class="fas fa-check"></i>');
    } else {
      $(status).html('<i class="fas fa-times"></i>');
    }
  });
};

PWScoreboard.Close = function () {
  $(".scoreboard-block").fadeOut(150);
};
