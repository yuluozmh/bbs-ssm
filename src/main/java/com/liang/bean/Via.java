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
@ApiModel(value = "头像实体类", description = "头像信息描述类")
public class Via {
    @ApiModelProperty("value = 用户编号")
    private String userid;
    @ApiModelProperty("value = 头像")
    private String photo;
    @ApiModelProperty("value = 头像更新时间")
    private Date updateTime;
}