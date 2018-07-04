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

<html>
<head>
    <title>Title</title>
</head>

<body>

<form>
    <table>
        <tr>
            <td>昵称：</td>
            <td><input type="text" name="name" size="14"></td>
        </tr>
        <tr>
            <td>
                <select name="sex">
                    <option>男</option>
                    <option>女</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>联系电话：</td>
            <td><input type="text" name="phoneNumber" size="14"></td>
        </tr>
    </table>
</form>

</body>
</html>
