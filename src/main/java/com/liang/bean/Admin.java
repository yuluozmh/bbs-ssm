package com.liang.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author maliang
 * @create 2019-05-25 21:12
 */
@Data
@ApiModel(value = "管理员实体类", description = "管理员信息描述类")
public class Admin {
    @ApiModelProperty(value = "管理员编号", hidden = true)
    private String aid;

    @ApiModelProperty(value = "管理员名称", required = true)
    @NotBlank(message = "管理员名称不能为空")
    private String aname;

    @ApiModelProperty(value = "管理员密码", required = true)
    @NotBlank(message = "管理员密码不能为空")
    @JsonIgnore
    private String apassword;

    @ApiModelProperty(value = "管理员创建时间", hidden = true)
    private Date createTime;

    @ApiModelProperty(value = "管理员更新时间", hidden = true)
    private Date updateTime;
}