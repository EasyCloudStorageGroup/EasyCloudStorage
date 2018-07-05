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

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>上传单个文件示例</title>
    <script></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css" type="text/css" />

</head>

<body>

<div align="center">

    <h1>上传附件</h1>

    <form method="post" action="upload" enctype="multipart/form-data" onformchange>

        <input type="file" name="file" multiple="multiple" value="search" onchange="change"/>

        <button type="submit" >upload</button>

    </form>

</div>

</body>

</html>