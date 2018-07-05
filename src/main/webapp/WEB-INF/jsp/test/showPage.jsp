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
<c:out value="当前目录"></c:out>
<h3>${rootDirectory.name}</h3>
<c:forEach items="${directoryList}" var="Directory">
    <c:out value="子目录"></c:out>
    <h3>${Directory.name}</h3>
</c:forEach>
<c:forEach items="${normalFileList}" var="normalFile">
    <c:out value="文件"></c:out>
    <h3>${normalFile.name}</h3>
</c:forEach>
</body>
</html>
