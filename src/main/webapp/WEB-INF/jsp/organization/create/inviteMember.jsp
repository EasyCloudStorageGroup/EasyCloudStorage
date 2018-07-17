<%--
  Created by IntelliJ IDEA.
  User: VULCAN
  Date: 2018/7/13
  Time: 10:32
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
                        <h1 align="center">邀请成员</h1>
                        <span id="warning"></span>
                        <h3 align="center"><font color="red">${error}</font></h3>
                        <h3 align="center"><font color="#00bfff">${message}</font></h3>
                    </div>
                    <div class="form-bottom">
                        <form action="invite" method="post">

                            <div class="form-group">
                                <label class="sr-only" for="form-phoneNumber">accountId</label>
                                <input type="text" id="form-phoneNumber" name = "accountId" class="form-phoneNumber form-control" placeholder="请输入用户ID">
                            </div>
                            <div><button type="submit" class="btn">继续邀请</button></div>
                        </form>
                        <p></p>
                        <a href="/EasyCloudStorage/enterOrganization?orgId=${orgId}">
                            <div><button type="submit" class="btn" style="width: 505px;">进入主页</button></div>
                        </a>
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