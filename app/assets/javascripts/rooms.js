// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    locale: 'ru',
    contentHeight: 600,
    header: {
      left: 'month,agendaWeek,agendaDay',
      center: 'title'
    },
    views: {
      month: {
        buttonText: 'месяц'
      },
      agendaWeek: {
        type: 'agenda',
        duration: { days: 7 },
        buttonText: 'неделя'
      },
      agendaDay: {
        type: 'agenda',
        duration: { days: 1 },
        buttonText: 'сегодня'
       }
    },

    events: '/orders.json?room_id=#{@room.id}',
    timeFormat: 'HH:mm'
  });
});
