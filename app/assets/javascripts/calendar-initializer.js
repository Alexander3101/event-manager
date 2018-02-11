function eventCalendar() {
  var parameter = $('#calendar').attr('data-room-id');
  var current_user = $('#calendar').attr('current_user');
  if ($('#calendar').attr('current_user') == "undefiner")
    current_user = 0;
  return $('#calendar').fullCalendar({
    locale: 'ru',
    contentHeight: 600,
    header: {
      left: 'prev',
      center: 'title',
      right: 'next'
    },
    events: '/events.json?room_id=' + parameter,
    timeFormat: 'HH:mm',
    displayEventEnd: true,
    eventLimit: false,
    dayClick: function(date, jsEvent, view, resourceObj) {
      var d = new Date();
      d.setHours(0, 0, 0);
      if (date >= d)
        showFormNew(date);
    },
    eventRender: function(event, element) {
      if (event.user.id == current_user)
        $(element).css("background-color", "#16907b");
      $(element).popover({
        html : true,
        title: event.title,
        content: function(){
          var c = "Время проведения: " + I18n.l("time.formats.d", new Date(event.start)) + I18n.l("time.formats.dash", new Date(event.end));
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
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

function showFormNew(date){
  var url = "/events/new?room_id="+$('#calendar').attr('data-room-id')+"&date="+I18n.l("time.formats.date", new Date(date));
  $.get(url, function(data){
    $("#event_form").modal();
    $("#event_form .modal-title").html(I18n.t('events.title_new'));
    $("#event_form .modal-body").html(data);
  });
}

function showFormEdit(event){
  console.log(event);
  var url = "/events/"+event.id+"/edit";
  $.get(url, function(data){
    $("#event_form").modal();
    $("#event_form .modal-title").html(I18n.t('events.title_edit'));
    $("#event_form .modal-body").html(data);
  });
}

$("body").on('click', '.modal-backdrop', function(){
  $("#event_form").modal("hide");
});

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
