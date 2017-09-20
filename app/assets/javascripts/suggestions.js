$(document).ready(function() {
  fetchComments()
  createComment()
})


function getSuggestion() {
  $("#create-comment").on("click", function() {
    var commentParams = {
      comment: {
        message: $("#comment-message").val()
      }

    }

    $.ajax({
      type:    "POST",
      url:     "/api/v1/leagues/" + $("#league-id").val() + "/comments",
      data:    commentParams,
      success: function(newComment) {
        $('#league-comments').html('');
        document.getElementById("comment-message").value = "";
        fetchComments()
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}
