<%--
  Created by IntelliJ IDEA.
  User: 杨欢
  Date: 2018/7/17
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../../shared/sharedHeader.jsp"%>
<link href="/EasyCloudStorage/css/infoShow.css" type="text/css" rel="stylesheet"/>

<div id="wholePage">
    <div id="title"><a href="/EasyCloudStorage/orgHomePage" class="layui-btn layui-btn-sm"> 组织主页</a>
        <div id="infoTitle">&nbsp;&nbsp;>&nbsp;&nbsp;文件详情</div>
    </div>
    <div class="mainBoard">
        <div class="leftPart">
            <div id="leftInfo">
                <div class="img">
                    <c:if test="${fileType=='directory'}">
                            <img class="fileImg" src="/EasyCloudStorage/img/home/folder.png">
                    </c:if>
                    <c:if test="${fileType=='normalFile'}">
                        <img class="fileImg" src="/EasyCloudStorage/img/home/file.png">
                    </c:if>
                </div>
                <div class="leftInfomation">✪ 文件信息</div>
            </div>
        </div>

        <div class="rightPart">

            <span>文件名:&nbsp;&nbsp;<span>${fileInfo.name}</span></span>
            <c:if test="${fileType=='directory'}">
                <span>文件类型:&nbsp;&nbsp;<span>文件夹</span></span>
            </c:if>
            <c:if test="${fileType=='normalFile'}">
                <span>文件类型:&nbsp;&nbsp;<span>${fileInfo.type}</span></span>
            </c:if>

            <c:if test="${fileType=='normalFile'}">
            <span>文件大小:&nbsp;&nbsp;<span>${fileInfo.size}</span></span>
            </c:if>

            <c:if test="${fileType=='directory'}">
                <span>修改时间:&nbsp;&nbsp;<span><fmt:formatDate value="${fileInfo.lastMovedTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span></span>
            </c:if>

            <c:if test="${fileAuthority.authority==0}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览</span></span>
            </c:if>
            <c:if test="${fileAuthority.authority==1}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览、下载</span></span>
            </c:if>
            <c:if test="${fileAuthority.authority==2}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览、编辑</span></span>
            </c:if>
            <c:if test="${fileAuthority.authority==3}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览、创建文件夹</span></span>
            </c:if>
            <c:if test="${fileAuthority.authority==4}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览、下载和编辑</span></span>
            </c:if>
            <c:if test="${fileAuthority.authority==5}">
                <span>我的权限:&nbsp;&nbsp;<span>可预览、创建和编辑</span></span>
            </c:if>

        </div>

    </div>
</div>
</body>
</html>
