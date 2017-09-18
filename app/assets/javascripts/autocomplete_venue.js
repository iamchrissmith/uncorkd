$(document).ready(function () {
  var data = {}
  var venueNames = $('.venues').data('names')
  $.each(venueNames, function (index, name) {
        data[name] = null
    })
    console.log(data)
$('input.autocomplete').autocomplete({
  data: data,
  limit: 10,
  onAutocomplete: function(val) {
    console.log(val)
    // Callback function when value is autcompleted.
  },
  minLength: 1,
});
});
