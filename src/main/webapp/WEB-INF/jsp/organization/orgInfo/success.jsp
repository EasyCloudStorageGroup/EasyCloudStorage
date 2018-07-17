<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2018/7/13
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../../shared/sharedHeader.jsp"%>
<html>
<head>
    <link rel="stylesheet" href="/EasyCloudStorage/layui/css/layui.css"  media="all">
</head>
<body style="background-color: #c1e2b3">

<script src="/EasyCloudStorage/layui/layui.js" charset="utf-8"></script>





<%--将参数传给组织id传给服务器--%>


<div style="position:absolute;left: 25%; top: 15%; width:50%;height:90%;background-color:#ffffff">


    <div style="position:absolute;left: 42%; top: 30%;">
        <p align="center">修改成功</p>
        <a href="/EasyCloudStorage/enterOrganization?orgId=${org.orgId}">
            <button class="layui-btn">回到主页</button>
        </a>
    </div>


</div>

</body>
</html>
