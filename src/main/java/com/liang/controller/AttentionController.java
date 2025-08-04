package com.liang.controller;

import com.liang.code.ReturnT;
import com.liang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.liang.bean.Attention;
import com.liang.service.AttentionService;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpSession;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/attention")
@RestController
@CrossOrigin
public class AttentionController {
    @Autowired
    AttentionService attentionService;
    @Autowired
    UserService userService;

    /**
     * 添加关注
     *
     * @return
     */
    @PostMapping("/setAttention")
    public ReturnT<?> setAttention(Attention attention) {
        try {
            attentionService.setAttention(attention);
            return ReturnT.success("关注成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("关注失败");
        }
    }

    /**
     * 取消关注（按gid）
     *
     * @param gid
     * @return
     */
    @DeleteMapping("/deleteAttention/{gid}")
    public ReturnT<?> deleteAttention(@PathVariable String gid) {
        try {
            attentionService.deleteAttention(gid);
            return ReturnT.success("取关成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取关失败");
        }
    }

    /**
     * 取消关注（按beuserid和userid）
     *
     * @param beuserid
     * @return
     */
    @DeleteMapping("/deleteByUserid/{beuserid}")
    public ReturnT<?> deleteByUserid(@PathVariable String beuserid, HttpSession session) {
        try {
            //取消关注
            attentionService.deleteByUserid(beuserid, (String) session.getAttribute("userid"));
            return ReturnT.success("取关成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取关失败");
        }
    }
}
