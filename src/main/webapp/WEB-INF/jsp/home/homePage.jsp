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

    })
</script>

<style>
    .file-manager-board {
        position: fixed;
        left: 200px;
        top: 60px;
        background-color: white;
        border-radius:10px;
        overflow: auto;
        opacity: 0.9;
    }
</style>
<style>
    .directory-show-board {
        position: relative;
        top: 10px;
        width: 400px;
        background-color: white;
        border-radius:10px;
    }
</style>

<style>
    .picture-show-board{
        position: relative;
        left: 150px;
        top: 100px;
        background-color: white;
        border-radius:10px;
        opacity:1;

        width: 1200px;
        height: 900px;
        object-fit: contain;

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
        border-color: #122b40;
        padding: 20px;

    }
</style>
<style>
    .table-show-board{
    position:relative;
    top:10px;
}
</style>



<%@ include file="include/navigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>


<div class="file-manager-board">
    <c:choose>
        <c:when test="${empty normalFile}">
    <a href="#" onclick="openNewDirectoryMenu()"><button class="layui-btn layui-btn-normal">新建文件夹</button></a>

    <a href="uploadPage">
        <button class="layui-btn layui-btn-normal">
            上传文件
        </button>
    </a>

    <%@ include file="include/orderNav.jsp"%>
    <%@ include file="include/searchBox.jsp"%>

    <div>
        <c:choose>
            <c:when test="${empty parentDirList}">
                <div class="directory-show-board">全部文件</div>
            </c:when>


            <c:otherwise>
                <c:forEach items="${parentDirList}" var="Directory">
                    <a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}&fileId=0" style="color: #4169E1;">${Directory.name}>></a>
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
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table" >


        <thead>
        <tr>
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
                <td ><img src="/EasyCloudStorage/img/home/folder.png" width="30px" height="30px"/> </td>
                <td ><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}&fileId=0">${Directory.name}</a></td>
                <td>-</td>
                <td >${Directory.displayTime}</td>
            </tr>
        </c:forEach>

        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.fileId}" sortType="${NormalFile.sortType}">
                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <c:choose>
                    <c:when test="${NormalFile.type=='image/jpeg'||NormalFile.type=='image/png'||NormalFile.type=='text/plain'}">
                <td><a  href="/EasyCloudStorage/homePage?fileId=${NormalFile.fileId}&dirId=${currentDir.dirId}">${NormalFile.name}</a></td>
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
<!--div  class="testClass" style="text-align: left">
    <c:forEach items="${currentDirectories}" var="Directory">
       <li>
           <input type="radio" name="dir" value=${Directory.dirId} title=${Directory.name}>
                ${Directory.name}
            </input>
       </li>
    </c:forEach>
</div-->
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
            <button type="button" class="layui-btn layui-btn-normal"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="picture-show-board" >
                <img width="80%"  height: auto src="/Data${filePath}">
            </div>
        </c:when>
        <c:when test="${normalFile.type=='text/plain'}">
            <button type="button" class="layui-btn layui-btn-normal"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="text-show-board" >
                ${fileContent}
            </div>
        </c:when>
    </c:choose>

</body>
</html>

