function inputHandler(obj) {
    if ($("#"+obj).is(':checked') == true) {
        $("."+obj).prop("checked", true);
    }
    else{
        $("."+obj).prop("checked", false);
    }
}

//记录选中的文件id，用户id和权限
function recordHandler() {
    //获得被赋予权限的用户
    var userArray=[];
    $(".ungroup").each(function () {
        if($(this).is(':checked') == true) {
            userArray.push($(this).parent().attr("accountId"));
        }
    })
    $(".userName").each(function () {
        if($(this).is(':checked') == true) {
            userArray.push($(this).parent().attr("accountId"));
        }
    })
    //获取权限
    var selectAuthority;
    var mySelect=document.getElementById("authority");
    var index=mySelect.selectedIndex;
    selectAuthority=mySelect.options[index].value;
    userArray.push(selectAuthority);

    //获得fileIds
    var norFileIds = new Array();
    var dirIds = new Array();
    $("input[name = 'check']:checked").each(function () {
        norFileIds.push($(this).val());
    });
    $("input[name = 'check2']:checked").each(function () {
        dirIds.push($(this).val());
    });

    var data = [];
    data.push(userArray, norFileIds, dirIds);

    $.ajax({
        type:'post',
        url:'/EasyCloudStorage/authorityManage',
        contentType:"application/json",
        data:JSON.stringify(data),
        traditional:true,
        success:function (data) {
            window.location.reload(true);
        }
    })
}

function authorityHandler() {
    var inputText=document.getElementById("UserId");
    inputText.value="";
    inputText.value=memberName;
}

//将所有选中用户以一个字符串显示
var memberName="";
function storeName() {
    $(".ungroup").each(function () {
        if($(this).is(':checked') == true){
            memberName+=(this.value+" ");
        }
    })
    $(".userName").each(function () {
        if($(this).is(':checked') == true){
            memberName+=(this.value+" ");
        }
    })
}
//清除input框里的内容
function clearStorage() {
    var inputText=document.getElementById("UserId");
    inputText.value="";
    var mySelect=document.getElementById("authority");
    mySelect.options[0].selected=true;
}

//清空变量memberName的内容
function clearMemberName() {
    memberName="";
}
//取消checkbox的选中状态
function clearCheckbox() {
    $(".ungroup").prop("checked", false);
    $(".group").prop("checked", false);
    $(".userName").prop("checked", false);
}

//取消小组成员时同时取消小组按钮的选中状态
//obj_1：成员id  obj_2：组id
function cancelGroup(obj_1,obj_2) {
    if ($("#"+obj_1).is(':checked') == false) {
        $("#"+obj_2).prop("checked", false);
    }
}