package com.liang.bean;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author maliang
 * @create 2019-05-25 21:12
 */
@Data
@ApiModel(value = "轮播图实体类", description = "轮播图信息描述类")
public class Slider {
    @ApiModelProperty("value = 轮播图编号")
    private Integer id;
    @ApiModelProperty("value = 轮播图文字")
    private String text;
    @ApiModelProperty("value = 轮播图文字对应链接")
    private String textUrl;
    @ApiModelProperty("value = 轮播图")
    private String imageUrl;
    @ApiModelProperty("value = 轮播图创建时间")
    private Date createTime;
}
