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
<%--><link rel="stylesheet" href="/EasyCloudStorage/css/homePage/fileShow.css"/>--%>

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
        overflow: auto;
        opacity: 0.9;
    }
</style>


<%@ include file="include/orgNavigator.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>


<div class="file-manager-board">

    <c:choose>
        <c:when test="${empty orgList}">

            <div class="empty-notice-board" ><img src="/EasyCloudStorage/img/home/smile.PNG" width="400px" height="320px"/>
                <h2>您还没有加入任何组织哦</h2></div>
        </c:when>
        <c:otherwise>
                    <c:forEach items="${orgList}" var="Organization">

                        <div style="float: left;width: 11%;height: 16%;margin: 4%">
                            <a href="http://www.baidu.com">
                                <img src="/EasyCloudStorage/img/organization/org.png" width="100%" height="100%"/>
                            </a>
                                <p align="center">${Organization.name}</p>
                        </div>
,
                    </c:forEach>

        </c:otherwise>
    </c:choose>

</div>


<script src="js/menu.js"></script>
</body>
</html>
