<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/7/14
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ include file="../shared/sharedHeader.jsp"%>
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet" href="/EasyCloudStorage/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/EasyCloudStorage/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/EasyCloudStorage/css/login/form-elements.css?v=4.0">
<link rel="stylesheet" href="/EasyCloudStorage/css/login/style.css">

<link rel="shortcut icon" href="/EasyCloudStorage/img/ico/favicon.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/EasyCloudStorage/img/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/EasyCloudStorage/img/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/EasyCloudStorage/img/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="/EasyCloudStorage/img/ico/apple-touch-icon-57-precomposed.png">
<div>
        <div class="inner-bg">
                <div class="container">
                        <div class="row">
                                <div class="col-sm-6 col-sm-offset-3 form-box">
                                        <div class="form-top">
                                                <h3 align="center">输入密码提取文件</h3>
                                                <h3 align="center"><font color="red">${error}</font></h3>
                                        </div>
                                        <div class="form-bottom">
                                                <div class="form-group">
                                                        <label class="sr-only" for="form-password">password</label>
                                                        <input type="text" id="form-password" name = "password" class="form-password form-control2" placeholder="请输入密码">
                                                        <button type="submit" class="btn2" id="form-getFile">提取文件</button>
                                                </div>
                                        </div>
                                </div>
                        </div>
                </div>
        </div>
</div>

<script src="/EasyCloudStorage/jquery/jsForLogin/jquery-1.11.1.min.js"></script>
<script src="/EasyCloudStorage/bootstrap/js/bootstrap.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/jquery.backstretch.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/scripts.js"></script>
<script>
    $("#form-getFile").click(function () {
        var str = window.location.href;
        var arr = str.split('/');
        var lastStr = arr[arr.length - 1];
        var password = $("#form-password").val();
        var data = {
            "str2": lastStr,
            "password": password
        };
        window.location = "toSharingPage?" + $.param(data);
    })
</script>
</body>
</html>
