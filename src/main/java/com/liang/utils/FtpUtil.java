package com.liang.utils;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

@PropertySource({"classpath:pathconfig.properties"})
@Component
public class FtpUtil {
    // FTP服务器ip
    @Value("${ftp.address}")
    private String host;
    // FTP服务器端口
    @Value("${ftp.port}")
    private int port;
    // FTP登录账号
    @Value("${ftp.username}")
    private String username;
    // FTP登录密码
    @Value("${ftp.password}")
    private String password;
    // FTP服务器基础目录（/home/ftpuser/nansin/data）
    @Value("${data.store.local}")
    private String basePath;
    // 图片服务器相关配置
    @Value("${image.base.url}")
    private String imageUrl;

    /**
     * Description: 向FTP服务器上传文件
     *
     * @param filePath FTP服务器文件存放路径。例如文章配图：/article。文件的路径为basePath+filePath
     * @param fileName 上传到FTP服务器上的文件名
     * @param input    输入流
     * @return 成功返回图片访问的全路径，否则返回null
     */
    public String uploadFile(String filePath, String fileName, InputStream input) {
        String result = null;
        FTPClient ftp = new FTPClient();
        try {
            // 连接FTP服务器（如果采用默认端口，可以使用ftp.connect(host)的方式直接连接FTP服务器）
            ftp.connect(host, port);
            // 登录
            ftp.login(username, password);
            // 获取应答code
            int reply = ftp.getReplyCode();
            // 判断是否成功连接（成功：200 <= n <= 300）
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
                return result;
            }

            // 切换到上传目录
            if (!ftp.changeWorkingDirectory(Paths.get(basePath, filePath).toString())) {
                // 如果目录不存在创建目录
                String[] dirs = filePath.split("/");
                String tempPath = basePath;
                for (String dir : dirs) {
                    if (null == dir || "".equals(dir)) continue;
                    tempPath += "/" + dir;
                    if (!ftp.changeWorkingDirectory(tempPath)) {
                        if (!ftp.makeDirectory(tempPath)) {
                            return result;
                        } else {
                            ftp.changeWorkingDirectory(tempPath);
                        }
                    }
                }
            }

            /**
             * 一定要加上ftp.enterLocalPassiveMode()设置被动模式，否则的话会出现图片传到服务器上去了，但是大小一直是0。
             * 这个方法的意思就是每次数据连接之前，ftp client告诉ftp server开通一个端口来传输数据。为什么要这样做呢，
             * 因为ftp server可能每次开启不同的端口来传输数据，但是在linux上或者其他服务器上面，由于安全限制，可能某些
             * 端口没有开启，所以就出现阻塞。
             */
            // 设置为被动模式
            ftp.enterLocalPassiveMode();
            // 设置上传文件的类型为二进制类型
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            // 去中文
            fileName = CommonUtil.getRemoveChinese(fileName);
            // 上传文件
            if (!ftp.storeFile(fileName, input)) {
                return result;
            }
            result = imageUrl + "/" + filePath + "/" + fileName;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                input.close();
                ftp.logout();
                if (ftp.isConnected()) {
                    ftp.disconnect();
                }
            } catch (Exception e) {
            }
        }
        System.out.println(result);
        return result;
    }
}
