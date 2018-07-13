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
<link rel="stylesheet" href="/EasyCloudStorage/css/login/form-elements.css?v=3.0">
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
                            <h1 align="center">注册</h1>
                            <font color="red"><span id="warning"></span></font>
                            <h3 align="center"><font color="red">${error}</font></h3>
                        </div>
                        <div class="form-bottom">
                            <form action="register" method="post">
                                <div class="form-group">
                                    <label class="sr-only" for="form-accountId">accountId</label>
                                    <input type="text" id="form-accountId" name = "accountId" class="form-accountId form-control" placeholder="请输入账户">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-password">Password</label>
                                    <input type="password" id="form-password" name="password"   class="form-password form-control" placeholder="请输入密码">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-password2">password</label>
                                    <input type="password" id="form-password2" name="password2" onblur="check()" class="form-password2 form-control" placeholder="重复输入确认密码">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-username">Username</label>
                                    <input type="text" name="userName" class="form-username form-control" id="form-username" placeholder="请输入用户名">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-phoneNumber">phoneNumber</label>
                                    <input type="text" id="form-phoneNumber" name = "phoneNumber" class="form-phoneNumber form-control" placeholder="请输入电话号码">
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-identifyingCode">identifyingCode</label>
                                    <input type="text" id="form-identifyingCode" name="identifyingCode" class="form-identifyingCode form-control2" placeholder="请输入验证码">
                                    <button type="submit" class="btn2">发送验证码</button>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-sex">sex</label>
                                    <select id="form-sex" name="sex" class="form-control form-sex">
                                        <option value="male">男</option>
                                        <option value="female">女</option>
                                    </select></div>
                                <div><button type="submit" class="btn">注册</button></div>
                            </form>
                            <p></p>
                            <form action="toLogin" method="get">
                                <div><button type="submit" class="btn">返回</button></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript" src="/EasyCloudStorage/jquery/changeSkin/jquery.js"></script>
<script>
    function check() {
        var password1 = document.getElementById("form-password").value;
        var password2 = document.getElementById("form-password2").value;
        if(password2 != password1){
            document.getElementById("warning").innerHTML = "两次输入密码不一致";
            $("#form-password").val("");
            $("#form-password2").val("");
        }

    }
</script>
<script src="/EasyCloudStorage/jquery/jsForLogin/jquery-1.11.1.min.js"></script>
<script src="/EasyCloudStorage/bootstrap/js/bootstrap.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/jquery.backstretch.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/scripts.js"></script>


</body>
</html>
