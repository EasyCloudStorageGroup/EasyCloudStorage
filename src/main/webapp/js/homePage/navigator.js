
layui.use('element', function(){
    var element = layui.element;
});

$(function() {
    $(".left-navigator li[sortType]").click(function () {
        var sortType = $(this).attr("sortType");
        $("tbody tr[sortType]").hide();
        $("tbody tr[sortType="+sortType+"]").show();
    })
});
