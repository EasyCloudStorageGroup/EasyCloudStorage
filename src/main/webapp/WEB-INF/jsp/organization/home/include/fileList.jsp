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

    .fileListBoard-content-list {
        display: flex;
        flex-wrap: wrap;
    }

    .dir-block, .nor-file-block {
        position: relative;
        margin: 20px 20px 0 20px;
        width: 80px;
    }

    .dir-block img, .nor-file-block img{
        width: 80px;
        height: 80px;
    }

    .dir-name, .nor-file-name {
        font: 12px/1.5 "Microsoft YaHei", arial, SimSun, 宋体;
        color: #424e67;
        text-align: center;
        width: 80px;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
    }

    .file-select {
        position: absolute;
        left: -16px;
        top: -16px;
        z-index: 100;
    }
    .file-select .layui-form-checked[lay-skin=primary] i {
        background-color: #574ab8 !important;
        border-color: #574ab8 !important;
    }

    .file-hover-div {
        border: 1px solid white;
        margin-right: 10px;
        margin-bottom: 10px;
    }

    .file-hover-div:hover {
        cursor: pointer;
    }

    .file-hover, .file-selected {
        background-color: #f1f5fa;
        border: 1px solid #90c3fd;
        border-radius: 5px;
    }

    .fileListBoard-header .layui-btn-container {
        padding-top: 12px;
        margin-left: 20px;
    }

    .fileListBoard-header .layui-btn-container .layui-btn-primary:hover {
        border-color: #574ab8;
    }
    .fileListBoard-header .layui-btn-container .layui-btn-primary {
        color: #574ab8;
    }
</style>

<script>

    /*按钮组显示、隐藏的操作*/
    function butGroupsShowOrHide() {
        var selectedNum = $(".file-selected").size();
        if(selectedNum == 0)
            $(".layui-btn-container .layui-btn-group").hide();
        else
            $(".layui-btn-container .layui-btn-group").show();
    }

    /*决定下载按钮是否禁用*/
    function fileDownloadable(authority) {
        if(authority == 1 || authority == 4)
            return true;
        else
            return false;
    }
    function downloadButClickable() {
        var selectedDirNum = $(".file-selected .dir-block").size();

        var isFileUnDownloadable = false;
        $(".file-selected .nor-file-block").each(function () {
            var authority = $(this).attr("authority");
            if(!fileDownloadable(authority)) {
                isFileUnDownloadable = true;
                return;
            }
        });

        if(selectedDirNum > 0 || isFileUnDownloadable) {
            $("#download-but").addClass("layui-btn-disabled");
            $("#download-but").attr("disabled", "disabled");
        }
        else {
            $("#download-but").removeClass("layui-btn-disabled");
            $("#download-but").removeAttr("disabled")
        }
    }

    /*决定删除按钮是否禁用*/
    function fileEditable(authority) {
        if(authority == 2 || authority == 4 || authority == 5)
            return true;
        else
            return false;
    }
    function deleteButClickable() {
        var isFileUnDeletable = false;
        $(".file-selected .nor-file-block").each(function () {
            var authority = $(this).attr("authority");
            if(!fileEditable(authority)) {
                isFileUnDeletable = true;
                return;
            }
        });
        $(".file-selected .dir-block").each(function () {
            var authority = $(this).attr("authority");
            if(!fileEditable(authority)) {
                isFileUnDeletable = true;
                return;
            }
        });

        if(isFileUnDeletable) {
            $("#delete-but").addClass("layui-btn-disabled");
            $("#delete-but").attr("disabled", "disabled");
        }
        else {
            $("#delete-but").removeClass("layui-btn-disabled");
            $("#delete-but").removeAttr("disabled");
        }

    }

    /*决定重命名按钮是否禁用*/
    function renameButClickable() {
        var selectedNum = $(".file-selected").size();

        var authority = $(".file-selected .nor-file-block, .file-selected .dir-block").attr("authority");

        if(selectedNum > 1 || !fileEditable(authority)) {
            $("#rename-but").addClass("layui-btn-disabled");
            $("#rename-but").attr("disabled", "disabled");
        }
        else {
            $("#rename-but").removeClass("layui-btn-disabled");
            $("#rename-but").removeAttr("disabled");
        }
    }

    layui.use('form', function(){
        var form = layui.form;

        /*file-hover-div 点击事件*/
        $(".file-hover-div").click(function() {
            if($(this).find(".file-select input").prop("checked") == true) {
                $(this).find(".file-select input").prop("checked", false);
                $(this).removeClass("file-selected");
                form.render();
            }
            else {
                $(this).find(".file-select input").prop("checked", true);
                $(this).addClass("file-selected");
                form.render();
            }

            butGroupsShowOrHide();
            downloadButClickable();
            deleteButClickable();
            renameButClickable();
        });
    });

    $(function () {
        /*根据浏览器高度，实现自适应高度*/
        var topNavH = 70;
        var margin = 10;
        var orgHeader = 55 + 10;
        var boardHeight = $(window).height() - topNavH - margin - orgHeader;
        $(".fileListBoard-content").css("height", boardHeight+"px");

        $(window).resize(function() {
            var boardHeight = $(window).height() - topNavH - margin - orgHeader;
            $(".fileListBoard-content").css("height", boardHeight+"px");
        });


        /*file点击事件*/
        $(".dir-block").on("dblclick", function () {
            window.location.href = "orgHomePage?dirId="+$(this).attr("dirId");
        });

        /*file悬浮事件*/
        $(".file-select").hide();

        $(".file-hover-div").hover(function () {
            $(this).find(".file-select").show();
            $(this).addClass("file-hover");
        },
        function () {
            if($(this).find(".file-select input").prop("checked") == false) {
                $(this).find(".file-select").hide();
            }
            $(this).removeClass("file-hover");
        });

        /*checkbox 选择事件*/
        $(".file-select").click(function() {
            if($(this).find("input").prop("checked") == false) {
                $(this).parents(".file-hover-div").removeClass("file-selected");
            }
            else {
                $(this).parents(".file-hover-div").addClass("file-selected");
            }

            butGroupsShowOrHide();
            downloadButClickable();
            deleteButClickable();
            renameButClickable();

            return false;
        });

        /*操作管理*/
        if("${organization.ownerId == user.accountId}" == "false") {
            if("${currentDir.dirAuthority == null or not currentDir.dirAuthority.newable}" == "true") {
                $("#upload-but, #new-but").addClass("layui-btn-disabled");
                $("#upload-but, #new-but").attr("disabled", "true");
            }
        }

        $(".layui-btn-container .layui-btn-group").hide();
    });
</script>

<div class="fileListBoard layui-col-md9">
    <div class="layui-col-md12" >
        <div class="fileListBoard-header">
            <div class="layui-btn-container">
                <span class="site-demo-button" id="layerDemo">
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="upload-but" data-method="setTop">
                        <i class="layui-icon">&#xe62f;</i>上传
                    </button>
                </span>

                <script src="/EasyCloudStorage/js/FileManager/upload.js">
                </script>

                <script src="js/menu.js"></script>

                <button class="layui-btn layui-btn-primary layui-btn-sm" id="new-but" onclick="openNewDirectoryMenu()">
                    <i class="layui-icon">&#xe608;</i>新建文件夹
                </button>

                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="download-but">
                        <i class="layui-icon">&#xe601;</i>下载
                    </button>

                    <script src="js/FileManager/download.js"></script>

                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="delete-but">
                        <i class="layui-icon">&#xe640;</i>删除
                    </button>
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="rename-but">
                        <i class="layui-icon">&#xe642;</i>重命名
                    </button>
                </div>
            </div>
        </div>

        <form class="layui-form">
            <div class="fileListBoard-content">
                <div class="fileListBoard-content-list">
                    <c:forEach items="${currentDir.childDirectories}" var="childDir">
                        <div class="file-hover-div">
                            <div class="dir-block" dirId="${childDir.dirId}" authority="${childDir.dirAuthority.authority}">
                                <div>
                                    <img src="/EasyCloudStorage/img/home/folder.png">
                                </div>
                                <div class="dir-name" title="${childDir.name}">${childDir.name}</div>
                                <div class="file-select">
                                    <input type="checkbox" name="check2" lay-skin="primary" value="${childDir.dirId}">
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:forEach items="${currentDir.childNorFiles}" var="childNorFile">
                        <div class="file-hover-div">
                            <div class="nor-file-block" authority="${childNorFile.norFileAuthority.authority}">
                                <div>
                                    <img src="/EasyCloudStorage/img/home/file.png">
                                </div>
                                <div class="nor-file-name" title="${childNorFile.name}">${childNorFile.name}</div>
                                <div class="file-select">
                                    <input type="checkbox" name="check" lay-skin="primary" value="${childNorFile.fileId}">
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </form>
    </div>
</div>