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
        <div class="layui-inline">
            <c:if test="${user.defaultAvatar==1}">
                <c:if test="${user.sex=='male'}">
                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.png">
                </c:if>
                <c:if test="${user.sex=='female'}">
                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.png">
                </c:if>
            </c:if>
            <c:if test="${user.defaultAvatar==0}">
                <img class="avatar" src="/EasyCloudStorage/img/avatar/${user.accountId}.jpg">
            </c:if>
        </div>
        <div class="layui-inline">
            <label>昵称：&nbsp;&nbsp;</label>
            <input type="text" name="name" size="14" value="${user.userName}" class="layui-input-inline">
        </div>
        <div class="layui-inline">
            <label>
                账号：&nbsp;&nbsp;
            </label>
            ${user.accountId}
        </div>
        <div class="layui-inline">
          <label>性别：&nbsp;&nbsp;</label>
            <c:if test="${user.sex=='male'}">
                <input type="radio" name="sex" value="male" title="男" checked>
                男&nbsp;
                <input type="radio" name="sex" value="female" title="女">
                &nbsp;女
            </c:if>
            <c:if test="${user.sex=='female'}">
                <input type="radio" name="sex" value="male" title="男">
                男&nbsp;
                <input type="radio" name="sex" value="female" title="女" checked>
                &nbsp;女
            </c:if>

        </div>
        <div class="layui-inline">
            <label>联系电话:&nbsp;&nbsp;</label>
            <input type="text" name="phoneNumber" size="14" value="${user.phoneNumber}" class="layui-input-inline">
        </div>
        <div class="layui-inline">
            <input class="button layui-btn layui-btn" type="submit" value="提交">
            <input class="button layui-btn layui-btn" type="button" value="返回" onclick="window.location.href='/EasyCloudStorage/infoShow'">
        </div>
    </div>
</form>

</body>
</html>
