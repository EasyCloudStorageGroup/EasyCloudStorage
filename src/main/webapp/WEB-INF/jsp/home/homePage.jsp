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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../shared/sharedHeader.jsp"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/homePage.css?v=1.0"/>
<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/fileShow.css"/>

<script>
    $(function() {
        var leftNavW = 200;
        var topNavH = 70;
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
        $("body").css("background", "${sessionScope.user.getBgUrl()}");
        $(".imgShow").css("background", "${sessionScope.user.getBgUrl()}");
        $(".imgShow").css("background-size","264px 180px");
        $("#passwordText").hide();
    })
</script>

<style>
    .file-manager-board {
        position: fixed;
        left: 200px;
        top: 70px;
        background-color: white;
        border-radius:10px;

        opacity: 0.95;
    }
</style>
<style>
    .directory-show-board {
        position: relative;
        top: 10px;
        font-size: 16px;
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
        display: flex;
        justify-content: center;

        width: 1200px;
        height: 900px;
    }
</style>
<style>
    .none-notice-board{
        position: absolute;
        left: 150px;
        top: 200px;
        width: 800px;
        height: auto;
    }
</style>
<style>
    .text-show-board{
        position: relative;
        left: 300px;
        top: 60px;
        width: 40%;
        height:70%;
        overflow: auto;
        background-color:white;

        border-bottom-left-radius: 20px;
        border-top-left-radius: 20px;
        opacity:0.9;
        border-style: solid;
        border-color: #40AFFE;
        padding: 20px;
    }
</style>
<style>
    .music-show-board{
        position: relative;
        left: 380px;
        top: 560px;
    }
</style>
<style>
    .video-show-board{
        position: relative;
        left: 100px;
        top: 50px;
    }
</style>
<style>
    .table-show-board{
        position:relative;
        top:10px;
        overflow: auto;
        height: 800px;
        opacity: 0.95;
    }

    .none-notice-board {
        text-align: center;
        width: 500px;
        margin-left: 100px;
    }

    .but-ops-div {
        margin-top: 10px;
    }
</style>


<%@ include file="include/navigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>

<!--homePage右下角大部分的展示内容-->
<div class="file-manager-board">
<!--该choose选择是展示目录信息还是文件具体内容-->
    <div class="but-ops-div">
<c:choose>
    <%-- 首先是目录信息--%>
    <c:when test="${empty normalFile}">
        <a href="#" onclick="openNewDirectoryMenu()"><button 	class="layui-btn layui-btn-normal" style="margin-left: 20px">新建文件夹</button></a>


        <div class="site-demo-button" id="layerDemo" style="float: left;margin-left: 1%">
            <button class="layui-btn site-demo-button" data-method="setTop">上传文件</button>
        </div>

        <%@ include file="include/orderNav.jsp"%>
        <%@ include file="include/searchBox.jsp"%>
    </div>

     <div class="directory-show-board">

         <%-- 目录信息的两种展示方式，分为不存在父目录，和存在父目录两种情况--%>
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
            <%--文件夹的展示情况，存在为空或者不为空两种情况--%>
<c:choose>
    <c:when test="${empty currentDirectories&&empty currentNormalFiles}">


        <div class="none-notice-board">
            <img src="/EasyCloudStorage/img/home/emptyfile.png" style="width:100px;height: 100px;" />
            <div>当前没有任何文件哦,赶紧上传一个吧！</div>
        </div>
    </c:when>

    <c:otherwise>
<div class="table-show-board">
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table">
        <thead>
        <br/><tr><input type="checkbox" height="30px" onclick="selectAll(this)"><label>全选</label></tr>
        <tr>
            <th >
                <button class="layui-btn layui-btn-normal" type="submit" id="download_btn" >下载</button>
            </th>

            <th lay-data="{field:'type', width:80}"style="width: 100px"></th>
            <th lay-data="{field:'username', width:80}"style="width: 350px">名称</th>
            <th lay-data="{field:'type', width:180}"style="width: 150px">类型</th>
            <th lay-data="{field:'joinTime', width:180}"style="width: 150px">最后修改时间</th>

        </tr>
        </thead>
            <%--文件夹不为空的情况下，优先展示其中的子文件夹--%>
        <tbody>
        <c:forEach items="${currentDirectories}" var="Directory">
            <tr href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" class="dirClass" id="${Directory.dirId}" sortType="Directory">
                <td style="width: 10%"><input type="checkbox" value="${Directory.dirId}" name="check2"></td>   <%--多选框 --%>
                <td style="width: 10%"><img src="/EasyCloudStorage/img/home/folder.png" width="30px" height="30px"/> </td>   <%-- 文件夹图片--%>
                <td style="width: 40%"><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}"style="width: 350px">${Directory.name}</a></td> <%-- 文件名，以及跳转的点击接口--%>
                <td style="width: 20%">-</td>           <%-- 文件夹类型，由于不存在所以写为"-"--%>
                <td style="width: 20%">${Directory.displayTime}</td>    <%-- 文件的最后一次改动时间--%>
            </tr>
        </c:forEach>
            <%-- 文件夹不为空的情况下，之后展示其中的普通文件--%>

        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.fileId}" sortType="${NormalFile.sortType}">
                <td><input type="checkbox" value="${NormalFile.fileId}" name="check"></td>    <!--下载的多选框-->
                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>        <!--文件图片-->
                <!--该choose决定了文件是否可以接着跳转查看详细信息，目前支持txt，jpg，MP3等格式的预览-->
                <c:choose>
                    <%-- 以下文件类型能接着跳转查看详细信息--%>

                    <c:when test="${NormalFile.type=='image/jpeg'||NormalFile.type=='image/png'||NormalFile.type=='text/plain'||NormalFile.type=='audio/mp3'||NormalFile.type=='video/mp4'}">
                <td><a  href="/EasyCloudStorage/homePage?fileId=${NormalFile.fileId}">${NormalFile.name}</a></td>
                    </c:when>
                    <%-- 其他文件只能看到文件名，无法点击--%>

                    <c:otherwise>
                        <td>${NormalFile.name}</td>
                    </c:otherwise>
                </c:choose>
                <td>${NormalFile.type}</td>     <!--文件类型-->
                <td>${NormalFile.displayTime}</td>     <!--文件最后改动时间-->
                <td><button type="submit" onclick="getFileId(this.value)" class="layui-btn layui-btn-normal" data-toggle="modal" data-target="#myModal" value="${NormalFile.fileId}">分享</button></td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>
    </c:otherwise>
</c:choose>
</div>


<ul class="client_menu" id="clientMenu" style="background-color: #f0f0f0">
    <li><a href="#" onclick="openRenameFileMenu()" data-type="rename">重命名</a></li>
    <li><a href="#" onclick="openDeleteFileMenu()">删除</a></li>
    <li><a href="#" onclick="openMoveFileMenu()">移动到</a></li>
</ul>
<script src="js/menu.js"></script>
    </c:when>
        <%-- 这是具体的文件详细信息--%>
        <%--图片展示 --%>

        <c:when test="${normalFile.type=='image/jpeg'||normalFile.type=='image/png'}">


            <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>

            <div class="picture-show-board" >

                <img height="70%"  width: auto   src="/Data${filePath}">
            </div>


        </c:when>
        <%-- 文本展示--%>

        <c:when test="${normalFile.type=='text/plain'}">

        <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
        <div class="text-show-board" >

                ${fileContent}
            </div>

            <%--mp3展示 --%>
        </c:when>
        <c:when test="${normalFile.type=='audio/mp3'}">

                <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
                <img height="500px"  width="500px"  style="position: absolute;left: 380px;top: 100px;opacity: 0.95;border-top-left-radius:2em;
border-top-right-radius:2em;" src="/EasyCloudStorage/img/home/music2.png">
                <div class="music-show-board" >

                    <audio loop="loop" autoplay="autoplay" style="width: 500px;opacity: 0.95;" src="/Data${filePath}" controls="controls" ></audio>
                </div>

        </c:when>
        <%--mp4展示 --%>

        <c:when test="${normalFile.type=='video/mp4'}">

        <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="video-show-board">

                <video  autoplay="autoplay" src="/Data${filePath}"   width="1000px"  height="600px" controls="controls"/>
            </div>
        </c:when>
    </c:choose>
<!--table-show-board所有展示内容结束-->

<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
<script src="js/FileManager/download.js"></script>
<script>
    $("#download_btn").click(function () {
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
</script>

<script><%--用于选择所有文件--%>
    function selectAll(input) {
        var result = false;
        if(input.checked==true)
            result=true;
        $("input[name='check']").each(function () {
            this.checked=result;
        })
        $("input[name='check2']").each(function () {
            this.checked=result;
        })
    }
</script>
<%--王浩宇添加--%>
<script src="/EasyCloudStorage/layui/lay/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/EasyCloudStorage/js/FileManager/upload.js">
</script>
<%--文件分享模块--%>
<link href="/EasyCloudStorage/bootstrap/css/bootstrap.min.css">
<script src="/EasyCloudStorage/bootstrap/js/bootstrap.min.js"></script>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">文件分享</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label><input name="sharing" type="radio" value="private" id="private">加密</label>
                    <label><input name="sharing" type="radio" value="public" id="public">公开</label>
                </div>
                <div>
                    <label><input type="text" class="form-control" id="linkText"></label>
                    <label><input type="text" class="form-control" id="passwordText" placeholder="请输入加密密钥"></label>
                </div>
                <div class="btn-group">
                    <button type="button" class="layui-btn layui-btn-normal" id="createLink">生成链接</button>
                    <button id="copyLink" type="button" class="layui-btn layui-btn-normal" onclick="copyText()">复制链接</button>
                    <div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
            </div>
        </div>
            </div>
        </div>
    </div>
</div>
<script>
    var fileId = 0;
    var linkHead = "http://localhost:8080";
    var password = "";
    function getFileId(btn) {
        fileId = btn;
    }
    function copyText() {
        var ele = document.getElementById("linkText");
        ele.select();
        document.execCommand("Copy");
    }
    function randomWord(randomFlag, min, max) {
        var str = "";
        range = min;
        arr = ['2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm','n', 'p',
        'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N','P', 'Q'
        ,'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        if(randomFlag){
            range = Math.round(Math.random() * (max - min)) + min;
        }
        for(var i = 0; i < range; i++){
            pos = Math.round(Math.random()*(arr.length - 1));
            str += arr[pos];
        }
        return str;
    }
    $("#private").click(function () {
        $("#passwordText").show();
    })
    $("#public").click(function () {
        $("#passwordText").hide();
    })
    $("#createLink").click(function () {
        if($("input[name='sharing']:checked").val() === "public"){
            var link = linkHead + "/EasyCloudStorage/linkSharing/";
            var str = randomWord(false, 10);
            $("#linkText").val(link + str);
        }
        else if($("input[name='sharing']:checked").val() === "private"){
            var link = linkHead + "/EasyCloudStorage/linkSharing/";
            var str = randomWord(false, 10);
            $("#linkText").val(link + str);
            password = randomWord(false, 4);
            $("#passwordText").val(password);
        }
        var  data = {
            "fileId": fileId,
            "str" : str,
            "password": password
        };
        $.ajax({
            type: "post",
            url : "sharingData",
            data: data
        });
        password = "";
    })
    $("#close").click(function () {
        $("#linkText").val("");
        $("#passwordText").val("");
    })
    
</script>
</body>
</html>

