<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/15/2018
  Time: 6:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<div class="org-members">
    <c:forEach items="${organization.unGroupedMembers}" var="member">
        <div class="un-grouped-member-div" accountId="${member.accountId}">
            <div>
                <input type="checkbox" class="ungroup" value="${member.userName}">
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
        </div>
    </c:forEach>

    <div class="layui-collapse groups-div">
        <c:forEach items="${organization.groups}" var="group">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">
                    <input type="checkbox" class="group" id="${group.groupId}" value="${group.name}" onclick="inputHandler(${group.groupId})">
                    ${group.name}
                </h2>
                <div class="layui-colla-content layui-show">
                    <c:forEach items="${group.members}" var="member">
                        <div class="grouped-member-div" accountId="${member.accountId}">
                            <div>
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
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
</div>