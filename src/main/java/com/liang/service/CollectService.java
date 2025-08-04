package com.liang.service;

import java.util.List;

import com.liang.bean.Collect;

public interface CollectService {
    /**
     * 添加收藏
     *
     * @param collect
     */
    void setCollect(Collect collect);

    /**
     * 删除收藏（按userid和fid）
     *
     * @param fid
     * @param userid
     */
    void deleteCollectUseridAndFid(String fid, String userid);

    /**
     * 按fid删除收藏信息
     *
     * @param fid
     */
    void deleteCollectFid(String fid);

    /**
     * 删除该用户对应的收藏信息(按userid)
     *
     * @param userid
     */
    void deleteCollectUserid(String userid);

    /**
     * 删除收藏(按sid)
     *
     * @param sid
     */
    void deleteCollect(String sid);

    /**
     * 查询收藏信息（无条件）
     *
     * @return
     */
    List<Collect> getCollect();

    /**
     * 按收藏者id和被收藏文章id进行查询
     *
     * @param fid
     * @param userid
     * @return
     */
    Collect getCollectFid(String fid, String userid);

    /**
     * 获取某一文章的收藏数
     *
     * @param fid
     * @return
     */
    int getCountByFid(String fid);
}
