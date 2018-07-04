<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/7/3
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" type="text/css" href="css/style.css?v=1.0">
</head>
<body>
    <%--<h1 align="center">登录页面</h1>--%>
    <%--<form action="login" method="get">--%>
        <%--<table>--%>
            <%--<tr>--%>
                <%--<td><label>账号</label></td>--%>
                <%--<td><input type="text" id="accountId" name="accountId"></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td><label>密码</label></td>--%>
                <%--<td><input type="text" id="password" name="password"></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td><input type="submit" id="login" name="login" value="登录"></td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form>--%>
    <%--<form action="toRegister" method="get">--%>
        <%--<input type="submit" id="register" name = "register" value="注册">--%>
    <%--</form>--%>
    <form action="login" method="get">
        <div class="input_control"><input type="text" name="accountId" placeholder="账号"/></div>
        <div class="input_control"><input type="text" name="password" placeholder="密码"/></div>
        <div class="input_control"><input type="submit" value="登录"></div>
    </form>
    <form action="toRegister" method="get">
        <div class="input_control"><input type="submit" value="注册"></div>
    </form>

</body>
</html>
