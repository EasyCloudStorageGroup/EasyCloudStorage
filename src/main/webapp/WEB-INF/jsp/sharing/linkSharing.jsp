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
            <th style="width: 50px;"><button class="layui-btn layui-btn-normal" type="submit" id="download_btn" >下载</button></th>
            <th lay-data="{field:'type'}"style="width: 10px"></th>
            <th lay-data="{field:'username'"style="width: 350px">名称</th>
            <th lay-data="{field:'type'}"style="width: 150px">类型</th>
            <th lay-data="{field:'joinTime'}"style="width: 150px">最后修改时间</th>
        </tr>
        </thead>

        <tbody>
            <tr class="normalFileClass">
                <td><input type="checkbox" value="${normalFile.fileId}" name="check"></td>

                <td><img src="/EasyCloudStorage/img/home/file.png" width="30px" height="30px"/> </td>
                <c:choose>
                    <c:when test="${normalFile.type=='image/jpeg'||normalFile.type=='image/png'||normalFile.type=='text/plain'||normalFile.type=='audio/mp3'||normalFile.type=='video/mp4'}">
                        <td><a  href="/EasyCloudStorage/homePage?fileId=${normalFile.fileId}">${normalFile.name}</a></td>
                    </c:when>
                    <c:otherwise>
                        <td>${normalFile.name}</td>
                    </c:otherwise>
                </c:choose>
                <td>${NormalFile.type}</td>
                <td>${NormalFile.displayTime}</td>
            </tr>
        </tbody>
    </table>
</div>
<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
<script>
    $("#download_btn").click(function () {
        var idCollection = [];
        $("input[name = 'check']:checked").each(function (i) {
            idCollection[i] = $(this).val();
        });
        if(!(idCollection.length === 0)) {
            var data = {
                "idCollection[]": idCollection
            };
            window.location = "http://localhost:8080/EasyCloudStorage/download?" + $.param(data);
        }
    })
</script>
</body>
</html>
