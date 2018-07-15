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
    var userArray=new Array();
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
    if(($("#visible").is(':checked')==true)&&($(".fileOperate").is(':checked') ==false)){
        selectAuthority=0;
    }
    else if(($("#visible").is(':checked')==true)&&(($("#download").is(':checked')==true)&&($("#edit").is(':checked')==false))){
        selectAuthority=1;
    }
    else if(($("#visible").is(':checked')==true)&&(($("#edit").is(':checked')==true)&&
            ($("#download").is(':checked')==false)&&($("#create").is(':checked')==false))){
        selectAuthority=2;
    }
    else if(($("#visible").is(':checked')==true)&&(($("#create").is(':checked')==true)&&($("#edit").is(':checked')==false))){
        selectAuthority=3;
    }
    else if(($("#visible").is(':checked')==true)&&(($("#download").is(':checked')==true)&&($("#edit").is(':checked')==true))){
        selectAuthority=4;
    }
    else {
        selectAuthority=5;
    }
    userArray.push(selectAuthority);

    $.ajax({
        type:'post',
        url:'/EasyCloudStorage/authorityManage',
        contentType:"application/json",
        data:JSON.stringify(userArray),
        traditional:true,
        success:function (data) {

        }
    })
}

//取消小组成员时同时取消小组按钮的选中状态
//obj_1：成员id  obj_2：组id
function cancelGroup(obj_1,obj_2) {
    if ($("#"+obj_1).is(':checked') == false) {
        $("#"+obj_2).prop("checked", false);
    }
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
    $(".fileOperate").prop("checked", false);
    $("#visible").prop("checked", false);
    $("#none").prop("checked", true);
    $("#allAutuority").prop("checked", false);
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
