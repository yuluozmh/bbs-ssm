// 点赞赋值
function setEnjoy(article, fid) {
    // 点赞表信息
    var eid = article.eid;
    // 点赞数
    var enjoyCount = article.enjoyCount;

    var form_enjoyDel_fid = "form_enjoyDel_" + fid;
    var form_enjoyAdd_fid = "form_enjoyAdd_" + fid;
    $(".form_enjoyDel").attr("class", form_enjoyDel_fid);
    $(".form_enjoyAdd").attr("class", form_enjoyAdd_fid);
    // 点赞数（取消）
    $("." + form_enjoyDel_fid + "> span").html(enjoyCount);
    // 点赞数（新增）
    $("." + form_enjoyAdd_fid + "> span").html(enjoyCount);

    // 判断该文章是否被点赞
    if (eid != null) {    // 已点赞
        // "取消点赞"
        $("#form_enjoyDel_btn").attr("onclick", "enjoyDel('" + fid + "')");
        // "点赞"
        $("#form_enjoyAdd_btn").attr("onclick", "enjoyAdd('" + fid + "')");
        // 显示“取消点赞”
        $("." + form_enjoyDel_fid).show();
    } else {    // 未点赞
        // "取消点赞"
        $("#form_enjoyDel_btn").attr("onclick", "enjoyDel('" + fid + "')");
        // "点赞"
        $("#form_enjoyAdd_btn").attr("onclick", "enjoyAdd('" + fid + "')");
        // 显示“点赞”
        $("." + form_enjoyAdd_fid).show();
    }
}

// 添加点赞
function enjoyAdd(fid) {
    // 参数构造
    var data = {
        "userid": userid,
        "fid": fid
    };
    $.ajax({
        //几个参数需要注意一下
        type: "post",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: APP_PATH + apiUrl + "/enjoy/setEnjoy" ,
        data: data,
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                var form_enjoyDel_fid = "form_enjoyDel_" + fid;
                var form_enjoyAdd_fid = "form_enjoyAdd_" + fid;

                // 原始值
                var sourceValue = $("." + form_enjoyDel_fid + "> span").html();
                // 显示“取消点赞”
                $("." + form_enjoyDel_fid).show();
                // 隐藏“点赞”
                $("." + form_enjoyAdd_fid).hide();

                // 点赞数（取消）
                $("." + form_enjoyDel_fid + "> span").html(parseInt(sourceValue) + 1);
                // 点赞数（新增）
                $("." + form_enjoyAdd_fid + "> span").html(parseInt(sourceValue) + 1);

                layer.msg(msg);
            } else if (code == 500) {
                layer.msg(msg,{icon: 5});
            }
        },
        error : function() {
            layer.msg("出错！",{icon: 5});
        }
    });
}

// 取消点赞
function enjoyDel(fid) {
    $.ajax({
        //几个参数需要注意一下
        type: "delete",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: APP_PATH + apiUrl + "/enjoy/deleteEnjoyUseridAndFid/" + fid ,
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                var form_enjoyDel_fid = "form_enjoyDel_" + fid;
                var form_enjoyAdd_fid = "form_enjoyAdd_" + fid;

                // 原始值
                var sourceValue = $("." + form_enjoyDel_fid + "> span").html();
                // 隐藏“取消点赞”
                $("." + form_enjoyDel_fid).hide();
                // 显示“点赞”
                $("." + form_enjoyAdd_fid).show();

                // 点赞数（取消）
                $("." + form_enjoyDel_fid + "> span").html(parseInt(sourceValue) - 1);
                // 点赞数（新增）
                $("." + form_enjoyAdd_fid + "> span").html(parseInt(sourceValue) - 1);

                layer.msg(msg);
            } else if (code == 500) {
                layer.msg(msg,{icon: 5});
            }
        },
        error : function() {
            layer.msg("出错！",{icon: 5});
        }
    });
}