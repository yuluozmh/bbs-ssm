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
@ApiModel(value = "关注实体类", description = "关注信息描述类")
public class Attention {
    @ApiModelProperty(value = "关注编号")
    private String gid;
    @ApiModelProperty(value = "关注者编号")
    private String userid;
    @ApiModelProperty(value = "被关注者编号")
    private String beuserid;
    @ApiModelProperty(value = "关注时间")
    private Date createTime;
}
