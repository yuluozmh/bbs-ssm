package com.liang.dao;

import com.liang.bean.Slider;

import java.util.List;

public interface SliderMapper {
    /**
     * 新增轮播图信息
     * @param slider
     */
    void insert(Slider slider);

    /**
     * 按id删除轮播图信息
     * @param id
     */
    void deleteSlider(String id);

    /**
     * 获取轮播图信息
     * @return
     */
    List<Slider> selectSlider();
}