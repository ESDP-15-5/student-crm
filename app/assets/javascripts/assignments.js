$(document).ready(function(){
    var groups = $('#group_').html();
    var course = $('#course_ option:selected').text();

    if (course.length > 0) {
        var options = $(groups).filter("optgroup[label='" + course + "']").html();
        if (options) {
            $('#group_').html(options);
            $("#group_").prepend("<option value=''></option>");
        } else {
            $('#group_').empty();
        };
    };
});

$(document).ready(function(){
    $('#course_').change(function(){
        $('#group_').empty();
        $('#filter_assignments').submit();
    });
    $('#group_').change(function(){
        $('#filter_assignments').submit();
    });
});

//this is for filtering by group
$(document).bind('page:change', function(){
    console.log('3');
    var groups = $('#group_').html();
    $('#course_').change(function(){
        console.log('2')
        var course = $('#course_ option:selected').text();
        var groups_options = $(groups).filter("optgroup[label='" + course + "']").html();
        if (groups_options) {
            $('#group_').html(groups_options);
            $("#group_").prepend("<option value=''></option>");
        } else {
            $('#group_').empty();
        };
    });
});