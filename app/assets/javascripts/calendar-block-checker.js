$(document).on('turbolinks:load', function() {

  if ($('#calendar').length > 0) {

    console.log("На странице существует блок #calendar");

  } else {

    console.log("На странице не существует блока #calendar");

  }
});
