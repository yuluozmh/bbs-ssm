package com.liang.bean.impl;

import com.liang.bean.Article;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * @EqualsAndHashCode(callSuper = true)注解的作用就是将其父类属性也进行比较
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ArticleImpl extends Article {
    /**
     * 用户名
     */
    private String name;
    /**
     * 用头像
     */
    private String userPhoto;
    /**
     * 版块名
     */
    private String bname;
    /**
     * 关注id
     */
    private String gid;
    /**
     * 收藏id
     */
    private String sid;
    /**
     * 收藏数
     */
    private Integer collectCount;
    /**
     * 点赞id
     */
    private String eid;
    /**
     * 点赞数
     */
    private Integer enjoyCount;
    /**
     * 评论数
     */
    private Integer commentCount;
    /**
     * 收藏时间
     */
    private Date collectTime;
}
