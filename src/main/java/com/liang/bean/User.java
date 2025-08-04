package com.liang.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author maliang
 * @create 2019-05-25 21:12
 */
@Data
@ApiModel(value = "用户实体类", description = "用户信息描述类")
public class User {
    @ApiModelProperty("value = 用户编号")
    private String userid;
    @ApiModelProperty("value = 用户名称")
    private String name;
    @ApiModelProperty("value = 用户年龄")
    private Integer age;
    @ApiModelProperty("value = 用户性别")
    private Integer sex;
    @ApiModelProperty("value = 用户密码")
    @JsonIgnore
    private String password;
    @ApiModelProperty("value = 用户邮箱")
    private String email;
    @ApiModelProperty("value = 用户住址")
    private String family;
    @ApiModelProperty("value = 用户简介")
    private String intro;
    @ApiModelProperty("value = 用户注册时间")
    private Date createTime;
    @ApiModelProperty("value = 用户更新")
    private Date updateTime;
}