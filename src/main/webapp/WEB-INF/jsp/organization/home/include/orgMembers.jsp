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
        padding: 15px 0 15px 20px;
        font-size: 18px;
        font-weight: bold;
    }

    .org-name {
        font-size: 14px;
    }

    .org-members {
        margin-top: 20px;
        overflow-y: auto;
    }

    .un-grouped-member-div {
        margin-left: 10px;
        margin-top: 5px;
    }

    .grouped-member-div {
        margin-left: 15px;
        margin-top: 5px;
    }

    .groups-div {
        margin-top: 10px;
    }
    .add-button{
        position: fixed;
        bottom:0px;

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
    });
</script>


<div class="orgMembersBoard layui-col-md3">
    <div class="layui-col-md12">
        <div class="orgMembersBoard-header">
            组织结构 -- <span class="org-name">${organization.name}
               <a href="/EasyCloudStorage/toInvite">
                    <button 	class="layui-btn layui-btn-normal" style="position: absolute;left: 230px">
                        邀请成员
                    </button>
               </a>
            </span>
        </div>

        <div class="org-members">
            <c:forEach items="${organization.unGroupedMembers}" var="member">
                <div class="un-grouped-member-div">
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
            </c:forEach>


            <div class="layui-collapse groups-div">
                <c:forEach items="${organization.groups}" var="group">
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">
                            <a href="/EasyCloudStorage/toAddMember">
                                <img src="/EasyCloudStorage/img/organization/minus.png" style="width: 40px;height: 40px">
                            </a>${group.name}
                            <a href="/EasyCloudStorage/toAddMember">
                                <img src="/EasyCloudStorage/img/organization/add.png" style="position:absolute;left: 280px;width: 50px;height: 40px">
                            </a>
                        </h2>
                        <div class="layui-colla-content layui-show">
                            <c:forEach items="${group.members}" var="member">
                                <div class="grouped-member-div">
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
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
                <div class="add-button">
                    <a href="/EasyCloudStorage/toAddMember">
                        <button 	class="layui-btn layui-btn-normal" style="width: 328px;opacity: 0.8;">
                            新建分组
                        </button>
                    </a>
                </div>
             </div>
        </div>
    </div>
</div>