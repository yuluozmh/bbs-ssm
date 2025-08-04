// 收藏赋值
function setCollect(article, fid) {
    // 收藏表信息
    var sid = article.sid;
    // 收藏数
    var collectCount = article.collectCount;

    var form_collectDel_fid = "form_collectDel_" + fid;
    var form_collectAdd_fid = "form_collectAdd_" + fid;
    $(".form_collectDel").attr("class", form_collectDel_fid);
    $(".form_collectAdd").attr("class", form_collectAdd_fid);
    // 收藏数（取消）
    $("." + form_collectDel_fid + "> span").html(collectCount);
    // 收藏数（新增）
    $("." + form_collectAdd_fid + "> span").html(collectCount);

    // 判断该文章是否被收藏
    if (sid != null) {   // 已收藏
        // "取消收藏"
        $("#form_collectDel_btn").attr("onclick", "collectDel('" + fid + "')");
        // "收藏"
        $("#form_collectAdd_btn").attr("onclick", "collectAdd('" + fid + "')");
        // 显示“取消收藏”
        $("." + form_collectDel_fid).show();
    } else {    // 未收藏
        // "取消收藏"
        $("#form_collectDel_btn").attr("onclick", "collectDel('" + fid + "')");
        // "收藏"
        $("#form_collectAdd_btn").attr("onclick", "collectAdd('" + fid + "')");
        // 显示“收藏”
        $("." + form_collectAdd_fid).show();
    }
}

// 添加收藏
function collectAdd(fid) {
    // 参数构造
    var data = {
        "userid": userid,
        "fid": fid
    };
    $.ajax({
        //几个参数需要注意一下
        type: "post",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: APP_PATH + apiUrl + "/collect/setCollect" ,
        data: data,
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                var form_collectDel_fid = "form_collectDel_" + fid;
                var form_collectAdd_fid = "form_collectAdd_" + fid;

                // 原始值
                var sourceValue = $("." + form_collectDel_fid + "> span").html();
                // 显示“取消收藏”
                $("." + form_collectDel_fid).show();
                // 隐藏“收藏”
                $("." + form_collectAdd_fid).hide();

                // 收藏数（取消）
                $("." + form_collectDel_fid + "> span").html(parseInt(sourceValue) + 1);
                // 收藏数（新增）
                $("." + form_collectAdd_fid + "> span").html(parseInt(sourceValue) + 1);

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

// 取消收藏（非个人主页）
function collectDel(fid) {
    $.ajax({
        //几个参数需要注意一下
        type: "delete",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: APP_PATH + apiUrl + "/collect/deleteCollectUseridAndFid/" + fid,
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                var form_collectDel_fid = "form_collectDel_" + fid;
                var form_collectAdd_fid = "form_collectAdd_" + fid;

                // 原始值
                var sourceValue = $("." + form_collectDel_fid + "> span").html();
                // 隐藏“取消收藏”
                $("." + form_collectDel_fid).hide();
                // 显示“收藏”
                $("." + form_collectAdd_fid).show();

                // 收藏数（取消）
                $("." + form_collectDel_fid + "> span").html(parseInt(sourceValue) - 1);
                // 收藏数（新增）
                $("." + form_collectAdd_fid + "> span").html(parseInt(sourceValue) - 1);
                
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

// 取消收藏（个人主页）
function collectDelMyself(fid) {
    $.ajax({
        //几个参数需要注意一下
        type: "delete",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: APP_PATH + apiUrl + "/collect/deleteCollectUseridAndFid/" + fid,
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                // 隐藏“取消收藏”
                // 隐藏刚刚取消收藏的文章信息
                $(".collect_num_" + fid).hide();
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