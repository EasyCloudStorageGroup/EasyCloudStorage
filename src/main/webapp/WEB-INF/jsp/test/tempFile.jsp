<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>jQuery File Upload Example</title>
</head>
<style>
    .bar {
        height: 18px;
        background: green;
    }
    .content{
        width: 100%;text-align: center;margin-top: 70px;
    }
    #progress{
        border-radius:6px;width: 300px;background: red;
        margin: 10px auto;
    }
</style>
<body>

<div class="content">
    <input id="uploader" type="file" name="file" data-url="{:U('setFile')}" multiple>
    <div id="progress">
        <div class="bar" style="width: 0%;"></div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-1.8.0.min.js"></script>
<script src="/js/FileManager/jquery.ui.widget.js"></script>
<script src="/js/FileManager/jquery.iframe-transport.js"></script>
<script src="/js/FileManager/jquery.fileupload.js"></script>
<script>
    $('#fileupload').fileupload({
        dataType: 'json',
        //url: "{:U('setFile')}",//文件的后台接受地址
        //设置进度条
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
        //上传完成之后的操作，显示在img里面
        done: function (e, data){
            $("#uploadimg").attr({src: data.result.pic_url});
            $("#uploadimg").css({width: "400px", height: "400px"});
        }
    });
</script>
</body>
</html>