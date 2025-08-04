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
@ApiModel(value = "相册实体类", description = "相册信息描述类")
public class PhotoPro {
    @ApiModelProperty("value = 相册编号")
    private String fid;
    @ApiModelProperty("value = 用户编号")
    private String userid;
    @ApiModelProperty("value = 相册名称")
    private String name;
    @ApiModelProperty("value = 相册创建时间")
    private Date createTime;
    @ApiModelProperty("value = 相册更新时间")
    private Date updateTime;
}