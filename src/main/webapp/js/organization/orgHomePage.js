
$(function () {
    var topNavH = 70;
    var boardHeight = $(window).height() - topNavH - 10;
    $(".orgMembersBoard > div").css("height", boardHeight+"px");
    $(".fileListBoard > div").css("height", boardHeight+"px");

    $(window).resize(function() {
        var boardHeight = $(window).height() - topNavH - 10;
        $(".orgMembersBoard > div").css("height", boardHeight+"px");
        $(".fileListBoard > div").css("height", boardHeight+"px");
    });
})