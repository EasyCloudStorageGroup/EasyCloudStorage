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

        /*file双击事件*/
        $(".dir-block").on("dblclick", function () {
            window.location.href = "orgHomePage?dirId="+$(this).attr("dirId");
        });
        $(".nor-file-block").on("dblclick", function () {
            var fileType = $(this).attr("fileType");
            if(fileType == "image/jpeg" || fileType == "image/png")  {
                var showImg = $("<img class='file-show-img' src='/Data"+$(this).attr("realPath").substr(23)+"'>");
                $("#file-show-modal .modal-body").prepend(showImg);
                $("#file-show-modal").modal("show");
            }
            else if(fileType == "audio/mp3") {
                var showAudio = $("<audio loop='loop' autoplay='autoplay' style='width: 500px; opacity: 0.95;' controls='controls' src='/Data"+$(this).attr("realPath").substr(23)+"'>");
                $("#file-show-modal .modal-body").height("100px");
                $("#file-show-modal .modal-body").prepend(showAudio);
                $("#file-show-modal").modal("show");
            }
            else if(fileType == "video/mp4") {
                var showVideo = $("<video autoplay='autoplay' width='800px' height='400px' controls='controls' src='/Data"+$(this).attr("realPath").substr(23)+"'>");
                $("#file-show-modal .modal-body").prepend(showVideo);
                $("#file-show-modal").modal("show");
            }
        });

        /*模态框关闭事件*/
        $('#file-show-modal').on('hide.bs.modal', function () {
            $("#file-show-modal .modal-body").empty();
            $("#file-show-modal .modal-body").height("500px");
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

                <button class="layui-btn layui-btn-primary layui-btn-sm" id="authority-set-but">
                    权限设置
                </button>
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
                            <div class="nor-file-block" authority="${childNorFile.norFileAuthority.authority}" fileType="${childNorFile.type}"
                                realPath="${childNorFile.realPath}">
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


<%--文件预览模态框--%>
<div class="modal fade" id="file-show-modal" tabindex="-1" role="dialog" aria-labelledby="file-show-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="file-show-modal-title">文件预览</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>