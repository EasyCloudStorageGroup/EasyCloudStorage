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
<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/fileShow.css">
<script src="layui/layui.js"></script>

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

<style>
    .empty-notice-board{
        position: relative;
        left: 500px;
        top: 300px;
        background-color: white;
        border-radius:10px;

        color:rgba(0,0,0,0.5)

    }
</style>

<%@ include file="../shared/navigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>


<div class="file-manager-board">
    <a href="#" onclick="openNewDirectoryMenu()"><button class="layui-btn layui-btn-normal">新建文件夹</button></a>
    <%@ include file="include/searchBox.jsp"%>
    <%@ include file="include/orderNav.jsp"%>

<c:choose>
    <c:when test="${empty parentDirList}">
        全部文件
    </c:when>

    <c:otherwise>
        <c:forEach items="${parentDirList}" var="Directory">
            <a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}">${Directory.name}>></a>
        </c:forEach>

        ${currentDir.name}
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${empty currentDirectories&&empty currentNormalFiles}">

        <div class="empty-notice-board" ><h1>当前没有任何文件哦,赶紧上传一个吧！</h1></div>

    </c:when>
    <c:otherwise>
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table">
        <thead>
        <tr>
            <th lay-data="{field:'type', width:50}"> 类型 </th>
            <th lay-data="{field:'username', width:50}">名称</th>
            <th lay-data="{field:'joinTime', width:50}">最后移动时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${currentDirectories}" var="Directory">
            <tr href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" class="dirClass" id="${Directory.dirId}"
            sortType="Directory">
                <td ><img src="/EasyCloudStorage/img/home/folder.png" width="30px" height="30px"/> </td>

                <td ><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}">${Directory.name}</a></td>

                <td >${Directory.displayTime}</td>
            </tr>
        </c:forEach>

        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.fileId}" sortType="${NormalFile.sortType}">
                <td ><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <td >${NormalFile.name}.${NormalFile.type}</td>
                <td>${NormalFile.displayTime}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    </c:otherwise>
</c:choose>
</div>
<div  class="testClass" style="text-align: left;display: none">
    <c:forEach items="${directoryList}" var="Directory">
       <li>
           <input type="radio" name="dir" value=${Directory.dirId} title=${Directory.name}>
                ${Directory.name}
            </input>
       </li>
    </c:forEach>
</div>
<ul class="client_menu" id="clientMenu" style="background-color: dodgerblue">
    <li><a href="#" class="demo" onclick="openRenameFileMenu()" data-type="rename">重命名</a></li>
    <li><a href="#" onclick="openDeleteFileMenu()">删除</a></li>
    <li><a href="#" onclick="openMoveFileMenu()">移动到</a></li>
</ul>
<div style="display: none" id="formTest">
    <label>重命名为：</label>
    <input type="text" name="searchForm.name" />
</div>
<script src="js/menu.js"></script>
<script src="js/menuLayer.js"></script>
</body>
</html>
