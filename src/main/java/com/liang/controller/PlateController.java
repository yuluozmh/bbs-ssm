package com.liang.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.liang.code.ReturnT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import com.liang.bean.Plate;
import com.liang.service.PlateService;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@RestController
@RequestMapping("/api/rest/nansin/v3.0/plate")
@SessionAttributes(value = {"plate", "plateEdit"}, types = {String.class})
@CrossOrigin
public class PlateController {
    @Autowired
    PlateService plateService;

    /**
     * 添加板块信息
     *
     * @param plate
     * @return
     */
    @PostMapping("/setPlate")
    public ReturnT<?> setPlate(Plate plate) {
        try {
            if (plateService.getPlateName(plate).size() == 0) {    // 该版块名不存在
                plateService.setPlate(plate);
                return ReturnT.success("添加板块成功");
            } else {
                return ReturnT.fail(HttpStatus.NOT_FOUND, "该板块已存在!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("添加板块失败");
        }
    }

    /**
     * 按bid删除板块信息
     *
     * @param bid
     * @return
     */
    @DeleteMapping("/deletePlate/{bid}")
    public ReturnT<?> deletePlate(@PathVariable String bid) {
        try {
            plateService.deletePlate(bid);
            return ReturnT.success("删除板块成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("删除板块失败");
        }
    }

    /**
     * 修改板块
     *
     * @param plate
     * @return
     */
    @PutMapping("/updatePlate")
    public ReturnT<?> updatePlate(Plate plate) {
        try {
            if (plateService.getPlateName(plate).size() == 0) {    // 该版块名不存在
                plateService.updatePlate(plate);
                return ReturnT.success("修改板块成功");
            } else {
                return ReturnT.fail(HttpStatus.NOT_FOUND, "该板块已存在!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("修改板块失败");
        }
    }

    /**
     * 查询板块信息（无条件）
     *
     * @return
     */
    @GetMapping("/getPlate")
    public ReturnT<?> getPlate() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("plate", plateService.getPlate());
            // 总板块数
            map.put("total", plateService.getCount());
            return new ReturnT<>(HttpStatus.OK, "获取板块数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取板块数据失败");
        }
    }
}
