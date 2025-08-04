package com.liang.service.impl;

import com.liang.bean.Enjoy;
import com.liang.dao.EnjoyMapper;
import com.liang.service.EnjoyService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnjoyServiceImpl implements EnjoyService {
    @Autowired
    EnjoyMapper enjoyMapper;

    /**
     * 添加点赞
     *
     * @param enjoy
     */
    @Override
    public void setEnjoy(Enjoy enjoy) {
        enjoy.setEid(UUIDUtil.getRandomUUID());
        enjoyMapper.insert(enjoy);
    }

    /**
     * 删除点赞(按eid)
     *
     * @param eid
     */
    @Override
    public void deleteEnjoy(String eid) {
        enjoyMapper.deleteByKey(eid);
    }

    /**
     * 删除点赞（按userid和fid）
     *
     * @param fid
     * @param userid
     */
    @Override
    public void deleteEnjoyUseridAndFid(String fid, String userid) {
        Enjoy enjoy = new Enjoy();
        enjoy.setFid(fid);
        enjoy.setUserid(userid);
        enjoyMapper.deleteByUF(enjoy);
    }

    /**
     * 查询点赞信息（无条件）
     *
     * @return
     */
    @Override
    public List<Enjoy> getEnjoy() {
        return enjoyMapper.selectEnjoy();
    }

    /**
     * 按点赞者id和被点赞文章id进行查询
     *
     * @param fid
     * @param userid
     * @return
     */
    @Override
    public Enjoy getEnjoyFid(String fid, String userid) {
        Enjoy enjoy = new Enjoy();
        enjoy.setFid(fid);
        enjoy.setUserid(userid);
        return enjoyMapper.selectEnjoyByUF(enjoy);
    }

    /**
     * 获取某一文章的点赞数
     *
     * @param fid
     * @return
     */
    @Override
    public int getCountByFid(String fid) {
        return enjoyMapper.selectCountByFid(fid);
    }
}
