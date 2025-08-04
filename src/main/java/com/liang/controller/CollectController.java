package com.liang.controller;

import com.liang.code.ReturnT;
import com.liang.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import com.liang.bean.Collect;
import com.liang.service.CollectService;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/collect")
@RestController
@CrossOrigin
public class CollectController {
    @Autowired
    CollectService collectService;
    @Autowired
    ArticleService articleService;

    /**
     * 添加收藏
     *
     * @param collect
     * @return
     */
    @PostMapping("/setCollect")
    public ReturnT<?> setCollect(Collect collect) {
        try {
            collectService.setCollect(collect);
            return ReturnT.success("收藏 +1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("收藏失败");
        }
    }

    /**
     * 删除收藏（按sid）
     *
     * @param sid
     * @return
     */
    @DeleteMapping("/deleteCollect/{sid}")
    public ReturnT<?> deleteCollect(@PathVariable String sid) {
        try {
            collectService.deleteCollect(sid);
            return ReturnT.success("收藏 -1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取消收藏失败");
        }
    }

    /**
     * 删除收藏（按userid和fid）
     *
     * @param fid
     * @return
     */
    @DeleteMapping("/deleteCollectUseridAndFid/{fid}")
    public ReturnT<?> deleteCollectUseridAndFid(@PathVariable String fid, HttpSession session) {
        try {
            //取消收藏
            collectService.deleteCollectUseridAndFid(fid, (String) session.getAttribute("userid"));
            return ReturnT.success("收藏 -1");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("取消收藏失败");
        }
    }

    /**
     * 按userid和fid获取收藏信息
     *
     * @param fid
     * @param session
     * @return
     */
    @GetMapping("/getCollectFid/{fid}")
    public ReturnT<?> getCollectFid(@PathVariable String fid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("collect", collectService.getCollectFid(fid, (String) session.getAttribute("userid")));
            return new ReturnT<>(HttpStatus.OK, "获取收藏数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取收藏数据失败");
        }
    }
}
