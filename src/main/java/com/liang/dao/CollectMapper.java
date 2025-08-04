package com.liang.dao;

import java.util.List;
import java.util.Map;

import com.liang.bean.Collect;

public interface CollectMapper {
    /**
     * 新增收藏信息
     * @param record
     */
    void insert(Collect record);

    /**
     * 按sid删除收藏信息
     * @param sid
     */
    void deleteByKey(String sid);

    /**
     * 按userid和fid删除收藏
     * @param collect
     */
    void deleteByUF(Collect collect);

    /**
     * 按fid删除收藏信息
     * @param fid
     */
    void deleteByFid(String fid);

    /**
     * 删除某用户对应的收藏信息
     * @param userid
     */
    void deleteByUserid(String userid);

    /**
     * 查询所有收藏信息
     * @return
     */
    List<Collect> selectCollect();

    /**
     * 按收藏者id和被收藏文章id进行查询
     * @param collect
     * @return
     */
    Collect selectCollectByUF(Collect collect);

    /**
     * 获取某一文章的收藏数
     * @param fid
     * @return
     */
    Integer selectCountByFid(String fid);
}
