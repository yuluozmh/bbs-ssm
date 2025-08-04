/* 新增轮播图信息 */
function sliderAdd(){
    const formData = new FormData();
    const text = $.trim($("#text").val());
    const textUrl = $.trim($("#textUrl").val());
    const picture = $("#imageUrl")[0].files[0];
    if (text === ""){
        layer.tips('请输入文字内容', '#text', {
            tips: [1, '#ff6620']
        });
        return;
    }
    if (textUrl === ""){
        layer.tips('请输入文字链接', '#textUrl', {
            tips: [1, '#ff6620']
        });
        return;
    }
    if (picture == null){  //未配图
        layer.tips('请选择轮播图!', '#imageUrl', {
            tips: [1, '#ff6620'] //还可配置颜色
        });
        return;
    }
    if (picture.size > sourceFileSize) {    // 超过上传源文件允许的最大值
        layer.msg("请上传不超过 " + sourceFileSize/(1024*1024) + "M 的图片!",{icon: 5});
        return;
    }
    formData.append("text", text);
    formData.append("textUrl", textUrl);
    formData.append("picture", picture);
    //调ajax
    $.ajax({
        url: APP_PATH + apiUrl + "/slider/setSlider",
        data: formData,
        type: "post",
        dataType: "json",
        // 告诉jQuery不要去处理发送的数据
        processData : false,
        // 告诉jQuery不要去设置Content-Type请求头
        contentType : false,
        xhr: function(){
            $(".picture-progress").show();
            myXhr = $.ajaxSettings.xhr();
            if(myXhr.upload){
                myXhr.upload.addEventListener('progress',function(e) {
                    if (e.lengthComputable) {
                        var percent = Math.floor(e.loaded/e.total*100);
                        if (percent <= 100) {
                            var ratio = dynamicStorageUnit(e.loaded) + '/' + dynamicStorageUnit(e.total) + ' ' + percent + '%';
                        }
                        if (percent >= 100) {
                            var ratio = '<small>上传中...</small>';
                        }
                        $(".picture-progress .progress-bar").attr("style", "width:" + percent + '%');
                        $(".picture-progress .progress-bar").html(ratio);
                    }
                }, false);
            }
            return myXhr;
        },
        success: function(data){
            // 隐藏进度条
            $(".picture-progress").hide();
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code === 200) {
                // 清空选择的文件
                $("#imageUrl").val("");
                $('#slider_Add').modal('hide');     // 关闭模态框
                getSlider();
                layer.msg(msg);
            } else if (code === 500) {
                layer.msg(msg,{icon: 5});
            }
        },
        error : function() {
            layer.msg("出错！",{icon: 5});
        }
    });
}

/* 删除确认框 */
function slider_del(id) {
    layer.confirm('确定删除该轮播图吗？<br>删除后无法恢复！', {
        btn:["确定","取消"],
        icon:2,
        title: "删除提示"
    }, function(){
        //点击确后关闭提示框
        layer.closeAll('dialog');
        sliderDel(id);
    });
}
/* 删除轮播图信息 */
function sliderDel(id) {
    //调ajax
    $.ajax({
        url: APP_PATH + apiUrl + "/slider/deleteSlider/" + id,
        data: $('#form_delSlider').serialize(),
        type: "delete",
        dataType: "json",
        success: function(data){
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code === 200) {
                getSlider();
                layer.msg(msg);
            } else if (code === 500) {
                layer.msg(msg,{icon: 5});
            }
        },
        error : function() {
            layer.msg("出错！",{icon: 5});
        }
    });
}

/* 获取轮播图信息 */
function getSlider() {
    $.ajax({
        url: APP_PATH + apiUrl + "/slider/getSlider",
        type: "get",
        dataType: "json",
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                $("#slider_all").html(getSliderList(data.data));
            } else if (code == 500) {
                layer.msg(msg, {icon: 5});
            }
        },
        error: function () {
            layer.msg("出错！", {icon: 5});
        }
    });
}