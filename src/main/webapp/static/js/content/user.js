// 将用户头像显示到个人中心
function getMePicture(user) {
    //判断头像显示
    if (user.via == null){
        /* 默认头像 */
        $("#myself_userphoto_img").attr("src", APP_PATH +"/static/img/head.png");
    } else {
        /* 自定义头像 */
        $("#myself_userphoto_img").attr("src", user.via.photo);
    }
}

// 将用户信息显示到“个人中心”
function getAboutMe(user) {
    //用户名
    $("#myself_name").html(user.name);
    //居住地
    $("#myself_family").html(user.family);
    //个人简介
    $("#myself_intro").html(user.intro);
    //电子邮箱
    $("#myself_email").html(user.email);
    //性别年龄
    $("#myself_sex_age").html(getSex(user.sex) + " " + getAge(user.age));
}

// 获取关于作者的信息并赋值
function getAboutUser(userid) {
    $.ajax({
        url: APP_PATH + apiUrl + "/user/getAboutUser/" + userid ,
        type: "get",
        dataType: "json",
        success: function (data) {
            // 状态码
            var code = data.code;
            // 提示信息
            var msg = data.msg;
            if (code == 200) {
                var user = data.data;
                var photo = user.photo;
                // 头像
                if (photo != null) {
                    $("#about_photo").attr("src", photo);
                }
                // 名称
                $("#about_name").html(user.name);
                // 邮箱
                $("#about_email").html(user.email);
                // 粉丝总数
                $("#about_fansCount").html(user.fansCount);
                // 获得收藏数
                $("#about_collectCount").html(user.collectCount);
                // 获得点赞数
                $("#about_enjoyCount").html(user.enjoyCount);
                // 文章被阅读
                $("#about_pvCount").html(user.pvCount);

                $("#about_user").show();
            } else if (code == 500) {
                layer.msg(msg, {icon: 5});
            }
        },
        error: function () {
            layer.msg("出错！", {icon: 5});
        }
    });
}