package com.liang.service.impl;

import com.liang.bean.User;
import com.liang.bean.impl.UserImpl;
import com.liang.dao.UserMapper;
import com.liang.service.UserService;
import com.liang.utils.PageUtil;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    @Autowired
    PageUtil pageUtil;

    // 管理系统-用户初始条数（第一页）
    private int adminUserPageSize;

    @PostConstruct
    private void init() {
        adminUserPageSize = pageUtil.getAdminUserPageSize();
    }

    /**
     * 插入用户信息
     *
     * @param user
     */
    @Override
    public void setUser(User user) {
        user.setUserid(UUIDUtil.getRandomUUID());
        userMapper.insert(user);
    }

    /**
     * 删除用户
     *
     * @param userid
     */
    @Override
    public void deleteUser(String userid) {
        userMapper.deleteByKey(userid);
    }

    /**
     * 编辑个人资料（修改user表）
     *
     * @param user
     */
    @Override
    public void updateUser(User user) {
        userMapper.updateByKey(user);
    }

    /**
     * 修改用户名
     *
     * @param username
     * @param userid
     */
    @Override
    public void updateUsername(String username, String userid) {
        User user = new User();
        user.setUserid(userid);
        user.setName(username);
        userMapper.updateNameByKey(user);
    }

    /**
     * 修改密码
     *
     * @param passNew
     * @param userid
     */
    @Override
    public void updatePassword(String passNew, String userid) {
        User user = new User();
        user.setUserid(userid);
        user.setPassword(passNew);
        userMapper.updatePasswordByKey(user);
    }

    /**
     * 修改Email
     *
     * @param email
     * @param userid
     */
    @Override
    public void updateEmail(String email, String userid) {
        User user = new User();
        user.setUserid(userid);
        user.setEmail(email);
        userMapper.updateEmailByKey(user);
    }

    /**
     * 按姓名和密码或者Email和密码查询用户信息
     *
     * @param user
     * @return
     */
    @Override
    public UserImpl getNameEmailPass(User user) {
        return userMapper.selectUserImplByNEP(user);
    }

    /**
     * 按用户id和密码查询
     *
     * @param passOld
     * @param userid
     * @return
     */
    @Override
    public User getIdPass(String passOld, String userid) {
        User user = new User();
        user.setUserid(userid);
        user.setPassword(passOld);
        return userMapper.selectUserByUP(user);
    }

    /**
     * 按用户名查询
     *
     * @param name
     * @return
     */
    @Override
    public User getUserName(String name) {
        return userMapper.selectUserByName(name);
    }

    /**
     * 按Email查询
     *
     * @param email
     * @return
     */
    @Override
    public User getEmail(String email) {
        return userMapper.selectUserByEmail(email);
    }

    /**
     * 查询用户信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    @Override
    public List<UserImpl> getUserImplPaging(int pageStart, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        if (pageStart == 1) {
            map.put("offset", (pageStart - 1) * pageSize);
        } else {
            map.put("offset", (pageStart - 2) * pageSize + adminUserPageSize);
        }
        map.put("limit", pageSize);
        return userMapper.selectUserImplPaging(map);
    }

    /**
     * 查询用户总数
     *
     * @return
     */
    @Override
    public int getCount() {
        return userMapper.selectCount();
    }

    /**
     * 按userid查询用户信息
     *
     * @param userid
     * @return
     */
    @Override
    public User getUserKey(String userid) {
        return userMapper.selectUserByKey(userid);
    }

    /**
     * 获取用户排名（按文章数）
     *
     * @return
     */
    @Override
    public List<UserImpl> getUserRankByArticleSum() {
        return userMapper.selectUserImplRankByArticleSum();
    }

    /**
     * 获取新注册用户
     *
     * @return
     */
    @Override
    public List<UserImpl> getNewUser() {
        return userMapper.selectNewUserImpl();
    }

    /**
     * 按userid查询关注信息
     *
     * @param userid
     * @param b      （true:你关注了谁/false:谁关注了你）
     * @return
     */
    @Override
    public List<UserImpl> getUserImpl(String userid, boolean b) {
        Map<String, Object> map = new HashMap<>();
        map.put("userid", userid);
        map.put("b", b);
        return userMapper.selectUserImplByKey(map);
    }

    /**
     * 按userid获取用户信息（名称、头像、粉丝数、文章总浏览、总点赞、总收藏）
     *
     * @param userid
     * @return
     */
    @Override
    public UserImpl getUserImplByUserid(String userid) {
        return userMapper.selectUserImplByUserid(userid);
    }
}
