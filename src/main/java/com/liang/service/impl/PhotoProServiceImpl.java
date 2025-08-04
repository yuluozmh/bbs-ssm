package com.liang.service.impl;

import com.liang.bean.PhotoPro;
import com.liang.bean.impl.PhotoProImpl;
import com.liang.dao.PhotoProMapper;
import com.liang.service.PhotoProService;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PhotoProServiceImpl implements PhotoProService {
    @Autowired
    PhotoProMapper photoProMapper;

    /**
     * 创建相册
     *
     * @param photoPro
     */
    @Override
    public void setPhotoPro(PhotoPro photoPro) {
        photoPro.setFid(UUIDUtil.getRandomUUID());
        photoProMapper.insert(photoPro);
    }

    /**
     * 删除相册
     *
     * @param fid
     */
    @Override
    public void deletePhotoPro(String fid) {
        photoProMapper.deleteByKey(fid);
    }

    /**
     * 编辑相册
     *
     * @param photoPro
     */
    @Override
    public void updateName(PhotoPro photoPro) {
        photoProMapper.updateNameByKey(photoPro);
    }

    /**
     * 获取相册分类信息(按userid)
     *
     * @param userid
     */
    @Override
    public List<PhotoProImpl> getPhotoPro(String userid) {
        return photoProMapper.selectPhotoProImplByUserid(userid);
    }

    /**
     * 按fid（相册id）查询相册信息
     *
     * @param fid
     */
    @Override
    public PhotoPro selectByPrimaryKey(String fid) {
        return photoProMapper.selectPhotoProByKey(fid);
    }

    /**
     * 按userid和name（相册名）查询相册信息
     *
     * @param photoPro
     * @return
     */
    @Override
    public List<PhotoPro> selectByName(PhotoPro photoPro) {
        return photoProMapper.selectPhotoProByUN(photoPro);
    }
}
