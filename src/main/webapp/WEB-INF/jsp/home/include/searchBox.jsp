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
            var newHref = "searchFiles?keyword="+keyword;
           $(".search-box-but-link").attr("href", "searchFiles?keyword="+keyword);
           return true;
        });
    });
</script>


<style>
    .search-box {
        position: absolute;
        width: 250px;
        right: 630px;
    }

    .search-box .search-box-input {
        background-color: rgb(240, 240, 240);
        border-radius:15px;

    }

    .search-box-but {
      position:absolute;
        right: 550px;

    }
</style>

<div class="layui-input-inline search-box" >
    <input class="layui-input search-box-input" type="text" placeholder="搜索文件"/>
</div>
<a href="searchFiles" class="search-box-but-link">
    <button class="layui-btn layui-btn-radius layui-btn-primary search-box-but" >
        搜索
    </button>
</a>
