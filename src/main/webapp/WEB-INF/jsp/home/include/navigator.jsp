    <%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/4/2018
  Time: 3:46 PM
  To change this template use File | Settings | File Templates.
--%>

<%--
    导航栏组件
    用法写在 test/testHomePage 里了
--%>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/navigator.css"/>
<link rel="stylesheet" href="/EasyCloudStorage/css/changeSkin/changeSkin.css">
<script src="/EasyCloudStorage/js/homePage/navigator.js"></script>




<div class="navigator">
    <div class="navigator-logo">
        <a href="homePage?dirId=0">
            <img src="/EasyCloudStorage/img/home/logo.png">
            轻松云存储
        </a>
    </div>
    <ul class="layui-nav layui-nav-tree layui-nav-side left-navigator">
        <li class="layui-nav-item layui-this"><a href="homePage?dirId=0">全部文件</a></li>

        <li class="layui-nav-item" sortType="Picture"><a>图片</a></li>
        <li class="layui-nav-item" sortType="Vedio"><a>视频</a></li>
        <li class="layui-nav-item" sortType="Music"><a>音乐</a></li>
        <li class="layui-nav-item" sortType="Other"><a>其它</a></li>

    </ul>

    <ul class="layui-nav top-left-navigator">
        <li class="layui-nav-item layui-this"><a href="homePage?dirId=0">网盘</a></li>
        <li class="layui-nav-item"><a>其它</a></li>
    </ul>

    <ul class="layui-nav top-right-navigator">
        <li class="layui-nav-item">
            <a href="infoShow">
                <c:if test="${user.defaultAvatar==1}">
                    <c:if test="${user.sex=='male'}">
                        <img src="/EasyCloudStorage/img/avatar/default-avatar-male.png" class="top-right-navigator-avatar">${user.userName}
                    </c:if>
                    <c:if test="${user.sex=='female'}">
                        <img src="/EasyCloudStorage/img/avatar/default-avatar-female.png" class="top-right-navigator-avatar">${user.userName}
                    </c:if>
                </c:if>
                <c:if test="${user.defaultAvatar==0}">
                    <img src="/EasyCloudStorage/img/avatar/${user.accountId}.jpg" class="top-right-navigator-avatar">${user.userName}
                </c:if>
                <dl class="layui-nav-child">
                    <dd><a href="infoShow">修改信息</a></dd>
                    <dd><a href="logout">退出</a></dd>
                </dl>
            </a>
        </li>
        <li class="layui-nav-item">
            <a id="changeSkin"><img src="/EasyCloudStorage/img/home/change-bg-icon.png" class="change-bg-icon"></a>
        </li>
    </ul>
</div>

<div class="head">
    <div class="main">
        <div class="imgList">
                <img src="/EasyCloudStorage/img/changeSkin/1.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/2.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/3.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/4.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/5.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/6.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/7.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/8.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/9.jpg">
                <img src="/EasyCloudStorage/img/changeSkin/10.jpg">
        </div>
        <div class="imgShow"></div>
    </div>
    <div class="bottom"><button class="quit layui-btn">收起</button></div>
</div>
<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
<script type="text/javascript">
    var i = 0;
    $("#changeSkin").click(function(){
        $(".head").animate({height:"288px"},500);
    });
    $(".quit").click(function () {
        $(".head").animate({height:"0px"},500)
    });
    $(".imgList img").hover(function () {
        i = $(this).index();
        $(".imgShow").css("background", 'url(/EasyCloudStorage/img/changeSkin/'+ (i+1) +'.jpg)');
        $(".imgShow").css("background-size","264px 180px");
    });
    $(".imgList img").click(function () {
        $("body").css("background", 'url(/EasyCloudStorage/img/changeSkin/'+ (i+1) +'.jpg)');
    });
</script>