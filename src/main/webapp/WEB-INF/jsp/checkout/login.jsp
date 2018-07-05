<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2018/7/3
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ include file="../shared/sharedHeader.jsp"%>

<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet" href="/EasyCloudStorage/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/EasyCloudStorage/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/EasyCloudStorage/css/login/form-elements.css">
<link rel="stylesheet" href="/EasyCloudStorage/css/login/style.css">

<link rel="shortcut icon" href="/EasyCloudStorage/img/ico/favicon.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/EasyCloudStorage/img/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/EasyCloudStorage/img/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/EasyCloudStorage/img/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="/EasyCloudStorage/img/ico/apple-touch-icon-57-precomposed.png">


<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>轻松云存储</strong></h1>
                    <div class="description">
                        <p>
                            全新云端体验，引领精彩生活
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>进入云盘</h3>
                            <p><font color="red">${error2}</font></p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-lock"></i>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <form role="form" action="login" method="get" class="login-form">
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text" name="accountId" placeholder="账户" class="form-username form-control" id="form-username">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password" name="password" placeholder="密码" class="form-password form-control" id="form-password">
                            </div>
                            <button type="submit" class="btn">登录</button>
                        </form>
                        <p></p>
                        <form action="toRegister" method="get">
                            <button type="submit" class="btn">注册</button>
                        </form>
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


</body>
</html>
