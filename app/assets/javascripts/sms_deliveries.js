$(window).on('page:change', function() {
    if (($(".sms_deliveries.new").length == 0)) {
        return;
    }
// скрипт не работает при переходе из contact_lists надо сделать проверку на страницу

    var messageTextField = $('#text-field');

    var count = function(text) {
        var messageInfo = SmsCounter.count(text);
        $("#char-num").text(messageInfo.length);
        $("#sms-count").text(messageInfo.messages);
    };

    var text = messageTextField.val();
    count(text);
    messageTextField.keyup(function () {
        var text = $(this).val();
        count(text);
    });

    Dropzone.autoDiscover = false;

    Dropzone.options.myAwesomeDropzone = {
        maxFilesize: 2,
        clickable: true,
        addRemoveLinks: true,
        acceptedFiles: '.xlsx, .xls',
        dictDefaultMessage: "Нажмите или Перетащите Файл",
        maxFiles: 1,
        headers: {
            'X-CSRF-Token': $('input[name="authenticity_token"]').val()
        }
    };

    var myDropzone = new Dropzone("div#my-awesome-dropzone", { url: $("#my-awesome-dropzone").data("url")});

    myDropzone.on("success", function(response, data) {
        var $contactListSelectBox = $("#sms_delivery_contact_list_id");
        $contactListSelectBox.prepend(
            "<option value='"+data.id+"'>"+data.title+"</option>"
        );
        $contactListSelectBox.val($("#sms_delivery_contact_list_id option:first").val());
    });

});