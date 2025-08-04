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
@ApiModel(value = "评论实体类", description = "评论信息描述类")
public class Comment {
    @ApiModelProperty(value = "评论编号")
    private String pid;
    @ApiModelProperty(value = "评论内容")
    private String pcontent;
    @ApiModelProperty(value = "用户编号")
    private String userid;
    @ApiModelProperty(value = "文章编号")
    private String fid;
    @ApiModelProperty(value = "评论创建时间")
    private Date createTime;
    @ApiModelProperty(value = "评论更新时间")
    private Date updateTime;
}