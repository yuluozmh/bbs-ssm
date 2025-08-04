package com.liang.dao;

import com.liang.bean.Enjoy;

import java.util.List;

public interface EnjoyMapper {
    /**
     * 新增点赞信息
     * @param record
     */
    void insert(Enjoy record);

    /**
     * 按eid删除点赞信息
     * @param eid
     */
    void deleteByKey(String eid);

    /**
     * 按userid和fid删除点赞
     * @param enjoy
     */
    void deleteByUF(Enjoy enjoy);

    /**
     * 查询所有点赞信息
     * @return
     */
    List<Enjoy> selectEnjoy();

    /**
     * 按点赞者id和被点赞文章id进行查询
     * @param enjoy
     * @return
     */
    Enjoy selectEnjoyByUF(Enjoy enjoy);

    /**
     * 获取某一文章的点赞数
     * @param fid
     * @return
     */
    Integer selectCountByFid(String fid);
}
