<%--
  Created by IntelliJ IDEA.
  User: 杨欢
  Date: 2018/7/3
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../shared/sharedHeader.jsp"%>
<link href="/EasyCloudStorage/css/modInfo.css" type="text/css" rel="stylesheet"/>

<form method="post" action="modifyInfo">
    <div class="mainBoard">
        <div class="info">
            <label>昵称：&nbsp;&nbsp;</label>
            <input type="text" name="name" size="14" value="${user.userName}">
        </div>
        <div class="info">
            <label>
                账号：&nbsp;&nbsp;
            </label>
            ${user.accountId}
        </div>
        <div class="info">
          <label>性别：&nbsp;&nbsp;</label>
            <select name="sex">
            <c:if test="${user.sex=='male'}">
                <option selected="selected">男</option>
                <option>女</option>
            </c:if>
            <c:if test="${user.sex=='female'}">
                <option>男</option>
                <option selected="selected">女</option>
            </c:if>
        </select>

        </div>
        <div class="info">
            <label>联系电话:&nbsp;&nbsp;</label>
            <input type="text" name="phoneNumber" size="14" value="${user.phoneNumber}">
        </div>
        <div class="info">
            <input class="button" type="submit" value="提交">
            <input class="button" type="button" value="返回" onclick="window.location.href='/EasyCloudStorage/infoShow'">
        </div>
    </div>
</form>

</body>
</html>
