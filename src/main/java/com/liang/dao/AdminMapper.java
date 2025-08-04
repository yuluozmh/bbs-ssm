package com.liang.dao;

import com.liang.bean.Admin;

public interface AdminMapper {
    /**
     * 管理员登录查询
     * @param admin
     * @return
     */
    Admin selectByAdmin(Admin admin);
}