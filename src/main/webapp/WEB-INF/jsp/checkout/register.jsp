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
</head>
<body>
    <h1 align="center">注册页面</h1>
    <form action="register" method="get">
        <table>
            <tr>
                <td><label>用户名</label></td>
                <td><input type="text" id="userName" name="userName"></td>
            </tr>
            <tr>
                <td><label>密码</label></td>
                <td><input type="text" id="password" name="password"></td>
            </tr>
            <tr>
                <td><label>账号</label></td>
                <td><input type="text" id="accountId" name = "accountId"></td>
            </tr>
            <tr>
                <td><label>电话号码</label></td>
                <td><input type="text" id="phoneNumber" name = "phoneNumber"></td>
            </tr>
            <tr>
                <td><label>性别</label></td>
                <td><select id="sex" name="sex">
                    <option>男</option>
                    <option>女</option>
                </select></td>
            </tr>
            <tr>
                <td><input type="submit" id="register2" value="提交"></td>
            </tr>
        </table>
    </form>

</body>
</html>
