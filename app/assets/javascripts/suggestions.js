$(document).ready(function() {
  getSuggestion()
})


function getSuggestion() {
  $("#btn-suggest").on("click", function() {
    var suggestionParams = {
        occasion: $("#occassion").val(),
        season: $("#season").val(),
        food: $("#food").val(),
        price: $("#price").val(),
    }
    console.log(suggestionParams)

    // $.ajax({
    //   type:    "POST",
    //   url:     "/api/v1/leagues/" + $("#league-id").val() + "/comments",
    //   data:    commentParams,
    //   success: function(newComment) {
    //     $('#league-comments').html('');
    //     document.getElementById("comment-message").value = "";
    //     fetchComments()
    //   },
    //   error: function(xhr) {
    //     console.log(xhr.responseText)
    //   }
    // })
  })
}
