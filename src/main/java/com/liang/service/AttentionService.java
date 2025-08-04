package com.liang.service;

import java.util.List;

import com.liang.bean.Attention;

public interface AttentionService {
    /**
     * 添加关注
     *
     * @param attention
     */
    void setAttention(Attention attention);

    /**
     * 取消关注（按gid）
     *
     * @param gid
     */
    void deleteAttention(String gid);

    /**
     * 取消关注（按beuserid和userid）
     *
     * @param beuserid
     * @param userid
     */
    void deleteByUserid(String beuserid, String userid);

    /**
     * 查询关注信息(无条件)
     *
     * @return
     */
    List<Attention> getAttention();

    /**
     * 获取userid的关注总数
     *
     * @param userid
     * @return
     */
    int getCountByUserid(String userid);

    /**
     * 获取userid的粉丝总数
     *
     * @param beuserid
     * @return
     */
    int getCountByBeuserid(String beuserid);

    /**
     * 删除该用户对应的关注和被关注信息
     *
     * @param userid
     */
    void deleteAttentionUseridOrBeuserid(String userid);
}
