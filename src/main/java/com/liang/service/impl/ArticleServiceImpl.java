package com.liang.service.impl;

import com.liang.bean.Article;
import com.liang.bean.impl.ArticleImpl;
import com.liang.dao.ArticleMapper;
import com.liang.service.ArticleService;
import com.liang.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleMapper articleMapper;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    PathUtil pathUtil;
    @Autowired
    PageUtil pageUtil;
    @Autowired
    ThumbnailatorUtil thumbnailatorUtil;

    // 用户系统-文章初始条数（第一页）
    private int articlePageSize;
    // 管理系统-文章初始条数（第一页）
    private int adminArticlePageSize;

    @PostConstruct
    private void init() {
        articlePageSize = pageUtil.getArticlePageSize();
        adminArticlePageSize = pageUtil.getAdminArticlePageSize();
    }

    /**
     * 向数据库插入发帖信息
     *
     * @param file
     * @param article
     * @param userid
     * @return
     * @throws Exception
     */
    @Override
    public long setArticle(MultipartFile file, Article article, String userid) throws Exception {
        article.setUserid(userid);
        article.setStatus(0);
        article.setPv(0);
        // 将article保存到数据库
        article.setFid(UUIDUtil.getRandomUUID());
        // 无配图
        if (file == null) {
            article.setPhoto("");
            articleMapper.insert(article);
            return 0;
        } else {
            // 当前文件大小
            long currentFileSize = file.getSize();
            // 上传源文件允许的最大值
            long fileLength = thumbnailatorUtil.getFileLength();
            if (currentFileSize <= fileLength) {
                article.setPhoto(fileUploadUtil.fileUpload(file, pathUtil.getArticlePath()));
                articleMapper.insert(article);
                return 0;
            } else {
                return fileLength / (1024 * 1024);
            }
        }
    }

    /**
     * 上传图片-editor.md
     *
     * @param file
     * @return
     * @throws Exception
     */
    @Override
    public long uploadPicture(MultipartFile file) throws Exception {
        // 当前文件大小
        long currentFileSize = file.getSize();
        // 上传源文件允许的最大值
        long fileLength = thumbnailatorUtil.getFileLength();
        if (currentFileSize <= fileLength) {
            return 0;
        } else {
            return fileLength / (1024 * 1024);
        }
    }

    /**
     * 按fid删除文章
     *
     * @param fid
     */
    @Override
    public void deleteArticle(String fid) {
        articleMapper.deleteByKey(fid);
    }

    /**
     * 删除用户对应的文章信息(按userid)
     *
     * @param userid
     */
    @Override
    public void deleteArticleUserid(String userid) {
        articleMapper.deleteByUserid(userid);
    }

    /**
     * 修改文章
     *
     * @param file
     * @param article
     * @throws Exception
     */
    @Override
    public long updateArticle(MultipartFile file, Article article) throws Exception {
        // 当前文件大小
        long currentFileSize = file.getSize();
        // 上传源文件允许的最大值
        long fileLength = thumbnailatorUtil.getFileLength();
        if (currentFileSize <= fileLength) {
            article.setPhoto(fileUploadUtil.fileUpload(file, pathUtil.getArticlePath()));
            // 修改文章表（数据库）
            articleMapper.updateByKey(article);
            return 0;
        } else {
            return fileLength / (1024 * 1024);
        }
    }

    /**
     * 修改文章（无图）
     *
     * @param article
     */
    @Override
    public void updateArticle(Article article) {
        articleMapper.updateByKey(article);
    }

    /**
     * 更改文章审核状态
     *
     * @param article
     */
    @Override
    public void updateArticleStatus(Article article) {
        articleMapper.updateStatusByKey(article);
    }

    /**
     * 记录（+1）文章访问量
     *
     * @param fid
     */
    @Override
    public void updateArticlePV(String fid) {
        articleMapper.updateArticlePV(fid);
    }

    /**
     * 获取发帖表信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    @Override
    public List<ArticleImpl> getArticle(int pageStart, int pageSize, String userid) {
        Map<String, Object> map = new HashMap<>();
        if (pageStart == 1) {
            map.put("offset", (pageStart - 1) * pageSize);
        } else {
            map.put("offset", (pageStart - 2) * pageSize + articlePageSize);
        }
        map.put("limit", pageSize);
        map.put("userid", userid);

        return articleMapper.selectPassArticleImplPaging(map);
    }

    /**
     * 获取发帖表信息（分页）
     *
     * @param bid       按板块查询
     * @param pageStart
     * @param pageSize
     * @return
     */
    @Override
    public List<ArticleImpl> getArticleBid(String bid, int pageStart, int pageSize, String userid) {
        Map<String, Object> map = new HashMap<>();
        if (pageStart == 1) {
            map.put("offset", (pageStart - 1) * pageSize);
        } else {
            map.put("offset", (pageStart - 2) * pageSize + articlePageSize);
        }
        map.put("bid", bid);
        map.put("limit", pageSize);
        map.put("userid", userid);

        return articleMapper.selectPassArticleImplPaging(map);
    }

    /**
     * 查询发帖表信息（分页）-管理员
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    @Override
    public List<ArticleImpl> getArticleAdmin(int pageStart, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        if (pageStart == 1) {
            map.put("offset", (pageStart - 1) * pageSize);
        } else {
            map.put("offset", (pageStart - 2) * pageSize + adminArticlePageSize);
        }
        map.put("limit", pageSize);
        return articleMapper.selectArticleImplPaging(map);
    }

    /**
     * 按userid查询发帖表信息（通过审核）
     *
     * @param userid
     * @return
     */
    @Override
    public List<Article> getPassArticleUserid(String userid) {
        return articleMapper.selectPassArticleByUserid(userid);
    }

    /**
     * 按userid获取文章信息（所有审核状态）
     *
     * @param userid
     * @return
     */
    @Override
    public List<Article> getArticleUserid(String userid) {
        return articleMapper.selectArticleByUserid(userid);
    }

    /**
     * 获取userid的总文章数
     *
     * @param map
     * @return
     */
    @Override
    public int getArticleCountByUserid(Map<String, Object> map) {
        return articleMapper.selectArticleCountByUserid(map);
    }

    /**
     * 按fid查询发帖表信息
     *
     * @return
     */
    @Override
    public Article getArticleKey(String fid) {
        return articleMapper.selectArticleByKey(fid);
    }

    /**
     * 按fid查询发帖表信息
     *
     * @param fid
     * @param userid
     * @return
     */
    @Override
    public ArticleImpl getArticleFidUserid(String fid, String userid) {
        Map<String, Object> map = new HashMap<>();
        map.put("fid", fid);
        map.put("userid", userid);
        return articleMapper.selectArticleImplByKeyU(map);
    }

    /**
     * 总贴数
     *
     * @return
     */
    @Override
    public int getCount() {
        return articleMapper.selectCount();
    }

    /**
     * 总贴数
     *
     * @return
     */
    @Override
    public int getPassArticleCountByBid(String bid) {
        return articleMapper.selectPassArticleCountByBid(bid);
    }

    /**
     * 热门文章
     *
     * @return
     */
    @Override
    public List<Article> getHotArticle() {
        return articleMapper.selectHotArticle();
    }

    /**
     * 获取userid用户评论过的文章信息
     *
     * @param map
     * @return
     */
    @Override
    public List<ArticleImpl> getAnswerArticleUserid(Map<String, Object> map) {
        return articleMapper.selectArticleImplByUserid(map);
    }

    /**
     * 获取userid评论过的文章总数
     *
     * @param map
     * @return
     */
    @Override
    public int getAnswerArticleCountByUserid(Map<String, Object> map) {
        return articleMapper.selectArticleImplCountByUserid(map);
    }

    /**
     * 按userid获取收藏的文章信息
     *
     * @param map
     * @return
     */
    @Override
    public List<ArticleImpl> getCollectArticleUserid(Map<String, Object> map) {
        return articleMapper.selectCollectArticleImplByUserid(map);
    }

    /**
     * 获取userid收藏总数
     *
     * @param map
     * @return
     */
    @Override
    public int getCollectCountByUserid(Map<String, Object> map) {
        return articleMapper.selectCollectCountByUserid(map);
    }

}
