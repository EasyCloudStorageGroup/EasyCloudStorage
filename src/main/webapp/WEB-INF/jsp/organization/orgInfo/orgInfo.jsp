<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2018/7/13
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%@ include file="../../shared/sharedHeader.jsp"%>
<html>
<head>
    <link rel="stylesheet" href="/EasyCloudStorage/layui/css/layui.css"  media="all">
</head>
<body style="background-color: #c1e2b3">

<script src="/EasyCloudStorage/layui/layui.js" charset="utf-8"></script>





<%--将参数传给组织id传给服务器--%>


<div style="position:absolute;left: 25%; top: 15%; width:50%;height:90%;background-color:#ffffff">
    <a href="/EasyCloudStorage/enterOrganization?orgId=${organization.orgId}"><button class="layui-btn">返回</button></a>
    <div class="layui-tab" >
        <ul class="layui-tab-title">
            <li class="layui-this">组织信息</li>
            <li>修改信息</li>


        </ul>

        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <dl>
                    <dd>名字：${organization.name}</dd>
                    <dd>描述：${organization.description}</dd>
                    <dt>分组信息：</dt>
                    <c:choose>
                        <c:when test="${empty groupList}">
                            <dd>当前无任何分组</dd>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${groupList}" var="group">
                                <dt>${group.name}:</dt>
                                <dd>描述：${group.description}</dd>
                                <dd>成员数：${group.members.size()}</dd>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </dl>
            </div>
            <div class="layui-tab-item">

                <form class="layui-form" action="">

                    <input type="hidden" name="orgId" value=${organization.orgId}>
                <div class="layui-form-item">
                    <label class="layui-form-label">单行输入框</label>
                    <div class="layui-input-block">
                        <input name="newName" class="layui-input" type="text" placeholder="输入新名字" autocomplete="off" lay-verify="title">
                    </div>
                </div>

                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">普通文本域</label>
                    <div class="layui-input-block">
                        <textarea name="description" class="layui-textarea" placeholder="请输入内容"></textarea>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-filter="demo1" lay-submit="">立即提交</button>
                        <button class="layui-btn layui-btn-primary" type="reset">重置</button>
                    </div>

                </div>

                </form>
            </div>
        </div>
    </div>
</div>



<script>
    layui.use('element', function(){
        var $ = layui.jquery
            ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        //触发事件
        var active = {
            tabChange: function(){
                //切换到指定Tab项
                element.tabChange('demo', '22'); //切换到：用户管理
            }
        };

        $('.site-demo-active').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });

        //Hash地址的定位
        var layid = location.hash.replace(/^#test=/, '');
        element.tabChange('test', layid);

        element.on('tab(test)', function(elem){
            location.hash = 'test='+ $(this).attr('lay-id');
        });

    });
</script>
</body>
</html>
