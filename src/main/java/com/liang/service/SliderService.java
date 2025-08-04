package com.liang.service;

import com.liang.bean.Slider;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SliderService {
    /**
     * 新增轮播图信息
     *
     * @param file
     * @param slider
     * @return
     */
    long setSlider(MultipartFile file, Slider slider) throws Exception;

    /**
     * 按id删除轮播图信息
     *
     * @param id
     */
    void deleteSlider(String id);

    /**
     * 获取轮播图信息
     *
     * @return
     */
    List<Slider> getSlider();
}
