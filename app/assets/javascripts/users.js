$(window).on("page:change", function() {

    $('#courses').change(function(event){
    var subcategory = $(this).closest('div').next().find('#groups');
    var selectedCat = $(this).val();
    if(selectedCat != false) {
        $(subcategory).prop('disabled', false).val(0);
        $(subcategory).find("[data-target='" + selectedCat + "']").show()
        $(subcategory).find("[data-target!='" + selectedCat + "']").hide()
    }   else {
        $(subcategory).prop('disabled', true).val(0);
    }
});
});