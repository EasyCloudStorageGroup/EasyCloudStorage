<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/6/2018
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/homePage/orderNav.css"/>
<style>
    .button-board {
        position: relative;
        left: 1000px;
        top: 0px;
        background-color: white;
        border-radius:10px;
        height: 30px;
        width: 280px;
    }
</style>
<div class="button-board">
<div class="layui-btn-group order-btn-group" >
    <a href="orderFile?orderBy=name">
        <button class="layui-btn layui-btn-sm" style="margin-right: 3px!important;">
            文件名
            <i class="layui-icon">&#xe619;</i>
        </button>
    </a>
    <a href="orderFile?orderBy=size">
        <button class="layui-btn layui-btn-sm" style="margin-right: 3px!important;">
            大小
            <i class="layui-icon">&#xe619;</i>
        </button>
    </a>
    <a href="orderFile?orderBy=lastMovedTime">
        <button class="layui-btn layui-btn-sm">
            上次修改时间
            <i class="layui-icon">&#xe619;</i>
        </button>
    </a>
</div></div>