$(document).ready(function () {
  if ($(".wedding-alert").length > 0) {
    setTimeout(function() {
      $(".wedding-alert").fadeOut();
    }, 4000);
  }

  $(".answer-question").on("click", function (event) {
    event.preventDefault();

    var question_id = $(this).attr("id").split("-")[1];

    $("#answer-"+question_id).fadeIn();
  });

  $(".menu-toggle").on("click", function (event) {
    event.preventDefault();
    $("#top-menu").slideToggle();
  });

  $("a[id^=give-]").confirmModal({
    confirmTitle      : "Er du sikker / Är du sikker ?",
    confirmMessage    : "Er du sikker på du vil gi denne gave / Bekräfta att du vill ge denna presenten ?",
    confirmOk         : "JA",
    confirmCancel     : "NEJ"
  });

});