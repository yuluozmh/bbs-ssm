package com.liang.service;

import java.util.List;

import com.liang.bean.impl.CommentImpl;
import com.liang.bean.Comment;

public interface CommentService {
    /**
     * 添加评论
     *
     * @param comment
     */
    void setComment(Comment comment);

    /**
     * 按pid删除评论表
     *
     * @param pid
     */
    void deleteComment(String pid);

    /**
     * 删除该用户对应的所有评论信息(按userid)
     *
     * @param userid
     */
    void deleteCommentUserid(String userid);

    /**
     * 按文章id（fid）查询评论表信息
     *
     * @param fid
     * @return
     */
    List<Comment> getCommentFid(String fid);

    /**
     * 按文章id（fid）获取评论表信息（包含用户名、用户头像）
     *
     * @param fid
     * @return
     */
    List<CommentImpl> getCommentImplFid(String fid);

    /**
     * 按文章id（fid）查询该条文章的评论数
     *
     * @param fid
     * @return
     */
    int getCountFid(String fid);

    /**
     * 最新评论
     *
     * @return
     */
    List<CommentImpl> getNewComment();

    /**
     * 获取本站总评论数
     *
     * @return
     */
    int getCount();
}
