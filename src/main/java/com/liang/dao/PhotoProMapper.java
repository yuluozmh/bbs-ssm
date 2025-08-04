package com.liang.dao;

import com.liang.bean.PhotoPro;
import com.liang.bean.impl.PhotoProImpl;

import java.util.List;

public interface PhotoProMapper {
    /**
     * 创建相册
     * @param record
     */
    void insert(PhotoPro record);

    /**
     * 删除相册
     * @param fid
     */
    void deleteByKey(String fid);

    /**
     * 编辑相册
     * @param photoPro
     */
    void updateNameByKey(PhotoPro photoPro);

    /**
     * 按fid（相册id）查询相册信息
     * @param fid
     * @return
     */
    PhotoPro selectPhotoProByKey(String fid);

    /**
     * 查询某用户的相册分类信息
     * @param userid
     * @return
     */
    List<PhotoProImpl> selectPhotoProImplByUserid(String userid);

    /**
     * 按userid和name（相册名）查询相册信息
     * @param photoPro
     * @return
     */
    List<PhotoPro> selectPhotoProByUN(PhotoPro photoPro);
}