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
        <a href="homePage">
            <img src="/EasyCloudStorage/img/home/logo.png">
            轻松云存储
        </a>
    </div>
    <ul class="layui-nav layui-nav-tree layui-nav-side left-navigator">
<c:choose>
    <c:when test="${navigatorType=='homePage'}">
        <c:choose>
            <c:when test="${empty type}">
                <li class="layui-nav-item layui-this"><a href="homePage">全部文件</a></li>
            </c:when>
            <c:otherwise><li class="layui-nav-item"><a href="homePage">全部文件</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='Picture'}">
                  <li class="layui-nav-item layui-this"><a href="homePage?type=Picture">图片</a></li>
            </c:when>
            <c:otherwise> <li class="layui-nav-item"><a href="homePage?type=Picture">图片</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='Video'}">
                <li class="layui-nav-item layui-this"><a href="homePage?type=Video">视频</a></li>
            </c:when>
            <c:otherwise> <li class="layui-nav-item"><a href="homePage?type=Video">视频</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='Music'}">
                <li class="layui-nav-item layui-this"><a href="homePage?type=Music">音乐</a></li>
            </c:when>
            <c:otherwise>  <li class="layui-nav-item"><a href="homePage?type=Music">音乐</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='Other'}">
                <li class="layui-nav-item layui-this"><a href="homePage?type=Other">其它</a></li>
            </c:when>
            <c:otherwise>  <li class="layui-nav-item"><a href="homePage?type=Other">其它</a></li></c:otherwise>
        </c:choose>
    </c:when>

    <c:when test="${navigatorType=='orgPage'}">
        <c:choose>
            <c:when test="${type=='all'}">
                <li class="layui-nav-item layui-this"><a href="organizationPage?type=all">全部组织</a></li>
            </c:when>
            <c:otherwise> <li class="layui-nav-item"><a href="organizationPage?type=all">全部组织</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='owner'}">
                <li class="layui-nav-item layui-this"><a href="organizationPage?type=owner">我创建的组织</a></li>
            </c:when>
            <c:otherwise> <li class="layui-nav-item"><a href="organizationPage?type=owner">我创建的组织</a></li></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${type=='join'}">
                <li class="layui-nav-item layui-this"><a href="organizationPage?type=join">我加入的组织</a></li>
            </c:when>
            <c:otherwise>  <li class="layui-nav-item"><a href="organizationPage?type=join">我加入的组织</a></li></c:otherwise>
        </c:choose>

    </c:when>

</c:choose>
    </ul>

    <ul class="layui-nav top-left-navigator">
    <li class="layui-nav-item"><a href="homePage">网盘</a></li>
        <li class="layui-nav-item"><a href="organizationPage" id="orgnizationButton">组织</a></li>
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
        var url = 'url(/EasyCloudStorage/img/changeSkin/'+ (i+1) +'.jpg)';
        var data = {
            "bgUrl":  url,
            "accountId": "${sessionScope.user.getAccountId()}"
        };
        window.location = "getBgUrl?" + $.param(data);
    });

</script>