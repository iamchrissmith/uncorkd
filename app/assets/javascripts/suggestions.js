$(document).ready(function() {
  getSuggestion()
})


function getSuggestion() {
  $("#btn-suggest").on("click", function() {
    var eventParams = {
        occasion: $("#occassion").val(),
        season: $("#season").val(),
        food: $("#food").val(),
        price: $("#price").val(),
    }

    var color = {red: 0, white: 0};
    var type = {wine: 0, sparkling: 0, dessert: 0};
    var price = eventParams["price"]

    //iterate over occassion
    if(eventParams["occasion"] === "dinner") {
    	type["wine"] += 50
    }
    else if(eventParams["occasion"] === "picnic") {
      type["wine"] += 25
      type["sparkling"] += 25
    	color["white"] += 10
    }
    else if(eventParams["occasion"] === "celebration") {
      type["sparkling"] += 100
    }
    else if(eventParams["occasion"] === "everyday") {
      type["wine"] += 25
    }
    else if(eventParams["occasion"] === "dessert") {
      type["dessert"] += 100
    }

    //iterate over season
    if(eventParams["season"] === "summer") {
      color["white"] += 50
    }
    else if(eventParams["season"] === "fall") {
      color["red"] += 10
    }
    else if(eventParams["season"] === "winter") {
      color["red"] += 50
    }
    else if(eventParams["season"] === "spring") {
      color["white"] += 10
    }

    //iterate over food
    if(eventParams["food"] === "red_meat") {
      type["wine"] += 45
      color["red"] += 60
    }
    else if(eventParams["food"] === "white_meat") {
      type["wine"] += 20
    }
    else if(eventParams["food"] === "vegetables") {
      type["wine"] += 20
      color["white"] += 20
    }
    else if(eventParams["food"] === "seafood") {
      color["white"] += 60
      type["wine"] += 20
    }
    else if(eventParams["food"] === "cheese_crackers") {
      type["wine"] += 10
      type["sparkling"] += 10
      color["red"] += 10
    }

    var typeParam = ["start", 0]
    $.each(type, function (key, value) {
      if(value > typeParam[1]){
        typeParam = [key, value]
      }
    })

    var colorParam = ["start", 0]
    $.each(color, function (key, value) {
      if(value > colorParam[1]){
        colorParam = [key, value]
      }
    })


    $.ajax({
      type:    "GET",
      url:     "http://api.snooth.com/wines/?akey=" + $('.snooth-info').data('key') + "&n=5&xp=" + price + "&t=" + typeParam[0] + "&color=" + colorParam[0],
      success: function(data) {
        $('#suggestions').html('');
        wines = JSON.parse(data)["wines"]
        for (var i = 0; i < wines.length; i++) {
          $('#suggestions').append('<p class="wine center-align">' + wines[i]["name"] + "<br>$" + wines[i]["price"] + "<br>" + wines[i]["type"] + "<br>" + "<a href='" + wines[i]["link"] + "'>Buy on Snooth</a>" + '</p>');
        }

      }
    })
  })
}
