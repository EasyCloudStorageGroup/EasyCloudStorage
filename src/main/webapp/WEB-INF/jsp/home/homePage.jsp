<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/5/2018
  Time: 6:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

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
    }
</style>

<%@ include file="../shared/navigator.jsp"%>

<div class="file-manager-board">
    <%@ include file="include/orderNav.jsp"%>
    <table width="80%" align="center">
        <tr>
            <td>编号</td>
            <td>名字</td>
            <td>最后一次修改时间</td>
            <td>路径</td>
        </tr>
        <c:forEach items="${directoryList}" var="Directory">
            <tr>
                <td><a href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" id=${Directory.dirId} > ${Directory.dirId }</a></td>
                <td>${Directory.name}</td>
                <td>${Directory.lastMovedTime}</td>
                <td>${Directory.realPath}</td>
            </tr>
        </c:forEach>
        <c:forEach items="${normalFileList}" var="NormalFile">
            <tr>
                <td>${NormalFile.fileId }</td>
                <td>${NormalFile.name}</td>
                <td>${NormalFile.lastMovedTime}</td>
                <td>${NormalFile.realPath}</td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>
