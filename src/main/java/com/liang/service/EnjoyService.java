package com.liang.service;

import com.liang.bean.Enjoy;

import java.util.List;

public interface EnjoyService {
    /**
     * 添加点赞
     *
     * @param enjoy
     */
    void setEnjoy(Enjoy enjoy);

    /**
     * 删除点赞(按eid)
     *
     * @param eid
     */
    void deleteEnjoy(String eid);

    /**
     * 删除点赞（按userid和fid）
     *
     * @param fid
     * @param userid
     */
    void deleteEnjoyUseridAndFid(String fid, String userid);

    /**
     * 查询点赞信息（无条件）
     *
     * @return
     */
    List<Enjoy> getEnjoy();

    /**
     * 按点赞者id和被点赞文章id进行查询
     *
     * @param fid
     * @param userid
     * @return
     */
    Enjoy getEnjoyFid(String fid, String userid);

    /**
     * 获取某一文章的点赞数
     *
     * @param fid
     * @return
     */
    int getCountByFid(String fid);
}
