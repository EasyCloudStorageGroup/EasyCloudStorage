<%--
  Created by IntelliJ IDEA.
  User: VULCAN
  Date: 2018/7/9
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../shared/sharedHeader.jsp"%>
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
    .detail-show-board {
        position: fixed;
        left: 200px;
        top: 60px;
        background-color: white;
        border-radius:10px;
        overflow: auto;
    }
</style>


<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>

<div class="detail-show-board">
    <c:choose>
        <c:when test="${file.type=='jpg'}">
    <img src="${file.realPath}'\'${file.name}.${file.type}">
    </c:when>
    <c:otherwise>

    </c:otherwise>

    </c:choose>
</div>


