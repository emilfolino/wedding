var current_index = -1;

function move_up_and_down (keyCode) {
  var current_elements = $("#search-result-container").children();

  if (keyCode == 13 || keyCode == 9) { // enter/tab->choose
    var id = $(current_elements[current_index]).attr("id");
    selected_song(id);
  }

  if (keyCode == 38) { // arrow up
    if (current_index > -1) {
      $(current_elements[current_index]).removeClass("search-result-selected");
      current_index = current_index - 1;
      $(current_elements[current_index]).addClass("search-result-selected");
    }
  }

  if (keyCode == 40) { // arrow down
    if (current_index < current_elements.length-1) {
      $(current_elements[current_index]).removeClass("search-result-selected");
      current_index = current_index + 1;
      $(current_elements[current_index]).addClass("search-result-selected");
    }
  }
}


function selected_song (id) {
  $("#search-song").val("");
  $("#search-result-container").hide();

  $.get("/add_song/" + $("#wedding_id").val() + "/" + id);
  $("#playlist-tracks").append($("#" + id).text() + "<br>");

}

$(document).ready(function () {
  $("#search-song").keyup(function(e) {
    var keyCode = event.which;
    if (keyCode == 13 || keyCode == 38 || keyCode == 40 || keyCode == 9) {
      move_up_and_down(keyCode);
    } else {
      if ($("#search-song").val().length > 1) {
        $.getJSON("https://api.spotify.com/v1/search?q="+$("#search-song").val()+"&type=track&market=SE&limit=20", function (data) {
          var str = "";

          $.each(data.tracks.items, function (index, val) {
            str+= "<div class='search-result' id='"+val.id+"'>";
              str += val.name + " - " + val.artists[0].name;
            str+= "</div>";
          });


          str+= "<div style='clear:both;'></div>";
          $("#search-result-container").show();
          $("#search-result-container").html(str);

          $(".search-result").hover(function () {
            $(this).addClass("search-result-selected");
            current_index = $("#search-result-container").children().index($(this));
          }, function () {
            $(this).removeClass("search-result-selected");
            current_index = -1;
          });
        });
      }
    }
  });

  $(document).on("click", ".search-result", function () {
    selected_song($(this).attr("id"));
  });
});