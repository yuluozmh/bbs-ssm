package com.liang.code.constant;

/**
 * 定义常量
 *
 * @author maliang
 * @create 2020-06-12 13:24
 */
public interface CommonConstant {
    // github登录
    Integer SOCIAL_TYPE_GITHUB = 0;

    // qq登录
    Integer SOCIAL_TYPE_QQ = 1;

    // 微博登录
    Integer SOCIAL_TYPE_WEIBO = 2;

    // 短信验证码key前缀
    String PRE_SMS = "SENS_PRE_SMS:";

    // 邮件验证码key前缀
    String PRE_EMAIL = "SENS_PRE_EMAIL:";

    // 本地文件存储
    Integer OSS_LOCAL = 0;

    // 七牛云OSS存储
    Integer OSS_QINIU = 1;

    // 阿里云OSS存储
    Integer OSS_ALI = 2;

    // 腾讯云COS存储
    Integer OSS_TENCENT = 3;
}
