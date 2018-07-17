<%--
  Created by IntelliJ IDEA.
  User: VULCAN
  Date: 2018/7/12
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ include file="../../shared/sharedHeader.jsp"%>
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
<div>
    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <h1 align="center">创建组织</h1>
                        <span id="warning"></span>
                        <h3 align="center"><font color="red">${error}</font></h3>
                    </div>
                    <div class="form-bottom">
                        <form action="create" method="post">
                            <div class="form-group">
                                <label class="sr-only" for="form-username">name</label>
                                <input type="text" name="name" class="form-username form-control" id="form-username" placeholder="请输入组织名">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-phoneNumber">description</label>
                                <input type="text" id="form-phoneNumber" name = "description" class="form-phoneNumber form-control" placeholder="请输入简介">
                            </div>
                            <div><a href="toInvite"><button type="submit" class="btn">创建组织并邀请成员</button></a></div>
                        </form>
                        <p></p>
                        <form action="toOrgPage" method="get">
                            <div><button type="submit" class="btn">取消创建</button></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function check() {
        password1 = document.getElementById("form-pssword").value;
        password2 = document.getElementById("form-password2").value;
        if(password2 != password1){
            document.getElementById("warning").innerHTML = "两次输入密码不一致";
        }

    }
</script>
<script src="/EasyCloudStorage/jquery/jsForLogin/jquery-1.11.1.min.js"></script>
<script src="/EasyCloudStorage/bootstrap/js/bootstrap.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/jquery.backstretch.min.js"></script>
<script src="/EasyCloudStorage/jquery/jsForLogin/scripts.js"></script>


</body>
</html>
