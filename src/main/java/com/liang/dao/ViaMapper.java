package com.liang.dao;

import com.liang.bean.Via;

public interface ViaMapper {
    /**
     * 新增头像
     * @param record
     */
    void insert(Via record);

    /**
     * 删除某用户的头像信息
     * @param userid
     */
    void deleteByKey(String userid);

    /**
     * 修改某用户头像信息
     * @param record
     */
    void updateByKey(Via record);

    /**
     * 按userid查询用户信息
     * @param userid
     * @return
     */
    Via selectViaByKey(String userid);
}