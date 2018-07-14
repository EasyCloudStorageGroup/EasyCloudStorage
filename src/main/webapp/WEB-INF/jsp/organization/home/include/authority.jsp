<%--
  Created by IntelliJ IDEA.
  User: 杨欢
  Date: 2018/7/10
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<script src="/EasyCloudStorage/js/organization/include/authority.js"></script>

<script>

    //权限管理的checkbox
    $(function () {
        $(".fileOperate").attr("disabled","disabled");
        $("#download").click(function () {
            if ($("#download").is(':checked') == true) {
                $("#create").attr("disabled","disabled");
            }
            else{
                $("#create").removeAttr("disabled");
            }
        })
        $("#create").click(function () {
            if ($("#create").is(':checked') == true) {
                $("#download").attr("disabled","disabled");
            }
            else{
                $("#download").removeAttr("disabled");
            }
        })

        //全部权限点击时
        $("#allAutuority").click(function () {
            if ($("#allAutuority").is(':checked') == true) {
                $(".fileOperate").removeAttr("disabled");
                $(".fileOperate").prop("checked", true);
                $("#visible").prop("checked", true);
                $("#none").prop("checked", false);
            }
        })
        //没有任何权限点击时
        $("#none").click(function () {
            if($("#none").is(':checked')==true) {
                $(".fileOperate").prop("checked", false);
                $("#visible").prop("checked", false);
                $("#allAutuority").prop("checked", false);
                $(".fileOperate").attr("disabled","disabled");
            }
            else {
                $(".fileOperate").prop("checked", false);
                $("#visible").prop("checked", false);
                $("#none").prop("checked", true);
            }
        })
        //可预览点击时
        $("#visible").click(function () {
            if ($("#visible").is(':checked') ==true) {
                $("#none").prop("checked", false);
                $(".fileOperate").removeAttr("disabled");
            }
            else{
                $(".fileOperate").prop("disabled","disabled");
                $("#allAutuority").prop("checked", false);
            }
        })
        //普通文件操作点击时
        $(".fileOperate").click(function () {
            if ($(this).is(':checked') ==false) {
                $("#allAutuority").prop("checked", false);
            }
        })
    })
</script>

<!-- 模态框（Modal） -->
<div class="modal fade" id="authority-set-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">权限管理</h4>
            </div>
            <div class="modal-body">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td width="20%">文件名：</td>
                            <td width="80%" style="overflow: hidden">
                                <div style="overflow-x: hidden;overflow-y: auto">文件名字</div>
                            </td>
                        </tr>
                        <tr height="5">
                            <td colspan="2"></td>
                        </tr>
                    </tbody>
                </table>
                <table id="Permission" width="100%" align="center" valign="top" style="table-layout: fixed">
                    <tbody>
                        <tr>
                            <td width="20%" align="left">用户范围:</td>
                            <td width="80%" align="left">
                                <table id="table_user" border="0" style="table-layout: fixed" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td class="inputBtn_input"><input style="height:34px;width: 400px" readonly class="input" type="text" id="UserId" name="UserId"></td>
                                            <td class="inputBtn_Btn">
                                                <button class="btn btn-default" data-toggle="modal" data-target="#Modal" onclick="clearMemberName();clearCheckbox()">选择</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    <tr height="5">
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td valign="top">权限类型：</td>
                        <td>
                            <div style="height: 120px; overflow:auto; border:1px solid #e2e2e2">
                                    <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                        &nbsp;
                                        <input type="checkbox" name="none" id="none" style="vertical-align: middle;" checked="checked" class="total">
                                        <label for="visible">没有任何权限</label>
                                    </div>
                                        <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                                                   &nbsp;
                                            <input type="checkbox" name="visible" id="visible" style="vertical-align: middle;" class="total">
                                            <label for="visible">可预览</label>
                                        </div>
                                        <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                                                   &nbsp;
                                            <input type="checkbox" name="download" id="download" class="fileOperate total" style="vertical-align: middle;">
                                            <label for="visible">可下载</label>
                                        </div>
                                        <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                                                   &nbsp;
                                            <input type="checkbox" name="create" id="create" class="fileOperate total" style="vertical-align: middle;">
                                            <label for="visible">可创建文件夹</label>
                                        </div>
                                        <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                                                   &nbsp;
                                            <input type="checkbox" name="edit" id="edit" class="fileOperate total" style="vertical-align: middle;">
                                            <label for="visible">可编辑</label>
                                        </div>
                                        <div style="float: left;width: 49%;height: 25px;line-height: 25px;">
                                                                   &nbsp;
                                            <input type="checkbox" name="allAutuority" id="allAutuority" class="total" style="vertical-align: middle">
                                            <label for="visible">全部权限</label>
                                        </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="recordHandler()">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="ModalLabel">选择角色</h4>
            </div>
            <div class="modal-body">
                <div class="org-members">
                    <c:forEach items="${organization.unGroupedMembers}" var="member">
                        <div class="un-grouped-member-div" accountId="${member.accountId}">
                            <input type="checkbox" class="ungroup" value="${member.userName} ">
                            <c:if test="${member.defaultAvatar==1}">
                                <c:if test="${member.sex=='male'}">
                                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.png">
                                </c:if>
                                <c:if test="${member.sex=='female'}">
                                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.png">
                                </c:if>
                            </c:if>
                            <c:if test="${member.defaultAvatar==0}">
                                <img class="avatar" src="/EasyCloudStorage/img/avatar/${member.accountId}.jpg">
                            </c:if>
                                ${member.userName}
                            <c:if test="${organization.ownerId == member.accountId}">
                                (创建者)
                            </c:if>
                        </div>
                    </c:forEach>

                    <div class="layui-collapse groups-div">
                        <c:forEach items="${organization.groups}" var="group">
                            <input type="checkbox" class="group" id="${group.groupId}" value="${group.name}" onclick="inputHandler(${group.groupId})">
                            <div class="layui-colla-item">
                                <h2 class="layui-colla-title">${group.name}</h2>
                                <div class="layui-colla-content layui-show">
                                    <c:forEach items="${group.members}" var="member">
                                        <div class="grouped-member-div" accountId="${member.accountId}">
                                            <input type="checkbox" class="${group.groupId} userName" id="${member.accountId}"
                                                   value="${member.userName}" onclick="cancelGroup(${member.accountId},${group.groupId})">
                                            <c:if test="${member.defaultAvatar==1}">
                                                <c:if test="${member.sex=='male'}">
                                                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-male.png">
                                                </c:if>
                                                <c:if test="${member.sex=='female'}">
                                                    <img class="avatar" src="/EasyCloudStorage/img/avatar/default-avatar-female.png">
                                                </c:if>
                                            </c:if>
                                            <c:if test="${member.defaultAvatar==0}">
                                                <img class="avatar" src="/EasyCloudStorage/img/avatar/${member.accountId}.jpg">
                                            </c:if>
                                                ${member.userName}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="clearStorage();storeName();authorityHandler();">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
