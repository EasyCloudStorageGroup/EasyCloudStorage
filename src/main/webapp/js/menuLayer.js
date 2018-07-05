/**
 * Created by zhuwenqi on 2017/6/16.
 */
/**
 * @param options 弹窗基本配置信息
 * @constructor 构造方法
 */
function MyLayer(options) {
    this.options = options ;
}
/**
 * 打开弹窗
 */
MyLayer.prototype.openLayer = function () {
    var background_layer = document.createElement("div");
    background_layer.style.display = "none";
    background_layer.style.position = "absolute";
    background_layer.style.top = "0px";
    background_layer.style.left = "0px";
    background_layer.style.width = "100%";
    background_layer.style.height = "100%";
    background_layer.style.backgroundColor = "gray";
    background_layer.style.zIndex = "1001";
    background_layer.style.opacity = "0.8" ;
    var open_layer = document.createElement("div");
    open_layer.style.display = "none";
    open_layer.style.position = "absolute";
    open_layer.style.top = this.options.top === undefined ? "10%" : this.options.top;
    open_layer.style.left = this.options.left === undefined ? "10%" :this.options.left;
    open_layer.style.width = this.options.width === undefined ? "80%" : this.options.width;
    open_layer.style.height = this.options.height === undefined ? "80%" : this.options.height;
    open_layer.style.border = "1px solid lightblue";
    open_layer.style.borderRadius = "15px" ;
    open_layer.style.boxShadow = "4px 4px 10px #171414";
    open_layer.style.backgroundColor = "white";
    open_layer.style.zIndex = "1002";
    open_layer.style.overflow = "auto";
    var div_toolBar = document.createElement("div");
    div_toolBar.style.textAlign = "right";
    div_toolBar.style.paddingTop = "10px" ;
    div_toolBar.style.backgroundColor = "aliceblue";
    div_toolBar.style.height = "40px";
    var span_title = document.createElement("span");
    span_title.style.fontSize = "18px";
    span_title.style.color = "black" ;
    span_title.style.float = "left";
    span_title.style.marginLeft = "20px";
    var span_title_content = document.createTextNode(this.options.title === undefined ? "" : this.options.title);
    span_title.appendChild(span_title_content);
    div_toolBar.appendChild(span_title);
    var span_close = document.createElement("span");
    span_close.style.fontSize = "16px";
    span_close.style.color = "blue" ;
    span_close.style.cursor = "pointer";
    span_close.style.marginRight = "20px";
    span_close.onclick = function () {
        open_layer.style.display = "none";
        background_layer.style.display = "none";
    };
    var span_close_content = document.createTextNode("关闭");
    span_close.appendChild(span_close_content);
    div_toolBar.appendChild(span_close);
    open_layer.appendChild(div_toolBar);

    //content
    if(this.options.content == "renameFileMenu")
        renameFileMenu(open_layer);
    else if(this.options.content=="deleteFileMenu")
        deleteFileMenu(open_layer);
    else if(this.options.content=="moveFileMenu")
        moveFileMenu(open_layer);

    document.body.appendChild(open_layer);
    document.body.appendChild(background_layer);
    open_layer.style.display = "block" ;
    background_layer.style.display = "block";
};

function renameFileMenu(open_layer) {
    var div_content = document.createElement("div");
    div_content.style.textAlign = "center";
    div_content.style.paddingTop = "5%";
    var contentForm = document.createElement("form");
    contentForm.method="POST";
    contentForm.action="renamePage";
    var nameLable=document.createElement("label");
    nameLable.innerHTML="重命名为: ";
    var oldFileName = document.createElement("input");
    oldFileName.name="oldFileName";
    //oldFileName.style.display="none";
    var newFileName = document.createElement("input");
    newFileName.name="newFileName";
    newFileName.text="aaa";
    var button=document.createElement("input");
    button.type="submit";
    button.value="OK";
    contentForm.appendChild(oldFileName);
    contentForm.appendChild(nameLable);
    contentForm.appendChild(newFileName);
    contentForm.appendChild(button);
    div_content.appendChild(contentForm);
    open_layer.appendChild(div_content);
}

function deleteFileMenu(open_layer) {
    var div_content = document.createElement("div");
    div_content.style.textAlign = "center";
    div_content.paddingTop="2cm"
    var aHref=document.createElement("a");
    aHref.href="deleteFilePage?filePid=1";
    var button=document.createElement("button");
    button.type="button";
    button.innerHTML="删除";
    aHref.appendChild(button);
    div_content.appendChild(aHref);
    open_layer.appendChild(div_content);
}

function moveFileMenu(open_layer) {
    var div_content = document.createElement("div");
    div_content.style.textAlign = "center";
    div_content.paddingTop="2cm"
    var aHref=document.createElement("a");
    aHref.href="moveFilePage?filePid=1&moveToPath=fff";
    var button=document.createElement("button");
    button.type="button";
    button.innerHTML="删除";
    aHref.appendChild(button);
    div_content.appendChild(aHref);
    open_layer.appendChild(div_content);
}