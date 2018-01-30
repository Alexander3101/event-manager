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
        buttonText: 'Месяц'
      },
      agendaWeek: {
        type: 'agenda',
        duration: {
          days: 7
        },
        buttonText: 'Неделя'
      },
      agendaDay: {
        type: 'agenda',
        duration: {
          days: 1
        },
        buttonText: 'День'
      }
    },
    buttonText: {
      today: 'Сегодня'
    },
    events: '/events.json?room_id=' + parameter,
    timeFormat: 'HH:mm',
    displayEventEnd: true,
    eventTitle: false,
    dayClick: function(date, jsEvent, view, resourceObj) {
      var d = new Date();
      d.setHours(0, 0, 0);
      if (date >= d)
        showFormNew(date);
    },
    eventRender: function(event, element) {
      $(element).popover({
        html : true,
        title: event.title,
        content: function(){
          var c = "Время проведения: " + event.start.format("HH.mm") + " - " + event.end.format("HH.mm");
          c += "<br>" + "Организатор: " + event.organizer.name + "<br>" + "Проводит: " + event.lector.name;
          c += "<hr>" + event.description;
          return c;
        },
        trigger: 'hover'
        // placement: 'right'
        // delay: {"hide": 300 }
      });
      $(element).click(function(){
        // alert(event.start.format("hh-mm"));
        // alert(new Date(2000, 1, 1, 11, 0, 0, '+03:00'))
        showFormEdit(event);
      })
    }
  });
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

function showFormNew(date){
  var url = "/events/new?room_id="+$('#calendar').attr('data-room-id')+"&date="+date.format("DD-MM-YYYY");
  $.get(url, function(data){
    $("#new_event").modal('toggle');
    $('#new_event').html(data);
  });
}

function showFormEdit(event){
  console.log(event);
  var url = "/events/"+event.id+"/edit?room_id="+$('#calendar').attr('data-room-id');
  url += "&date="+event.start.format("DD-MM-YYYY")+"&begin_time="+event.start.format("YYYY-MM-DDTHH:mm:ss.SSSSZ")+"&end_time="+event.end.format("YYYY-MM-DDTHH:mm:ss.SSSSZ");
  url += "&organizer_id="+event.organizer.id+"&lector_id="+event.lector.id+"&user_id="+event.user.id;
  $.get(url, function(data){
    $("#new_event").modal('toggle');
    $('#new_event').html(data);
  });
}

$("body").on('click', '.modal-backdrop', function(){
  $("#new_event").modal("hide");
});

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
