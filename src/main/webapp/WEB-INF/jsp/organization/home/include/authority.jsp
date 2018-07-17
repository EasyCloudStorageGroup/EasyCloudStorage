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
        });
    })
</script>

<style>
    #Permission tr {
        margin-top: 20px;
    }
</style>

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
                                <div style="overflow-x: hidden;overflow-y: auto" class="selected-files-name-div"></div>
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
                                <form class="layui-form">
                                    <select id="authority" class="select" lay-verify="">
                                        <option value="0">可预览</option>
                                        <option value="1">可预览、下载</option>
                                        <option value="2">可预览、编辑</option>
                                        <option value="3">可预览、创建文件夹</option>
                                        <option value="4">可预览、下载和编辑</option>
                                        <option value="5">可预览、创建和编辑</option>
                                    </select>
                                </form>
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
    <div class="modal-dialog" style="width: 620px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="ModalLabel">选择角色</h4>
            </div>
            <div class="modal-body">
                <%@ include file="orgMemberSelectList.jsp"%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="clearStorage();storeName();authorityHandler();">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
