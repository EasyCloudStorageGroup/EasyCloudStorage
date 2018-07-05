<%--
  Created by IntelliJ IDEA.
  User: 杨欢
  Date: 2018/7/3
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../shared/sharedHeader.jsp"%>
<link href="/EasyCloudStorage/css/infoShow.css" type="text/css" rel="stylesheet"/>

<div class="mainBoard">
    <div class="leftPart">
        <div class="img">
            <img src="/EasyCloudStorage/img/defaultHead.png">
        </div>
        <div class="leftInfo">✪ 账号信息</div>
        <div class="leftInfo">
            <input type="button" value="修改资料" onclick="window.location.href='/EasyCloudStorage/modInfo'">
        </div>

    </div>
    <div class="rightPart">

        <span>昵称:&nbsp;&nbsp;<span>${information.userName}</span></span>
        <span>账号:&nbsp;&nbsp;<span>${information.accountId}</span></span>
        <c:if test="${information.sex=='male'}">
            <span>性别:&nbsp;&nbsp;<span>男</span></span>
        </c:if>
        <c:if test="${information.sex=='female'}">
            <span>性别:&nbsp;&nbsp;<span>女</span></span>
        </c:if>
        <span>联系方式:&nbsp;&nbsp;<span>${information.phoneNumber}</span></span>

    </div>

</div>
</body>
</html>
