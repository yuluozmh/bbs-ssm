package com.liang.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import com.liang.bean.*;
import com.liang.bean.impl.ArticleImpl;
import com.liang.bean.impl.PlateImpl;
import com.liang.code.ReturnT;
import com.liang.service.*;
import com.liang.utils.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@RequestMapping("/api/rest/nansin/v3.0/article")
@RestController
@CrossOrigin
public class ArticleController {
    private static Logger logger = LoggerFactory.getLogger(ArticleController.class);
    @Autowired
    ArticleService articleService;
    @Autowired
    CommentService commentService;
    @Autowired
    CollectService collectService;
    @Autowired
    PlateService plateService;
    @Autowired
    AttentionService attentionService;
    @Autowired
    EnjoyService enjoyService;
    @Autowired
    UserService userService;
    @Autowired
    ViaService viaService;
    @Autowired
    VisitService visitService;
    @Autowired
    FileUploadUtil fileUploadUtil;
    @Autowired
    PathUtil pathUtil;
    @Autowired
    PageUtil pageUtil;

    // 用户系统-文章初始条数（第一页）
    private int articlePageSize;
    // 用户系统-文章追加条数（出第一页外）
    private int articleDefaultPageSize;
    // 管理系统-文章追加条数（出第一页外）
    private int adminArticleDefaultPageSize;

    @PostConstruct
    private void init() {
        articlePageSize = pageUtil.getArticlePageSize();
        articleDefaultPageSize = pageUtil.getArticleDefaultPageSize();
        adminArticleDefaultPageSize = pageUtil.getAdminArticleDefaultPageSize();
    }

    /**
     * 发布文章
     *
     * @param file
     * @param article
     * @param session
     * @return
     */
    @PostMapping("/setArticle")
    public ReturnT<?> setArticle(@RequestParam(value = "picture", required = false) MultipartFile file, Article article, HttpSession session) {
        try {
            long length = articleService.setArticle(file, article, (String) session.getAttribute("userid"));
            if (length == 0) {
                return ReturnT.success("发布文章成功");
            } else {
                return ReturnT.fail("请上传不超过 " + length + "M 的题图!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("发布文章失败");
            return ReturnT.fail("发布文章失败");
        }
    }

    /**
     * 上传图片-editor.md（由于editor.md的特性，使用我们构造好的“ReturnT<?>”不能达到预期效果）
     *
     * @param file
     * @return
     * @throws IOException
     */
    @PostMapping("/uploadPicture")
    public ResponseEntity<Map<String, Object>> uploadPicture(@RequestParam(value = "editormd-image-file", required = false) MultipartFile file) {
        Map<String, Object> map = new HashMap<>();
        try {
            long length = articleService.uploadPicture(file);
            if (length == 0) {
                // 注意：1一定要是数字不能是字符
                map.put("success", 1);
                map.put("message", "上传成功");
                map.put("url", fileUploadUtil.fileUpload(file, pathUtil.getIllustrationPath()));
            } else {
                // 注意：0一定要是数字不能是字符
                map.put("success", 0);
                map.put("message", "请上传不超过 " + length + "M 的图片!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 注意：0一定要是数字不能是字符
            map.put("success", 0);
            map.put("message", "上传失败！");
        }

        return new ResponseEntity(map, HttpStatus.OK);
    }

    /**
     * 按fid删除文章
     *
     * @param fid
     * @return
     */
    @DeleteMapping("/deleteArticle/{fid}")
    public ReturnT<?> deleteArticle(@PathVariable String fid) {
        try {
            // 删除文章
            articleService.deleteArticle(fid);
            return ReturnT.success("删除文章成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("删除文章失败");
        }
    }

    /**
     * 修改文章（更改题图）
     *
     * @param file
     * @param article
     * @return
     */
    @PutMapping("/updateArticle")
    public ReturnT<?> updateArticle(@RequestParam("picture") MultipartFile file, Article article) {
        try {
            long length = articleService.updateArticle(file, article);
            if (length == 0) {
                return ReturnT.success("修改文章成功");
            } else {
                return ReturnT.fail("请上传不超过 " + length + "M 的题图!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("修改文章失败");
        }
    }

    /**
     * 修改文章表（题图未更改）
     *
     * @return
     * @throws IOException
     */
    @PutMapping("/updateArticleNotPhoto")
    public ReturnT<?> updateArticleNotPhoto(Article article) {
        try {
            System.out.println("无图：" + article);
            //修改文章表（数据库）
            articleService.updateArticle(article);
            return ReturnT.success("修改文章成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("修改文章失败");
        }
    }

    /**
     * 更改文章审核状态
     *
     * @return
     */
    @PutMapping("/updateArticleStatus")
    public ReturnT<?> updateArticleStatus(Article article) {
        try {
            articleService.updateArticleStatus(article);
            return ReturnT.success("更改审核状态成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("更改审核状态失败");
        }
    }

    /**
     * 获取文章信息（审核通过）
     *
     * @param session
     * @return
     */
    @GetMapping("/getArticle")
    public ReturnT<?> getArticle(HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<ArticleImpl> articleList = new ArrayList<>();
            // 获取文章数据
            List<ArticleImpl> articles = articleService.getArticle(1, articlePageSize, (String) session.getAttribute("userid"));
            for (ArticleImpl article : articles) {
                article.setEnjoyCount(enjoyService.getCountByFid(article.getFid()));
                article.setCollectCount(collectService.getCountByFid(article.getFid()));
                articleList.add(article);
            }
            map.put("listArticle", articleList);
            map.put("pageStart", 1);

            return new ReturnT<>(HttpStatus.OK, "获取文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取文章数据失败");
        }
    }

    /**
     * 追加更多的文章信息
     *
     * @param bid       板块id
     * @param pageStart 第几页
     * @return
     */
    @GetMapping("/appendMore")
    public ReturnT<?> appendMore(@RequestParam(defaultValue = "") String bid,
                                 @RequestParam(required = true, defaultValue = "1") int pageStart,
                                 HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<ArticleImpl> articleList = new ArrayList<>();
            List<ArticleImpl> listArticle;
            if (bid.isEmpty()) {
                listArticle = articleService.getArticle(pageStart, articleDefaultPageSize, (String) session.getAttribute("userid"));
            } else {
                listArticle = articleService.getArticleBid(bid, pageStart, articleDefaultPageSize, (String) session.getAttribute("userid"));
            }
            for (ArticleImpl article : listArticle) {
                article.setEnjoyCount(enjoyService.getCountByFid(article.getFid()));
                article.setCollectCount(collectService.getCountByFid(article.getFid()));
                articleList.add(article);
            }
            // 获取文章数据
            map.put("listArticle", articleList);
            map.put("pageStart", pageStart);
            return new ReturnT<>(HttpStatus.OK, "文章加载成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("文章加载失败");
        }
    }

    /**
     * 获取文章信息（分页-无条件）
     *
     * @param pageStart
     * @return
     */
    @GetMapping("/getArticleManagement")
    public ReturnT<?> getArticleAdmin(@RequestParam(required = true, defaultValue = "1") int pageStart) {
        Map<String, Object> map = new HashMap<>();
        try {
            // 尾页
            int tail;
            // 总贴数
            int total = articleService.getCount();
            List<ArticleImpl> articleList = new ArrayList<>();
            // 获取文章数据
            List<ArticleImpl> articles = articleService.getArticleAdmin(pageStart, adminArticleDefaultPageSize);
            for (ArticleImpl article : articles) {
                article.setEnjoyCount(enjoyService.getCountByFid(article.getFid()));
                article.setCollectCount(collectService.getCountByFid(article.getFid()));
                articleList.add(article);
            }
            map.put("listArticle", articleList);
            map.put("total", total);
            map.put("pageStart", pageStart);
            map.put("pageSize", adminArticleDefaultPageSize);
            if (total % adminArticleDefaultPageSize == 0) {
                tail = total / adminArticleDefaultPageSize;
                map.put("tail", tail);
            } else {
                tail = (total / adminArticleDefaultPageSize) + 1;
                map.put("tail", tail);
            }
            return new ReturnT<>(HttpStatus.OK, "获取文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取文章数据失败");
        }
    }

    /**
     * 按userid获取文章信息
     *
     * @param userid
     * @return
     */
    @GetMapping("/getArticleUserid/{userid}")
    public ReturnT<?> getArticleUserid(@PathVariable String userid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<Article> listArticle;
            if (userid.equals(session.getAttribute("userid"))) {
                listArticle = articleService.getArticleUserid(userid);
            } else {
                listArticle = articleService.getPassArticleUserid(userid);
            }
            map.put("listArticle", listArticle);
            return new ReturnT<>(HttpStatus.OK, "获取文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取文章数据失败");
        }
    }

    /**
     * 获取userid用户评论过的文章信息
     *
     * @param userid
     * @return
     */
    @GetMapping("/getAnswerArticleUserid/{userid}")
    public ReturnT<?> getAnswerArticleUserid(@PathVariable String userid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("userid", userid);
            map.put("status", true);
            map.put("listArticle_answer", articleService.getAnswerArticleUserid(map));
            map.remove("userid");
            map.remove("status");
            return new ReturnT<>(HttpStatus.OK, "获取评论文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取评论文章数据失败");
        }
    }

    /**
     * 按userid获取收藏的文章信息
     *
     * @param userid
     * @return
     */
    @GetMapping("/getCollectArticleUserid/{userid}")
    public ReturnT<?> getCollectArticleUserid(@PathVariable String userid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("userid", userid);
            map.put("status", true);
            map.put("listArticle_collect", articleService.getCollectArticleUserid(map));
            map.remove("userid");
            map.remove("status");
            return new ReturnT<>(HttpStatus.OK, "获取收藏文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取收藏文章数据失败");
        }
    }

    /**
     * 按文章板块查询文章（通过审核的）
     *
     * @return
     */
    @GetMapping("/getArticleBid/{bid}")
    public ReturnT<?> getArticleBid(@PathVariable String bid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<ArticleImpl> articleList = new ArrayList<>();
            // 获取文章数据
            List<ArticleImpl> articles = articleService.getArticleBid(bid, 1, articlePageSize, (String) session.getAttribute("userid"));
            for (ArticleImpl article : articles) {
                article.setEnjoyCount(enjoyService.getCountByFid(article.getFid()));
                article.setCollectCount(collectService.getCountByFid(article.getFid()));
                articleList.add(article);
            }
            // 获取文章数据
            map.put("listArticle", articleList);
            // 该板块下文章总数
            map.put("plateArticleCount", articleService.getPassArticleCountByBid(bid));
            map.put("pageStart", 1);
            return new ReturnT<>(HttpStatus.OK, "获取该板块下的文章信息成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取该板块下的文章信息失败");
        }
    }

    /**
     * 获取文章和板块信息
     *
     * @param fid
     * @return
     */
    @GetMapping("/getUpdateArticle/{fid}")
    public ReturnT<?> getUpdateArticle(@PathVariable String fid) {
        Map<String, Object> resMap = new HashMap<>();
        try {
            Article article = articleService.getArticleKey(fid);
            // 实体类转Map
            Map<String, Object> map = EntityMapUtils.entityToMap(article);
            // 当前板块
            map.put("currentPlate", plateService.getPlateId(article.getBid()));
            resMap.put("article", map);
            //无条件获取板块信息
            List<PlateImpl> plate = plateService.getPlate();
            resMap.put("plate", plate);
            return new ReturnT<>(HttpStatus.OK, "获取文章和板块信息成功", resMap);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取文章和板块信息失败");
        }
    }

    /**
     * 按fid获取文章信息
     *
     * @return
     */
    @GetMapping("/getArticleFid/{fid}")
    public ReturnT<?> getArticleFid(@PathVariable String fid, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        try {
            // 获取文章数据
            ArticleImpl article = articleService.getArticleFidUserid(fid, (String) session.getAttribute("userid"));
            article.setEnjoyCount(enjoyService.getCountByFid(article.getFid()));
            article.setCollectCount(collectService.getCountByFid(article.getFid()));
            map.put("article", article);
            // 通过fid查找出对应的评论信息
            map.put("listComment", commentService.getCommentImplFid(fid));
            // 热门文章
            map.put("listHotArticle", articleService.getHotArticle());
            // 最新评论
            map.put("listNewComment", commentService.getNewComment());
            // 查询板块信息（无条件）
            map.put("plate", plateService.getPlate());
            // 统计访问信息-国家
            map.put("visitCountryCount", visitService.visitCountryStatistic());
            // 统计访问信息-中国省份
            map.put("visitProvinceCount", visitService.visitProvinceStatistic());
            // 记录（+1）文章访问量
            articleService.updateArticlePV(fid);

            return new ReturnT<>(HttpStatus.OK, "获取文章信息成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取文章信息失败");
        }
    }

    /**
     * 热门文章
     *
     * @return
     */
    @GetMapping("/getHotArticle")
    public ReturnT<?> getHotArticle() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<Article> listHotArticle = articleService.getHotArticle();
            map.put("listHotArticle", listHotArticle);
            return new ReturnT<>(HttpStatus.OK, "获取热门文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取热门文章数据失败");
        }
    }

    /**
     * 获取本站总文章数、总评论数、总访问量
     *
     * @return
     */
    @GetMapping("/getTotalCount")
    public ReturnT<?> getTotalCount() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("articleCount", articleService.getCount());
            map.put("commentCount", commentService.getCount());
            map.put("visitCount", visitService.getCount());
            return new ReturnT<>(HttpStatus.OK, "获取热门文章数据成功", map);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnT.fail("获取热门文章数据失败");
        }
    }
}
