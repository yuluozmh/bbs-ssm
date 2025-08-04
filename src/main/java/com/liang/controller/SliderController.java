package com.liang.controller;

import com.liang.bean.Slider;
import com.liang.code.ReturnT;
import com.liang.service.SliderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@RestController
@RequestMapping("/api/rest/nansin/v3.0/slider")
@CrossOrigin
public class SliderController {
    @Autowired
    SliderService sliderService;

    /**
     * 新增轮播图信息
     *
     * @param file
     * @param slider
     * @return
     */
    @PostMapping("/setSlider")
    public ReturnT<?> setSlider(@RequestParam(value = "picture", required = false) MultipartFile file, Slider slider) {
        try {
            long length = sliderService.setSlider(file, slider);
            if (length == 0) {
                return ReturnT.success("新增轮播图成功");
            } else {
                return ReturnT.fail("请上传不超过 " + length + "M 的轮播图!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("新增轮播图失败");
        }
    }

    /**
     * 按id删除轮播图信息
     *
     * @param id
     * @return
     */
    @DeleteMapping("/deleteSlider/{id}")
    public ReturnT<?> deleteSlider(@PathVariable String id) {
        try {
            sliderService.deleteSlider(id);
            return ReturnT.success("删除轮播图成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("删除轮播图失败");
        }
    }

    /**
     * 获取轮播图信息
     *
     * @return
     */
    @GetMapping("/getSlider")
    public ReturnT<?> getSlider() {
        try {
            return new ReturnT<>(HttpStatus.OK, "获取轮播图数据成功", sliderService.getSlider());
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取轮播图数据失败");
        }
    }
}
