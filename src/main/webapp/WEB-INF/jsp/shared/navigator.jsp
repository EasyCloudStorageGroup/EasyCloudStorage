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
        <a href="homePage">
            <img src="/EasyCloudStorage/img/home/logo.png">
            轻松云存储
        </a>
    </div>
    <ul class="layui-nav layui-nav-tree layui-nav-side left-navigator">
        <li class="layui-nav-item layui-this"><a href="homePage">全部文件</a></li>
        <li class="layui-nav-item"><a>图片</a></li>
        <li class="layui-nav-item"><a>视频</a></li>
        <li class="layui-nav-item"><a>音乐</a></li>
        <li class="layui-nav-item"><a>其它</a></li>
    </ul>

    <ul class="layui-nav top-left-navigator">
        <li class="layui-nav-item layui-this"><a href="homePage">网盘</a></li>
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
            <a><img src="/EasyCloudStorage/img/home/change-bg-icon.png" class="change-bg-icon"></a>
        </li>
    </ul>
</div>