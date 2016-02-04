$(document).ready(function(){
    var groups = $('#group_').html();
    var course = $('#course_ option:selected').text();

    if (course.length > 0) {
        var options = $(groups).filter("optgroup[label='" + course + "']").html();
        options = "<option value=''></option>"+options;
        if (options) {
            $('#group_').html(options);
        } else {
            $('#group_').empty();
        }
    }

    $('#course_').change(function(){
        $('#filter_assignments').submit();
    });

    $('#group_').change(function(){
        $('#filter_assignments').submit();
    });
});