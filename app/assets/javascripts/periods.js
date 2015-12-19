
$(document).bind('page:change', function() {

    $('#calendar').fullCalendar({
        events: '/courses/'+ 2 +'/periods.json'

    });
});

