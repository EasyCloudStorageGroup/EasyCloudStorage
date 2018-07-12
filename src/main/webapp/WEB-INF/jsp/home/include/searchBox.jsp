<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 7/6/2018
  Time: 1:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         isELIgnored="false"%>

<script>
    $(function () {
        $(".search-box-but").click(function () {
            var keyword = $(".search-box-input").val();
            if(keyword.replace(/(^\s*)|(\s*$)/g,"").length == 0)
                return false;

            $(".search-box-but-link").attr("href", "searchFiles?keyword="+keyword);
            return true;
        });
    });
</script>


<style>
    .search-box {
        position: absolute;
        width: 400px;
        top:0px;
        left: 30%;
    }

    .search-box .search-box-input {
        background-color: rgb(240, 240, 240);
        border-radius:15px;
    }
</style>

<div class="layui-inline search-box">
    <div class="layui-input-inline">
        <input class="layui-input search-box-input" type="text" placeholder="搜索文件"/>
    </div>

    <a href="searchFiles" class="search-box-but-link">
        <button class="layui-btn layui-btn-radius layui-btn-primary search-box-but" style="position: absolute;margin-left: 5px ;">
            搜索
        </button>
    </a>
</div>
