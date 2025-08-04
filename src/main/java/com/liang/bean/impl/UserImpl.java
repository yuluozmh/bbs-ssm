package com.liang.bean.impl;

import com.liang.bean.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * @author maliang
 * @create 2020-04-08 15:15
 * @EqualsAndHashCode(callSuper = true)注解的作用就是将其父类属性也进行比较
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class UserImpl extends User {
    /**
     * 文章数
     */
    private Integer articleSum;
    /**
     * 头像
     */
    private String photo;
    /**
     * 关注id
     */
    private String gid;
    /**
     * 关注时间
     */
    private Date attentionTime;
    /**
     * 粉丝数
     */
    private Integer fansCount;
    /**
     * 获得点赞数
     */
    private Integer enjoyCount;
    /**
     * 获得收藏数
     */
    private Integer collectCount;
    /**
     * 文章被阅读总数
     */
    private Integer pvCount;
}
