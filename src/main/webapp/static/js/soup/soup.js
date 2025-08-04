$(function () {
    randSoup();
});

$(".pcs_button").click(function () {
    randSoup();
});

// 随机一碗毒鸡汤
function randSoup() {
    // $.ajax({
    //     url: APP_PATH + apiUrl + "/soup/getSoupRand",
    //     type: "get",
    //     dataType: "json",
    //     success: function (data) {
    //         // 状态码
    //         var code = data.code;
    //         // 提示信息
    //         var msg = data.msg;
    //         if (code == 200) {
    //             var soup = data.data;
    //             $("#pcs_content").html(soup.content);
    //         } else if (code == 500) {
    //             layer.msg(msg, {icon: 5});
    //         }
    //     },
    //     error: function () {
    //         layer.msg("出错！", {icon: 5});
    //     }
    // });

    $.ajax({
        url: 'https://iiter.cn/api/soup',
        type: "get",
        dataType: "json",
        success: function (data) {
            // 状态码
            var code = data.result;
            // 提示信息
            var msg = data.message;
            if (code) {
                var soup = data.data;
                $("#pcs_content").html(soup.title);
            } else {
                layer.msg(msg, {icon: 5});
            }
        },
        error: function () {
            layer.msg("出错！", {icon: 5});
        }
    });
}