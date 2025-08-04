package com.liang.service.impl;

import com.liang.bean.Admin;
import com.liang.dao.AdminMapper;
import com.liang.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminMapper adminMapper;

    /**
     * 管理员登录查询
     *
     * @param admin
     * @return
     */
    @Override
    public Admin getAdmin(Admin admin) {
        return adminMapper.selectByAdmin(admin);
    }
}