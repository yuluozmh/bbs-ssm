package com.liang.service.impl;

import com.liang.bean.Collect;
import com.liang.dao.CollectMapper;
import com.liang.service.CollectService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollectServiceImpl implements CollectService {
    @Autowired
    CollectMapper collectMapper;

    /**
     * 添加收藏
     *
     * @param collect
     */
    @Override
    public void setCollect(Collect collect) {
        collect.setSid(UUIDUtil.getRandomUUID());
        collectMapper.insert(collect);
    }

    /**
     * 删除收藏（按userid和fid）
     *
     * @param fid
     * @param userid
     */
    @Override
    public void deleteCollectUseridAndFid(String fid, String userid) {
        Collect collect = new Collect();
        collect.setFid(fid);
        collect.setUserid(userid);
        collectMapper.deleteByUF(collect);
    }

    /**
     * 按fid删除收藏信息
     *
     * @param fid
     */
    @Override
    public void deleteCollectFid(String fid) {
        collectMapper.deleteByFid(fid);
    }

    /**
     * 删除该用户对应的收藏信息(按userid)
     *
     * @param userid
     */
    @Override
    public void deleteCollectUserid(String userid) {
        collectMapper.deleteByUserid(userid);
    }

    /**
     * 删除收藏(按sid)
     *
     * @param sid
     */
    @Override
    public void deleteCollect(String sid) {
        collectMapper.deleteByKey(sid);
    }

    /**
     * 查询收藏信息（无条件）
     *
     * @return
     */
    @Override
    public List<Collect> getCollect() {
        return collectMapper.selectCollect();
    }

    /**
     * 按收藏者id和被收藏文章id进行查询
     *
     * @param fid
     * @param userid
     * @return
     */
    @Override
    public Collect getCollectFid(String fid, String userid) {
        Collect collect = new Collect();
        collect.setFid(fid);
        collect.setUserid(userid);
        return collectMapper.selectCollectByUF(collect);
    }

    /**
     * 获取某一文章的收藏数
     *
     * @param fid
     * @return
     */
    @Override
    public int getCountByFid(String fid) {
        return collectMapper.selectCountByFid(fid);
    }
}
