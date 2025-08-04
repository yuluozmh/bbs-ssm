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
@ApiModel(value = "点赞实体类", description = "点赞信息描述类")
public class Enjoy {
    @ApiModelProperty(value = "点赞编号")
    private String eid;
    @ApiModelProperty(value = "用户编号")
    private String userid;
    @ApiModelProperty(value = "文章编号")
    private String fid;
    @ApiModelProperty(value = "点赞时间")
    private Date createTime;
}
