<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/7/13
  Time: 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ include file="../shared/sharedHeader.jsp"%>
<div class="table-show-board">
    <table class="layui-table" lay-skin="line" lay-filter="parse-table-demo" id="file-manager-table"  >
        <thead>
        <tr>
            <th lay-data="{checkbox:true}" style="width: 60px">下载</th>
            <th lay-data="{field:'type'}"style="width: 100px"></th>
            <th lay-data="{field:'username'"style="width: 350px">名称</th>
            <th lay-data="{field:'type'}"style="width: 150px">类型</th>
            <th lay-data="{field:'joinTime'}"style="width: 150px">最后修改时间</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${currentNormalFiles}" var="NormalFile">
            <tr class="normalFileClass" id="${NormalFile.fileId}" sortType="${NormalFile.sortType}">
                <td><input type="checkbox" value="${NormalFile.realPath}" name="check"></td>

                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <c:choose>
                    <c:when test="${NormalFile.type=='image/jpeg'||NormalFile.type=='image/png'||NormalFile.type=='text/plain'||NormalFile.type=='audio/mp3'||NormalFile.type=='video/mp4'}">
                        <td><a  href="/EasyCloudStorage/homePage?fileId=${NormalFile.fileId}">${NormalFile.name}</a></td>
                    </c:when>
                    <c:otherwise>
                        <td>${NormalFile.name}</td>
                    </c:otherwise>
                </c:choose>
                <td>${NormalFile.type}</td>
                <td>${NormalFile.displayTime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
