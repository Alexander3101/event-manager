//= require jquery
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require moment/ru
//= require fullcalendar
//= require calendar-initializer
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap


$(document).on('turbolinks:load', function() {
  var max_height = 0;
  var blocks = $('.card-body');
  blocks.each(function() {
    if ( $(this).height() > max_height ) {
      max_height = $(this).height();
    }
  });
  blocks.each(function() {
    $(this).height(max_height);
  });
});
