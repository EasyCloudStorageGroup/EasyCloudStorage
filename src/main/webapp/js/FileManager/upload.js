
var ifOn=false
layui.use('layer', function(){ //独立版的layer无需执行这一句
    var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

    //触发事件
    var active = {
        setTop: function(){
            if (true==ifOn)return;
            ifOn=true
            var that = this;
            //多窗口模式，层叠置顶
            layer.open({
                type: 2 //此处以iframe举例
                ,title: '上传列表'
                ,area: ['750px', '450px']
                ,shade: 0
                ,maxmin: true
                ,resize:false
                ,offset: 'rb'
                ,content: '/EasyCloudStorage/uploadPage'
                ,cancel: function(index, layero){


                    self.
                    layer.confirm('确定要关闭此窗口吗，关闭后上传会被中断', {icon: 3, title:'提示'}, function(i){
                        //do something
                        layer.close(index)
                        layer.close(i);
                        ifOn=false
                        window.location.reload(true)
                    })
                    return false
                }
                // ,btn: ['继续弹出', '全部关闭'] //只是为了演示
                // ,yes: function(){
                //     $(that).click();
                // }
                // ,btn2: function(){
                //     layer.closeAll();
                // }

                ,zIndex: layer.zIndex //重点1
            });
        }

        ,offset: function(othis){
            var type = othis.data('type')
                ,text = othis.text();
            layer.open({
                type: 1
                ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                ,id: 'layerDemo'+type //防止重复弹出
                ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
                ,btn: '关闭全部'
                ,btnAlign: 'c' //按钮居中
                ,shade: 0 //不显示遮罩
                ,yes: function(){
                    layer.closeAll();
                }
            });
        }
    };

    $('#layerDemo .layui-btn').on('click', function(){
        var othis = $(this), method = othis.data('method');
        active[method] ? active[method].call(this, othis) : '';
    });

});