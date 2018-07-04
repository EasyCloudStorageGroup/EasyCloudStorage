<%--
  Created by IntelliJ IDEA.
  User: 杨欢
  Date: 2018/7/3
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<html>
<head>
    <title>Title</title>
    <style>
        .mainBoard{
            width:700px;
            height:500px;
            /*text-align: center;*/
            border: 1px solid grey;
            line-height: 60px;
            display: flex;
        }
        .leftPart{
            width: 300px;
            align-items: flex-end;
            display: flex;
        }
        .rightPart{
            width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
        }
    </style>
</head>
<body>
<div class="mainBoard">
    <div class="leftPart">
        <p>hhh</p>
    </div>
    <div class="rightPart">
        <span>昵称：</span>
        <span>账号：</span>
        <span>性别：</span>
        <span>联系方式：</span>
    </div>

</div>
</body>
</html>
