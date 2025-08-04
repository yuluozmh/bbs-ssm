package com.liang.controller;

import com.liang.code.ReturnT;
import com.liang.service.SoupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@RestController
@RequestMapping("/api/rest/nansin/v3.0/soup")
@CrossOrigin
public class SoupController {
    @Autowired
    SoupService soupService;

    /**
     * 随机一碗毒鸡汤
     *
     * @return
     */
    @GetMapping("/getSoupRand")
    public ReturnT<?> getVersionsMarkNew() {
        try {
            return new ReturnT<>(HttpStatus.OK, "获取毒鸡汤数据成功", soupService.getSoupRand());
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取毒鸡汤数据失败");
        }
    }
}
