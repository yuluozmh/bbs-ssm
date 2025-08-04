package com.liang.controller;

import com.liang.bean.PhotoPro;
import com.liang.code.ReturnT;
import com.liang.service.PhotoProService;
import com.liang.service.TbPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/photoPro")
@RestController
@CrossOrigin
public class PhotoProController {
    @Autowired
    PhotoProService photoProService;
    @Autowired
    TbPhotoService tbPhotoService;

    /**
     * 创建相册
     *
     * @param photoPro
     * @param session
     * @return
     */
    @PostMapping("/setPhotoPro")
    public ReturnT<?> setPhotoPro(PhotoPro photoPro, HttpSession session) {
        try {
            photoPro.setUserid((String) session.getAttribute("userid"));
            if (photoProService.selectByName(photoPro).size() == 0) {    // 不存在该相册名
                photoProService.setPhotoPro(photoPro);
                return ReturnT.success("创建相册成功");
            } else {
                return ReturnT.fail(HttpStatus.NOT_FOUND, "该相册已存在!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("创建相册失败");
        }
    }

    /**
     * 删除相册
     *
     * @return
     */
    @DeleteMapping("/deletePhotoPro/{fid}")
    public ReturnT<?> deletePhotoPro(@PathVariable String fid) {
        try {
            // 删除相册
            photoProService.deletePhotoPro(fid);
            return ReturnT.success("删除相册成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("删除相册失败");
        }
    }

    /**
     * 编辑相册
     *
     * @return
     */
    @PutMapping("/updatePhotoPro")
    public ReturnT<?> updatePhotoPro(PhotoPro photoPro, HttpSession session) {
        try {
            photoPro.setUserid((String) session.getAttribute("userid"));
            if (photoProService.selectByName(photoPro).size() == 0) {    // 不存在该相册名
                photoProService.updateName(photoPro);
                return ReturnT.success("修改相册成功");
            } else {
                return ReturnT.fail(HttpStatus.NOT_FOUND, "该相册已存在!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("修改相册失败");
        }
    }

    /**
     * 获取相册信息
     *
     * @return
     */
    @GetMapping("/getPhoto")
    public ReturnT<?> getPhoto(HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            //获取相册分类信息(按userid)
            map.put("listPhotoPros", photoProService.getPhotoPro((String) session.getAttribute("userid")));
            return new ReturnT<>(HttpStatus.OK, "获取相册数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取相册数据失败");
        }
    }

    /**
     * 按fid（相册id）获取相册信息
     *
     * @return
     */
    @GetMapping("/getPhotoProFid/{fid}")
    public ReturnT<?> selectByPrimaryKey(@PathVariable String fid) {
        Map<String, Object> map = new HashMap<>();
        try {
            //查询相册
            map.put("photoPro", photoProService.selectByPrimaryKey(fid));
            return new ReturnT<>(HttpStatus.OK, "获取相册数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取相册数据失败");
        }
    }
}
