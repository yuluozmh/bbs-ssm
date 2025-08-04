package com.liang.utils;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@PropertySource({"classpath:pathconfig.properties"})
@Component
public class FileUploadUtil {
    @Autowired
    FtpUtil ftpUtil;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;
    @Autowired
    QiniuUtil qiniuUtil;
    @Autowired
    PathUtil pathUtil;

    private static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
    // 文件存储根路径
    @Value("${data.store.local}")
    private String rootPath;
    // 允许上传的文件后缀名
    @Value("${data.store.local.suffix}")
    private String suffix;

    private List<String> suffixList = null;

    @PostConstruct
    private void init() {
        if (StringUtil.isNotEmpty(suffix)) {
            suffixList = Stream.of(suffix.split("(, *)+")).map(s -> s.trim().toLowerCase()).collect(Collectors.toList());
        }
    }

    /**
     * 文件上传到七牛云
     *
     * @param file 源文件
     * @param type 类型（文章/头像/...）
     * @return
     * @throws Exception
     */
    public String fileUpload(MultipartFile file, String type) throws Exception {
        // 构造文件名（type-：给文件加标签-前缀）
        String fileName = type + "-" + generateFileName(file.getOriginalFilename());
        // 保存文件（返回保存后的全路径）
        String filePath = save(file, type);
        // 不压缩轮播图
        if (type.equals(pathUtil.getSliderPath())) {
            System.out.println("轮播图...");
            // 上传到七牛云
            qiniuUtil.upload(filePath, fileName);
            return qiniuUtil.getDomin() + File.separator + fileName;
        }
        // 满足需要压缩的图片格式才进行压缩
        if (thumbnailatorUtil.getSuffixList().contains(CommonUtil.getFileSuffix(fileName).toLowerCase())) {
            // 构压缩（剪切）后的路径
            String newFilePath = filePath.substring(0, filePath.lastIndexOf(File.separator) + 1) + fileName;
            if (type.equals(pathUtil.getUserPath())) {  // 头像
                // 剪切图片
                thumbnailatorUtil.getRegion(filePath, newFilePath, false);
            } else {
                // 压缩图片
                thumbnailatorUtil.getScale(filePath, newFilePath, false);
            }
            // 上传到七牛云
            qiniuUtil.upload(newFilePath, fileName);
            // 删除本地文件（压缩剪切后的）
            new File(newFilePath).delete();
        } else {
            // 上传到七牛云
            qiniuUtil.upload(filePath, fileName);
        }

        return qiniuUtil.getDomin() + File.separator + fileName;
    }

    /**
     * 保存文件
     *
     * @param file   源文件
     * @param folder 文件夹名称（介于前者与后者之间）
     * @return 全路径
     */
    public String save(MultipartFile file, String folder) {
        String orginalName = file.getOriginalFilename();
        if (checkFile(orginalName)) { // 检查文件后缀名
            // 构造存储文件名
            String fileName = generateFileName(orginalName);
            // 构造目标文件路径
            String targetPath = generateStorePath(folder, fileName);
            // 保存文件到指定目录
            String path = storeData(targetPath, file);
            logger.info("已保存文件：" + path);

            return path;
        } else {
            logger.info("不支持上传该类型的文件：" + orginalName);
            return null;
        }
    }

    /**
     * 删除文件
     *
     * @param fulPath 全路径
     */
    public static void del(String fulPath) {
        // 封装上传文件位置的全路径
        File targetFile = new File(fulPath);
        // 删除文章对应的图片（实际删除）
        targetFile.delete();
    }

    /**
     * 构造存储文件名
     *
     * @param orginalName 原始文件名
     * @return 返回新的文件名
     */
    public String generateFileName(String orginalName) {
        return DateUtil.getNowDate() + "_" + orginalName;//“上传时间_文件名”
    }

    /**
     * 构造目标文件路径
     *
     * @param folder   文件夹名称（介于前者与后者之间）
     * @param fileName 文件名
     * @return 目标文件路径
     */
    public String generateStorePath(String folder, String fileName) {
        return Paths.get(rootPath, folder, fileName).toString();
    }

    /**
     * 保存文件到指定目录
     *
     * @param path 目标目录
     * @param file 文件
     * @return
     */
    public String storeData(String path, MultipartFile file) {
        File stored = new File(path);
        try (InputStream in = file.getInputStream();) {
            FileUtils.copyInputStreamToFile(in, stored);
            return stored.getCanonicalPath();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
            return null;
        }
    }

    /**
     * 检查文件后缀名
     *
     * @param fileName 文件名
     * @return 通过检查为true，不通过为false
     */
    public boolean checkFile(String fileName) {
        if (suffixList.size() == 1 && suffixList.get(0).equals("*")) {
            return true;
        }
        String ext = FilenameUtils.getExtension(fileName);
        return suffixList.contains(ext.toLowerCase());
    }
}