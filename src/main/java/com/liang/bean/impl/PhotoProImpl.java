package com.liang.bean.impl;

import com.liang.bean.PhotoPro;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @EqualsAndHashCode(callSuper = true)注解的作用就是将其父类属性也进行比较
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PhotoProImpl extends PhotoPro {
    /**
     * 图片名
     */
    private String photo;
}
