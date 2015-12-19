$(document).bind('page:change', function() {

    $('#calendar').fullCalendar({
        events: '/courses/'+ $.param( {'course_id'} ) +'/periods.json'

    });


});

