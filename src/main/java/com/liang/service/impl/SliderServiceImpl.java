package com.liang.service.impl;

import com.liang.bean.Slider;
import com.liang.dao.SliderMapper;
import com.liang.service.SliderService;
import com.liang.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class SliderServiceImpl implements SliderService {
    @Autowired
    SliderMapper sliderMapper;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    PathUtil pathUtil;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;

    /**
     * 新增轮播图信息
     *
     * @param file
     * @param slider
     * @return
     */
    @Override
    public long setSlider(MultipartFile file, Slider slider) throws Exception {
        // 当前文件大小
        long currentFileSize = file.getSize();
        // 上传源文件允许的最大值
        long fileLength = thumbnailatorUtil.getFileLength();
        if (currentFileSize <= fileLength) {
            slider.setImageUrl(fileUploadUtil.fileUpload(file, pathUtil.getSliderPath()));
            sliderMapper.insert(slider);
            return 0;
        } else {
            return fileLength / (1024 * 1024);
        }
    }

    /**
     * 按id删除轮播图信息
     *
     * @param id
     */
    @Override
    public void deleteSlider(String id) {
        sliderMapper.deleteSlider(id);
    }

    /**
     * 获取轮播图信息
     *
     * @return
     */
    @Override
    public List<Slider> getSlider() {
        return sliderMapper.selectSlider();
    }
}
