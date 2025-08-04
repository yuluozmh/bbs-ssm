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
@ApiModel(value = "收藏实体类", description = "收藏信息描述类")
public class Collect {
    @ApiModelProperty(value = "收藏编号")
    private String sid;
    @ApiModelProperty(value = "用户编号")
    private String userid;
    @ApiModelProperty(value = "文章编号")
    private String fid;
    @ApiModelProperty(value = "收藏时间")
    private Date createTime;
}
