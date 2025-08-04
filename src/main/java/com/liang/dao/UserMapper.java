package com.liang.dao;

import com.liang.bean.User;
import com.liang.bean.impl.UserImpl;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    /**
     * 新增用户信息
     * @param record
     */
    void insert(User record);

    /**
     * 删除用户信息
     * @param userid
     */
    void deleteByKey(String userid);

    /**
     * 编辑用户信息
     * @param record
     */
    void updateByKey(User record);

    /**
     * 修改用户名
     * @param user
     */
    void updateNameByKey(User user);

    /**
     * 修改密码
     * @param user
     */
    void updatePasswordByKey(User user);

    /**
     * 修改Email
     * @param user
     */
    void updateEmailByKey(User user);

    /**
     * 按姓名（Email）和密码查询用户信息
     * @param user
     * @return
     */
    UserImpl selectUserImplByNEP(User user);

    /**
     * 按用户名查询用户信息
     * @param name
     * @return
     */
    User selectUserByName(String name);

    /**
     * 按Email查询用户信息
     * @param name
     * @return
     */
    User selectUserByEmail(String name);

    /**
     * 查询用户信息（分页）
     * @param map
     * @return
     */
    List<UserImpl> selectUserImplPaging(Map<String, Object> map);

    /**
     * 按userid查询用户信息
     * @param userid
     * @return
     */
    User selectUserByKey(String userid);

    /**
     * 按userid和密码查询用户信息
     * @param user
     * @return
     */
    User selectUserByUP(User user);

    /**
     * 按文章数获取用户排名
     * @return
     */
    List<UserImpl> selectUserImplRankByArticleSum();

    /**
     * 获取新注册用户信息
     * @return
     */
    List<UserImpl> selectNewUserImpl();

    /**
     * 按userid查询关注信息
     * @param map
     * @return
     */
    List<UserImpl> selectUserImplByKey(Map<String, Object> map);

    /**
     * 按userid获取用户信息（名称、头像、粉丝数、文章总浏览、总点赞、总收藏）
     * @param userid
     * @return
     */
    UserImpl selectUserImplByUserid(String userid);

    /**
     * 查询用户总数
     * @return
     */
    int selectCount();
}