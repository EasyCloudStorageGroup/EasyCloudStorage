<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/10/2018
  Time: 9:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<style>
    .fileListBoard > div {
        position: relative;
    }

    .fileListBoard-header {
        height: 55px;
        background-color: white;
        border-radius:3px;
        margin-bottom: 10px;
    }

    .fileListBoard-content {
        background-color: white;
        border-radius:3px;
        overflow-y: auto;
    }
</style>

<script>
    $(function () {
        var topNavH = 70;
        var margin = 10;
        var orgHeader = 55 + 10;
        var boardHeight = $(window).height() - topNavH - margin - orgHeader;
        $(".fileListBoard-content").css("height", boardHeight+"px");

        $(window).resize(function() {
            var boardHeight = $(window).height() - topNavH - margin - orgHeader;
            $(".fileListBoard-content").css("height", boardHeight+"px");
        });
    });
</script>

<div class="fileListBoard layui-col-md9">
    <div class="layui-col-md12" >
        <div class="fileListBoard-header">

        </div>

        <div class="fileListBoard-content">

        </div>
    </div>
</div>