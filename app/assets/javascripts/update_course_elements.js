$(window).on("page:change", function() {

    var cells, desired_width, table_width;
    var $sortable = $('#sortable');
    if ($sortable.length > 0) {
        table_width = $sortable.width();
        var $heading = $sortable.find('tr').first();
        var widths = {};

        var ths = $heading.find('th');
        for (var i = 0; i < ths.length; i++) {
            widths[i] = $(ths[i]).width();
        }

        var rebuildPositions = function() {
            $sortable.find('[data-display="position"]').each(function(index) {
                $(this).html(index + 1);
            });
        };

        $sortable.sortable({
            axis: 'y',
            items: '.item',
            cursor: 'move',
            handle: '.elements-table-handle',
            sort: function(e, ui) {
                ui.item.addClass('active-item-shadow');
                ui.item.find('td').each(function(index) {
                    $(this).width(widths[index]);
                });
                ui.placeholder.height(ui.item.height());
            },
            stop: function(e, ui) {
                ui.item.removeClass('active-item-shadow');
                ui.item.children('td').effect('highlight', {}, 1000);
                rebuildPositions();
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