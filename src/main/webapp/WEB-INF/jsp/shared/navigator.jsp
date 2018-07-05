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
<script src="/EasyCloudStorage/js/homePage/navigator.js"></script>

<div class="navigator">
    <div class="navigator-logo">
        <a href="">
            <img src="/EasyCloudStorage/img/logo.png">
            轻松云存储
        </a>
    </div>
    <ul class="layui-nav layui-nav-tree layui-nav-side left-navigator">
        <li class="layui-nav-item layui-this"><a>全部文件</a></li>
        <li class="layui-nav-item"><a>图片</a></li>
        <li class="layui-nav-item"><a>视频</a></li>
        <li class="layui-nav-item"><a>音乐</a></li>
        <li class="layui-nav-item"><a>其它</a></li>
    </ul>

    <ul class="layui-nav top-left-navigator">
        <li class="layui-nav-item layui-this"><a href="">网盘</a></li>
        <li class="layui-nav-item"><a>其它</a></li>
    </ul>

    <ul class="layui-nav top-right-navigator">
        <li class="layui-nav-item">
            <a href=""><img src="/EasyCloudStorage/img/avatar/default-avatar-male.webp" class="top-right-navigator-avatar">${user.userName}</a>
            <dl class="layui-nav-child">
                <dd><a>修改信息</a></dd>
                <dd><a>退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a><img src="/EasyCloudStorage/img/change-bg-icon.png" class="change-bg-icon"></a>
        </li>
    </ul>
</div>