package com.liang.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.liang.code.ReturnT;
import com.liang.utils.ThumbnailatorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.liang.service.ViaService;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/via")
@SessionAttributes("userPhoto")
@RestController
@CrossOrigin
public class ViaController {
    @Autowired
    ViaService viaService;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;

    /**
     * 上传用户头像（插入、修改）
     *
     * @param file
     * @param session
     * @return
     * @throws IOException
     */
    @PostMapping("/setUserPhoto")
    public ReturnT<?> setUserPhoto(@RequestParam("photo") MultipartFile file, HttpSession session, Model model) {
        try {
            // 上传源文件允许的最大值
            long fileLength = thumbnailatorUtil.getFileLength();
            String newFileName = viaService.setVia(file, (String) session.getAttribute("userid"));
            if (newFileName != null) {
                model.addAttribute("userPhoto", newFileName);
                return ReturnT.success("修改头像成功");
            } else {
                return ReturnT.fail("请上传不超过 " + fileLength / (1024 * 1024) + "M 的头像!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("修改头像失败");
        }
    }
}
