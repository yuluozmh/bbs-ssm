package com.liang.service;

import com.liang.bean.TbPhoto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface TbPhotoService {
    /**
     * 上传照片
     *
     * @param file
     * @param fid
     * @param userid
     * @return
     * @throws Exception
     */
    long setTbPhoto(MultipartFile file, String fid, String userid) throws Exception;

    /**
     * 删除某一张照片
     *
     * @param xid
     */
    void deleteTbPhoto(String xid);

    /**
     * 删除相册对应的照片
     *
     * @param fid
     */
    void deleteTbPhotoFid(String fid);

    /**
     * 获取相册分类下的对应的照片
     *
     * @param fid
     * @param userid
     * @return
     */
    List<TbPhoto> getTbPhoto(String fid, String userid);

    /**
     * 按xid查询照片信息
     *
     * @param xid
     */
    TbPhoto getTbPhotoXid(String xid);
}
