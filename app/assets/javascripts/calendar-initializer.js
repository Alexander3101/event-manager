function eventCalendar() {
  var parameter = $('#calendar').attr('data-room-id');
  return $('#calendar').fullCalendar({
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
        duration: {
          days: 7
        },
        buttonText: 'неделя'
      },
      agendaDay: {
        type: 'agenda',
        duration: {
          days: 1
        },
        buttonText: 'сегодня'
      }
    },
    events: '/orders.json?room_id='+parameter,
    timeFormat: 'HH:mm'

  });
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
