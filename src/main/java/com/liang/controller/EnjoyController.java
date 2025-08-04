package com.liang.controller;

import com.liang.bean.Enjoy;
import com.liang.code.ReturnT;
import com.liang.service.ArticleService;
import com.liang.service.EnjoyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/enjoy")
@RestController
@CrossOrigin
public class EnjoyController {
    @Autowired
    EnjoyService enjoyService;
    @Autowired
    ArticleService articleService;

    /**
     * 添加点赞
     *
     * @param enjoy
     * @return
     */
    @PostMapping("/setEnjoy")
    public ReturnT<?> setEnjoy(Enjoy enjoy) {
        try {
            enjoyService.setEnjoy(enjoy);
            return ReturnT.success("点赞 +1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("点赞失败");
        }
    }

    /**
     * 删除点赞（按eid）
     *
     * @param eid
     * @return
     */
    @DeleteMapping("/deleteEnjoy/{eid}")
    public ReturnT<?> deleteEnjoy(@PathVariable String eid) {
        try {
            enjoyService.deleteEnjoy(eid);
            return ReturnT.success("点赞 -1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取消点赞失败");
        }
    }

    /**
     * 删除点赞（按userid和fid）
     *
     * @param fid
     * @return
     */
    @DeleteMapping("/deleteEnjoyUseridAndFid/{fid}")
    public ReturnT<?> deleteEnjoyUseridAndFid(@PathVariable String fid, HttpSession session) {
        try {
            enjoyService.deleteEnjoyUseridAndFid(fid, (String) session.getAttribute("userid"));
            return ReturnT.success("点赞 -1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取消点赞失败");
        }
    }

    /**
     * 按userid和fid获取点赞信息
     *
     * @param fid
     * @param session
     * @return
     */
    @GetMapping("/getEnjoyFid/{fid}")
    public ReturnT<?> getEnjoyFid(@PathVariable String fid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("enjoy", enjoyService.getEnjoyFid(fid, (String) session.getAttribute("userid")));
            return new ReturnT<>(HttpStatus.OK, "获取点赞数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取点赞数据失败");
        }
    }
}
