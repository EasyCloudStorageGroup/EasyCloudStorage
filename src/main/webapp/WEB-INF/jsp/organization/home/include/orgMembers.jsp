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
        width: 40px;
        height: 40px;
    }

    .orgMembersBoard-header {
        border-bottom: 1.5px solid #f3f3f3;
        padding: 15px 0 15px 20px;
        font-size: 16px;
        font-weight: bold;
    }
</style>

<script>
    layui.use('element', function(){
        var element = layui.element;
    });
</script>


<div class="orgMembersBoard layui-col-md3">
    <div class="layui-col-md12">
        <div class="orgMembersBoard-header">
            组织结构
        </div>

        <div>
            <img src="">
            ${organization.name}
        </div>

        <div class="layui-collapse">
            <c:forEach items="${organization.members}" var="member">
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">${}</h2>
                    <div class="layui-colla-content layui-show">内容区域</div>
                </div>
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">李清照</h2>
                    <div class="layui-colla-content layui-show">内容区域</div>
                </div>
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">鲁迅</h2>
                    <div class="layui-colla-content layui-show">内容区域</div>
                </div>
            </c:forEach>
        </div>



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
                </div>


    </div>
</div>