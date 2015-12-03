$(window).on("page:change", function() {

    var cells, desired_width, table_width;
    var $sortable = $('#sortable');
    if ($sortable.length > 0) {
        table_width = $sortable.width();
        cells = $('.table').find('tr')[0].cells.length;
        desired_width = table_width / cells + 'px';
        $('.table td').css('width', desired_width);
        $sortable.sortable({
            axis: 'y',
            items: '.item',
            cursor: 'move',
            sort: function(e, ui) {
                ui.item.addClass('active-item-shadow');
            },
            stop: function(e, ui) {
                ui.item.removeClass('active-item-shadow');
                ui.item.children('td').effect('highlight', {}, 1000);
            },
            update: function(e, ui) {
                var item_id, position, url;
                item_id = ui.item.data('item-id');
                url = $('[data-action="elements-table"]').attr('data-update-position-url');
                position = parseInt(ui.item.index()) - 1;
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: {
                        course_element_id: item_id,
                        row_order_position: position
                    }
                });
            }
        });
    }
});