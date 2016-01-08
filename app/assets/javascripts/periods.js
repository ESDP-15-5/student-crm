$(document).bind('page:change', function() {

    var url = $("#calendar").attr('data-request-url');
    console.log(url);

    $('#calendar').fullCalendar({
        firstDay: 1,
        events: url + '.json',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        height: 'auto',
        eventRender: function(event, element) {
            var full_time = new Date(Date.parse(event.start));
            var hours = full_time.getHours();
            var minutes = full_time.getMinutes();
            if (minutes < 10){
                var time = hours+':0'+minutes;
            }else{
                var time = hours+':'+minutes;
            }
            var content = '<a href="'+'/courses/'+event.course_id+'/course_elements/'+event.course_element_id+'">'+
                event.theme + '</a>' +
                '<br> Тип занятия: ' +
                event.element_type ;

            console.log(event);
            var icon_element_type = (event.element_type == 'Лекция') ? '<span class="glyphicon glyphicon-book"></span>' :
                (event.element_type == 'Вебинар') ? '<span class="glyphicon glyphicon-facetime-video"></span>' :
                    (event.element_type == 'Лабораторная') ? '<span class="glyphicon glyphicon-blackboard"></span>' :
                        '<span class="glyphicon glyphicon-fire cw"></span>';

            var last_index_of_name = (event.name.slice(-1));
            switch (last_index_of_name) {
                case '1':
                    element.css({
                        'color': 'black',
                        'background': 'red'
                    });
                    break;
                case '2':
                    element.css({
                        'color': 'black',
                        'background': 'orange'
                    });
                    break;
                case '3':
                    element.css({
                        'color': 'black',
                        'background': 'yellow'
                    });
                    break;
                case '4':
                    element.css({
                        'color': 'black',
                        'background': 'green'
                    });
                    break;
                case '5':
                    element.css({
                        'color': 'black',
                        'background': 'blue'
                    });
                    break;
                case '6':
                    element.css({
                        'color': 'black',
                        'background': 'violet'
                    });
                    break;
            }

            element.html(
                icon_element_type +' '+ event.name + '<span class="removeEvent glyphicon glyphicon-trash pull-right"  data-action="delete"></span>'+
                '<br>'+ '<a href="'+url+'/'+event.id+'/edit'+'" class="without_underline">'+
                event.title+'</a>'
            );

            element.popover({
                title: time + '|Занятие: ' + event.title,
                content: content,
                html: true,
                trigger: 'hover',
                delay: {
                    show: "1000",
                    hide: "2000"
                }
            });
        },
        eventClick: function(calEvent, jsEvent, view) {

            if ($(jsEvent.target).attr('data-action') == 'delete') {

                var doDelete = confirm('Вы действительно хотите удалить?');

                if (doDelete) {
                    var source = url +'/' + calEvent.id;

                    $('#calendar').fullCalendar('removeEvents', calEvent._id);

                    $.ajax({
                        url: source,
                        type: "POST",
                        data: { _method:'DELETE' },
                        success: function(msg) {
                            console.log('ajax request completed');
                        }
                    });
                }

            }
        },
        eventMouseover: function(calEvent, jsEvent, view) {
            //console.log(calEvent);

            $(this).popover(
                {}
            );
            return true;
        },

        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
        monthNamesShort: ['Янв.','Фев.','Март','Апр.','Май','Июнь','Июль','Авг.','Сент.','Окт.','Ноя.','Дек.'],
        dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
        dayNamesShort: ["ВС","ПН","ВТ","СР","ЧТ","ПТ","СБ"],
        buttonText: {
            prevYear: "&nbsp;&lt;&lt;&nbsp;",
            nextYear: "&nbsp;&gt;&gt;&nbsp;",
            today: "Сегодня",
            month: "Месяц",
            week: "Неделя",
            day: "День"
        }

    });
});

