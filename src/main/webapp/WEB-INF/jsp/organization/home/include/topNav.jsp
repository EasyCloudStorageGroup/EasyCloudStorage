<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/10/2018
  Time: 6:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<script>
    layui.use('element', function(){
        var element = layui.element;
    });
</script>

<style>
    .navigator-logo {
        position: relative;
        width: 300px;
        top: 15px;
        left: 15px;
    }

    .navigator-logo a:hover {
        text-decoration: none;
    }

    .navigator-logo a {
        color: white;
        font: 23px "Microsoft YaHei", arial, SimSun, 宋体;
    }

    .navigator-logo img {
        width: 45px;
        height: 45px;
    }

    .navigator a:hover {
        text-decoration: none;
    }

    .top-left-navigator {
        position: fixed;
        top: 0px;
        left: 240px;
        background-color: rgba(255, 255, 255, 0);
    }

    .top-left-navigator .layui-nav-bar {
        background-color: white !important;
    }

    .top-left-navigator .layui-this:after {
        background-color: white;
    }

    .top-left-navigator .layui-nav-item {
        margin-right: 50px;
    }

    .top-right-navigator {
        position: fixed;
        top: 0px;
        right: 100px;
        background-color: rgba(255, 255, 255, 0);
    }

    .top-right-navigator-avatar {
        width: 35px;
        height: 35px;
        border-radius:50%;
        margin-right: 8px;
    }

    .top-right-navigator .layui-nav-bar, .top-right-navigator .layui-this:after {
        display: none;
    }

    .top-right-navigator .layui-nav-item .layui-nav-child dd {
        line-height: 40px;
    }

    .top-right-navigator .layui-nav-item {
        margin-right: 15px;
    }

    .change-bg-icon {
        width: 30px;
        height: 30px;
    }

    .top-right-navigator {
        z-index: 100;
    }
</style>

<div class="navigator">
    <div class="navigator-logo">
        <a href="homePage?dirId=0">
            <img src="/EasyCloudStorage/img/home/logo.png">
            轻松云存储
        </a>
    </div>

    <ul class="layui-nav top-left-navigator">
        <li class="layui-nav-item"><a href="homePage?dirId=0&fileId=0">网盘</a></li>
        <li class="layui-nav-item layui-this"><a>组织</a></li>
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

<link rel="stylesheet" href="/EasyCloudStorage/css/changeSkin/changeSkin.css">

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