var clientMenu = document.getElementById('clientMenu');
var table = document.getElementById('1008');
var dirClass=document.getElementsByClassName("dirClass");
var normalFileClass=document.getElementsByClassName("normalFileClass");

function menuEvent(event){
    /*if(event.clientX + 242 > screen.availWidth){
        clientMenu.style.left = event.clientX - 242 + 'px';
    }else{
        clientMenu.style.left = event.clientX + 'px';
    }
    if(event.clentY + 122 > screen.availHeight){
        clientMenu.style.top = event.clientY - 122 + 'px';
    }else{
        clientMenu.style.top = event.clientY + 'px';
    }*/
    clientMenu.style.left = event.clientX + 'px';
    clientMenu.style.top = event.clientY + 'px';
    clientMenu.style.visibility = 'visible';
    clientMenu.id=this.id;
    clientMenu.objName=this.children[1].innerText;
    clientMenu.objClass=this.className;
    return false;
}

function hiddenMenu(){
    clientMenu.style.visibility = 'hidden';
}

function defaultMenu(){
    return false;
}

function openRenameFileMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=0;
    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        layer.prompt({
            formType: 0,
            title: '重命名为：',
            area:'500px',
            value:clientMenu.objName
        }, function(value, index, elem){
            value = value.replace(/\%/g,"%25").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\+/g,"%2B");//特殊字符处理
            layer.close(index);
            if(clientMenu.objClass=="normalFileClass")
                window.location.href=encodeURI(encodeURI("renameFilePage?oldFileId="+clientMenu.id+"&newFileName="+value+"&dirId="+dirId));
            else if(clientMenu.objClass=="dirClass")
                window.location.href=encodeURI(encodeURI("renameDirectoryPage?oldFileId="+clientMenu.id+"&newFileName="+value+"&dirId="+dirId));
            layer.msg("重命名成功")
        });

    });
    /*new MyLayer({
        top:"40%",
        left:"30%",
        width:"40%",
        height:"20%",
        title:"重命名",
        id:clientMenu.id,
        content:"renameFileMenu"
    }).openLayer();*/
}
function openNewDirectoryMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=-1;
    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        layer.prompt({
            formType: 0,
            title: '新建文件夹：',
            area:'500px',
            value:"新建文件夹"
        }, function(value, index, elem){
            value = value.replace(/\%/g,"%25").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\+/g,"%2B");//特殊字符处理
            layer.close(index);
            window.location.href=encodeURI(encodeURI("newDirPage?dirId="+dirId+"&newFileName="+value));
            layer.msg("新建文件夹成功")
        });

    });
    /*new MyLayer({
        top:"40%",
        left:"30%",
        width:"40%",
        height:"20%",
        title:"重命名",
        id:clientMenu.id,
        content:"renameFileMenu"
    }).openLayer();*/
}

function openDeleteFileMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=-1;
    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        layer.confirm('确定删除文件？',{
        btn:['确定','取消']
    },function () {
        layer.msg("删除成功",{time:6000});
        if(clientMenu.objClass=="normalFileClass")
            window.location.href=encodeURI(encodeURI("deleteFilePage?fileId="+clientMenu.id+"&dirId="+dirId));
        else if(clientMenu.objClass=="dirClass")
        window.location.href=encodeURI(encodeURI("deleteDirectoryPage?fileId="+clientMenu.id+"&dirId="+dirId));
        });
    });
    /*new MyLayer({
        top:"40%",
        left:"30%",
        width:"40%",
        height:"20%",
        title:"确认删除",
        id:clientMenu.id,
        content:"deleteFileMenu"
    }).openLayer();*/
}

function openMoveFileMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=-1;
    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        layer.prompt({
            formType: 2,
            title: '移动到：',
            content: $('.testClass')
        }, function (pass, index) {
            alert("ff");
        });
    });
    /*new MyLayer({
        top:"20%",
        left:"30%",
        width:"60%",
        height:"20%",
        title:"文件移动",
        content:"moveFileMenu"
    }).openLayer();*/
}

function init(){
    //for(var child=0;child<table.childNodes.length;child++)
        //table.oncontextmenu=menuEvent;
    for(var a =0; a<dirClass.length;a++)
        dirClass[a].oncontextmenu=menuEvent;
    for(var a =0; a<normalFileClass.length;a++)
        normalFileClass[a].oncontextmenu=menuEvent;
    document.body.onclick=hiddenMenu;
    clientMenu.oncontextmenu = defaultMenu;
}

init();
