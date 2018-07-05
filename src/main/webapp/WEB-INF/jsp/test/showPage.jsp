<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/2/2018
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%--注意：一定要写 isELIgnored = "false"--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<html>
<head>
    <title>文件列表展示</title>
</head>
<body>
<table width="80%" align="center">
    <tr>
        <td>编号</td>
        <td>名字</td>
        <td>最后一次修改时间</td>
        <td>路径</td>
    </tr>
    <c:forEach items="${directoryList }" var="Directory">

        <tr>
            <td><a  href="/EasyCloudStorage/homePage?dirId=${Directory.dirId}" id=${Directory.dirId} > ${Directory.dirId }</a></td>
            <td>${Directory.name}</td>
            <td>${Directory.lastMovedTime}</td>
            <td>${Directory.realPath}</td>
        </tr>
    </c:forEach>
    <c:forEach items="${normalFileList}" var="NormalFile">
        <tr>
            <td>${NormalFile.fileId }</td>
            <td>${NormalFile.name}</td>
            <td>${NormalFile.lastMovedTime}</td>
            <td>${NormalFile.realPath}</td>
        </tr>
    </c:forEach>
</table>

<script>
    function changeUrl(obj) {
        document.getElementById(obj.id).href = "123"+obj.id;
    }
</script>
</body>
</html>
