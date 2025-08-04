package com.liang.service;

import com.liang.bean.Via;
import org.springframework.web.multipart.MultipartFile;

public interface ViaService {
    /**
     * 上传用户头像（插入）（via）
     *
     * @param file
     * @param userid
     * @return
     * @throws Exception
     */
    String setVia(MultipartFile file, String userid) throws Exception;

    /**
     * 删除用户对应的头像信息
     *
     * @param userid
     */
    void deleteVia(String userid);

    /**
     * 按userid修改用户头像信息（via）
     *
     * @param via
     */
    void updateVia(Via via);

    /**
     * 按userid查询用户头像信息（via）
     *
     * @param userid
     * @return
     */
    Via getVia(String userid);
}
