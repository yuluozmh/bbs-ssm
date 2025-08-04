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
@ApiModel(value = "毒鸡汤实体类", description = "毒鸡汤信息描述类")
public class Soup {
    @ApiModelProperty("value = 毒鸡汤编号")
    private Integer id;
    @ApiModelProperty("value = 毒鸡汤内容")
    private String content;
    @ApiModelProperty("value = 毒鸡汤收录时间")
    private Date createTime;
}
