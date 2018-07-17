
$(function () {
    $("#download_btn, #download-but").click(function () {
        var idCollection = [];
        var idCollection2 = [];
        $("input[name = 'check']:checked").each(function (i) {
            idCollection[i] = $(this).val();
        });
        $("input[name = 'check2']:checked").each(function (i) {
            idCollection2[i] = $(this).val();
        })

        if(!(idCollection.length === 0 && idCollection2.length === 0)) {
            var data = {
                "idCollection[]": idCollection,
                "idCollection2[]": idCollection2
            };
            window.location = "download?" + $.param(data);
        }
    })
});
