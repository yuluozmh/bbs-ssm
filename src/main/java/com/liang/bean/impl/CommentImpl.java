package com.liang.bean.impl;

import com.liang.bean.Comment;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @EqualsAndHashCode(callSuper = true)注解的作用就是将其父类属性也进行比较
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class CommentImpl extends Comment {
    /**
     * 用户名
     */
    private String name;
    /**
     * 用头像
     */
    private String userPhoto;
}
