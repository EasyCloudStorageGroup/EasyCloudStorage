<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<%@ include file="../shared/sharedHeader.jsp"%>
<div class="layui-upload">

    <div>
    <%--<input type="file" multiple class="" id="fileUpload" style="position:relative; margin: 10px;float: left"  onchange="fileSelected()"/>--%>
        <button class="layui-btn" style="position:relative; margin: 7px;" onclick="selectFile()">
            <i class="layui-icon">&#xe608;</i> 上传
        </button>
        <input type="file" multiple class="" id="fileUpload" style="display: none"  onchange="fileSelected()"/>
    </div>

    <div class="layui-upload-list">
        <table class="layui-table" id="tableId">
            <thead>
            <tr ><th style="width: 40%;height: 10%">文件名</th>
                <th style="width: 15%;height: 10%">大小</th>
                <th style="width: 25%;height: 10%">状态</th>
                <th style="width: 20%;height: 10%">操作</th>
            </tr></thead>
            <tbody id="demoList"></tbody>
        </table>
    </div>

</div>

<script>
    function selectFile(){
        $("#fileUpload").trigger("click");
    }
    var id=0;
    var items=new Array()
    var date=new Array()
    var loaded=new Array()

    function getId() {
        return id++;
    }
    function checkSize(sizeByte) {
        var level=0;
        while (sizeByte>1000){
            sizeByte/=1000
            ++level
        }
        switch (level){
            case 0:
                return sizeByte.toFixed(2)+"B"
            case 1:
                return sizeByte.toFixed(2)+"KB"
            case 2:
                return sizeByte.toFixed(2)+"MB"
            case 3:
                return sizeByte.toFixed(2)+"G"
        }
    }

    function tableClear(table) {
        var row=table.rows.length
        for (var i=row-1;i>0;--i) table.deleteRow(1)
    }
    function fileSelected() {
        var table=document.getElementById("tableId")
        var files=document.getElementById("fileUpload");
        if (files) {
            var fileLength=files.files.length
            var tableLength=table.rows.length
            for (var i=0;i<fileLength;++i) {

                var row=table.insertRow(i+tableLength)
                var cell1=row.insertCell(0)
                var cell2=row.insertCell(1)
                var cell3=row.insertCell(2)
                var cell4=row.insertCell(3)
                cell1.innerHTML=files.files[i].name
                cell2.innerHTML=checkSize(files.files[i].size)
                cell3.innerHTML="等待传输"
                var a=getId()
                items[a]=new Object()
                items[a].isOn=false
                items[a].index=i+tableLength
                items[a].fileIndex=i
                var o = document.createElement('input');
                o.type = 'button';
                o.value = '删除';
                o.className='layui-btn layui-btn-danger'
                o.addEventListener('click',function (ev) {
                    var a= parseInt(this.parentNode.parentNode.childNodes[2].id)
                    var index=items[a].index
                    if(items[a].isOn)
                    items[a].XHR.abort();
                    items[a].isOn=false
                    table.deleteRow(index)
                    for (var i=0;i<items.length;++i){
                        if (items[i].index>index)
                            --(items[i].index)
                    }

                })
                cell4.appendChild(o)
                cell3.id=a.toString()

            }
            for (var i=1;i<table.rows.length;++i) {
                uploadFile(i)
            }
        }
    }

    $("#startUpload").click(function () {
        var files=document.getElementById("fileUpload");
        var table=document.getElementById("tableId")
        for (var i=1;i<table.rows.length;++i) {
            uploadFile(i)
        }
    })


    function uploadFile(i) {

        var table=document.getElementById("tableId")
        var index=parseInt(table.rows[i].cells[2].id)//int 类型的id
        if (items[index].isOn)return
        items[index].isOn=true
        date[index]=new Date()
        loaded[index]=0

        var currentDate=new Date()
        var fd = new FormData();

        fd.append("file",document.getElementById("fileUpload").files[items[index].fileIndex])

        var xhr = new XMLHttpRequest();
        items[index].XHR=xhr

        xhr.upload.onprogress=function (eve) {
            if (eve.lengthComputable) {
                var percentComplete = Math.round(eve.loaded * 100 / eve.total);
                var time=(new Date().getTime()-date[index].getTime())/1000
                date[index]=new Date()
                var amount=eve.loaded-loaded[index]
                loaded[index]=eve.loaded
                if (0==time)return
                var speed=amount/time

                document.getElementById(index.toString()).innerHTML = percentComplete.toString() + "%"+"("+checkSize(speed)+"/s"+")";

            }else {
                document.getElementById(index.toString()).innerHTML = "unable to compute";
            }
        };

        xhr.upload.addEventListener("load", function (ev) {

            document.getElementById(index.toString()).innerHTML = "传输完成";
            items[index].isOn=false
            tryReload()
        }, false);

        xhr.upload.addEventListener("error", function (ev) {
            document.getElementById(index.toString()).innerHTML = "传输失败";
            items[index].isOn=false
        }, false);

        xhr.open("POST", "/EasyCloudStorage/upload",true);

        xhr.send(fd);

    }

    function tryReload() {
        var ifReload=true
        for (var i=0;i<items.length;++i){
            ifReload=ifReload&(!items[i].isOn)
        }
        if (ifReload) {
            setTimeout(function () { parent.location.reload() },500)
            // parent.location.reload()
        }
    }

</script>
