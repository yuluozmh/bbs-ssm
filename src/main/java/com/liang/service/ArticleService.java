package com.liang.service;

import java.util.List;
import java.util.Map;

import com.liang.bean.impl.ArticleImpl;
import com.liang.bean.Article;
import org.springframework.web.multipart.MultipartFile;

public interface ArticleService {
    /**
     * 向数据库插入发帖信息
     *
     * @param file
     * @param article
     * @param userid
     * @return
     * @throws Exception
     */
    long setArticle(MultipartFile file, Article article, String userid) throws Exception;

    /**
     * 上传图片-editor.md
     *
     * @param file
     * @return
     * @throws Exception
     */
    long uploadPicture(MultipartFile file) throws Exception;

    /**
     * 按fid删除文章
     *
     * @param fid
     */
    void deleteArticle(String fid);

    /**
     * 删除用户对应的文章信息(按userid)
     *
     * @param userid
     */
    void deleteArticleUserid(String userid);

    /**
     * 修改文章
     *
     * @param file
     * @param article
     * @throws Exception
     */
    long updateArticle(MultipartFile file, Article article) throws Exception;

    /**
     * 修改文章（无图）
     *
     * @param article
     * @throws Exception
     */
    void updateArticle(Article article);

    /**
     * 更改文章审核状态
     *
     * @param article
     */
    void updateArticleStatus(Article article);

    /**
     * 记录（+1）文章访问量
     *
     * @param fid
     */
    void updateArticlePV(String fid);

    /**
     * 获取发帖表信息（分页）
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    List<ArticleImpl> getArticle(int pageStart, int pageSize, String userid);

    /**
     * 获取发帖表信息（分页）
     *
     * @param bid       按板块查询
     * @param pageStart
     * @param pageSize
     * @return
     */
    List<ArticleImpl> getArticleBid(String bid, int pageStart, int pageSize, String userid);

    /**
     * 查询发帖表信息（分页）-管理员
     *
     * @param pageStart
     * @param pageSize
     * @return
     */
    List<ArticleImpl> getArticleAdmin(int pageStart, int pageSize);

    /**
     * 按userid查询发帖表信息（通过审核）
     *
     * @param userid
     * @return
     */
    List<Article> getPassArticleUserid(String userid);

    /**
     * 按userid获取文章信息（所有审核状态）
     *
     * @param userid
     * @return
     */
    List<Article> getArticleUserid(String userid);

    /**
     * 获取userid的总文章数
     *
     * @param map
     * @return
     */
    int getArticleCountByUserid(Map<String, Object> map);

    /**
     * 按fid查询发帖表信息
     *
     * @return
     */
    Article getArticleKey(String fid);

    /**
     * 按fid查询发帖表信息
     *
     * @param fid
     * @param userid
     * @return
     */
    ArticleImpl getArticleFidUserid(String fid, String userid);

    /**
     * 总贴数
     *
     * @return
     */
    int getCount();

    /**
     * 总贴数
     *
     * @return
     */
    int getPassArticleCountByBid(String bid);

    /**
     * 热门文章
     *
     * @return
     */
    List<Article> getHotArticle();

    /**
     * 获取userid用户评论过的文章信息
     *
     * @param map
     * @return
     */
    List<ArticleImpl> getAnswerArticleUserid(Map<String, Object> map);

    /**
     * 获取userid评论过的文章总数
     *
     * @param map
     * @return
     */
    int getAnswerArticleCountByUserid(Map<String, Object> map);

    /**
     * 按userid获取收藏的文章信息
     *
     * @param map
     * @return
     */
    List<ArticleImpl> getCollectArticleUserid(Map<String, Object> map);

    /**
     * 获取userid收藏总数
     *
     * @param map
     * @return
     */
    int getCollectCountByUserid(Map<String, Object> map);

}
