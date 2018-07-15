<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/10/2018
  Time: 8:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<style>
    .orgMembersBoard > div {
        position: relative;
        background-color: white;
        border-radius:3px;
    }

    .avatar {
        width: 30px;
        height: 30px;
        border-radius:50%;
    }

    .orgMembersBoard-header {
        border-bottom: 1.5px solid #f3f3f3;
        padding: 15px 20px 15px 20px;
        display: flex;
        justify-content: space-between;
    }

    .org-name {
        font-size: 20px;
        font-weight: bold;
    }

    .org-members {
        margin-top: 20px;
        overflow-y: auto;
    }

    .un-grouped-member-div {
        margin-left: 15px;
        margin-top: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .un-grouped-member-div:hover, .grouped-member-div:hover {
        cursor: pointer;
    }

    .grouped-member-div {
        margin-left: 20px;
        margin-top: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .groups-div {
        margin-top: 10px;
        border-bottom: 0px;
    }

    /*组织成员*/
    .add-org-member-link:hover, .add-group-member-link:hover,  .grouped-member-ops-link:hover {
        text-decoration: none;
        opacity: 0.8;
    }
    .add-org-member-link i {
        font-size: 23px;
        color: #574ab8;
    }
    .add-group-member-link i {
        font-size: 18px;
        color: #574ab8;
    }
    .add-group-member-link {
        position: absolute;
        right: 23px;
    }

    .remove-un-grouped-member-link i{
        color: #574ab8;
        font-size: 18px;
    }
    .remove-group-link i {
        color: #574ab8;
        font-size: 18px;
    }
    .grouped-member-ops-link i {
        color: #574ab8;
        font-size: 18px;
    }

    .remove-un-grouped-member-link {
        margin-right: 10px;
    }
    .remove-group-link {
        position: absolute;
        left: 100px;
    }

    .remove-un-grouped-member-link:hover {
        text-decoration: none;
        opacity: 0.8;
    }
    .remove-group-link:hover {
        text-decoration: none;
        opacity: 0.8;
    }

    /*确认模态框*/
    #make-sure-modal .modal-dialog{
        width: 600px;
    }
    #make-sure-modal .modal-body {
        text-align: center;
    }

    /*添加分组*/
    .add-group-div {
        border:2px dashed rgb(177, 177, 177);
        height: 80px;
        background-color: #f2f2f2;
        margin-top: 30px;

        font-size: 20px;
        text-align: center;
        line-height: 80px;

        color: #60CDEE;
        opacity: 0.5;
    }

    .add-group-div:hover {
        cursor: pointer;
    }
</style>

<script>
    layui.use('element', function(){
        var element = layui.element;
    });

    $(function () {
        var topNavH = 70;
        var margin = 10;
        var orgHeader = 76;
        var boardHeight = $(window).height() - topNavH - margin - orgHeader;
        $(".org-members").css("height", boardHeight+"px");

        $(window).resize(function() {
            var boardHeight = $(window).height() - topNavH - margin - orgHeader;
            $(".org-members").css("height", boardHeight+"px");
        });
        
        /*移出组织操作*/
        /*解散分组操作*/
        $(".remove-un-grouped-member-link, .remove-group-link, .grouped-member-ops-link").hide();
        $(".un-grouped-member-div").hover(function () {
            $(this).children(".remove-un-grouped-member-link").show();
        },function () {
            $(this).children(".remove-un-grouped-member-link").hide();
        });

        $(".layui-colla-title").hover(function () {
            $(this).children(".remove-group-link").show();
        },function () {
            $(this).children(".remove-group-link").hide();
        });

        $(".grouped-member-div").hover(function () {
            $(this).children(".grouped-member-ops-link").show();
        },function () {
            $(this).children(" .grouped-member-ops-link").hide();
        });

        $(".remove-un-grouped-member-link").click(function () {
            $("#make-sure-modal .modal-body").empty();
            var msg = $("<span>你确定要将<span class='layui-badge layui-bg-gray' style='margin: 0 5px'>"+$(this).attr("memberName")+"</span>移出该组织?</span>");
            $("#make-sure-modal .modal-body").prepend(msg);

            var memberId = $(this).attr("memberId");
            $("#make-sure-modal .make-sure-but").click(function () {
                window.location.href = "/EasyCloudStorage/removeOrgMember?memberId="+memberId;
            })
            $("#make-sure-modal").modal("show");
        });

        $(".remove-group-link").click(function () {
            $("#make-sure-modal .modal-body").empty();
            var msg = $("<span>你确定要解散<span class='layui-badge layui-bg-gray' style='margin: 0 5px'>"+$(this).attr("groupName")+"</span>吗?</span>");
            $("#make-sure-modal .modal-body").prepend(msg);

            var groupId = $(this).attr("groupId");
            $("#make-sure-modal .make-sure-but").click(function () {
                window.location.href = "/EasyCloudStorage/deleteGroup?groupId="+groupId;
            });
            $("#make-sure-modal").modal("show");

            return false;
        });

        $(".grouped-member-ops-link").click(function () {
            var memberId = $(this).attr("memberId");
            var groupId = $(this).attr("groupId");
            $("#choose-remove-modal .from-group").click(function () {
                window.location.href = "/EasyCloudStorage/removeGroupMember?memberId="+memberId+"&groupId="+groupId;
            });
            $("#choose-remove-modal .from-org").click(function () {
                window.location.href = "/EasyCloudStorage/removeGroupMember?memberId="+memberId;
            });

            $("#choose-remove-modal").modal("show");
        })

        /*添加分组*/
        $(".add-group-div").width($(".orgMembersBoard").width()-4);
        $(".add-group-div").hover(function () {
            $(".add-group-div").animate({opacity: 1}, "fast");
        }, function () {
            $(".add-group-div").animate({opacity: 0.5}, "fast")
        })
    });
</script>


<div class="orgMembersBoard layui-col-md3">
    <div class="layui-col-md12">
        <div class="orgMembersBoard-header">
           <div class="org-name">
               ${organization.name}
           </div>
           <div>
               <c:if test="${user.accountId == organization.ownerId}">
                   <a href="/EasyCloudStorage/toInvite" class="add-org-member-link" title="邀请成员">
                       <i class="layui-icon">&#xe61f;</i>
                   </a>
               </c:if>
           </div>
        </div>
       <div class="org-members">
            <c:forEach items="${organization.unGroupedMembers}" var="member">
                <div class="un-grouped-member-div">
                    <div>
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
                        <c:if test="${member.accountId == user.accountId}">
                            (我)
                        </c:if>
                    </div>
                    <c:if test="${user.accountId == organization.ownerId}">
                        <a class="remove-un-grouped-member-link" title="移出组织" memberId="${member.accountId}" memberName="${member.userName}">
                            <i class="layui-icon">&#x1006;</i>
                        </a>
                    </c:if>
                </div>
            </c:forEach>

            <c:if test="${organization.groups != null}">
                <div class="layui-collapse groups-div">
                    <c:forEach items="${organization.groups}" var="group">
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">
                                ${group.name}
                                <c:if test="${user.accountId == organization.ownerId}">
                                    <a href="/EasyCloudStorage/toAddMember" class="add-group-member-link" title="添加组成员">
                                        <i class="layui-icon">&#xe61f;</i>
                                    </a>

                                    <a class="remove-group-link" title="解散该组" groupId="${group.groupId}" groupName="${group.name}">
                                        <i class="layui-icon">&#x1006;</i>
                                    </a>
                                </c:if>
                            </h2>
                            <div class="layui-colla-content layui-show">
                                <c:forEach items="${group.members}" var="member" varStatus="status">
                                    <div class="grouped-member-div">
                                        <div>
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
                                            <c:if test="${member.accountId == user.accountId}">
                                                (我)
                                            </c:if>
                                        </div>

                                        <c:if test="${user.accountId == organization.ownerId}">
                                            <a class="grouped-member-ops-link" title="移出操作" memberId="${member.accountId}" groupId="${group.groupId}">
                                                <i class="layui-icon">&#x1006;</i>
                                            </a>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${user.accountId == organization.ownerId}">
               <div class="add-group-div" data-toggle="modal" data-target=".bs-example-modal-lg">
                   <i class="layui-icon" style="font-size: 20px">&#xe654;</i> 新建分组
               </div>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${user.accountId == organization.ownerId}">
<!-- 新建分组 -->

    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <form class="layui-form" action="addGroup" method="post">
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="text" name="name" lay-verify="title" autocomplete="off" placeholder="请输入组名" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="text" name="description" lay-verify="required" placeholder="请输入描述" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1">提交</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--确认模态框--%>
    <div class="modal fade" id="make-sure-modal" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="make-sure-modal-h4">确认</h4>
                </div>
                <div class="modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger make-sure-but">确定</button>
                </div>
            </div>
        </div>
    </div>

    <style>
        #choose-remove-modal .from-group button:hover, #choose-remove-modal .from-org button:hover {
            background-color: #f3f3f3;
            border: 2px solid #f3f3f3;
        }
    </style>
    <%--选择移出组织或分组--%>
    <div class="modal fade" id="choose-remove-modal" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="choose-remove-modal-h4">选择</h4>
                </div>
                <div class="modal-body">
                    <div style="margin-bottom: 20px;" class="from-group">
                        <button class="layui-btn layui-btn-fluid layui-btn-primary">移出该分组</button>
                    </div>
                    <div class="from-org">
                        <button class="layui-btn layui-btn-fluid layui-btn-primary">移出该组织</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="add-group-member-modal" tabindex="-1" role="dialog" aria-labelledby="">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="add-group-member-modal-h4">添加组成员</h4>
                </div>
                <div class="modal-body">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger make-sure-but">确定</button>
                </div>
            </div>
        </div>
    </div>

</c:if>