package com.liang.service.impl;

import com.liang.bean.Via;
import com.liang.dao.ViaMapper;
import com.liang.service.ViaService;
import com.liang.utils.FileUploadUtil;
import com.liang.utils.PathUtil;
import com.liang.utils.ThumbnailatorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ViaServiceImpl implements ViaService {
    @Autowired
    ViaMapper viaMapper;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    PathUtil pathUtil;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;

    /**
     * 上传用户头像（插入）（via）
     *
     * @param file
     * @param userid
     * @return
     * @throws Exception
     */
    @Override
    public String setVia(MultipartFile file, String userid) throws Exception {
        // 当前文件大小
        long currentFileSize = file.getSize();
        // 上传源文件允许的最大值
        long fileLength = thumbnailatorUtil.getFileLength();
        if (currentFileSize <= fileLength) {
            Via via = new Via();
            via.setUserid(userid);
            // 用于存放新生成的文件名字(不重复)
            String newFileName;
            if (getVia(userid) == null) {    //如果该用户还没有上传过头像，则进行新增操作
                // 保存文件
                newFileName = fileUploadUtil.fileUpload(file, pathUtil.getUserPath());
                via.setPhoto(newFileName);
                // 将via保存到数据库
                viaMapper.insert(via);
            } else {    //如果该用户上传过头像，则进行修改操作
                // 保存文件
                newFileName = fileUploadUtil.fileUpload(file, pathUtil.getUserPath());
                via.setPhoto(newFileName);
                // 将via保存到数据库(修改)
                viaMapper.updateByKey(via);
            }

            return newFileName;
        } else {
            return null;
        }
    }

    /**
     * 删除用户对应的头像信息
     *
     * @param userid
     */
    @Override
    public void deleteVia(String userid) {
        viaMapper.deleteByKey(userid);
    }

    /**
     * 按userid修改用户头像信息（via）
     *
     * @param via
     */
    @Override
    public void updateVia(Via via) {
        viaMapper.updateByKey(via);
    }

    /**
     * 按userid查询用户头像信息（via）
     *
     * @param userid
     * @return
     */
    @Override
    public Via getVia(String userid) {
        return viaMapper.selectViaByKey(userid);
    }
}
