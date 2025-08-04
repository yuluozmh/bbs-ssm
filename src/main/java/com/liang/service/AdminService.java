package com.liang.service;

import com.liang.bean.Admin;

/**
 * service属于业务的具体实现。在具体实现过程中可以将取值、数据运算等存于业务层
 */
public interface AdminService {
    /**
     * 管理员登录查询
     *
     * @param admin
     * @return
     */
    Admin getAdmin(Admin admin);
}
