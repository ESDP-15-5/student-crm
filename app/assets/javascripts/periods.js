
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
            element.popover({
                title: 'Занятие ' + event.title,
                content: event.course_element,
                trigger: 'manual'
            });
        },
        eventMouseover: function(calEvent, jsEvent, view) {
            console.log(calEvent);

            $(this).popover('toggle');
            return false;
        },
        eventMouseout: function(calEvent, jsEvent, view) {
            console.log(calEvent);

            $(this).popover('hide');
            return false;
        },
    });
});

