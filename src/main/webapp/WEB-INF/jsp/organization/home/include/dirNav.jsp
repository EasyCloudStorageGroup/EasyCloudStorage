<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/13/2018
  Time: 9:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<style>
    .dir-nav a {
        color: #574ab8 !important;
    }
    .dir-nav a:hover{
        text-decoration-color: #574ab8 !important;
        color: #574ab8 !important;
    }

    .breadcrumb {
        background-color: rgba(255, 255, 255, 0);
    }

    .breadcrumb > li + li:before {
        content: "> ";
        padding: 0 5px;
    }
</style>

<ol class="breadcrumb dir-nav">
    <c:forEach items="${dirNav}" var="dir" varStatus="status">
        <c:if test="${not status.last}">
            <c:if test="${dir.dirId == null}">
                <li><a href="/EasyCloudStorage/orgHomePage">${dir.name}</a></li>
            </c:if>
            <c:if test="${dir.dirId != null}">
                <li><a href="/EasyCloudStorage/orgHomePage?dirId=${dir.dirId}">${dir.name}</a></li>
            </c:if>
        </c:if>
        <c:if test="${status.last}">
            <li class="active">${dir.name}</li>
        </c:if>
    </c:forEach>
</ol>