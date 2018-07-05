var clientMenu = document.getElementById('clientMenu');
var table = document.getElementById('renameTable');

function menuEvent(event){
    if(event.clientX + 242 > screen.availWidth){
        clientMenu.style.left = event.clientX - 242 + 'px';
    }else{
        clientMenu.style.left = event.clientX + 'px';
    }
    if(event.clentY + 122 > screen.availHeight){
        clientMenu.style.top = event.clientY - 122 + 'px';
    }else{
        clientMenu.style.top = event.clientY + 'px';
    }
    clientMenu.style.visibility = 'visible';
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
    new MyLayer({
        top:"40%",
        left:"30%",
        width:"40%",
        height:"20%",
        title:"重命名",
        content:"renameFileMenu"
    }).openLayer();
}

function openDeleteFileMenu()
{
    new MyLayer({
        top:"40%",
        left:"30%",
        width:"40%",
        height:"20%",
        title:"确认删除",
        content:"deleteFileMenu"
    }).openLayer();
}

function openMoveFileMenu()
{
    new MyLayer({
        top:"20%",
        left:"30%",
        width:"60%",
        height:"20%",
        title:"文件移动",
        content:"moveFileMenu"
    }).openLayer();
}

function init(){
    for(var child=0;child<table.childNodes.length;child++)
        table.childNodes[child].oncontextmenu=menuEvent;
    document.body.onclick=hiddenMenu;
    clientMenu.oncontextmenu = defaultMenu;
}

init();
