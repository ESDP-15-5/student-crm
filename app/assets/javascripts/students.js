$(document).bind('page:change', function() {
    if (($(".students.index").length == 0)) {
        return;
    }
    $('.submit_file').on('change', function() {
        $(this).closest('form').submit();

    });

});

