<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<%@ include file="../shared/sharedHeader.jsp"%>
<script src=""></script>

<div class="layui-upload">
    <a href="javascript:" onclick="self.location=document.referrer;">

    <button type="button" class="layui-btn layui-btn-normal" id="return" style="background-color: #a94442; position:relative;left:0%; margin: 10px">返回</button>
    </a>
    <input type="file" name="" multiple class="" id="fileUpload" style="position:relative;left:35%; margin: 10px" onchange="fileSelected()"/>
    <button type="button" class="layui-btn" id="startUpload" style="position:relative;left: 40%; margin: 10px">开始上传</button>
    <div class="layui-upload-list">
        <table class="layui-table" id="tableId">
            <thead>
            <tr><th>文件名</th>
                <th>大小</th>
                <th>状态</th>
                <th>操作</th>
            </tr></thead>
            <tbody id="demoList"></tbody>
        </table>
    </div>

</div>

<script>

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

    function fileSelected() {
        var files=document.getElementById("fileUpload");
        if (files) {
            var table=document.getElementById("tableId")
            for (var i=0;i<files.files.length;++i) {

                var row=table.insertRow(i+1)
                var cell1=row.insertCell(0)
                var cell2=row.insertCell(1)
                var cell3=row.insertCell(2)
                cell1.innerHTML=files.files[i].name
                cell2.innerHTML=checkSize(files.files[i].size)
                cell3.innerHTML="等待传输"
                cell3.id="file"+i
                //uploadFile(i)
            }
        }
    }

    $("#startUpload").click(function () {
        var files=document.getElementById("fileUpload");
        for (var i=0;i<files.files.length;++i) {
            uploadFile(i)
        }
    })


    function uploadFile(index) {

        var fd = new FormData();

        fd.append("file",document.getElementById("fileUpload").files[index])

        var xhr = new XMLHttpRequest();

        xhr.upload.onprogress=function (eve) {
                if (eve.lengthComputable) {
                var percentComplete = Math.round(eve.loaded * 100 / eve.total);

                document.getElementById("file"+index).innerHTML = percentComplete.toString() + "%";

            }else {
                document.getElementById("file"+index).innerHTML = "unable to compute";
            }
        };

        xhr.addEventListener("load", function (ev) {
            document.getElementById('file'+index).innerHTML = "传输完成";
        }, false);

        xhr.addEventListener("error", function (ev) {
            document.getElementById('file'+currentId).innerHTML = "传输失败";
        }, false);

        xhr.addEventListener("abort", function (ev) {

        }, false);

        xhr.open("POST", "/EasyCloudStorage/upload",true);

        xhr.send(fd);

    }



    // layui.use('upload', function() {
    //     var upload = layui.upload;
    //     //多文件列表示例
    //     var demoListView = $('#demoList')
    //         , uploadListIns = upload.render({
    //         elem: '#testList'
    //         , url: '/EasyCloudStorage/upload'
    //         , accept: 'file'
    //         , multiple: true
    //         , auto: true
    //         ,drag:true
    //         ,xhr:xhrOnProgress
    //         ,progress:function (value) {
    //             element.progress('demo',value+'%')
    //         }
    //         , bindAction: '#testListAction'
    //         , choose: function (obj) {
    //             //var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
    //             //读取本地文件
    //             obj.preview(function (index, file, result) {
    //                 var tr = $(['<tr id="upload-' + index + '">'
    //                     , '<td>' + file.name + '</td>'
    //                     , '<td>' + (file.size / 1014).toFixed(1) + 'kb</td>'
    //                     , '<td>等待上传</td>'
    //                     , '<td>'
    //                     , '<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
    //                     , '<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
    //                     , '</td>'
    //                     , '</tr>'].join(''));
    //
    //                 //单个重传
    //                 tr.find('.demo-reload').on('click', function () {
    //                     obj.upload(index, file);
    //                 });
    //
    //                 //删除
    //                 tr.find('.demo-delete').on('click', function () {
    //                     delete files[index]; //删除对应的文件
    //                     tr.remove();
    //                     uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
    //                 });
    //
    //                 demoListView.append(tr);
    //             });
    //         }
    //         , done: function (res, index, upload) {
    //             if (res.code == 0) { //上传成功
    //                 var tr = demoListView.find('tr#upload-' + index)
    //                     , tds = tr.children();
    //                 tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
    //                 tds.eq(3).html(''); //清空操作
    //                 return delete this.files[index]; //删除文件队列已经上传成功的文件
    //             }
    //             this.error(index, upload);
    //         }
    //         , error: function (index, upload) {
    //             var tr = demoListView.find('tr#upload-' + index)
    //                 , tds = tr.children();
    //             tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
    //             tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
    //         }
    //     });
    // })
</script>
