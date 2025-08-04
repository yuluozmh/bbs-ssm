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
@ApiModel(value = "访问实体类", description = "访问信息描述类")
public class Visit {
    @ApiModelProperty("value = 访问编号")
    private String visitid;
    @ApiModelProperty("value = 访问者地址")
    private String visiturl;
    @ApiModelProperty("value = 访问者IP")
    private String visitip;
    @ApiModelProperty("value = 访问者国家")
    private String visitcountry;
    @ApiModelProperty("value = 访问者省份")
    private String visitprovince;
    @ApiModelProperty("value = 访问者城市")
    private String visitcity;
    @ApiModelProperty("value = 主机名")
    private String visithostname;
    @ApiModelProperty("value = 操作系统")
    private String visitos;
    @ApiModelProperty("value = 访问时间")
    private Date visittime;
    @ApiModelProperty("value = 访问数量")
    private int count;
}