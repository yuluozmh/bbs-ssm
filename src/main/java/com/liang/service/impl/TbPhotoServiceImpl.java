package com.liang.service.impl;

import com.liang.bean.TbPhoto;
import com.liang.dao.TbPhotoMapper;
import com.liang.service.TbPhotoService;
import com.liang.utils.FileUploadUtil;
import com.liang.utils.PathUtil;
import com.liang.utils.ThumbnailatorUtil;
import com.liang.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class TbPhotoServiceImpl implements TbPhotoService {
    @Autowired
    TbPhotoMapper tbPhotoMapper;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    PathUtil pathUtil;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;

    /**
     * 上传照片
     *
     * @param file
     * @param fid
     * @param userid
     * @return
     * @throws Exception
     */
    @Override
    public long setTbPhoto(MultipartFile file, String fid, String userid) throws Exception {
        // 当前文件大小
        long currentFileSize = file.getSize();
        // 上传源文件允许的最大值
        long fileLength = thumbnailatorUtil.getFileLength();
        if (currentFileSize <= fileLength) {
            TbPhoto tbPhoto = new TbPhoto();
            tbPhoto.setPhoto(fileUploadUtil.fileUpload(file, pathUtil.getPhotoPath()));
            tbPhoto.setFid(fid);
            tbPhoto.setUserid(userid);
            //保存到数据库
            tbPhoto.setXid(UUIDUtil.getRandomUUID());
            tbPhotoMapper.insert(tbPhoto);

            return 0;
        } else {
            return fileLength / (1024 * 1024);
        }
    }

    /**
     * 删除某一张照片
     *
     * @param xid
     */
    @Override
    public void deleteTbPhoto(String xid) {
        tbPhotoMapper.deleteByKey(xid);
    }

    /**
     * 删除相册对应的照片
     *
     * @param fid
     */
    @Override
    public void deleteTbPhotoFid(String fid) {
        tbPhotoMapper.deleteByFid(fid);
    }

    /**
     * 获取相册分类下的对应的照片
     *
     * @param fid
     * @param userid
     * @return
     */
    @Override
    public List<TbPhoto> getTbPhoto(String fid, String userid) {
        TbPhoto tbPhoto = new TbPhoto(fid, userid);
        return tbPhotoMapper.selectTbPhotoByFU(tbPhoto);
    }

    /**
     * 按xid查询照片信息
     *
     * @param xid
     */
    @Override
    public TbPhoto getTbPhotoXid(String xid) {
        return tbPhotoMapper.selectTbPhotoByKey(xid);
    }

}
