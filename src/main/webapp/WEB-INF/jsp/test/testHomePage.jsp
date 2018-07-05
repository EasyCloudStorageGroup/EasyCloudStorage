<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/5/2018
  Time: 8:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<%@ include file="../shared/sharedHeader.jsp"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/homePage.css"/>

<script>
    $(function() {
        var leftNavW = 200;
        var topNavH = 60;
        var boardWidth = $(document).width() - leftNavW - 15;
        var boardHeight = $(document).height() - topNavH;
        $(".file-manager-board").css("width", boardWidth+"px");
        $(".file-manager-board").css("height", boardHeight+"px");

        $(window).resize(function() {
            var boardWidth = $(document).width() - leftNavW - 15;
            var boardHeight = $(document).height() - topNavH;
            $(".file-manager-board").css("width", boardWidth+"px");
            $(".file-manager-board").css("height", boardHeight+"px");
        });

    })
</script>

<style>
    .file-manager-board {
        position: fixed;
        left: 200px;
        top: 60px;
        background-color: white;
        border-radius:10px;
        z-index: -1;
    }
</style>

<%@ include file="../shared/navigator.jsp"%>

<div class="file-manager-board">

</div>

</body>
</html>