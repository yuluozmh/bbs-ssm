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
@ApiModel(value = "照片实体类", description = "照片信息描述类")
public class TbPhoto {
    @ApiModelProperty("value = 照片编号")
    private String xid;
    @ApiModelProperty("value = 相册编号")
    private String fid;
    @ApiModelProperty("value = 用户编号")
    private String userid;
    @ApiModelProperty("value = 照片")
    private String photo;
    @ApiModelProperty("value = 照片上传时间")
    private Date createTime;

    public TbPhoto() {
    }

    public TbPhoto(String fid, String userid) {
        this.fid = fid;
        this.userid = userid;
    }
}