package com.liang.service.impl;

import com.liang.bean.Attention;
import com.liang.dao.AttentionMapper;
import com.liang.service.AttentionService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttentionServiceImpl implements AttentionService {
    @Autowired
    AttentionMapper attentionMapper;

    /**
     * 添加关注
     *
     * @param attention
     */
    @Override
    public void setAttention(Attention attention) {
        attention.setGid(UUIDUtil.getRandomUUID());
        attentionMapper.insert(attention);
    }

    /**
     * 取消关注（按gid）
     *
     * @param gid
     */
    @Override
    public void deleteAttention(String gid) {
        attentionMapper.deleteByKey(gid);
    }

    /**
     * 取消关注（按beuserid和userid）
     *
     * @param beuserid
     * @param userid
     */
    @Override
    public void deleteByUserid(String beuserid, String userid) {
        Attention attention = new Attention();
        attention.setBeuserid(beuserid);
        attention.setUserid(userid);
        attentionMapper.deleteByUB(attention);
    }

    /**
     * 查询关注信息(无条件)
     *
     * @return
     */
    @Override
    public List<Attention> getAttention() {
        return attentionMapper.selectAttention();
    }

    /**
     * 获取userid的关注总数
     *
     * @param userid
     * @return
     */
    @Override
    public int getCountByUserid(String userid) {
        return attentionMapper.selectCountByUserid(userid);
    }

    /**
     * 获取userid的粉丝总数
     *
     * @param beuserid
     * @return
     */
    @Override
    public int getCountByBeuserid(String beuserid) {
        return attentionMapper.selectCountByBeuserid(beuserid);
    }

    /**
     * 删除该用户对应的关注和被关注信息
     *
     * @param userid
     */
    @Override
    public void deleteAttentionUseridOrBeuserid(String userid) {
        attentionMapper.deleteByUorB(userid);
    }
}
