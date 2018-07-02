<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/2/2018
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%--注意：一定要写 isELIgnored = "false"--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <c:forEach items="${tests}" var="test">
        <h3>${test.name}</h3>
    </c:forEach>
</body>
</html>
