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

<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/homePage.css?v=1.0"/>
<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/fileShow.css"/>

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
        $("body").css("background", "${sessionScope.user.getBgUrl()}")

    })
</script>

<style>
    .file-manager-board {
        position: fixed;
        left: 200px;
        top: 60px;
        background-color: white;
        border-radius:10px;

        opacity: 0.9;
    }
</style>
<style>
    .directory-show-board {
        position: relative;
        top: 10px;
        width: 400px;

        border-radius:10px;
    }
</style>
<style type="text/css">
    a:link {
        text-decoration: none;
        color: black;
    }
    a:visited {
        text-decoration: none;
        color: black;
    }
    a:hover {
        text-decoration: none;
        color: #007DDB;
    }
    a:active {
        text-decoration: none;
        color: black;
    }
</style>
<style>
    .picture-show-board{
        position: relative;
        opacity:1;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 1200px;
        height: 800px;


    }
</style>
<style>
    .text-show-board{
        position: relative;
        left: 300px;
        top: 75px;
        width: 600px;
        background-color:white;
        border-radius:30px;
        opacity:0.9;
        border-style: solid;
        border-color: #40AFFE;
        padding: 20px;

    }
</style>
<style>
    .table-show-board{
    position:relative;
    top:10px;
        overflow: auto;
        height: 800px;
}
</style>



<%@ include file="include/navigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>


<div class="file-manager-board">
    <c:choose>
        <c:when test="${empty normalFile}">
    <a href="#" onclick="openNewDirectoryMenu()"><button 	class="layui-btn layui-btn-normal" style="margin-left: 20px">新建文件夹</button></a>

    <a href="uploadPage">
        <button 	class="layui-btn layui-btn-normal">
            上传文件
        </button>
    </a>

    <%@ include file="include/orderNav.jsp"%>
    <%@ include file="include/searchBox.jsp"%>

            <div class="directory-show-board">
        <c:choose>
            <c:when test="${empty parentDirList}">
              全部文件
            </c:when>

            <c:otherwise>
                <c:forEach items="${parentDirList}" var="Directory">
                    <a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" style="color: #4169E1">${Directory.name}>></a>
                </c:forEach>

                ${currentDir.name}
            </c:otherwise>
        </c:choose>
    </div>

    <script src="/EasyCloudStorage/js/homePage/fileShow.js" charset="utf-8"></script>

<c:choose>
    <c:when test="${empty currentDirectories&&empty currentNormalFiles}">

        <div class="picture-show-board" ><img src="/EasyCloudStorage/img/home/smile.PNG" width="400px" height="320px"/>
            <h2>当前没有任何文件哦,赶紧上传一个吧！</h2></div>

    </c:when>
    <c:otherwise>

<div class="table-show-board">
    <%--<form action="download" method="post">--%>
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table" >


        <thead>
        <tr>
            <th><button class="layui-btn layui-btn-normal" type="submit" id="download_btn">下载</button></th>
            <th lay-data="{field:'type', width:50}"></th>
            <th lay-data="{field:'username', width:50}">名称</th>
            <th lay-data="{field:'type', width:50}">类型</th>
            <th lay-data="{field:'joinTime', width:50}">最后修改时间</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${currentDirectories}" var="Directory">
            <tr href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" class="dirClass" id="${Directory.dirId}"
            sortType="Directory">
                <td><input type="checkbox" value="${Directory.realPath}" name="check"></td>
                <td ><img src="/EasyCloudStorage/img/home/folder.png" width="30px" height="30px"/> </td>
                <td ><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}">${Directory.name}</a></td>
                <td>-</td>
                <td >${Directory.displayTime}</td>
            </tr>
        </c:forEach>

        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.realPath}" sortType="${NormalFile.sortType}">
                <td><input type="checkbox" value="${NormalFile.realPath}" name="check"></td>
                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <c:choose>
                    <c:when test="${NormalFile.type=='image/jpeg'||NormalFile.type=='image/png'||NormalFile.type=='text/plain'}">
                <td><a  href="/EasyCloudStorage/homePage?fileId=${NormalFile.fileId}">${NormalFile.name}</a></td>
                    </c:when>
                    <c:otherwise>
                        <td>${NormalFile.name}</td>
                    </c:otherwise>
                </c:choose>
                <td>${NormalFile.type}</td>
                <td>${NormalFile.displayTime}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>
    </c:otherwise>
</c:choose>
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

    </c:when>
        <c:when test="${normalFile.type=='image/jpeg'||normalFile.type=='image/png'}">
            <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="picture-show-board" >
                <img height="70%"  width: auto   src="/Data${filePath}">
            </div>
        </c:when>
        <c:when test="${normalFile.type=='text/plain'}">
            <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="text-show-board" >
                ${fileContent}
            </div>
        </c:when>
    </c:choose>

<script src="js/menuLayer.js"></script>
<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
<script>
    $("#download_btn").click(function () {
        var paths = [];
        $("input[name = 'check']:checked").each(function (i) {
            paths[i] = $(this).val();
        });
        var data = {
            "paths[]": paths
        };
        window.location = "download?" + $.param(data);
    })
</script>
</body>
</html>

