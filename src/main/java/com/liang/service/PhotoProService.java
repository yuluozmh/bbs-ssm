package com.liang.service;

import com.liang.bean.PhotoPro;
import com.liang.bean.impl.PhotoProImpl;

import java.util.List;

public interface PhotoProService {
    /**
     * 创建相册
     *
     * @param photoPro
     */
    void setPhotoPro(PhotoPro photoPro);

    /**
     * 删除相册
     *
     * @param fid
     */
    void deletePhotoPro(String fid);

    /**
     * 编辑相册
     *
     * @param photoPro
     */
    void updateName(PhotoPro photoPro);

    /**
     * 获取相册分类信息(按userid)
     *
     * @param userid
     */
    List<PhotoProImpl> getPhotoPro(String userid);

    /**
     * 按fid（相册id）查询相册信息
     *
     * @param fid
     */
    PhotoPro selectByPrimaryKey(String fid);

    /**
     * 按userid和name（相册名）查询相册信息
     *
     * @param photoPro
     * @return
     */
    List<PhotoPro> selectByName(PhotoPro photoPro);
}
