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
@ApiModel(value = "板块实体类", description = "板块信息描述类")
public class Plate {
    @ApiModelProperty("value = 板块编号")
    private String bid;
    @ApiModelProperty("value = 板块名称")
    private String bname;
    @ApiModelProperty("value = 板块创建时间")
    private Date createTime;
    @ApiModelProperty("value = 板块更新时间")
    private Date updateTime;
}