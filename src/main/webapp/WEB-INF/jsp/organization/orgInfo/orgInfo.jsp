<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2018/7/13
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>

<form class="layui-form" action="">

<div class="layui-form-item">
    <label class="layui-form-label">单行输入框</label>
    <div class="layui-input-block">
        <input name="newName" class="layui-input" type="text" placeholder="输入新名字" autocomplete="off" lay-verify="title">
    </div>
</div>

<%--将参数传给组织id传给服务器--%>
<input type="hidden" name="orgId" value=${organization.orgId}>

<div class="layui-form-item layui-form-text">
    <label class="layui-form-label">普通文本域</label>
    <div class="layui-input-block">
        <textarea name="description" class="layui-textarea" placeholder="请输入内容"></textarea>
    </div>
</div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-filter="demo1" lay-submit="">立即提交</button>
            <button class="layui-btn layui-btn-primary" type="reset">重置</button>
        </div>
    </div>

</form>

</body>
</html>
