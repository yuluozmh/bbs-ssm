package com.liang.controller;

import com.liang.code.ReturnT;
import com.liang.service.TbPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/tbPhoto")
@RestController
@CrossOrigin
public class TbPhotoController {
    @Autowired
    TbPhotoService tbPhotoService;

    /**
     * 上传照片
     *
     * @param file
     * @param session
     * @param fid
     * @return
     */
    @PostMapping("/setTbPhoto/{fid}")
    public ReturnT<?> setTbPhoto(@RequestParam("photo") MultipartFile file, HttpSession session, @PathVariable String fid) {
        try {
            long length = tbPhotoService.setTbPhoto(file, fid, (String) session.getAttribute("userid"));
            if (length == 0) {
                return ReturnT.success("上传照片成功");
            } else {
                return ReturnT.fail("请上传不超过 " + length + "M 的照片!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("上传照片失败");
        }
    }

    /**
     * 删除某一张照片
     *
     * @param xid
     * @return
     */
    @DeleteMapping("/deleteTbPhoto/{xid}")
    public ReturnT<?> deleteTbPhoto(@PathVariable String xid) {
        try {
            // 删除照片（数据库）
            tbPhotoService.deleteTbPhoto(xid);
            return ReturnT.success("删除照片成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("删除照片成功");
        }
    }

    /**
     * 获取相册分类下的对应的照片
     *
     * @param fid     相册id
     * @param session
     * @return
     */
    @GetMapping("/getTbPhoto/{fid}")
    public ReturnT<?> getTbPhoto(@PathVariable String fid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("listTbPhotos", tbPhotoService.getTbPhoto(fid, (String) session.getAttribute("userid")));
            return new ReturnT<>(HttpStatus.OK, "获取照片数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取照片数据失败");
        }
    }
}
