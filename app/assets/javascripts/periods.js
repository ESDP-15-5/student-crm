$(document).bind('page:change', function() {

    var page = ($(".periods").length == 0)
    if (page) {
        return;
    }

    $('#period_deadline').on("change",function(){
        console.log('1')
        if(this.checked){
            $('#hidden_deadline_time').css("display", "block");;
        }else{
            $('#hidden_deadline_time').css("display", "none");;
        }
    });

    var url = $("#calendar").attr('data-request-url');
    //console.log(url);

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

            //console.log(event);
            var icon_element_type = (event.element_type == 'Лекция') ? '<span class="glyphicon glyphicon-book"></span>' :
                (event.element_type == 'Вебинар') ? '<span class="glyphicon glyphicon-facetime-video"></span>' :
                    (event.element_type == 'Лабораторная') ? '<span class="glyphicon glyphicon-blackboard"></span>' :
                        '<span class="glyphicon glyphicon-fire cw"></span>';

            var last_index_of_name = (event.name.slice(-1));
            switch (last_index_of_name) {
                case '1':
                    element.css({
                        'color': 'black',
                        'background': '#ff9999'
                    });
                    break;
                case '2':
                    element.css({
                        'color': 'black',
                        'background': '#ffdb99'
                    });
                    break;
                case '3':
                    element.css({
                        'color': 'black',
                        'background': '#ffff99'
                    });
                    break;
                case '4':
                    element.css({
                        'color': 'black',
                        'background': '#99ff99'
                    });
                    break;
                case '5':
                    element.css({
                        'color': 'black',
                        'background': '#9999ff'
                    });
                    break;
                case '6':
                    element.css({
                        'color': 'black',
                        'background': '#ffccff'
                    });
                    break;
            }

            var title = event.title;
            var shortTitle = jQuery.trim(title).substring(0, 12)
                    .trim(this) + "...";
            if (title.length > 13) {
                title = shortTitle
            }

            element.html(
                '<div id="'+event.id+'">'+
                icon_element_type +
                ' '+ event.name +'|'+ time +
                '<br>'+
                title+
                '</div>'
            );

            element.popover({
                title: '<div class="raw">'+
                '<span class="removeEvent glyphicon glyphicon-trash pull-right"  data-action="delete"></span>'+
               'Занятие: ' +
                event.title +
                '</div>',
                content: content,
                html: true,
                trigger: 'manual',
                container: 'body'
            });

            element.on('click', function(){
                var redirect_url = url+'/'+event.id+'/edit';
                $(location).attr('href',redirect_url);
            })
        },
        eventClick: function(calEvent, jsEvent, view) {

        },
        dayClick: function(date, jsEvent, view) {
            date = date.format();
            var date_array = date.split("-");
            var day =  parseInt(date_array[2]);
            var month = parseInt(date_array[1]);
            var year = parseInt(date_array[0]);
            var hours = 19;
            var minutes = '00';
            $("#period_commence_datetime_3i").val(day);
            $("#period_commence_datetime_2i").val(month);
            $("#period_commence_datetime_1i").val(year);
            $("#period_commence_datetime_4i").val(hours);
            $("#period_commence_datetime_5i").val(minutes);

        },
        eventMouseover: function(calEvent, jsEvent, view) {
            var _this = this;
            $('.popover').hide();
            $(_this).popover('show');
            console.log('show');
            $('.removeEvent').on('click',function(){
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
                    var redirect_url = url+'/';
                    $(location).attr('href',redirect_url);
                }
            });
            $(".popover").on("mouseleave", function () {
                $(_this).popover('hide');
            });
            $(_this).on('mouseleave', function(){
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 50);
            });

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

