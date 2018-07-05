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

<div class="mainBoard">
    <div class="leftPart">
        <div class="img">
            <c:if test="${information.sex=='male'}">
                <!--href触发模态框-->
                <a data-toggle="modal" href="#myModal"><img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.webp"></a>
                <!--模态框-->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="trye">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">修改头像</h4>
                            </div>
                            <!--修改头像-->
                            <form name="uploadForm">
                                <div class="modal-body">
                                    <center>
                                        <div id="localImage">
                                            <img class="innerAvatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.webp" id="preview">
                                        </div>
                                    </center>
                                    <center>
                                        <button type="button" class="btn btn-default" onclick="selectFile()">上传图片</button>
                                    </center>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <button type="button" class="btn btn-primary">确认</button>
                                    <input type="file" name="doc" onchange="setImagePreview()" id="doc" style="display: none">
                                </div>
                            </form>
                        </div> <!--modal-content-->
                    </div>
                </div>
            </c:if>
            <c:if test="${information.sex=='female'}">
                <!--href触发模态框-->
                <a data-toggle="modal" href="#myModal"><img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.webp"></a>
                <!--模态框-->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="trye">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">修改头像</h4>
                            </div>
                            <div class="modal-body">
                                <center>
                                    <img class="innerAvatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.webp">
                                </center>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary">确认</button>
                            </div>
                        </div> <!--modal-content-->
                    </div>
                </div>
            </c:if>
        </div>



        <div class="leftInfo">✪ 账号信息</div>
        <div class="leftInfo">
            <input type="button" value="修改资料" onclick="window.location.href='/EasyCloudStorage/modInfo'">
        </div>

    </div>
    <div class="rightPart">

        <span>昵称:&nbsp;&nbsp;<span>${information.userName}</span></span>
        <span>账号:&nbsp;&nbsp;<span>${information.accountId}</span></span>
        <c:if test="${information.sex=='male'}">
            <span>性别:&nbsp;&nbsp;<span>男</span></span>
        </c:if>
        <c:if test="${information.sex=='female'}">
            <span>性别:&nbsp;&nbsp;<span>女</span></span>
        </c:if>
        <span>联系方式:&nbsp;&nbsp;<span>${information.phoneNumber}</span></span>

    </div>

</div>
</body>
</html>
