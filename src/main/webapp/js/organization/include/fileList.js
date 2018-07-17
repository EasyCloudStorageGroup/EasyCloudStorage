/*按钮组显示、隐藏的操作*/
function butGroupsShowOrHide() {
    var selectedNum = $(".file-selected").length;
    if(selectedNum == 0)
        $(".layui-btn-container .layui-btn-group, #authority-set-but").hide();
    else
        $(".layui-btn-container .layui-btn-group, #authority-set-but").show();
}

/*决定下载按钮是否禁用*/
function fileDownloadable(authority) {
    if(authority == 1 || authority == 4)
        return true;
    else
        return false;
}
function downloadButClickable() {
    var selectedDirNum = $(".file-selected .dir-block").length;

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
    var selectedNum = $(".file-selected").length;

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

function deleteFiles() {
    var idCollection = [];
    var idCollection2 = [];
    var dirId = 0
        $("input[name = 'check']:checked").each(function (i) {
            idCollection[i] = $(this).val();
        });
    $("input[name = 'check2']:checked").each(function (i) {
        idCollection2[i] = $(this).val();
    })

    for(var i=0; i<idCollection.length; i++) {
        $.ajax({
            type: "get",
            async: true,
            url: encodeURI(encodeURI("deleteFilePage?fileId="+idCollection[i]+"&dirId="+dirId)),
            success:function () {
                window.location.reload(true)
            }
        })
    }
    for(var i = 0; i<idCollection2.length; i++) {
        $.ajax({
            type: "get",
            async: true,
            url: encodeURI(encodeURI("deleteDirectoryPage?fileId="+idCollection2[i]+"&dirId="+dirId)),
            success:function () {
                window.location.reload(true)
            }
        })
    }

    layer.msg("删除成功",{time:5000});
}

function renameFile()
{
    var dirId = 0;

    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        var selectedName = $("input[name = 'check']:checked, input[name = 'check2']:checked");
        layer.prompt({
            formType: 0,
            title: '重命名为：',
            area:'500px',
            value:selectedName.attr("fileName")
        }, function(value, index, elem){
            value = value.replace(/\%/g,"%25").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\+/g,"%2B");//特殊字符处理
            layer.close(index);
            if(selectedName.attr("name")=="check")
                window.location.href=encodeURI(encodeURI("renameFilePage?oldFileId="+selectedName.val()+"&newFileName="+value+"&dirId="+dirId));
            else if(selectedName.attr("name")=="check2")
                window.location.href=encodeURI(encodeURI("renameDirectoryPage?oldFileId="+selectedName.val()+"&newFileName="+value+"&dirId="+dirId));
            layer.msg("重命名成功")
        });
    });
}


/*权限管理点击事件*/
function authoritySetButClick() {
    $(".selected-files-name-div").empty();
    var selectedFiles = $("input[name = 'check']:checked, input[name = 'check2']:checked");
    selectedFiles.each(function () {
        var nameBadge = $("<span class='layui-badge layui-bg-gray' style='margin-right: 5px'>"+$(this).attr("fileName")+"</span>")
        $(".selected-files-name-div").append(nameBadge);
    });

    $("#authority-set-modal").modal("show");
}