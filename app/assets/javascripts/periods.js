
$(document).bind('page:change', function() {

    var url = location.pathname
    console.log(url)

    $('#calendar').fullCalendar({
        events: url + '.json',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        eventRender: function(event, element) {
            element.html(event.title + '<span class="removeEvent glyphicon glyphicon-trash pull-right" id="Delete" data-item-id='+ event.id +'></span>');

            element.popover({
                title: 'Занятие ' + event.title,
                content: event.name,
                trigger: 'manual'
            });
        },
        eventClick: function(calEvent, jsEvent, view) {
            if (jsEvent.target.id === 'Delete') {
                console.log(calEvent.id);
                var source = url +'/' + calEvent.id;

                $('#calendar').fullCalendar('removeEvents', calEvent._id);

                $.ajax({
                    url: source,
                    type: "POST",
                    data: { _method:'DELETE' },
                    success: function(msg) {
                        'Удаление прошло успешно'
                    }
                });
            }
        },
        eventMouseover: function(calEvent, jsEvent, view) {
            //console.log(calEvent);

            $(this).popover('toggle');
            return false;
        },
        eventMouseout: function(calEvent, jsEvent, view) {
            //console.log(calEvent);

            $(this).popover('hide');
            return false;
        },
    });
});

