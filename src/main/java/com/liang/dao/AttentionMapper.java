package com.liang.dao;

import java.util.List;

import com.liang.bean.Attention;

public interface AttentionMapper {
    /**
     * 新增关注信息
     * @param record
     */
    void insert(Attention record);

    /**
     * 按gid删除关注信息
     * @param gid
     */
    void deleteByKey(String gid);

    /**
     * 按userid和beuserid删除关注信息
     * @param attention
     */
    void deleteByUB(Attention attention);

    /**
     * 删除某用户对应的关注和被关注信息
     * @param userid
     */
    void deleteByUorB(String userid);

    /**
     * 查询所有关注信息
     * @return
     */
    List<Attention> selectAttention();

    /**
     * 获取某用户的关注总数
     * @param userid
     * @return
     */
    int selectCountByUserid(String userid);

    /**
     * 获取某用户的粉丝总数
     * @param beuserid
     * @return
     */
    int selectCountByBeuserid(String beuserid);
}
