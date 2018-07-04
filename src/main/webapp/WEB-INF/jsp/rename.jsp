<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/2/2018
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%--这是一个测试文件，可以随意更改--%>

<%--注意：一定要写 isELIgnored = "false"--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="./shared/sharedHeader.jsp"%>
<link href="/EasyCloudStorage/css/menu.css" rel="stylesheet"/>

<ul class="client_menu" id="clientMenu">
    <li><a href="#" onclick="openWindow()">重命名</a></li><br />
    <li><a href="#">删除</a></li>
</ul>
<table border="0" class="renameTable" id="renameTable">
    <tr>
        <td>January</td>
    </tr>
    <tr>
        <td>February</td>
    </tr>
</table>
<script src="js/menu.js"></script>
<script src="js/menuLayer.js"></script>
</body>
</html>
