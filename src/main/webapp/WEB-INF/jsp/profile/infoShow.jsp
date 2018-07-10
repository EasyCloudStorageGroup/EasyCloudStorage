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

<%@ include file="../shared/sharedHeader.jsp"%>
<link href="/EasyCloudStorage/css/infoShow.css" type="text/css" rel="stylesheet"/>
<script src="/EasyCloudStorage/js/OpenFilePage/openFile.js"></script>

<div id="wholePage">
    <div id="title"><a href="/EasyCloudStorage/homePage?dirId=0" class="layui-btn layui-btn-sm"> 轻松云存储</a>
        <div id="infoTitle">&nbsp;&nbsp;>&nbsp;&nbsp;个人资料</div>
    </div>
    <div class="mainBoard">
        <div class="leftPart">
            <div id="leftInfo">
                <div class="img">
                    <a data-toggle="modal" href="#myModal">
                        <c:if test="${user.defaultAvatar==1}">
                            <c:if test="${user.sex=='male'}">
                                <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.png">
                            </c:if>
                            <c:if test="${user.sex=='female'}">
                                <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.png">
                            </c:if>
                        </c:if>
                        <c:if test="${user.defaultAvatar==0}">
                            <img class="avatar" src="/EasyCloudStorage/img/avatar/${user.accountId}.jpg" title="修改头像">
                        </c:if>
                    </a>
                    <!--href触发模态框-->
                    <!--模态框-->
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="trye">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="myModalLabel">修改头像</h4>
                                </div>
                                <!--修改头像-->
                                <form name="uploadForm" action="/EasyCloudStorage/modifyAvatar" method="post" enctype="multipart/form-data">
                                    <div class="modal-body">
                                        <center>
                                            <div id="localImage">
                                                <c:if test="${user.defaultAvatar==1}">
                                                    <c:if test="${user.sex=='male'}">
                                                        <img class="innerAvatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.png" id="preview">
                                                    </c:if>
                                                    <c:if test="${user.sex=='female'}">
                                                        <img class="innerAvatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.png" id="preview">
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${user.defaultAvatar==0}">
                                                    <img class="innerAvatar" src="/EasyCloudStorage/img/avatar/${user.accountId}.jpg" id="preview">
                                                </c:if>
                                            </div>
                                        </center>
                                        <center>
                                            <button type="button" class="btn btn-default" onclick="selectFile()">上传图片</button>
                                        </center>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">确认</button>
                                        <input type="file" accept="image/*" name="avatar" onchange="setImagePreview()" id="avatar" style="display: none">
                                    </div>
                                </form>
                            </div> <!--modal-content-->
                        </div>
                    </div>
                </div>




                <div class="leftInfomation">✪ 账号信息</div>
                <div class="leftInfomation">
                    <input type="button" value="修改资料" onclick="window.location.href='/EasyCloudStorage/modInfo'" class="layui-btn-primary layui-btn-sm">
                </div>
            </div>

        </div>
        <div class="rightPart">

            <span>昵称:&nbsp;&nbsp;<span>${user.userName}</span></span>
            <span>账号:&nbsp;&nbsp;<span>${user.accountId}</span></span>
            <c:if test="${user.sex=='male'}">
                <span>性别:&nbsp;&nbsp;<span>男</span></span>
            </c:if>
            <c:if test="${user.sex=='female'}">
                <span>性别:&nbsp;&nbsp;<span>女</span></span>
            </c:if>
            <span>联系方式:&nbsp;&nbsp;<span>${user.phoneNumber}</span></span>

        </div>

    </div>
</div>
</body>
</html>
