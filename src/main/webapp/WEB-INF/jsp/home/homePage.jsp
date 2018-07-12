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
        $("body").css("background", "${sessionScope.user.getBgUrl()}")
        $(".imgShow").css("background", "${sessionScope.user.getBgUrl()}")
        $(".imgShow").css("background-size","264px 180px");
    })
</script>

<style>
    .file-manager-board {
        position: fixed;
        left: 200px;
        top: 70px;
        background-color: white;
        border-radius:10px;

        opacity: 0.9;
    }
</style>
<style>
    .directory-show-board {
        position: relative;
        top: 10px;


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
        width: 40%;
        height:75%;
        overflow: auto;
        background-color:white;
        border-radius:30px;
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
}
</style>



<%@ include file="include/navigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>


<div class="file-manager-board">
    <c:choose>
        <c:when test="${empty normalFile}">
    <a href="#" onclick="openNewDirectoryMenu()"><button 	class="layui-btn layui-btn-normal" style="margin-left: 20px">新建文件夹</button></a>

            <div class="site-demo-button" id="layerDemo" style="float: left;margin-left: 1%">
        <button class="layui-btn site-demo-button" data-method="setTop">上传文件</button>
            </div>

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
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table"  >


        <thead>
        <tr>
            <th lay-data="{checkbox:true}" style="width: 60px">下载</th>
            <th lay-data="{field:'type'}"style="width: 100px"></th>
            <th lay-data="{field:'username'"style="width: 350px">名称</th>
            <th lay-data="{field:'type'}"style="width: 150px">类型</th>
            <th lay-data="{field:'joinTime'}"style="width: 150px">最后修改时间</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${currentDirectories}" var="Directory">
            <tr href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" class="dirClass" id="${Directory.dirId}" sortType="Directory">
                <td><input type="checkbox" value="${Directory.realPath}" name="check"></td>
                <td><img src="/EasyCloudStorage/img/home/folder.png" width="30px" height="30px"/> </td>
                <td><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}">${Directory.name}</a></td>

                <td>-</td>
                <td >${Directory.displayTime}</td>
            </tr>
        </c:forEach>

        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.fileId}" sortType="${NormalFile.sortType}">
                <td><input type="checkbox" value="${NormalFile.realPath}" name="check"></td>

                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <c:choose>
                    <c:when test="${NormalFile.type=='image/jpeg'||NormalFile.type=='image/png'||NormalFile.type=='text/plain'||NormalFile.type=='audio/mp3'||NormalFile.type=='video/mp4'}">
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
<script src="js/menu.js"></script>

    </c:when>
        <c:when test="${normalFile.type=='image/jpeg'||normalFile.type=='image/png'}">
            <div style="width:auto; height:800px;opacity: 0.85;background-image: url(/EasyCloudStorage/img/home/water.jpg);">
            <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="picture-show-board" >
                <img height="70%"  width: auto   src="/Data${filePath}">
            </div>
            </div>
        </c:when>
        <c:when test="${normalFile.type=='text/plain'}">
            <div style="width:auto; height:800px;opacity: 0.85;background-image: url(/EasyCloudStorage/img/home/water.jpg);">
        <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
        <div class="text-show-board" >
                ${fileContent}
            </div>
        </div>
        </c:when>
        <c:when test="${normalFile.type=='audio/mp3'}">
            <div style="width:auto; height:800px;opacity: 0.85;background-image: url(/EasyCloudStorage/img/home/water.jpg);">
                <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
                <img height="500px"  width="500px"  style="position: absolute;left: 380px;top: 100px;opacity: 0.8;border-top-left-radius:2em;
border-top-right-radius:2em;" src="/EasyCloudStorage/img/home/music2.png">
                <div class="music-show-board" >
                    <audio autoplay="autoplay" style="width: 500px;opacity: 0.8;" src="/Data${filePath}" controls="controls" ></audio>
                </div>
            </div>
        </c:when>
        <c:when test="${normalFile.type=='video/mp4'}">
            <div style="width:auto; height:800px;opacity: 0.85;background-image: url(/EasyCloudStorage/img/home/water.jpg);">
        <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 3px"><a href="javascript:" onclick="self.location=document.referrer;">返回</a> </button>
            <div class="video-show-board"><video  autoplay="autoplay" src="/Data${filePath}"   width="1000px"  height="600px" controls="controls">
            </video></div></div>
        </c:when>
    </c:choose>

<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
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
        var data = {
            "idCollection[]":idCollection,
            "idCollection2[]":idCollection2
        };
        window.location = "download?" + $.param(data);
    })
</script>
<%--王浩宇添加--%>
<script src="/EasyCloudStorage/layui/lay/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>

    var ifOn=false
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

        //触发事件
        var active = {
            setTop: function(){
                if (true==ifOn)return;
                ifOn=true
                var that = this;
                //多窗口模式，层叠置顶
                layer.open({
                    type: 2 //此处以iframe举例
                    ,title: '上传列表'
                    ,area: ['750px', '450px']
                    ,shade: 0
                    ,maxmin: true
                    ,resize:false
                    ,offset: 'rb'
                    ,content: '/EasyCloudStorage/uploadPage'
                    ,cancel: function(index, layero){


                        layer.confirm('确定要关闭此窗口吗，关闭后上传会被中断', {icon: 3, title:'提示'}, function(i){
                            //do something
                            layer.close(index)
                            layer.close(i);
                            ifOn=false
                        })
                        return false
                    }
                    // ,btn: ['继续弹出', '全部关闭'] //只是为了演示
                    // ,yes: function(){
                    //     $(that).click();
                    // }
                    // ,btn2: function(){
                    //     layer.closeAll();
                    // }

                    ,zIndex: layer.zIndex //重点1
                });
            }

            ,offset: function(othis){
                var type = othis.data('type')
                    ,text = othis.text();
                layer.open({
                    type: 1
                    ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    ,id: 'layerDemo'+type //防止重复弹出
                    ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
                    ,btn: '关闭全部'
                    ,btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    ,yes: function(){
                        layer.closeAll();
                    }
                });
            }
        };

        $('#layerDemo .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

    });
</script>

</body>
</html>

