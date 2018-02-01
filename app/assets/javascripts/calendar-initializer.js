function eventCalendar() {
  var parameter = $('#calendar').attr('data-room-id');
  var current_user = $('#calendar').attr('current_user');
  if ($('#calendar').attr('current_user') == "undefiner")
    current_user = 0;
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
    eventLimit: true,
    dayClick: function(date, jsEvent, view, resourceObj) {
      var d = new Date();
      d.setHours(0, 0, 0);
      if (date >= d)
        showFormNew(date);
    },
    eventRender: function(event, element) {
      if (event.user.id == current_user)
        $(element).css("background-color", "#378006");
      $(element).popover({
        html : true,
        title: event.title,
        content: function(){
          var c = "Время проведения: " + event.start.format("HH.mm") + " - " + event.end.format("HH.mm");
          c += "<br>" + "Организатор: " + event.organizer.name + "<br>" + "Проводит: " + event.lector.name;
          c += "<hr>" + event.description;
          return c;
        },
        trigger: 'hover',
        placement: 'top'
      });
      $(element).click(function(){
        showFormEdit(event);
      })
    }
  });
  //
  // if ($(".userfield").attr('actual_user') == $(".userfield").val()) {
  // }
  // else {
  // };
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

function showFormNew(date){
  var url = "/events/new?room_id="+$('#calendar').attr('data-room-id')+"&date="+date.format("DD-MM-YYYY");
  $.get(url, function(data){
    $("#event_form").modal();
    $("#event_form .modal-title").html("Новое событие");
    $("#event_form .modal-body").html(data);
  });
}

function showFormEdit(event){
  console.log(event);
  var url = "/events/"+event.id+"/edit";
  $.get(url, function(data){
    $("#event_form").modal();
    $("#event_form .modal-title").html("Событие");
    $("#event_form .modal-body").html(data);
  });
}

$("body").on('click', '.modal-backdrop', function(){
  $("#event_form").modal("hide");
});

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
