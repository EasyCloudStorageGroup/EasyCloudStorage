<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/10/2018
  Time: 9:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<link rel="stylesheet" href="/EasyCloudStorage/css/organization/include/fileList.css"/>

<script src="js/organization/include/fileList.js"></script>
<script>
    $(function () {
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

        //使用layui  element 模块
        $(function () {
            layui.use('element', function(){
                var element = layui.element;
            });
        })
    });
</script>
<script src="/EasyCloudStorage/js/FileManager/upload.js"></script>
<script src="js/menu.js"></script>
<script src="js/FileManager/download.js"></script>

<div class="fileListBoard layui-col-md9">
    <div class="layui-col-md12" >
        <div class="fileListBoard-header">
            <div class="layui-btn-container">
                <span class="site-demo-button" id="layerDemo">
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="upload-but" data-method="setTop">
                        <i class="layui-icon">&#xe62f;</i>上传
                    </button>
                </span>

                <button class="layui-btn layui-btn-primary layui-btn-sm" id="new-but" onclick="openNewDirectoryMenu()">
                    <i class="layui-icon">&#xe608;</i>新建文件夹
                </button>

                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="download-but">
                        <i class="layui-icon">&#xe601;</i>下载
                    </button>
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="delete-but" onclick="deleteFiles()">
                        <i class="layui-icon">&#xe640;</i>删除
                    </button>
                    <button class="layui-btn layui-btn-primary layui-btn-sm" id="rename-but" onclick="renameFile()">
                        <i class="layui-icon">&#xe642;</i>重命名
                    </button>
                </div>
            </div>
        </div>

        <form class="layui-form">
            <div class="fileListBoard-content">
                <%@ include file="dirNav.jsp"%>
                <div class="fileListBoard-content-list">
                    <c:forEach items="${currentDir.childDirectories}" var="childDir">
                        <div class="file-hover-div">
                            <div class="dir-block" dirId="${childDir.dirId}" authority="${childDir.dirAuthority.authority}">
                                <div>
                                    <img src="/EasyCloudStorage/img/home/folder.png">
                                </div>
                                <div class="dir-name" title="${childDir.name}">${childDir.name}</div>
                                <div class="file-select">
                                    <input type="checkbox" name="check2" lay-skin="primary" value="${childDir.dirId}" fileName="${childDir.name}">
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
                                    <input type="checkbox" name="check" lay-skin="primary" value="${childNorFile.fileId}" fileName="${childNorFile.name}">
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </form>
    </div>
</div>