package com.liang.service.impl;

import com.liang.bean.Comment;
import com.liang.bean.impl.CommentImpl;
import com.liang.dao.CommentMapper;
import com.liang.service.CommentService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    CommentMapper commentMapper;

    /**
     * 添加评论
     *
     * @param comment
     */
    @Override
    public void setComment(Comment comment) {
        comment.setPid(UUIDUtil.getRandomUUID());
        commentMapper.insert(comment);
    }

    /**
     * 按pid删除评论表
     *
     * @param pid
     */
    @Override
    public void deleteComment(String pid) {
        commentMapper.deleteByKey(pid);
    }

    /**
     * 删除该用户对应的所有评论信息(按userid)
     *
     * @param userid
     */
    @Override
    public void deleteCommentUserid(String userid) {
        commentMapper.deleteByUserid(userid);
    }

    /**
     * 按文章id（fid）查询评论表信息
     *
     * @param fid
     * @return
     */
    @Override
    public List<Comment> getCommentFid(String fid) {
        return commentMapper.selectCommentByFid(fid);
    }

    /**
     * 按文章id（fid）获取评论表信息（包含用户名、用户头像）
     *
     * @param fid
     * @return
     */
    @Override
    public List<CommentImpl> getCommentImplFid(String fid) {
        return commentMapper.selectCommentImplByFid(fid);
    }

    /**
     * 按文章id（fid）查询该条文章的评论数
     *
     * @param fid
     * @return
     */
    @Override
    public int getCountFid(String fid) {
        return commentMapper.selectCountByFid(fid);
    }

    /**
     * 最新评论
     *
     * @return
     */
    @Override
    public List<CommentImpl> getNewComment() {
        return commentMapper.selectNewComment();
    }

    /**
     * 获取本站总评论数
     *
     * @return
     */
    @Override
    public int getCount() {
        return commentMapper.selectCount();
    }
}
