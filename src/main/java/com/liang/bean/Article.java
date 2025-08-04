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
@ApiModel(value = "文章实体类", description = "文章信息描述类")
public class Article {
    @ApiModelProperty(value = "文章编号")
    private String fid;
    @ApiModelProperty(value = "文章标题")
    private String titles;
    @ApiModelProperty(value = "文章内容")
    private String fcontent;
    @ApiModelProperty(value = "文章配图（题图）")
    private String photo;
    @ApiModelProperty(value = "板块编号")
    private String bid;
    @ApiModelProperty(value = "用户编号")
    private String userid;
    @ApiModelProperty(value = "文章审核状态")
    private Integer status;
    @ApiModelProperty(value = "文章浏览量")
    private Integer pv;
    @ApiModelProperty(value = "文章发布时间")
    private Date createTime;
    @ApiModelProperty(value = "文章更新时间")
    private Date updateTime;
}