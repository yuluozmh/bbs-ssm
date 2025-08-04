package com.liang.service;

import java.util.List;

import com.liang.bean.impl.UserImpl;
import com.liang.bean.User;

public interface UserService {
    /**
     * 插入用户信息
     *
     * @param user
     */
    void setUser(User user);

    /**
     * 删除用户
     *
     * @param userid
     */
    void deleteUser(String userid);

    /**
     * 编辑个人资料（修改user表）
     *
     * @param user
     */
    void updateUser(User user);

    /**
     * 修改用户名
     *
     * @param username
     * @param userid
     */
    void updateUsername(String username, String userid);

    /**
     * 修改密码
     *
     * @param passNew
     * @param userid
     */
    void updatePassword(String passNew, String userid);

    /**
     * 修改Email
     *
     * @param email
     * @param userid
     */
    void updateEmail(String email, String userid);

    /**
     * 按姓名和密码或者Email和密码查询用户信息
     *
     * @param user
     * @return
     */
    UserImpl getNameEmailPass(User user);

    /**
     * 按用户id和密码查询
     *
     * @param passOld
     * @param userid
     * @return
     */
    User getIdPass(String passOld, String userid);

    /**
     * 按用户名查询
     *
     * @param name
     * @return
     */
    User getUserName(String name);

    /**
     * 按Email查询
     *
     * @param email
     * @return
     */
    User getEmail(String email);

    /**
     * 查询用户信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    List<UserImpl> getUserImplPaging(int pageStart, int pageSize);

    /**
     * 查询用户总数
     *
     * @return
     */
    int getCount();

    /**
     * 按userid查询用户信息
     *
     * @param userid
     * @return
     */
    User getUserKey(String userid);

    /**
     * 获取用户排名（按文章数）
     *
     * @return
     */
    List<UserImpl> getUserRankByArticleSum();

    /**
     * 获取新注册用户
     *
     * @return
     */
    List<UserImpl> getNewUser();

    /**
     * 按userid查询关注信息
     *
     * @param userid
     * @param b      （true:你关注了谁/false:谁关注了你）
     * @return
     */
    List<UserImpl> getUserImpl(String userid, boolean b);

    /**
     * 按userid获取用户信息（名称、头像、粉丝数、文章总浏览、总点赞、总收藏）
     *
     * @param userid
     * @return
     */
    UserImpl getUserImplByUserid(String userid);
}
