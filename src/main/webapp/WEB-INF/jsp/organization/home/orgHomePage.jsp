<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/10/2018
  Time: 6:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../../shared/sharedHeader.jsp"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/organization/orgHomePage.css"/>
<script src="/EasyCloudStorage/js/organization/orgHomePage.js"/>

<%@ include file="include/topNav.jsp"%>

<script>
    $(function () {
        $("body").css("background-image", "${sessionScope.user.getBgUrl()}");
    });
</script>

<div class="mainBoard layui-row layui-col-space15">
    <%@ include file="include/orgMembers.jsp"%>
    <%@ include file="include/fileList.jsp"%>
</div>

</body>
</html>