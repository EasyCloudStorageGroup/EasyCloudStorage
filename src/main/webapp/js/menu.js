var clientMenu = document.getElementById('clientMenu');
var dirClass=document.getElementsByClassName("dirClass");
var normalFileClass=document.getElementsByClassName("normalFileClass");
var fileMoveClickedId;
var fileCollection = [];
var dirCollection = [];

//右键菜单事件
function menuEvent(event){
    if(event.clientX + 120 > screen.availWidth){
        clientMenu.style.left = event.clientX - 120 + 'px';
    }else{
        clientMenu.style.left = event.clientX + 'px';
    }
    if(event.clentY + 150 > screen.availHeight){
        clientMenu.style.top = event.clientY - 150 + 'px';
    }else{
        clientMenu.style.top = event.clientY + 'px';
    }
    clientMenu.style.left = event.clientX + 'px';
    clientMenu.style.top = event.clientY + 'px';
    clientMenu.style.visibility = 'visible';
    clientMenu.id=this.id;
    clientMenu.objName=this.children[2].innerText;
    clientMenu.objClass=this.className;
    this.children[0].children[0].checked= true

    return false;
}

function hiddenMenu(){
    clientMenu.style.visibility = 'hidden';
}

function defaultMenu(){
    return false;
}

//重命名菜单
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
}

//新建文件夹菜单
function openNewDirectoryMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=0;
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
}

//删除文件菜单
function openDeleteFileMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=0;
    layui.use('layer',function () {
        var $ = layui.jquery, layer = layui.layer;

        layer.confirm('确定删除选中文件？',{
        btn:['确定','取消']
    },function () {
            $("input[name = 'check']").each(function (i) {
                if(this.checked==true)
                    fileCollection[i] = this.parentElement.parentElement;
            });
            $("input[name = 'check2']").each(function (i) {
                if(this.checked==true)
                    dirCollection[i] = this.parentElement.parentElement;
            });
            for(var i=0;i<dirCollection.length;i++)
            {
                $.ajax({
                    type: "get",
                    async: true,
                    url: encodeURI(encodeURI("deleteDirectoryPage?fileId="+dirCollection[i].id+"&dirId="+dirId)),
                    success:function () {
                        window.location.reload(true)
                    }
                })//window.location.href=encodeURI(encodeURI("deleteDirectoryPage?fileId="+nodeCollection[i].id+"&dirId="+dirId));
            }
        for(var i=0;i<fileCollection.length;i++)
        {
            $.ajax({
                type: "get",
                async: true,
                url: encodeURI(encodeURI("deleteFilePage?fileId="+fileCollection[i].id+"&dirId="+dirId)),
                success:function () {
                    window.location.reload(true)
                }
            })//window.location.href=encodeURI(encodeURI("deleteFilePage?fileId="+nodeCollection[i].id+"&dirId="+dirId));
        }
        layer.msg("删除成功",{time:5000});
    });
    });
}

//移动文件菜单
function openMoveFileMenu()
{
    var result=/dirId=([0-9]+)/.exec(window.location.href);
    var dirId;
    if(result!=null&&result.length>1) dirId=result[1];
    else dirId=0;

    $.ajax({
        type:"get",
        async:false,
        url:"getAllDirectories",
        contentType:"application/json;charset=utf-8",
        success: function(data){
            var div = generetaContent(data);

            layui.use('layer',function () {
                var $ = layui.jquery, layer = layui.layer;
                layer.prompt({
                    type: 1,
                    title: '移动到：',
                    area: '800px',
                    content:div.outerHTML,
                    yes:function (index, layero) {
                        layer.close(index)
                        $("input[name = 'check']").each(function (i) {
                            if(this.checked==true)
                                fileCollection[i] = this.parentElement.parentElement;
                        });
                        $("input[name = 'check2']").each(function (i) {
                            if(this.checked==true)
                                dirCollection[i] = this.parentElement.parentElement;
                        });
                        for(var i=0;i<fileCollection.length;i++)
                        {
                            if(fileCollection[i]!= undefined)
                                $.ajax({
                                    type: "get",
                                    async: true,
                                    url: encodeURI(encodeURI("moveFilePage?fileId="+fileCollection[i].id+"&moveToId="+fileMoveClickedId+"&dirId="+dirId)),
                                    success:function () {
                                        window.location.reload(true)
                                    }
                                })//window.location.href=encodeURI(encodeURI("moveFilePage?fileId="+clientMenu.id+"&moveToId="+fileMoveClickedId+"&dirId="+dirId));
                        }
                        for(var i=0;i<dirCollection.length;i++)
                        {
                            if(dirCollection[i]!= undefined)
                                $.ajax({
                                    type: "get",
                                    async: true,
                                    url: encodeURI(encodeURI("moveDirectoryPage?fileId="+dirCollection[i].id+"&moveToId="+fileMoveClickedId+"&dirId="+dirId)),
                                    success:function () {
                                        window.location.reload(true)
                                    }
                                })//window.location.href=encodeURI(encodeURI("moveDirectoryPage?fileId="+clientMenu.id+"&moveToId="+fileMoveClickedId+"&dirId="+dirId));
                        }
                    },
                    cancel:function (index, layero) {
                        layer.close(index)
                    },
                    end:function () {
                        fileMoveClickedId=undefined
                    }
                })
            });
        }
    });
}
$(document).on("click",".fileMoveClass",function () {
    click(this);
})
$(document).on("mouseover",".fileMoveClass",function () {
    mouseOver(this);
})
$(document).on("mouseout",".fileMoveClass",function () {
    mouseOut(this);
})

function init(){
    for(var a =0; a<dirClass.length;a++)
        dirClass[a].oncontextmenu=menuEvent;
    for(var a =0; a<normalFileClass.length;a++)
        normalFileClass[a].oncontextmenu=menuEvent;
    document.body.onclick=hiddenMenu;
    clientMenu.oncontextmenu = defaultMenu;
}

function generetaContent(data)
{
    var div = document.createElement("div");
    div.style.height="300px";
    div.style.overflow = "auto";
    generateDirLi(div, data.dirId, data.name, 0, data);

    return div;
}

function generateDirLi(parent, dirId, name, deep, data)
{

    var li = document.createElement("li");
    li.id = dirId;
    li.className="fileMoveClass"
    li.style.paddingLeft=15*deep+"px";
    li.onclick = function(){
        click();
    };
    li.click=function () { alert("ggg") }
    if(deep==0)
        li.innerText = "全部文件"
    else
        li.innerText = name;
    parent.appendChild(li);
    for(var i =0; data.childrenDir!= undefined&&i<data.childrenDir.length;i++)
        generateDirLi(li, data.childrenDir[i].dirId, data.childrenDir[i].name, deep+1, data.childrenDir[i])
}

function click(file)
{
    var allFileMoveClasses = ($(document))[0].getElementsByClassName("fileMoveClass")
    for(var i=0;i<allFileMoveClasses.length;i++)
        allFileMoveClasses[i].style.backgroundColor=""
    file.style.backgroundColor="#1E9FFF"
    fileMoveClickedId = file.id;
}

function mouseOver(file)
{
    var allFileMoveClasses = ($(document))[0].getElementsByClassName("fileMoveClass")
    for(var i=0;i<allFileMoveClasses.length;i++)
        if(allFileMoveClasses[i].id == fileMoveClickedId)
            allFileMoveClasses[i].style.backgroundColor="#1E9FFF"
        else
            allFileMoveClasses[i].style.backgroundColor=""
    file.style.backgroundColor="70DB93"
}

function mouseOut(file)
{
    var allFileMoveClasses = ($(document))[0].getElementsByClassName("fileMoveClass")
    for(var i=0;i<allFileMoveClasses.length;i++)
        if(allFileMoveClasses[i].id == fileMoveClickedId)
            allFileMoveClasses[i].style.backgroundColor="#1E9FFF"
        else
            allFileMoveClasses[i].style.backgroundColor=""
}
function test(){alert("test")}
init();