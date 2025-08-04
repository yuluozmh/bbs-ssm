package com.liang.service.impl;

import com.liang.bean.Soup;
import com.liang.dao.SoupMapper;
import com.liang.service.SoupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SoupServiceImpl implements SoupService {
    @Autowired
    SoupMapper soupMapper;

    /**
     * 随机获取一条信息
     *
     * @return
     */
    @Override
    public Soup getSoupRand() {
        return soupMapper.selectSoupRand();
    }
}
