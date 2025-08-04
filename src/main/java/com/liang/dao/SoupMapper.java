package com.liang.dao;

import com.liang.bean.Soup;

public interface SoupMapper {
    /**
     * 随机获取一条信息
     * @return
     */
    Soup selectSoupRand();
}