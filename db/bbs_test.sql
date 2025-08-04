/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : 127.0.0.1:3306
 Source Schema         : bbs_test

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 04/08/2025 12:49:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `aid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员id',
  `aname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员姓名',
  `apassword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理员密码',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('20191229183631-d938dd63de7f45fb9ebe131c4156441c', 'admin', 'admin', '2016-12-10 12:43:08', '2025-08-04 12:43:08');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章id',
  `titles` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `fcontent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章图片',
  `bid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属板块id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '写文章人id',
  `status` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT 00000000000 COMMENT '文章审核状态(0为等待审核，1为审核通过，2为审核拒绝，默认为0)',
  `pv` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT 00000000000 COMMENT '文章浏览量',
  `create_time` datetime NOT NULL COMMENT '文章创建时间',
  `update_time` datetime NOT NULL COMMENT '文章更新时间',
  PRIMARY KEY (`fid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `bid`(`bid` ASC) USING BTREE,
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `plate` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '发帖表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('20220408151450-db6770b5b17d417d81fb8f408899ac59', '神器 SpringDoc 横空出世！最适合 SpringBoot 的API文档工具来了！', '# 神器 SpringDoc 横空出世！最适合 SpringBoot 的API文档工具来了！\r\n\r\n> 之前在SpringBoot项目中一直使用的是SpringFox提供的Swagger库，上了下官网发现已经有接近两年没出新版本了！前几天[升级了SpringBoot 2.6.x](https://juejin.cn/post/7077731765737472037) 版本，发现这个库的兼容性也越来越不好了，有的常用注解属性被废弃了居然都没提供替代！无意中发现了另一款Swagger库`SpringDoc`，试用了一下非常不错，推荐给大家！\r\n\r\n## SpringDoc简介\r\n\r\nSpringDoc是一款可以结合SpringBoot使用的API文档生成工具，基于`OpenAPI 3`，目前在Github上已有`1.7K+Star`，更新发版还是挺勤快的，是一款更好用的Swagger库！值得一提的是SpringDoc不仅支持Spring WebMvc项目，还可以支持Spring WebFlux项目，甚至Spring Rest和Spring Native项目，总之非常强大，下面是一张SpringDoc的架构图。\r\n\r\n\r\n\r\n## 使用\r\n\r\n> 接下来我们介绍下SpringDoc的使用，使用的是之前集成SpringFox的`mall-tiny-swagger`项目，我将把它改造成使用SpringDoc。\r\n\r\n### 集成\r\n\r\n> 首先我们得集成SpringDoc，在`pom.xml`中添加它的依赖即可，开箱即用，无需任何配置。\r\n\r\n```xml\r\n<!--springdoc 官方Starter-->\r\n<dependency>\r\n    <groupId>org.springdoc</groupId>\r\n    <artifactId>springdoc-openapi-ui</artifactId>\r\n    <version>1.6.6</version>\r\n</dependency>\r\n```\r\n\r\n### 从SpringFox迁移\r\n\r\n- 我们先来看下经常使用的Swagger注解，看看SpringFox的和SpringDoc的有啥区别，毕竟对比已学过的技术能该快掌握新技术；\r\n\r\n| SpringFox                                   | SpringDoc                                                    |\r\n| ------------------------------------------- | ------------------------------------------------------------ |\r\n| @Api                                        | @Tag                                                         |\r\n| @ApiIgnore                                  | @Parameter(hidden = true)`or`@Operation(hidden = true)`or`@Hidden |\r\n| @ApiImplicitParam                           | @Parameter                                                   |\r\n| @ApiImplicitParams                          | @Parameters                                                  |\r\n| @ApiModel                                   | @Schema                                                      |\r\n| @ApiModelProperty                           | @Schema                                                      |\r\n| @ApiOperation(value = \"foo\", notes = \"bar\") | @Operation(summary = \"foo\", description = \"bar\")             |\r\n| @ApiParam                                   | @Parameter                                                   |\r\n| @ApiResponse(code = 404, message = \"foo\")   | ApiResponse(responseCode = \"404\", description = \"foo\")       |\r\n\r\n- 接下来我们对之前Controller中使用的注解进行改造，对照上表即可，之前在`@Api`注解中被废弃了好久又没有替代的`description`属性终于被支持了！\r\n\r\n```java\r\n/**\r\n * 品牌管理Controller\r\n * Created by macro on 2019/4/19.\r\n */\r\n@Tag(name = \"PmsBrandController\", description = \"商品品牌管理\")\r\n@Controller\r\n@RequestMapping(\"/brand\")\r\npublic class PmsBrandController {\r\n    @Autowired\r\n    private PmsBrandService brandService;\r\n\r\n    private static final Logger LOGGER = LoggerFactory.getLogger(PmsBrandController.class);\r\n\r\n    @Operation(summary = \"获取所有品牌列表\",description = \"需要登录后访问\")\r\n    @RequestMapping(value = \"listAll\", method = RequestMethod.GET)\r\n    @ResponseBody\r\n    public CommonResult<List<PmsBrand>> getBrandList() {\r\n        return CommonResult.success(brandService.listAllBrand());\r\n    }\r\n\r\n    @Operation(summary = \"添加品牌\")\r\n    @RequestMapping(value = \"/create\", method = RequestMethod.POST)\r\n    @ResponseBody\r\n    @PreAuthorize(\"hasRole(\'ADMIN\')\")\r\n    public CommonResult createBrand(@RequestBody PmsBrand pmsBrand) {\r\n        CommonResult commonResult;\r\n        int count = brandService.createBrand(pmsBrand);\r\n        if (count == 1) {\r\n            commonResult = CommonResult.success(pmsBrand);\r\n            LOGGER.debug(\"createBrand success:{}\", pmsBrand);\r\n        } else {\r\n            commonResult = CommonResult.failed(\"操作失败\");\r\n            LOGGER.debug(\"createBrand failed:{}\", pmsBrand);\r\n        }\r\n        return commonResult;\r\n    }\r\n\r\n    @Operation(summary = \"更新指定id品牌信息\")\r\n    @RequestMapping(value = \"/update/{id}\", method = RequestMethod.POST)\r\n    @ResponseBody\r\n    @PreAuthorize(\"hasRole(\'ADMIN\')\")\r\n    public CommonResult updateBrand(@PathVariable(\"id\") Long id, @RequestBody PmsBrand pmsBrandDto, BindingResult result) {\r\n        CommonResult commonResult;\r\n        int count = brandService.updateBrand(id, pmsBrandDto);\r\n        if (count == 1) {\r\n            commonResult = CommonResult.success(pmsBrandDto);\r\n            LOGGER.debug(\"updateBrand success:{}\", pmsBrandDto);\r\n        } else {\r\n            commonResult = CommonResult.failed(\"操作失败\");\r\n            LOGGER.debug(\"updateBrand failed:{}\", pmsBrandDto);\r\n        }\r\n        return commonResult;\r\n    }\r\n\r\n    @Operation(summary = \"删除指定id的品牌\")\r\n    @RequestMapping(value = \"/delete/{id}\", method = RequestMethod.GET)\r\n    @ResponseBody\r\n    @PreAuthorize(\"hasRole(\'ADMIN\')\")\r\n    public CommonResult deleteBrand(@PathVariable(\"id\") Long id) {\r\n        int count = brandService.deleteBrand(id);\r\n        if (count == 1) {\r\n            LOGGER.debug(\"deleteBrand success :id={}\", id);\r\n            return CommonResult.success(null);\r\n        } else {\r\n            LOGGER.debug(\"deleteBrand failed :id={}\", id);\r\n            return CommonResult.failed(\"操作失败\");\r\n        }\r\n    }\r\n\r\n    @Operation(summary = \"分页查询品牌列表\")\r\n    @RequestMapping(value = \"/list\", method = RequestMethod.GET)\r\n    @ResponseBody\r\n    @PreAuthorize(\"hasRole(\'ADMIN\')\")\r\n    public CommonResult<CommonPage<PmsBrand>> listBrand(@RequestParam(value = \"pageNum\", defaultValue = \"1\")\r\n                                                        @Parameter(description = \"页码\") Integer pageNum,\r\n                                                        @RequestParam(value = \"pageSize\", defaultValue = \"3\")\r\n                                                        @Parameter(description = \"每页数量\") Integer pageSize) {\r\n        List<PmsBrand> brandList = brandService.listBrand(pageNum, pageSize);\r\n        return CommonResult.success(CommonPage.restPage(brandList));\r\n    }\r\n\r\n    @Operation(summary = \"获取指定id的品牌详情\")\r\n    @RequestMapping(value = \"/{id}\", method = RequestMethod.GET)\r\n    @ResponseBody\r\n    @PreAuthorize(\"hasRole(\'ADMIN\')\")\r\n    public CommonResult<PmsBrand> brand(@PathVariable(\"id\") Long id) {\r\n        return CommonResult.success(brandService.getBrand(id));\r\n    }\r\n}\r\n```\r\n\r\n- 接下来进行SpringDoc的配置，使用`OpenAPI`来配置基础的文档信息，通过`GroupedOpenApi`配置分组的API文档，SpringDoc支持直接使用接口路径进行配置。\r\n\r\n```java\r\n/**\r\n * SpringDoc API文档相关配置\r\n * Created by macro on 2022/3/4.\r\n */\r\n@Configuration\r\npublic class SpringDocConfig {\r\n    @Bean\r\n    public OpenAPI mallTinyOpenAPI() {\r\n        return new OpenAPI()\r\n                .info(new Info().title(\"Mall-Tiny API\")\r\n                        .description(\"SpringDoc API 演示\")\r\n                        .version(\"v1.0.0\")\r\n                        .license(new License().name(\"Apache 2.0\").url(\"https://github.com/macrozheng/mall-learning\")))\r\n                .externalDocs(new ExternalDocumentation()\r\n                        .description(\"SpringBoot实战电商项目mall（50K+Star）全套文档\")\r\n                        .url(\"http://www.macrozheng.com\"));\r\n    }\r\n\r\n    @Bean\r\n    public GroupedOpenApi publicApi() {\r\n        return GroupedOpenApi.builder()\r\n                .group(\"brand\")\r\n                .pathsToMatch(\"/brand/**\")\r\n                .build();\r\n    }\r\n\r\n    @Bean\r\n    public GroupedOpenApi adminApi() {\r\n        return GroupedOpenApi.builder()\r\n                .group(\"admin\")\r\n                .pathsToMatch(\"/admin/**\")\r\n                .build();\r\n    }\r\n}\r\n```\r\n\r\n### 结合SpringSecurity使用\r\n\r\n- 由于我们的项目集成了SpringSecurity，需要通过JWT认证头进行访问，我们还需配置好SpringDoc的白名单路径，主要是Swagger的资源路径；\r\n\r\n```java\r\n/**\r\n * SpringSecurity的配置\r\n * Created by macro on 2018/4/26.\r\n */\r\n@Configuration\r\n@EnableWebSecurity\r\n@EnableGlobalMethodSecurity(prePostEnabled = true)\r\npublic class SecurityConfig extends WebSecurityConfigurerAdapter {                                              \r\n\r\n    @Override\r\n    protected void configure(HttpSecurity httpSecurity) throws Exception {\r\n        httpSecurity.csrf()// 由于使用的是JWT，我们这里不需要csrf\r\n                .disable()\r\n                .sessionManagement()// 基于token，所以不需要session\r\n                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)\r\n                .and()\r\n                .authorizeRequests()\r\n                .antMatchers(HttpMethod.GET, // Swagger的资源路径需要允许访问\r\n                        \"/\",   \r\n                        \"/swagger-ui.html\",\r\n                        \"/swagger-ui/\",\r\n                        \"/*.html\",\r\n                        \"/favicon.ico\",\r\n                        \"/**/*.html\",\r\n                        \"/**/*.css\",\r\n                        \"/**/*.js\",\r\n                        \"/swagger-resources/**\",\r\n                        \"/v3/api-docs/**\"\r\n                )\r\n                .permitAll()\r\n                .antMatchers(\"/admin/login\")// 对登录注册要允许匿名访问\r\n                .permitAll()\r\n                .antMatchers(HttpMethod.OPTIONS)//跨域请求会先进行一次options请求\r\n                .permitAll()\r\n                .anyRequest()// 除上面外的所有请求全部需要鉴权认证\r\n                .authenticated();\r\n        \r\n    }\r\n\r\n}\r\n```\r\n\r\n- 然后在`OpenAPI`对象中通过`addSecurityItem`方法和`SecurityScheme`对象，启用基于JWT的认证功能。\r\n\r\n```java\r\n/**\r\n * SpringDoc API文档相关配置\r\n * Created by macro on 2022/3/4.\r\n */\r\n@Configuration\r\npublic class SpringDocConfig {\r\n    private static final String SECURITY_SCHEME_NAME = \"BearerAuth\";\r\n    @Bean\r\n    public OpenAPI mallTinyOpenAPI() {\r\n        return new OpenAPI()\r\n                .info(new Info().title(\"Mall-Tiny API\")\r\n                        .description(\"SpringDoc API 演示\")\r\n                        .version(\"v1.0.0\")\r\n                        .license(new License().name(\"Apache 2.0\").url(\"https://github.com/macrozheng/mall-learning\")))\r\n                .externalDocs(new ExternalDocumentation()\r\n                        .description(\"SpringBoot实战电商项目mall（50K+Star）全套文档\")\r\n                        .url(\"http://www.macrozheng.com\"))\r\n                .addSecurityItem(new SecurityRequirement().addList(SECURITY_SCHEME_NAME))\r\n                .components(new Components()\r\n                                .addSecuritySchemes(SECURITY_SCHEME_NAME,\r\n                                        new SecurityScheme()\r\n                                                .name(SECURITY_SCHEME_NAME)\r\n                                                .type(SecurityScheme.Type.HTTP)\r\n                                                .scheme(\"bearer\")\r\n                                                .bearerFormat(\"JWT\")));\r\n    }\r\n}\r\n```\r\n\r\n### 测试\r\n\r\n- 接下来启动项目就可以访问Swagger界面了，访问地址：[http://localhost:8088/swagger-ui.html](https://link.juejin.cn/?target=http%3A%2F%2Flocalhost%3A8088%2Fswagger-ui.html)\r\n\r\n\r\n\r\n- 我们先通过登录接口进行登录，可以发现这个版本的Swagger返回结果是支持高亮显示的，版本明显比SpringFox来的新；\r\n\r\n\r\n\r\n- 然后通过认证按钮输入获取到的认证头信息，注意这里不用加`bearer`前缀；\r\n\r\n\r\n\r\n- 之后我们就可以愉快地访问需要登录认证的接口了；\r\n\r\n\r\n\r\n- 看一眼请求参数的文档说明，还是熟悉的Swagger样式！\r\n\r\n\r\n\r\n### 常用配置\r\n\r\nSpringDoc还有一些常用的配置可以了解下，更多配置可以参考官方文档。\r\n\r\n```yaml\r\nspringdoc:\r\n  swagger-ui:\r\n    # 修改Swagger UI路径\r\n    path: /swagger-ui.html\r\n    # 开启Swagger UI界面\r\n    enabled: true\r\n  api-docs:\r\n    # 修改api-docs路径\r\n    path: /v3/api-docs\r\n    # 开启api-docs\r\n    enabled: true\r\n  # 配置需要生成接口文档的扫描包\r\n  packages-to-scan: com.macro.mall.tiny.controller\r\n  # 配置需要生成接口文档的接口路径\r\n  paths-to-match: /brand/**,/admin/**\r\n```\r\n\r\n## 总结\r\n\r\n在SpringFox的Swagger库好久不出新版的情况下，迁移到SpringDoc确实是一个更好的选择。今天体验了一把SpringDoc，确实很好用，和之前熟悉的用法差不多，学习成本极低。而且SpringDoc能支持WebFlux之类的项目，功能也更加强大，使用SpringFox有点卡手的朋友可以迁移到它试试！', 'https://aid.nansin.top/default/ssm/article-20220408151450_SpringDoc2.png', '32', '101', 00000000001, 00000000183, '2025-08-04 15:14:50', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention`  (
  `gid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关注表id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主动关注者的id',
  `beuserid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被动关注者的id',
  `create_time` datetime NOT NULL COMMENT '关注时间',
  PRIMARY KEY (`gid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `beuserid`(`beuserid` ASC) USING BTREE,
  CONSTRAINT `attention_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `attention_ibfk_2` FOREIGN KEY (`beuserid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '关注表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attention
-- ----------------------------

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `sid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收藏表id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收藏者id',
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被收藏帖子id',
  `create_time` datetime NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`sid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `fid`(`fid` ASC) USING BTREE,
  CONSTRAINT `collect_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collect_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `article` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `pid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论id',
  `pcontent` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论者',
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被评论帖子id',
  `create_time` datetime NOT NULL COMMENT '评论创建时间',
  `update_time` datetime NOT NULL COMMENT '评论更新时间',
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `fid`(`fid` ASC) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `article` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for enjoy
-- ----------------------------
DROP TABLE IF EXISTS `enjoy`;
CREATE TABLE `enjoy`  (
  `eid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '点赞id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '点赞者id',
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被点赞帖子id',
  `create_time` datetime NOT NULL COMMENT '点赞时间',
  PRIMARY KEY (`eid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `fid`(`fid` ASC) USING BTREE,
  CONSTRAINT `enjoy_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enjoy_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `article` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '点赞（欣赏）表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of enjoy
-- ----------------------------

-- ----------------------------
-- Table structure for photo_pro
-- ----------------------------
DROP TABLE IF EXISTS `photo_pro`;
CREATE TABLE `photo_pro`  (
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '相册id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '相册名',
  `create_time` datetime NOT NULL COMMENT '相册创建时间',
  `update_time` datetime NOT NULL COMMENT '相册更新时间',
  PRIMARY KEY (`fid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  CONSTRAINT `photo_pro_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '相册' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of photo_pro
-- ----------------------------
INSERT INTO `photo_pro` VALUES ('20200619221421-388d985f0cb64bd7817a2375819de62b', '101', '相册', '2025-08-04 15:14:50', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for plate
-- ----------------------------
DROP TABLE IF EXISTS `plate`;
CREATE TABLE `plate`  (
  `bid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '板块id',
  `bname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '板块名字',
  `create_time` datetime NOT NULL COMMENT '板块创建时间',
  `update_time` datetime NOT NULL COMMENT '板块更新时间',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '板块表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of plate
-- ----------------------------
INSERT INTO `plate` VALUES ('2', 'C++', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('22', '前端', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('23', '运维', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('24', '架构', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('26', 'github', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('27', 'C#', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('28', '发发神经', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('29', '英语', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('3', 'Python', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('30', '搞笑', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('32', 'java', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('35', '诗词', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('36', '历史', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('37', '歌曲', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('38', '杂说', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('39', '游戏', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('40', '公告', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('45', '推荐', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('46', '插件', '2025-08-04 15:14:50', '2025-08-04 15:14:50');
INSERT INTO `plate` VALUES ('47', '中国', '2025-08-04 15:14:50', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for slider
-- ----------------------------
DROP TABLE IF EXISTS `slider`;
CREATE TABLE `slider`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文字内容',
  `text_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文字url',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '轮播图对应链接',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of slider
-- ----------------------------
INSERT INTO `slider` VALUES (11, '测试001', '#', 'https://aid.nansin.top/default/ssm/slider-20200706000714_1.png', '2025-08-04 15:14:50');
INSERT INTO `slider` VALUES (12, '测试001', '#', 'https://aid.nansin.top/default/ssm/slider-20200706001324_3.png', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for soup
-- ----------------------------
DROP TABLE IF EXISTS `soup`;
CREATE TABLE `soup`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '毒鸡汤内容',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of soup
-- ----------------------------
INSERT INTO `soup` VALUES (1, '想好了的是假象，认真的做了也没前途。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (2, '没有人关心你飞得多高，倒是有一群人，等着看你摔得多惨。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (3, '以前觉得靠关系的人，一定很无能，接触后发现人家样样比我强。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (4, '能从上到下摸遍你全身的，也就只有，车站安检员了。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (5, '这年头，哪有不分手的恋爱，只有不伤手的立白。遇事得看开一点。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (6, '纵然人生坎坷，但我从不向命运屈服！我通常都是直接屈膝Orz。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (7, '遇到闪电记得要微笑，因为那是天空在给你拍照。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (8, '跟丑这个缺点比，穷根本不值得一提。', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (9, '世界上没有无缘无故的爱，也没有无缘无故的恨，却TM偏偏有无缘无故的胖！', '2025-08-04 15:14:50');
INSERT INTO `soup` VALUES (10, '要笑着走下去吧，反正来到这个世界上，谁也没打算活着回去。', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for tb_photo
-- ----------------------------
DROP TABLE IF EXISTS `tb_photo`;
CREATE TABLE `tb_photo`  (
  `xid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '照片id',
  `fid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '相册id',
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '照片',
  `create_time` datetime NOT NULL COMMENT '照片上传时间',
  PRIMARY KEY (`xid`) USING BTREE,
  INDEX `fid`(`fid` ASC) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  CONSTRAINT `tb_photo_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `photo_pro` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_photo_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_photo
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户姓名',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `sex` int NULL DEFAULT NULL COMMENT '性别(0=男，1=女)',
  `password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户email',
  `family` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户住址',
  `intro` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_time` datetime NOT NULL COMMENT '用户注册时间',
  `update_time` datetime NOT NULL COMMENT '用户更新时间',
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('101', '马亮南生', 24, 0, '123456', '924818949@qq.com', '四川广元青川', '弱者才言命，强者只言运！', '2025-08-04 15:14:50', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for via
-- ----------------------------
DROP TABLE IF EXISTS `via`;
CREATE TABLE `via`  (
  `userid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户头像',
  `update_time` datetime NOT NULL COMMENT '头像更新时间',
  PRIMARY KEY (`userid`) USING BTREE,
  CONSTRAINT `via_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '头像表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of via
-- ----------------------------
INSERT INTO `via` VALUES ('101', 'https://aid.nansin.top/default/ssm/user-20200603230008_19.png', '2025-08-04 15:14:50');

-- ----------------------------
-- Table structure for visit
-- ----------------------------
DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit`  (
  `VisitID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问记录编号',
  `VisitURL` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者地址',
  `VisitIP` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者ip',
  `VisitCountry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者所在国家',
  `VisitProvince` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者省份',
  `VisitCity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者城市',
  `VisitHostName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主机名',
  `VisitOS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '访问者操作系统',
  `VisitTime` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`VisitID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '访问记录表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of visit
-- ----------------------------
INSERT INTO `visit` VALUES ('20210420120430-287263731e644ca9be86149024aa56e7', NULL, '13.125.229.139', '韩国', '首尔', '亚马逊云', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420140115-d01bb5ce7bba4ed0a0b72af2665fcb12', NULL, '123.152.213.66', '中国', '浙江', '宁波', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420170356-3b8e78c5655342d4a573814d1a0e9d23', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420170936-7cf90a5ab5a1483d85820660627d601a', NULL, '14.211.18.150', '中国', '广东', '中山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420171526-3954432eb33042dd879bc459e3aa3944', NULL, '116.11.9.37', '中国', '广西', '北海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420172228-9fa1773d55e045979aadf76ab0a137df', NULL, '49.93.19.128', '中国', '江苏', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420190930-da3ef7a42334453ca6658512d4f5abc8', NULL, '17.121.112.77', '美国', '001', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420202748-e7a1b119e0d3459eba529f6de695e8e1', NULL, '195.154.122.204', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420210348-a3472fb800fc40e88f6ded62bd195a99', NULL, '116.179.37.3', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420210356-61c40884f92a4489866810fd19a0fa54', NULL, '111.206.221.45', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210420234459-0d787d47a74342e98428751873851035', NULL, '202.98.13.141', '中国', '吉林', '长春', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421000727-997a891f2fb945c1bbe179b8e07c9ae4', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421005419-811433f0231949a2a7f9e4a1dd55f8d9', NULL, '120.228.3.54', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421070302-c751ad7d96b94e7a8f31ee48a1b2e625', NULL, '93.119.105.80', '罗马尼亚', '0040', NULL, 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421081315-21749764ab0b437889bfade07afef6d8', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421081906-9121f63b3ec4485680d76e72d2ca8e44', NULL, '61.156.32.36', '中国', '山东', '日照', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421081951-5b609df2a0b44d4091be3152f9a02f9c', NULL, '180.163.220.4', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421082024-39a478104bbb4ac68ec8ef60ac94518f', NULL, '180.163.220.4', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421083617-ac42efd92b5f42b7a6c34dee47f3d669', NULL, '223.104.185.6', '中国', '山东', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421130233-e326fba085064a488d2425fd747344cd', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421141942-cb4fe631e58849799bbb23c8f6cefcb1', NULL, '20.41.99.211', '韩国', '首尔', '微软云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421150303-830a73cfee274d6a837987ebeb8d2554', NULL, '182.97.248.205', '中国', '江西', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421154841-50104d7062134ccfb241c9fd5b54c9bf', NULL, '123.14.88.64', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421164746-69082d9062924870a95fa0069be03a44', NULL, '195.154.122.204', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421183520-5da1e959a4394845ab6972aedef1c0d7', NULL, '121.4.138.66', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421194956-ab44b89f69314bbb83fdb1ce302119d7', NULL, '111.60.28.174', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421195210-82dd0c70576f4339aafdd324470961cf', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421200507-8ac3604b698e4588ba622ae1700027e3', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421200652-82f25a2d83184340a45084ed3ab51b85', NULL, '221.195.51.12', '中国', '河北', '沧州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421201045-d99f41f3d61d48499e35a97ba0f6e1f9', NULL, '117.152.69.108', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421202823-0626c80ef540413d88fa1ed82b69f1de', NULL, '113.108.77.56', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421203449-75ec2eaacf594a97bc28ada89d794aaa', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421204026-051727d18e1548e699237e110b420922', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421210217-84ae7dcfce1d409ba9a958b04a2c5fe7', NULL, '61.136.151.253', '中国', '湖北', '宜昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421212316-e9c4d08e14b743d4b67e1bfb4fa00e3c', NULL, '112.97.57.9', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421213514-88dd170a1af348da9528fbf293f59cc0', NULL, '112.224.136.247', '中国', '山东', '烟台', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421222317-f2f4493e4b8e43f2aeeb9d2e836c1af7', NULL, '61.136.151.252', '中国', '湖北', '宜昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210421223147-19fdbe943187452b95b0103f230b5bbe', NULL, '122.192.11.170', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422004322-7f6652fcdb994cf7a4891b47079aae51', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422041655-5f7125b279be4819985300950fc681f8', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422071650-f614b819db5e4ecc8bcc817109be16a1', NULL, '61.136.151.253', '中国', '湖北', '宜昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422085213-8c73b5c7ab2f4c4bac559bfe3b9614ca', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422094945-ec71993794744f8eaaa3d531efb268b9', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422114353-6265c9855a5449f7bc010ed524ea28ab', NULL, '117.152.69.108', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422114943-9a9868fe8d324b1aad54c18a83d46704', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422142205-fdd9faef798841d2bf8ee8617668796f', NULL, '183.238.225.42', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422145252-2a12f8a38dcf4d4f9979205eabde1ccb', NULL, '173.82.238.243', '美国', '加利福尼亚', '洛杉矶', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422160233-3c3a57dba0654f6b8313619eb13521fd', NULL, '112.17.99.6', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422160954-4d52351a3a0643aca25cac5ea23afd08', NULL, '35.243.98.153', '日本', '东京', '谷歌云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422161152-86bdb8889fd2414abecb1c33b80e8e63', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422161840-a7cc8b543000406792fb1b0146755715', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422200617-d680a4475f0843afb38e9fd16696e400', NULL, '122.96.34.5', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422200846-c73fdf6872de4c8abfdda3e75268eae4', NULL, '112.47.232.240', '中国', '福建', '泉州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422220934-5d9a07ef311e45d781022197026c3e8a', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422222552-21d2823dd4a74d94897fb7b775281916', NULL, '122.96.34.5', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422224214-be508261e8c04376a2f77355decd558f', NULL, '112.10.137.50', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422224652-9380cd635a974ab385892ca82e6b3a28', NULL, '122.96.34.5', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422224829-2c89022220024b22b1e1595730c155f8', NULL, '117.172.254.224', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210422232302-4c0da2326c914b82b00fe3db2d6f5f48', NULL, '122.96.34.5', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423004243-989bb9a303354809bfd8d18d50eafe06', NULL, '119.119.172.207', '中国', '辽宁', '沈阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423060230-2009c5c2071c49ef843e3a8ac966d6fb', NULL, '195.154.122.204', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423083744-7eafc94702eb487ca42b55689ca191ac', NULL, '110.53.91.245', '中国', '湖南', '衡阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423110855-639dd4dbfadc46409c42c755a4acb8fe', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423120205-997aa33a326243a49cf7b3769290f26c', NULL, '116.30.198.91', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423133154-ef244150b7cd4827bab51890576d8244', NULL, '119.4.252.5', '中国', '四川', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423134655-7996c8be77254cc1be0fe13cdb213bc3', NULL, '117.178.115.28', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423135259-438a032db98f438e9ac2eee709e61311', NULL, '117.178.115.28', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423140431-2e827a24c7754008bdc4d79bf295faa2', NULL, '61.158.149.219', '中国', '河南', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423142203-9e5180e2256044b5be6e5aaa65240111', NULL, '218.104.71.166', '中国', '安徽', '合肥', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423145027-9f4e004dcb1240adb8325eea6f979d2b', NULL, '223.104.193.2', '中国', '山东', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423150726-f2af13a6dcda4a328ceb4079e7bfa102', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423161413-95d0e4bcc1894985a6149df98303b8eb', NULL, '223.104.193.2', '中国', '山东', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423175013-caea478aa6834d50aee672b1535d7a31', NULL, '223.104.187.138', '中国', '山东', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423184546-b2710c695b9d401f99cc5c177b68157b', NULL, '106.9.75.21', '中国', '河北', '电信', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423195537-a956b068dc714a3aa89113049fa8db94', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423212931-046c0db4419e46c59b8d9b05f4ef548f', NULL, '218.81.8.90', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423220816-98234e2aef954217af52acb61c2e20a9', NULL, '125.47.85.226', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423225216-2b2243166e1a41dd94a5ea77f9bea54d', NULL, '1.198.19.9', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210423230148-7df340f280eb475cb92b50617716f3ae', NULL, '223.107.140.37', '中国', '江苏', '盐城', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424022258-24f5671e9f914b148f8ee79a217f0850', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424060952-575e9a69eae243d8ae0ae65a13b16512', NULL, '183.208.36.82', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424061740-839a7665a29c4621a6c6351ebfc36d85', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424093810-5922e0493fa04d738eca382e9dae97f1', NULL, '112.211.48.211', '菲律宾', 'PLDT', '0063', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424101807-7174ae5acb3145489f8012ac4974fa8e', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424112636-5a1649f678784ffea65711f81b4a2f21', NULL, '159.75.215.53', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424130420-c39326ced6c14bd6ac8c7e0165957da7', NULL, '119.4.252.5', '中国', '四川', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424131515-b8363394aefb47eca529ddb5b1a37cd6', NULL, '223.104.147.236', '中国', '江苏', '连云港', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424140309-6e461713ec4f40618ad6f03d043bdc90', NULL, '223.90.32.143', '中国', '河南', '焦作', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424141707-4eec3c2826014f8db9593090a73033b8', NULL, '111.187.1.239', '中国', '上海', '杨浦', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424143042-5af19999181c4171b6203ec5ba23e858', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424175807-0ed5d351964748b5ad1fd7a9a65516cb', NULL, '222.178.202.93', '中国', '重庆', '荣昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424180109-761a2ec9576b45758af302c66cb62a04', NULL, '223.104.20.230', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424183925-34899db92f8c4c0c9e4a149c61fc5485', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424215706-723af2f94b9d4c0fb0cb0ce454997421', NULL, '122.192.11.209', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424230556-0d0ddead4b9c451c8eff45e472273ff9', NULL, '195.154.122.204', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210424231437-d80ed55a7ade48bf823dfa5063b86ef4', NULL, '112.32.171.79', '中国', '安徽', '阜阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425004830-285c5209d7fc432fb955e136f7d36256', NULL, '40.77.188.15', '美国', '伊利诺斯', '芝加哥', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425020056-11caa3806ca54584a36918d040e3ebc2', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425080202-c8cd341c1fe14531a491e7845c67c0f1', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425085521-7180c808bbae46ceb0a6d05f660ec6b0', NULL, '111.33.154.14', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425100111-e9480dde11fb48a793a17f5d61f7e0f2', NULL, '220.196.50.230', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425102500-e9bcf9d6fb864ffe8a888d7c649b7d15', NULL, '117.136.81.148', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425111710-84df84949acf42689452cb7555a59436', NULL, '42.179.205.180', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425112042-61dcb4cf46f449af9a33df366da31b85', NULL, '111.26.180.84', '中国', '吉林', '吉林', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425124254-f5b234d7aa714a1a9d5cde01ec9f4472', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425145318-1fed2f8bc34146cdbc796122acb66586', NULL, '218.205.55.243', '中国', '浙江', '宁波', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425152433-e39826724643493baf1b76733a9fdfbe', NULL, '117.136.46.219', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425152649-d5a27f8bf00544e5a7d16389ede51a94', NULL, '117.147.19.54', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425152846-81a5d0b655074ac9bc6d80cea81b90b4', NULL, '117.147.19.54', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425153745-09890d8426eb4452a34cddd2fc7e8e51', NULL, '51.77.246.67', '法国', '上法兰西', 'OVH', 'yisu-5f1931fe50f10', ' Dataprovider.com)', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425161744-bbf76b58945e46e09b58512b4db14180', NULL, '111.32.91.155', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425184843-edd8c19605dd4d07ab6a5e3038a2763b', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425191009-ffecc6997c134ed998c96192ba675b6a', NULL, '120.230.126.47', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425191205-04145d37b5734d8c9454f87ed023b8e3', NULL, '111.206.214.32', '中国', '北京', '海淀', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425191904-da0a1345fd4a4a068db134c307f50e66', NULL, '205.169.39.237', '美国', '德克萨斯', 'CenturyLink', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425191953-ca835daed0e74ac8b95edb52da70f71e', NULL, '205.169.39.41', '美国', '德克萨斯', 'CenturyLink', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425192636-10fef6bf68bc43499dbe2929e9609a6d', NULL, '207.102.138.19', '加拿大', '温哥华', 'Telus', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425201317-fec64e3542a040bd8c6ed1d908f6eac0', NULL, '223.104.237.105', '中国', '辽宁', '大连', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425202134-953474298a5145e3ab8e1e96bc4a4d3c', NULL, '36.142.180.5', '中国', '甘肃', '兰州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425210000-8e24a97077f9478ea48bca5aa28b520d', NULL, '182.32.1.135', '中国', '山东', '济南', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210425225146-b9fc4c4adc0642c0b768775d8e4a5f13', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426014303-20579cc6c5e54ccfb95dfa4a98700e22', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426052110-73947fc33c3c4534b5ee88ea0ee48757', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426085238-cfecc4cca2504e66aa1095ce9e145309', NULL, '168.119.68.124', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426111938-8bd8978da6614929ae5d845a39a2c4cb', NULL, '60.169.46.132', '中国', '安徽', '芜湖', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426115625-531f4a3a6d8542cd95b35cd583cedfae', NULL, '81.70.201.11', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426130023-35cc6202160f4893bd4795d0dbf07d20', NULL, '180.162.35.195', '中国', '上海', '青浦', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426132757-6612b8a302604e81b0059c4fc8d5847a', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426134545-3db27d05a0ef4cc1afad368b93b52daa', NULL, '117.160.193.21', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426143540-292eb1d9901a4355a788f82059a113fc', NULL, '117.136.89.72', '中国', '湖南', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426144143-a5013dc066d24f91884ec8f3d438f03e', NULL, '117.184.71.250', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426144629-bbdd05040cdc4244903cdf703e01d7d4', NULL, '222.211.143.42', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426150829-63f98ccc07374b33b567711f5e372968', NULL, '117.178.112.156', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426162808-3eac963c56c949bb89360fd54b7380a3', NULL, '161.129.39.203', '美国', '俄勒冈', '波特兰', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426163808-20a61d2e735142ad966ea045f7c33e9a', NULL, '117.135.89.183', '中国', '上海', '嘉定', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426164744-0233053df9a64316a188cbaff53ca4fe', NULL, '218.81.5.190', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426170842-349b44a2646947c4ba0648f2e77a9dbf', NULL, '113.50.48.171', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426175640-710f5db5ec474001ab169ef8ccd264ae', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426190941-9971eef0af994c779e59a971ee86da0f', NULL, '180.163.220.97', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426191928-e40bc14199e14cb98dbf0e0c26045e4d', NULL, '27.220.198.99', '中国', '山东', '菏泽', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426200356-33ab3c7eaded4e8c92ab0790feac0c2d', NULL, '113.236.15.123', '中国', '辽宁', '鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426204415-25c3ba4db6ad4b70b75351ce00c7afe6', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210426213705-0dffacf1b26f460792944cb57600b77c', NULL, '112.44.105.199', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427005811-478db9d4462248e2b1b6201d69e1eb05', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427041836-079b8d85bc554e1a9af93b04de18244e', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427075144-94d37bdecf6c43bc9b5ec21f27b77318', NULL, '111.30.250.155', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427081206-0821ba1d43b34ca0a05676ab5d2af59e', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427091157-0c94d1e20a2045ab8441dfe0441bb6be', NULL, '144.123.105.178', '中国', '山东', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427091736-0e2c35aeddef4bf6a38b1eccb40f3012', NULL, '222.89.237.13', '中国', '河南', '漯河', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427101110-2bfd8d592f584043b06602a9305c571a', NULL, '222.89.237.13', '中国', '河南', '漯河', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427101427-bb5a9ef55ff045fdadf3196b48fe3678', NULL, '42.236.10.93', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427101455-a2f20cf88da34370b9c333532fb35b62', NULL, '42.236.10.78', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427115036-5739a9149bd3409f8c93bd9b29e35718', NULL, '117.150.1.189', '中国', '湖北', '宜昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427120142-8e3775e4ddbe46abaf885ec112f5d348', NULL, '117.178.115.175', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427121353-f437889fa4e94549b212fc119c2a3715', NULL, '195.154.122.133', '法国', '0033', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427125234-1ef6e69e25194dd39f051bc57549b9ef', NULL, '106.47.94.97', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427130526-49ae0846b81a43469df7967d045a087c', NULL, '117.178.115.175', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427141004-044b2d0f00cb47f09085c6235f9b31d1', NULL, '117.178.115.175', '中国', '江西', '赣州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427143916-c0bb79a1878142e1b63a8a6f4c7c3f4d', NULL, '117.136.55.140', '中国', '天津', '天津', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427144014-5b9d3e3274264f3c82e9f1018f1e1cd5', NULL, '36.106.227.235', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427144520-86d2ff1c5d21431da9ad9e9e79fccf50', NULL, '106.47.93.175', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427165740-4ada0628046342289f808d9b0025ae41', NULL, '222.240.14.151', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427170524-abc9c4dd02454bc580e1235c04b20416', NULL, '168.119.68.240', '德国', '0049', NULL, 'yisu-5f1931fe50f10', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427184804-64ac5cb860664c47b24093966c428b37', NULL, '106.33.182.74', '中国', '河南', '电信', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427185229-6d6f9f60010b4d5aa982ebe6000b9b93', NULL, '116.179.37.34', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427185232-316b9f2a664d4ce7b432749e48c55ae7', NULL, '116.179.37.247', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427185959-ce94ac67e8e249ae9eded877d2bed585', NULL, '117.150.1.189', '中国', '湖北', '宜昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427212622-5ae629bd35d04b84a59a82c53568e919', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427221559-5314fdb773d147609090363efbcb9fa8', NULL, '111.221.136.120', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427225041-24a6d14253a142feb1b89a63cea49ff7', NULL, '111.8.72.91', '中国', '湖南', '湘潭', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210427234806-66bb0dda89f940c69e031c4a1cff1336', NULL, '112.44.105.199', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428024639-475743bc79924fddb3b0ad68f80639ae', NULL, '81.70.201.11', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428055006-18e547284dde4b009ac609d2104788dc', NULL, '81.70.201.11', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428091536-d932eb988b9346f9a403ca80a107b008', NULL, '183.95.48.180', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428093353-c1ee3a4669dd426bafa73c42d72405f5', NULL, '144.0.48.241', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428093500-c42820f3761940948dabceb71999754d', NULL, '144.0.48.241', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428094945-3e7b98d63ef64549958842b5bd0b7d6c', NULL, '144.0.48.241', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428131248-2a589db7ed894937a0595310ec9724ef', NULL, '121.5.31.116', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows XP', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428134721-940f5cc3a06047b29b4a91ea61beebdb', NULL, '121.225.235.116', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428140521-c113f4a6ecc5422da54714c8cde6c7a9', NULL, '222.240.14.151', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428140710-750cd206c29f448794d9f6291c92f523', NULL, '180.163.220.3', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428140827-a2aa73f34f9840519086875d647db107', NULL, '42.236.10.75', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428163202-d287ab098a9c4f4da64ea106a7de4e2d', NULL, '124.128.34.82', '中国', '山东', '济南', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428164109-ceb1954583854b45a22501a1029e21a3', NULL, '203.208.60.72', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428165117-55974db9da7547938a7d3d4000d6d16f', NULL, '120.36.227.47', '中国', '福建', '厦门', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428174302-ad025f77a6f4409ba1655a0a41ae98ea', NULL, '1.194.187.28', '中国', '河南', '开封', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428181328-78202e2910c2409faa25f876f0db0142', NULL, '113.110.226.218', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428190822-c9a44b538abd45bb99429e42064d5731', NULL, '111.37.1.25', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428193254-36b77c3d2d38457c8d244e234f286bb8', NULL, '1.194.187.28', '中国', '河南', '开封', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428194310-977cbab28d36412da71941d46d994756', NULL, '17.121.114.176', '美国', '001', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428205834-30de749374a84d1481bc637f70be2197', NULL, '39.176.195.8', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428215503-26418238a1b344cb8d293bbd53bcee2e', NULL, '183.95.36.149', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210428233830-a45aaa3c3ce0423bbe60aa76d5aa94ea', NULL, '61.152.197.179', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429062746-c93ff30b07c34489b138d6b31495e45a', NULL, '89.131.67.1', '西班牙', '0034', NULL, 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429101647-cb9d73cc980741dda0c5011545dd2b78', NULL, '222.89.237.13', '中国', '河南', '漯河', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429110816-64cab34abd674a12b43694dfcd4b328d', NULL, '182.100.19.222', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429111303-270f8efdab9a4115be28649ba61a37b3', NULL, '1.194.187.28', '中国', '河南', '开封', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429114331-79a4b387a2334623814398ad05420bb1', NULL, '117.164.170.71', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429150743-6be681fce282427f810abacf024f384f', NULL, '110.185.160.39', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429152511-fd42bfc0c86b4cd3ab1011dadafde742', NULL, '203.208.60.55', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429155839-cb8b344196374751802b70b7d48bfe60', NULL, '182.149.79.172', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429170319-ae825cfa51a14796be05853a825475f5', NULL, '139.59.228.153', '新加坡', '0065', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429173436-9435fcaa3cdf4d50af9bfb0a86c7d1d8', NULL, '42.236.10.84', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429173511-7bd659a3b69744788db83bc0b01c64fd', NULL, '42.236.10.84', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429182842-97c1cf8c71bf4fd89f504e1b4aa69237', NULL, '182.149.79.172', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429215509-c936b643c60c4130a4fad83757f75881', NULL, '116.179.37.230', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429215511-f57979336d934fd7a84b9630c8fd6a28', NULL, '111.206.198.50', '中国', '北京', '海淀', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429215737-db63788628df403ca88aac823b0144a9', NULL, '171.104.70.249', '中国', '广西', '防城港', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429215808-c163157eda6141599e0b97f8f4146fcf', NULL, '111.231.91.23', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210429235536-aa2b8c42e1724886ab205c1e21546739', NULL, '117.89.142.204', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430014534-8dd5614dd9894e3a80f746e4f56d6592', NULL, '120.85.135.20', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430043009-c5b34d0902944dcd845d70723f3467d2', NULL, '203.208.60.120', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430054019-4c828068b1bc4064ba599993c60c0cef', NULL, '203.208.60.69', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430093120-94bdcdf11b904685b918b87901d00b61', NULL, '39.176.195.8', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430094118-4ea753a9d681405d82e552ca7a0ce26f', NULL, '111.30.250.35', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430094233-55f721bb94324e6299bab7ab35a4c1ae', NULL, '60.28.43.173', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430112336-ce129630759b4c4c9b779c9b6b4a9ddd', NULL, '58.255.79.104', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430133414-d17d6e4d9cf14ef2b52dcc41efda4e75', NULL, '42.49.148.73', '中国', '湖南', '怀化', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430141815-89b9898674d64eb3903f40246e2bbccf', NULL, '117.89.143.109', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430151020-d7aac9ce3c594fb6823f7da403f21e40', NULL, '123.150.8.42', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430160415-dec7cf8428f54f4d9c55c3a960194707', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430160454-a57e5732c2964c4c81b6e3ec6870576d', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430160554-a0c2e7384bb64bc3bc598369a0184282', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161607-8c794e8b4d58424b83fddd4c4ff0bc9c', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161630-2b7e1b79ed1e4c81a065e99c43a55737', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161903-1fb224ccccbc4246a101b84803e990dd', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161919-b57096a0afdf43d8a71b749e7e9eb4fa', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161937-47c096e01d454c4fa551f620e80a5a3b', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430161954-0b97d0d5bf904abcb5be5f239ee90bbd', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162011-d280977998ee48b6b667634a0d323a81', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162028-d24e0c6a6157425387a4ef9d4cbf5b28', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162049-153a58818c644d2a9c88e27d6b297735', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162106-207add4b4b784190858eae5300782df3', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162122-a359896880a1498496b55260a8db7b9d', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430162138-a45bb897167f4e9f95dae30afe1be352', NULL, '218.106.145.4', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430163001-9d3f9695e647400eb044f461a883f07d', NULL, '43.250.201.97', '中国', '湖南', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430182257-3e03da656914435ca33d09c7fdf8752d', NULL, '183.199.243.124', '中国', '河北', '邯郸', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430183318-5630d2b719464f7da2a6139d22d052cf', NULL, '223.113.50.4', '中国', '江苏', '徐州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430192708-e8b09eaee1a143f4a87c6f73fe657b41', NULL, '117.89.143.109', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430215643-d051c1a442404b489182916d3434710f', NULL, '203.208.60.45', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430220312-4beb9a04fe0b4b5faa889ed3db07164b', NULL, '89.163.220.82', '德国', '杜塞尔多夫', '0049', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210430225436-7f6be03c07e74d9a92faacc55b1850e5', NULL, '36.34.167.101', '中国', '安徽', '马鞍山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501003159-2be78a4ce2554f1883687b958ee8341f', NULL, '123.8.230.20', '中国', '河南', '漯河', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501101014-d70aac2b64e94cd18d394a1c7bd865b6', NULL, '123.55.235.226', '中国', '河南', '漯河', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501142327-a3f80612513a4d24869c941e81107a95', NULL, '211.97.3.146', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501174940-7135bca93daf4c6b9d1c24ef4504cee9', NULL, '220.202.225.106', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501202634-01b65c4a1dc943159e87ac0271c3bd60', NULL, '111.0.8.26', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501202647-122674e9a56c44619c46f07ee7d79703', NULL, '42.236.10.75', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501223724-a163b1ef754b4e0b8d4bc62a55384cb0', NULL, '162.14.129.186', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210501223932-f8cefdfaf5cb4e599dc912f2ba9cec41', NULL, '205.169.39.240', '美国', '德克萨斯', 'CenturyLink', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502093128-d8ca5e8c52664a429f1f85fee7de137c', NULL, '111.47.112.64', '中国', '湖北', '仙桃', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502114144-cbb7a7d2db5b426d9d8b6d72adb8e1f5', NULL, '140.207.23.209', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502114205-0d4da4af340647e984cb3c1ed4a7284e', NULL, '220.196.194.73', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' Android 11', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502122705-f88eaef0c10248b196a55e24fc8c150a', NULL, '111.32.90.45', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502145612-85d6feb60af34acabb1802e6fddb0e92', NULL, '36.158.34.253', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502151127-4c9d47d25d0647af829b5c16bf4c9fc4', NULL, '39.191.29.145', '中国', '浙江', '舟山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502180601-f28f77156caa4690b67b3701ea4f8a1d', NULL, '147.78.177.79', '德国', '法兰克福', 'xTom', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502181008-ac4c22100d3244edb65e3872c6a71f5d', NULL, '182.97.168.21', '中国', '江西', '电信', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502191918-9d45643c64da46759dae5428595e5d76', NULL, '133.167.67.5', '日本', '大阪', '0081', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210502204331-2daa6d2a6c6947a9ba541b2ebe8427d8', NULL, '66.249.79.185', '美国', '俄勒冈', '达尔斯', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503002505-5d17f6802b1440508582cc8bcc3fa060', NULL, '23.98.39.169', '中国', '香港', '微软云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503010011-07397363819f4b6a97117052f094d945', NULL, '120.85.135.20', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503021300-724bf426af9e4fbea841a6b8f792ffa4', NULL, '120.85.135.20', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503064558-5029f2a8d3834a8e9302d1fc7d003931', NULL, '203.208.60.54', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503103839-df4d852f671a4c7f85a3d04ff15320b3', NULL, '120.230.126.126', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503134613-afc95b7402744fb49fd955790ffc7e74', NULL, '42.90.3.119', '中国', '甘肃', '兰州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503175223-8cd1b92d1cc54ec58f27e2c0b1b6331a', NULL, '36.59.48.12', '中国', '安徽', '合肥', 'yisu-5f1931fe50f10', ' Android 11', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210503231010-eaa73cd8eeb041849176d912d62ee2cc', NULL, '112.2.251.179', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504092222-8083f222d7aa458f83f8afcec207eea2', NULL, '117.136.90.73', '中国', '山西', '移动', 'yisu-5f1931fe50f10', ' Android 9', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504100544-4bb4e461d13d41c2850caa02eb08b567', NULL, '115.60.184.39', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504101050-115946265b664f898fb16da7096e9dfe', NULL, '117.136.81.188', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504101134-7b75860ec6a84be7b01b26ad7952465b', NULL, '106.39.42.126', '中国', '北京', '海淀', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504123324-8166bbb3b9e3442eb3c401aaf25c4e92', NULL, '117.136.81.188', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504132222-b311d32a0a1f44d7b7f3c44f73bfb08e', NULL, '117.136.81.188', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504142159-a5056a76b4084cf8be52ca66bd6e2c78', NULL, '111.0.8.199', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504144625-ffcbe335c1bd423e8b261a528100abfa', NULL, '27.115.124.38', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504144656-d9b1e9a514034012a3d0dfe97d801012', NULL, '27.115.124.6', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504152517-65ffa2d472b748169911bfa19c5dac2f', NULL, '58.247.22.45', '中国', '上海', '闵行', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504162449-366f8564ef1e4c8c99594fd723c21def', NULL, '117.136.81.188', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504164041-4486605f35ba491ab7c58bc3028e3576', NULL, '27.187.219.241', '中国', '河北', '保定', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504173306-06995633a4f2441790c3f195d62168f6', NULL, '13.59.42.115', '美国', '俄亥俄', '都柏林', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504175218-a95d831c53b14a39a70b315dcced7e03', NULL, '117.136.81.188', '中国', '湖北', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504182334-2739cab05d914e99bbb6db79b7941c7d', NULL, '122.96.40.114', '中国', '江苏', '联通', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504211551-b90030cd01b94bf6a7049fdeff31390c', NULL, '116.179.37.240', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504213459-bca68aad20224ce0a030cd689015fff8', NULL, '66.249.79.218', '美国', '俄勒冈', '达尔斯', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210504220745-c368411ba46841ea83d4d6bd7a8e657e', NULL, '123.139.67.64', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505064609-bc0cb55fe1ed4536b747bcc3a74f07fd', NULL, '203.208.60.3', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505071615-5ccca553834c41229589750d352f6aee', NULL, '203.208.60.79', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505112909-874eabc41a3b46ad8eb037c58fc231c8', NULL, '121.239.93.229', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505113103-4c304b1fa0224ab8ba52dbe145217755', NULL, '121.239.93.229', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505131504-f875b26982d445229a8628eb31476d69', NULL, '111.30.250.40', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505151411-4a90daf60801484890926677d4f6da01', NULL, '112.96.168.11', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505154820-c8b1af150f90479f8db7d3d0f3ed3d37', NULL, '121.239.93.229', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210505173242-3a08061af9eb462f8e96e61027f49e5b', NULL, '220.197.221.71', '中国', '贵州', '贵阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506095546-e29aba1c98584dd6aff0a53da9392be8', NULL, '113.74.163.29', '中国', '广东', '清远', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506104927-3aa7e9577bbc40688866286b8dc8c5eb', NULL, '58.255.79.104', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506105237-af84a347b9c4401da2b5bc0a117502c9', NULL, '61.183.71.118', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506105612-3f6a71db450a43139fab9969571628f2', NULL, '61.144.97.88', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506122926-d861ba7789d341efa72ef9c41eea60cd', NULL, '183.230.226.219', '中国', '重庆', '合川', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506153125-f74f4000ff944f05b86ecdb770dadcbd', NULL, '112.209.69.189', '菲律宾', '马尼拉', 'PLDT', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506153228-c2b6e90692904b6d95fd6be16410142a', NULL, '112.209.69.189', '菲律宾', '马尼拉', 'PLDT', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506154446-8b93a3eaffdf4e628411360c404b38c1', NULL, '114.222.3.104', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506155622-106aa346e20340dda82b01e24309a07d', NULL, '124.127.244.4', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506163018-d7433d4b10af4d7bb10305936ebc20f0', NULL, '123.14.95.6', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506174953-a6eb7c0153864686b1b47e42622c2945', NULL, '221.7.210.220', '中国', '广西', '桂林', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506183249-3fff58f2c2bd4eedadf3c43e88b2f1b7', NULL, '218.92.219.188', '中国', '江苏', '盐城', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506213444-22009a7d6403498597b6e68c61498385', NULL, '117.173.131.254', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506220154-d51850f35b6b407487b070c73eddf58c', NULL, '223.104.20.47', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210506222058-d5e4cc4536f84b83971d40e8c9aac20a', NULL, '125.86.164.225', '中国', '重庆', '南岸', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507101415-96cd6ab6350a40e99a4e9e44a730e541', NULL, '117.71.53.211', '中国', '安徽', '合肥', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507102038-a163561761034d22a54d8a0e327b91d4', NULL, '36.130.168.100', '中国', '辽宁', '大连', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507102836-9fa673363391471c8fed41d85f9bfe8e', NULL, '116.169.4.200', '中国', '四川', '成都', 'yisu-5f1931fe50f10', ' Android 11', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507113033-32ac79d60efa4f1d8df6f3cd0efb695d', NULL, '119.27.186.11', '中国', '四川', '成都', 'yisu-5f1931fe50f10', ' Android 5.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507143203-87b0693f74d747e994a985ed08557f62', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507150019-46a86495cdbf418280d68c862e16e3fc', NULL, '115.171.62.221', '中国', '北京', '昌平', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507153541-644f0afc7f4c4b15aca14a23573bda57', NULL, '180.156.234.76', '中国', '上海', '松江', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507165811-4674444204c2475aaf4c87f38be18869', NULL, '58.255.79.104', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507170137-2218688372fc41248cefd22a6446787b', NULL, '60.176.28.169', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507184244-4dd7026cba25430bbabd350f778f2163', NULL, '58.255.79.104', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507201948-f97538e0e6664ba6a68b7e1cd81a34be', NULL, '112.3.237.188', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507220208-5178fd6947d948ff8ecb98a839cff00b', NULL, '112.3.237.188', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507224139-5791c552c115419d85ad49503dd9b5da', NULL, '203.208.60.35', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507224539-f02a7761ee4c470db31e777207491bd6', NULL, '49.93.128.65', '中国', '江苏', '电信', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210507234200-258de09e04d940a9b3501e335d8cf975', NULL, '117.173.131.254', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508030139-a6d91b45002a40f7913f0d230d04eda7', NULL, '40.77.189.82', '美国', '伊利诺斯', '芝加哥', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508102026-a1899f2cc89044a2b18cfbc97a14d44d', NULL, '222.240.204.78', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508102414-e9ddbbf480734a3d934b06ef079df4a4', NULL, '180.111.191.185', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508103136-7896c041d8f6465490d2e701963a4f0e', NULL, '211.72.35.152', '中国', '台湾', '台中', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508105447-28753434ef114665b062654a25440b66', NULL, '221.203.70.232', '中国', '辽宁', '抚顺', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508145501-6eca65f26bfa4697bf2bceecaad2da03', NULL, '180.213.6.137', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508150330-ec8892831ab342e3800207894089e04c', NULL, '117.89.142.234', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508155318-129f137ff5bf4fd1b841e7d6247646dc', NULL, '182.150.81.210', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508194554-a0470c13fbb44b34b328e67f8551e807', NULL, '211.167.228.197', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508201558-c2812734a0774def8c3841b2efa20e97', NULL, '42.91.4.176', '中国', '甘肃', '兰州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508205731-4ef211e2ec6146ea9dcdb32f8209151f', NULL, '117.89.142.234', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508213310-0402b0b6d3e44071b3eb69cc0132a248', NULL, '114.222.3.104', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210508215251-93bf781e2d2d4cdabff43bb96dc2b4fd', NULL, '117.89.142.234', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509002439-3cbc26f944744ea7aa43762629345074', NULL, '116.179.37.86', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509002441-41dc0f7fdcde4c9e83c6aaca34d6fe22', NULL, '116.179.37.232', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509002501-9a4c1531260e4894abdfe47e1430e66c', NULL, '116.179.37.123', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509002502-81311678cdcd4ce98ad898e0d56b4ef9', NULL, '116.179.37.50', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509032610-43b7dfec2da345dda4648028973b55c0', NULL, '61.139.23.143', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509050210-f15b894b3c24406b8250e1f097b6c9e1', NULL, '65.49.27.189', '美国', '加利福尼亚', '费利蒙', 'yisu-5f1931fe50f10', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509050223-1dbfd9dc71634aeba33769e2f302d7ea', NULL, '65.49.27.189', '美国', '加利福尼亚', '费利蒙', 'yisu-5f1931fe50f10', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509053929-a1d5f61cf0c04c568594b3bc66e3c07e', NULL, '111.7.96.155', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509095951-e6cd1dfdcf2a424787f94af198cfabe9', NULL, '111.30.250.177', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509100822-99d034285c9c4d31957d21638fed7f30', NULL, '39.144.41.44', '中国', '贵州', '毕节', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509100844-6e8ca0b38dd44c729e3fde1873f2fa8a', NULL, '112.193.75.113', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509101445-188b69c8b1b448ba82ed165bb9e7e00d', NULL, '42.193.96.90', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509105103-78c74a4cf71945c6802beb5bf335cdc0', NULL, '182.132.132.187', '中国', '四川', '雅安', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509111335-31bd1eacb2224f749ac4aac3dd044077', NULL, '180.109.31.220', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509113819-de894e30bf9b49e5acfceafeebc74975', NULL, '117.136.54.99', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509131911-84ce4e1d95e34329b9d9bf8e06fd3e11', NULL, '106.47.147.146', '中国', '天津', '北辰', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509161342-391bf87317d64f0ab621010fca802b81', NULL, '116.179.37.199', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509164021-55d1d3fa14e940d7af77bd6a7642862f', NULL, '14.154.31.254', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509214518-a1201b429e674d8faa855a80398bf052', NULL, '218.68.107.119', '中国', '天津', '西青', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210509221428-e16afe1e526149188369661669315fc0', NULL, '106.122.180.150', '中国', '福建', '厦门', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510090254-c062c0e33a6241f8858db8173d8ff26c', NULL, '222.95.131.34', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510135858-c813ff491f624ec5858a9b9aeb9239cc', NULL, '125.76.213.65', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510164446-b9f45e34f5ba4f8b9d65d5ed5b1b9e9a', NULL, '121.225.234.212', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510165917-14e117d0c18340d7a4a9df4cdd0599cd', NULL, '222.95.131.16', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510170030-b8c14d16149d4fc981b0d2efb827e29f', NULL, '223.150.15.112', '中国', '湖南', '常德', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510170633-96bf250ae2e4496e9d0e61f7f1964bd5', NULL, '223.104.21.232', '中国', '湖南', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510173954-cb252d504b8c4d67b1c1efbda3e4f9a9', NULL, '121.225.234.212', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510180631-25d6e524344b497f8acbc0f56a03afec', NULL, '223.150.15.112', '中国', '湖南', '常德', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510183556-1855f20d79304cddae126134ff932ee4', NULL, '121.225.234.212', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510195918-81e13e4738144832af4ddf93295ee3dc', NULL, '113.140.11.4', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510200910-eddbd16475c542958de52cd33511c5d3', NULL, '171.43.160.148', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510203915-15b04192819749f9bfcb6f2d9f97d4f9', NULL, '59.41.245.247', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510212539-062b1b787e384213b3bca5ef0bd0ce7c', NULL, '42.102.168.249', '中国', '黑龙江', '哈尔滨', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510221403-dfaf9f36c9894a01b3f3a327fa206dbd', NULL, '123.234.244.2', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210510232201-15428412f32d49359ae499dba5bbaafe', NULL, '123.234.244.2', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511011602-a98c768b414845508acfbb32d6681a05', NULL, '222.178.202.93', '中国', '重庆', '荣昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511091855-ef46ba43d0244632a92ab3a4e344e41c', NULL, '116.179.37.105', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511091921-08c1e820a8e240dcb36ac9d38d08e0ec', NULL, '61.185.28.125', '中国', '陕西', '咸阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511100138-6dbf9da26d5249f882e20774429a0bf6', NULL, '114.222.215.127', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511110957-3c820ee68e794d70ab055bd6640af112', NULL, '123.191.14.29', '中国', '辽宁', '沈阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511111013-e9f10c6e08b04e15ac6388c4ee599fe3', NULL, '66.249.66.19', '美国', '南卡罗来纳', '蒙克斯科纳', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511111143-21f202d8fb0c484d93400594e169a496', NULL, '175.167.154.46', '中国', '辽宁', '联通', 'yisu-5f1931fe50f10', ' Android 9', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511111803-c204433a69a448da9baa065d709fa920', NULL, '114.222.215.127', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511121013-f84405d23c12458b893fb356747a77c5', NULL, '66.249.66.19', '美国', '南卡罗来纳', '蒙克斯科纳', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511130652-fa835fad4d404fa2949fab7ec9b90ca1', NULL, '222.95.169.5', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511134146-3f484bd234f24ab1bdf523a124f6faae', NULL, '123.191.14.29', '中国', '辽宁', '沈阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511135506-cb6e204db0144b739b91b1eabd1399d3', NULL, '211.94.109.198', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511140849-b4c84cef91f74c09a0b6ac11e35cfd22', NULL, '117.136.66.131', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511141415-1999ef3b9af640c5a62432a01b4879b1', NULL, '58.255.79.104', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511144420-e74fc7540dbe4c2aa4e2add531dc9b41', NULL, '222.95.169.5', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511170822-fb1c12b7ecfa400cb33073fc2dff1c40', NULL, '117.159.17.196', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511172717-0036ac7541234708ac5da8d6ba2f193c', NULL, '218.206.196.38', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511174437-81edd441cfa3474e8140c91817b07d80', NULL, '42.102.159.216', '中国', '黑龙江', '哈尔滨', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511175835-cc32a93028e14a2ea06329794e902c42', NULL, '218.206.196.38', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511183929-f7b27e53dcf245d19ec6ae469f43a8bb', NULL, '42.102.118.194', '中国', '黑龙江', '大庆', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511204432-67b5a5251ffc4a659053b24aceb3bdfd', NULL, '223.88.32.52', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511214821-b022c806263f4db29455e509f377f3f0', NULL, '113.140.11.4', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511221557-2c595d6069ce47229c255bcc5158bb53', NULL, '223.88.32.52', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210511232620-10179d0b67f64a0db22da84d216958df', NULL, '171.221.136.175', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512000613-d2d5a9c96b264611899b55b49b1988e5', NULL, '223.87.242.128', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512013804-16e4068eccf64374998c5853d05ee970', NULL, '223.88.32.52', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512091301-bafc331e44774d539cc4e2d7abde23a5', NULL, '59.53.165.195', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512095121-dd6c444031a043babef9863fc855366c', NULL, '117.176.240.119', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512103718-f8a7bcd87ff4492ca9e86481d396e533', NULL, '104.149.201.10', '美国', '加利福尼亚', '洛杉矶', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512104828-8cffffb57607480db766f917fee4150f', NULL, '117.176.240.119', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512150045-20620a3f61644bf9a840ee9063fca850', NULL, '221.197.41.190', '中国', '天津', '南开', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512160949-8b1337e8973d4715a2192957a1ce8b63', NULL, '106.18.90.1', '中国', '湖南', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512161750-682bed97ed69416ab6c1d948f47278e3', NULL, '222.240.172.90', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512205343-5c7cdb5948564a5ea416e50f1766dffa', NULL, '113.57.209.11', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512210845-86da8f7928ec464183baad9371f3809f', NULL, '120.244.142.6', '中国', '北京', '朝阳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512214859-700bf50a354742c6a51c7e93c7c224f3', NULL, '121.69.69.86', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512222752-4668d7f516044c3b8bd69e20a65c2920', NULL, '58.20.126.134', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512225506-245dc36b29d044d9bf06f7acdbb12406', NULL, '117.136.57.238', '中国', '黑龙江', '哈尔滨', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512230526-1b19c1b596824f4d84b9623674868955', NULL, '118.113.0.54', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210512233811-987c2e6d1058405f9bb42b0bd3fed2bb', NULL, '202.111.182.27', '中国', '吉林', '长春', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210513105536-ca7ca8f7ef6c435484d66e295cd4c77c', NULL, '182.118.236.93', '中国', '河南', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210513162320-8e4c8a2fb2ea4bbebfdf13e917b0e8ac', NULL, '61.144.96.186', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210513174245-1dcbb25e077b4bffb34b1fc7d2c5f6a3', NULL, '218.61.30.43', '中国', '辽宁', '盘锦', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210513190334-b44c89a7ff55472c9abebfe65eb693c6', NULL, '223.104.194.51', '中国', '山东', '济南', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514014930-d2dbb93fc39e49109ddd95f5bad399ed', NULL, '66.249.79.243', '美国', '俄勒冈', '达尔斯', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514092557-69c9cc6651154cd4975a4746a3cd4ae8', NULL, '61.155.220.62', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514094411-d93a99b420954eebb8a4710d96bd82bb', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514095410-6f0fa973f946408198bf41d26001f689', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514102558-7fa9ec79d553421fb67a8fa1b51c74a4', NULL, '113.108.190.50', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514103212-beb3bd77aa814bf98a11c3503436f8dd', NULL, '113.108.77.58', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514103434-0a105d4c7a8c46378348ecfe6836c8da', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514104718-b74c394927e745e3b51373a9ac256e86', NULL, '183.217.28.96', '中国', '江西', '南昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514113554-7d2446940df3462e82a7afd92ce4c52f', NULL, '218.28.253.3', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514133704-a7f39edc49e743a5870177d6324b333a', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514141148-a9b3e79c87374f4d952b96272833018b', NULL, '17.121.113.20', '美国', '001', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514142934-0ef0be4ae5024aebb254a1987be3ba60', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514143457-b5eb7fbcf9b7465a97b4c99ce2878d8e', NULL, '115.212.18.57', '中国', '浙江', '金华', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514150850-70113c19024f45bb9dcae29a11ce2c42', NULL, '47.93.248.110', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514170604-2326ba3d7a854669ada5f1bce4a5d908', NULL, '117.147.3.124', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514194200-0edc92c7623d4c7980f21cdc9e9eebcc', NULL, '118.119.248.192', '中国', '四川', '乐山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514195324-6d3b753f5fe7441ea505e162dc150b38', NULL, '124.127.210.58', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514200223-577e3af7c57a42b3aec8d93ecd1848fc', NULL, '120.244.142.6', '中国', '北京', '朝阳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514201429-a580f3b79c21419daf2d53c3ecdf5316', NULL, '117.159.17.237', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514211701-b4231615c4d049228b14c1ca211a29b1', NULL, '118.119.248.192', '中国', '四川', '乐山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514222331-bba78b36f5374a78a7172728ab40e835', NULL, '117.159.17.237', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210514230949-17a9222ea6b7423aa77e995d3c3345b6', NULL, '149.129.55.180', '新加坡', '阿里云', '0065', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515083330-4e396a61298c43b9a03ca8065e1cba01', NULL, '66.249.79.187', '美国', '俄勒冈', '达尔斯', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515102008-8da03f1a72c14273ba2e918219a8a630', NULL, '182.90.223.101', '中国', '广西', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515102019-0113903cc493499eae00ced11d933ce2', NULL, '180.163.220.4', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515132733-eab83d8e5d8142938fde74199f5ec9ff', NULL, '112.96.227.3', '中国', '广东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515143106-214c6ff054c64e5d9ff2ce43cf11ddfd', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515170203-cfe8821a9a664bc287e35c9d588f657c', NULL, '173.245.219.249', '韩国', '首尔', '0082', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515170332-5a6a47f7c7e440e28a1233f3fe9cbb5b', NULL, '112.6.124.183', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515171036-937ca6dcfaac4b4c9575e252e0ad0374', NULL, '27.115.124.38', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515171055-459a95f09396472f97a64ad644aa1265', NULL, '27.115.124.38', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515185703-e67ba713abe74af59994805d10df30f5', NULL, '112.6.124.168', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210515220814-bad15c3561e84fa781226db81f142f4c', NULL, '222.178.202.93', '中国', '重庆', '荣昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516065725-109b38e58868436696a899021da4c9a4', NULL, '39.106.185.18', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516074250-1810b6ae44b54428bc3cd35ebf874ba1', NULL, '101.200.151.214', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516114932-89f7efc32b6348b9bd28acc7e8901d1d', NULL, '117.159.17.237', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516124951-f294f277286d4bac914d40da952f1d80', NULL, '223.87.242.128', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516143329-c5a1116a8cde48b89e446a97d1b79e84', NULL, '223.87.242.128', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516193938-2809885e4dfd408399e06713035001c6', NULL, '117.159.17.237', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516205205-e7b1c93bf90d44fbafafbdf4167c2ed2', NULL, '112.22.160.221', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210516224153-453e04831b0d4245a91314c4e6b17404', NULL, '3.139.94.168', '美国', '俄亥俄', '都柏林', 'yisu-5f1931fe50f10', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517002534-f47ffbf5d50a438c8e85733779040602', NULL, '223.87.242.128', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517090630-c0a0d584b1f149ba82ec600dcd31eb29', NULL, '220.248.118.69', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517090956-0e18a6cbe2f54ef69c7ed722204c6129', NULL, '62.216.92.124', '中国', '香港', '999077', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517095559-2c6b217829a44a18b543add9d2601377', NULL, '124.160.220.154', '中国', '浙江', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517111428-79e9ad733f6c4a579e8c7014e885da82', NULL, '119.137.53.200', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517112105-8085c99146744333912a448c80854717', NULL, '65.154.226.167', '美国', '德克萨斯', '达拉斯', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517112123-fbf8bf95f4b244299865987b0ca49b7a', NULL, '205.169.39.233', '美国', '德克萨斯', 'CenturyLink', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517121058-574fef6ecfe046aa86cce9bcbbd4f333', NULL, '27.18.142.74', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517134213-d4f93726ca6e4e29b1e7de0d671a38d6', NULL, '113.118.116.108', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517135744-6bb4561a679448f4b3421b365508d59a', NULL, '116.179.37.217', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517135747-ac3c6a3596584c78976597d1a1432651', NULL, '116.179.37.184', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517135750-589f39e6abab4067b8c2344280c44365', NULL, '116.179.37.88', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517135750-bad21b7074ff40a893b1fef84603db69', NULL, '116.179.37.164', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517143603-234d087863ef41ce80686764d6facf7c', NULL, '222.65.75.31', '中国', '上海', '浦东', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517174045-c378a6f4fb014823867587fa9817991f', NULL, '61.190.198.10', '中国', '安徽', '芜湖', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517203337-02d862cb86cf452398c409ccfde3676e', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517211351-db4072e24b6545628cb75fc137f7a17f', NULL, '203.198.16.232', '中国', '香港', '电讯盈科', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517214401-7873b4d9e06a4cff98f87acd1448ec3c', NULL, '113.223.44.156', '中国', '湖南', '益阳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517223843-e44977f3df2748c5956ccda3557e29a1', NULL, '183.156.54.149', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210517234049-6668ae28fbf34f6da41e8d0afa71d6ef', NULL, '125.91.244.94', '中国', '广东', '潮州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518091747-315d74037681408989d9a2549131103a', NULL, '218.18.162.220', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518094035-2dd1b87abc894fe1b2173469fce5b6e7', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518141455-46345c8ea0c0426bbfd732ed270401f6', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518165319-303f925d0400491fa374425fa19f4fa9', NULL, '183.129.209.30', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518170806-f3b1777d8d8842c48be8f225b302c2ff', NULL, '221.195.51.12', '中国', '河北', '沧州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518175614-06563945278e4eb6aa0a73d80fd9452b', NULL, '220.196.194.49', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518204917-0b885f0008e34b3890c34e0508de44eb', NULL, '117.148.108.112', '中国', '浙江', '湖州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518221311-443e515173fa41848dd3ef8535edfc0f', NULL, '221.212.176.16', '中国', '黑龙江', '哈尔滨', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518222551-2dd03cdb948541f89794d1d3020ec7fe', NULL, '221.195.51.12', '中国', '河北', '沧州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518233418-b9e95cc963334fdd80725e942533f970', NULL, '125.47.43.34', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210518233802-103a3889d2ee4e0bbb35fc7bef908a4c', NULL, '182.118.236.184', '中国', '河南', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519011633-1bb997bee7f44dfb8e684c90453ced39', NULL, '116.179.37.68', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519071011-7e250ab178ba436080e601ef850d7dc5', NULL, '120.228.78.74', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519073426-e97bc159a2c2486993be8a6a1cd67f3f', NULL, '115.171.170.153', '中国', '北京', '海淀', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519075906-ea1bcbcc51af4d7a9617422402cdafa1', NULL, '116.179.37.242', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519075916-8d2c12aea13e4598bdb95be75aae2d49', NULL, '116.179.37.123', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519100717-78400650ae944a768ca084481fa28941', NULL, '113.108.77.60', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519103926-6115689d841548a083896b6874987611', NULL, '125.47.43.14', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519124326-fae8a56f915d4c4b98f774ea4ce5993f', NULL, '125.47.43.14', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519151658-ba00ba7d358645a1815594e5fafe4d42', NULL, '113.57.169.98', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519154046-fb3c9e30b9d242719c9fc17ce491e980', NULL, '58.214.106.167', '中国', '江苏', '无锡', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519162036-d7c7ca5a2bf0435587aa02a99ae9ea56', NULL, '27.115.124.101', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519162139-7cec4114269e4fc8bb2acd36fc4ff711', NULL, '58.240.187.102', '中国', '江苏', '苏州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519171117-4369a463242f4415baedc0ea0ba3058b', NULL, '125.47.18.98', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519173623-44f750365c6f41cb9866416598aace41', NULL, '122.194.49.79', '中国', '江苏', '镇江', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519174435-a8b5a7f8725545dbb71bb0a9d929fbe7', NULL, '118.116.12.175', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519182411-95b6bdd7238c4299be313dd5515ba519', NULL, '42.236.10.117', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519182422-77112f8264aa46ed8be5ccfc643f1020', NULL, '42.236.10.106', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519182951-e363869ccc6645dfae3f28789eee2cf2', NULL, '113.5.4.178', '中国', '黑龙江', '联通', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210519195701-56f815b0fab9409093175f8502969e37', NULL, '113.127.69.95', '中国', '山东', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520001950-5ac5a4b0d1a44ba4aa2667b821c74d48', NULL, '125.47.43.63', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520112753-28ca5c97ba604de8bbff7c38a6ef7e3e', NULL, '40.77.190.24', '美国', '伊利诺斯', '芝加哥', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520122314-4cd3f1f108dc4c70917f848f8421b6de', NULL, '101.87.25.32', '中国', '上海', '黄浦', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520131339-edfd2482c7a64cd3a219521bc626fb89', NULL, '183.249.120.125', '中国', '浙江', '宁波', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520152838-6ff70187408f428b92bef9090ecc4b35', NULL, '222.222.49.98', '中国', '河北', '石家庄', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520175212-c28b65e73de640f1808cfad2c68dfa0b', NULL, '115.158.0.120', '中国', '河南', '南阳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210520220958-1d57ae8a45d84784924fcfb143e1868c', NULL, '222.91.168.32', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521001557-9c1888b63a3f4e869f38593dc211b54d', NULL, '206.190.234.237', '加拿大', '001', NULL, 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521040921-0a5974ff09cd4eb9aa25ffd1523c268e', NULL, '17.121.113.249', '美国', '001', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521092948-2a837f9913d348e99c562566f85e158a', NULL, '117.176.185.110', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521101948-32abd19c22d54e83a0d1cd92d90a3069', NULL, '222.178.202.93', '中国', '重庆', '荣昌', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521105519-b3d9e8e804b744c6ac76873fd8fbb895', NULL, '117.132.7.228', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521111409-89b991727916442ea21af2afee7d6aee', NULL, '117.136.78.45', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521111414-ea55aa08397540778a3412f2c2877ffb', NULL, '49.4.43.18', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 9.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521142905-047f796f592543a483f73da64ee2452d', NULL, '180.164.60.77', '中国', '上海', '浦东', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521145851-e83552a2092149d193607d8667c6954c', NULL, '117.132.7.227', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521155638-d4077d3a632746839701738f5650f1e2', NULL, '115.196.158.46', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521155957-b12927920c7f411989c9ac6993de663b', NULL, '66.249.73.227', '美国', '俄克拉荷马', '普赖尔', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521170447-e942d17ba03548e1bcc2bc3aaf79998f', NULL, '218.87.96.53', '中国', '江西', '新余', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521171601-bd86ce275cea474ebfaf9e548f2f072e', NULL, '221.226.85.250', '中国', '江苏', '南京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521175203-c76df0e185e145899e92fe2b42944615', NULL, '117.132.7.228', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521184949-3fb4590ae3864a18a8b041d140df5001', NULL, '106.33.229.161', '中国', '河南', '电信', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521223546-183aa5b3ff82407785a1668d11c81fbd', NULL, '112.94.174.220', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210521223552-635a330cb62445068ba7b7756dd12ba2', NULL, '115.212.48.248', '中国', '浙江', '金华', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522000601-3af45aeda5014a6e8a3377ba61f2ed57', NULL, '223.74.87.15', '中国', '广东', '湛江', 'yisu-5f1931fe50f10', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522031111-1fa820f48b124f94913f891912af7d2f', NULL, '66.249.74.22', '美国', '谷歌云', '001', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522035939-d18576f909b9498da3e333f6e5e46d43', NULL, '27.115.124.70', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522043133-83f4276e978445cfb156d3b14d928102', NULL, '66.249.74.24', '美国', '谷歌云', '001', 'yisu-5f1931fe50f10', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522071638-2fa8ffb095dd42f18422aa1e6cc74688', NULL, '120.242.77.14', '中国', '安徽', '芜湖', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522105727-76f9aa6c8a284c939a2d3e22d22890e4', NULL, '106.46.46.199', '中国', '河南', '焦作', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522112137-a2a32b73a202498284c7ba733da4c80a', NULL, '121.56.71.48', '中国', '内蒙古', '呼伦贝尔', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522132525-3985df939e564a5192661c7b22ae278c', NULL, '183.198.246.176', '中国', '河北', '唐山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522143449-f293b94f5f3541e79c1ac1b72b13f9b1', NULL, '66.249.70.22', '美国', '南卡罗来纳', '蒙克斯科纳', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522160712-c21812f4b87f43f5920d932cde47ecac', NULL, '117.188.127.147', '中国', '贵州', '黔东南', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522172018-d4f7da39b1bd47c3b9207d9c61df17e1', NULL, '117.132.7.228', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522202728-382dca89320245e0897cfca26337717d', NULL, '47.242.246.204', '中国', '香港', '阿里云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522221044-16bcea1ba568414bbd502e30a0bd456e', NULL, '113.246.122.100', '中国', '湖南', '长沙', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210522225039-7489cc2d874a4e4db6c01c180fb02185', NULL, '202.120.234.104', '中国', '上海', '杨浦', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523110212-551a4eaa2c974d279b408aa6e78b78e7', NULL, '14.211.18.37', '中国', '广东', '中山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523140514-584329e674d74705a77fda64499828ac', NULL, '222.212.154.151', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523154300-fda33bcbbb4d4aecb4d78714adf0d9e1', NULL, '120.230.76.180', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523164917-60e484817eaa42d5b447a9d27e816159', NULL, '66.249.66.87', '美国', '南卡罗来纳', '蒙克斯科纳', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523192121-1f33c89f27a24192ada89ca02be69d2e', NULL, '180.163.220.124', '中国', '上海', '上海', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523200558-6e7cc6eade4b4ad19801d5446bea3fec', NULL, '222.90.72.74', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523203843-a418febf72b448ac8679da1258f1bc96', NULL, '183.199.128.53', '中国', '河北', '沧州', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523221548-a725b5facb8741e8a2b0ca23b9cd88a3', NULL, '223.84.238.131', '中国', '江西', '新余', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210523235410-5c9abed63d59478b8e45a02d7f7f1337', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524011445-97de1ecd94274601b2af6c29d43b2744', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524090631-8a34f967675b435b9e69ee6c071a397b', NULL, '39.144.25.29', '中国', '河南', '移动', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524114240-590f04a5a4bc4b919cf969f255373493', NULL, '36.112.201.201', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524120757-35f1db1a756b430f83a2ccaa1b7df8f5', NULL, '14.211.18.232', '中国', '广东', '中山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524125845-e42bdde90e31483585647cb960d9594a', NULL, '36.112.201.201', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524141855-919517fefc124a349a97af1308d9605e', NULL, '110.87.39.72', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524143029-9e50f072892b48d7ab4fa15aa0216ead', NULL, '117.188.127.147', '中国', '贵州', '黔东南', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524144414-22973fc6810f4b0a8bf7b11f70679482', NULL, '117.188.127.147', '中国', '贵州', '黔东南', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524151937-69a75a5bcbc04574adfb07dd829deea9', NULL, '14.211.18.232', '中国', '广东', '中山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524153542-ec619b648a554c7da2771d3fe2f0aaf4', NULL, '111.1.127.206', '中国', '浙江', '温州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524161511-99242345e09a473fae0b20addbae8dca', NULL, '203.76.245.248', '日本', '大阪', '0081', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524161608-7d725deb6dd04e6fbeac8b43d6a6d80e', NULL, '122.224.142.66', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524162003-1ee6da1f9461432d87e340ca97800f4e', NULL, '58.23.111.132', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524162050-5697dfa708334701896fb78e78e64dc6', NULL, '27.115.124.6', '中国', '上海', '上海', 'yisu-5f1931fe50f10', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524164134-2620018a86db40d8880f26b472a7b92a', NULL, '222.173.96.2', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524170100-75fbef1e78744e4fb8df87d754800540', NULL, '42.102.142.54', '中国', '黑龙江', '哈尔滨', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524170324-e9257ffecb304dcfbdf5271c3c9e1bcb', NULL, '110.87.39.72', '中国', '福建', '福州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524175244-63462cf355f94e299b0ac5920a15fc5f', NULL, '121.8.235.165', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524195738-9b62d0c8e7c84e0f9f459c468579b798', NULL, '58.23.111.132', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524204811-789791149cef47f0808ab9f695c0be3e', NULL, '20.194.16.164', '韩国', '首尔', '微软云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524205008-f05374320e484b75a55b431194f41cc6', NULL, '58.23.111.132', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524210618-577840e8e02a42edad30ebe04865d968', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210524225358-d5ff34901fd84d928909d89aa39e397d', NULL, '117.174.31.68', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525084434-ecf71d6594aa47e090b26cf8b23ff6b5', NULL, '61.142.25.220', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525094508-4a187f6f0bcc41058a6e50cf5cb87a50', NULL, '111.33.154.2', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525100555-130a27e5e7a54cb38a3690a10b09c491', NULL, '111.33.154.2', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525100623-e90ce7ce729b48e0b83d843fce20851e', NULL, '111.33.154.16', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525101136-2249f33d8fd34e98806b7bfc48acb406', NULL, '17.121.113.182', '美国', '001', NULL, 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525112237-30b08e69099d485e8dea7238f3e64674', NULL, '111.33.154.12', '中国', '天津', '天津', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525131750-33ef41f4953644be82d41daf8f5f5af1', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525135545-4a7d135e8cc84c198399fe8235d9a56c', NULL, '112.12.36.135', '中国', '浙江', '金华', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525135938-5f1a512c48de45339094b2831d222887', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525150103-69f6b9b4d01147148fc44756e44b7ee2', NULL, '112.224.19.154', '中国', '山东', '联通', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525150609-49dafeaa99684ea28242806713ad7c35', NULL, '183.39.148.58', '中国', '广东', '电信', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525155249-2a55e339921642c2ba3e7c484f3d375c', NULL, '51.91.218.19', '法国', '上法兰西', '格拉沃利讷', 'yisu-5f1931fe50f10', ' Dataprovider.com)', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525162954-f9a61858abf045daa0a408558362f40b', NULL, '218.199.113.6', '中国', '湖北', '武汉', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525175424-a86fee767b2943acb3dc124fc6b8aa13', NULL, '60.209.25.204', '中国', '山东', '青岛', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525195539-b9600abb00234aa7acf0460defc05946', NULL, '18.166.76.74', '中国', '香港', '亚马逊云', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210525231148-abd7dc0364cb4a758c296bdaab45080e', NULL, '117.174.31.68', '中国', '四川', '成都', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526001324-afdb6abb7c8949b8835fd2381014f8b7', NULL, '58.23.96.221', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526021251-b5394f43f44748ae971afb10e918311b', NULL, '116.179.37.11', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526021252-b61f1519f6914b5f8223d960297f6bc5', NULL, '116.179.37.239', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526021252-ff0283e8fb16456e84a310f7b82bec8f', NULL, '116.179.37.225', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526021253-14499ab134d0493dbc6e95a437dcc848', NULL, '116.179.37.92', '中国', '山西', '阳泉', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526053403-98232d50e54445ae85bb0bf48e4a2829', NULL, '87.200.57.134', '阿联酋', '00971', NULL, 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526093048-9e7e390426904fd881eae2dda9f860a0', NULL, '61.163.96.218', '中国', '河南', '郑州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526094603-7a5dfdc32de846089055da5014569a1a', NULL, '218.56.42.148', '中国', '山东', '烟台', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526100841-e03ca890a7f746a08f14279f317c83f7', NULL, '210.83.70.2', '中国', '浙江', '宁波', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526102744-0c26332a83f94015882b6a7b3d276f86', NULL, '111.113.175.70', '中国', '宁夏', '电信', 'yisu-5f1931fe50f10', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526134733-471a2ce0dfa4434a95abe5b0977998d1', NULL, '58.62.189.84', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526141711-39f2aabd72d34a4da46bc56feb306a4f', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526145002-96aa15a22c72473599315a9a4f765e8c', NULL, '36.112.179.67', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526151529-05b89d0fc68f4684a1714b0e75918d85', NULL, '183.219.106.168', '中国', '江西', '九江', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526151653-8a58afb5f97b422db4e6785b45973949', NULL, '123.139.33.226', '中国', '陕西', '西安', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526153316-966221399056434dbbbf594309960ae1', NULL, '117.149.23.50', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526161705-e28fd31c56fb4c619419d2517cd21045', NULL, '40.77.189.159', '美国', '伊利诺斯', '芝加哥', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526175141-0aced217d3294f0f842c0e9d88a5fe00', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526183638-5baea48399b24fb89e9e695665614116', NULL, '117.149.23.50', '中国', '浙江', '杭州', 'yisu-5f1931fe50f10', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526184136-89598c7de9d04a37878939d7ba6a11b1', NULL, '58.252.5.72', '中国', '广东', '东莞', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526184906-38a721d3c2a7467e957657f8f04ec40d', NULL, '113.102.165.168', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526210329-923bf88b5bd146899ec0f76e2c03036c', NULL, '59.42.46.116', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526220102-4f109858efc84f19aa1f73c7d710bb6f', NULL, '218.92.4.254', '中国', '江苏', '连云港', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526220355-89c9565dd0ec4d6cbadc52cd0e6f5939', NULL, '203.208.60.3', '中国', '北京', '北京', 'yisu-5f1931fe50f10', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526223212-56329724ab03416da341feaec595370b', NULL, '183.36.181.208', '中国', '广东', '广州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210526231410-c5cb863870dd45feac781fd4435d28c5', NULL, '61.53.168.251', '中国', '河南', '平顶山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527100810-72c827e0ebac4b5fadbb9eec39d05fc0', NULL, '113.108.77.53', '中国', '广东', '深圳', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527105929-379b65f2cceb45a384ea4609bef3e075', NULL, '14.157.174.213', '中国', '广东', '佛山', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527115534-e5b50790b1bd42a69af0500a7d80d959', NULL, '111.41.118.45', '中国', '黑龙江', '绥化', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527125838-d002941823c94aa8b02757018898e5b6', NULL, '58.23.96.221', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527151251-c4ea87747fd546b78d1507e5df2388c4', NULL, '58.23.111.132', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527151803-2ff8834ecdf748829ad13eb5bddde867', NULL, '58.23.111.132', '中国', '福建', '漳州', 'yisu-5f1931fe50f10', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527152713-064d382e3d794cb7ad0601f570bd0fc8', NULL, '1.203.163.198', '中国', '北京', '北京', 'yisu-5f1931fe50f10', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210527170908-51b5d2fdf2984a6c82146ed7a7484a86', NULL, '121.13.218.233', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528101935-559e27e9557c401fa3c55ec6ca416637', NULL, '121.12.147.249', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528141523-7c10ca1ec7394a96ac7aee3c0dbc8ff9', NULL, '121.12.147.249', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528143311-737bdc08a26346e3a376fd4cb713f55b', NULL, '121.12.147.249', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528144001-fde2aa142f7646f7924de2b31c261981', NULL, '49.7.6.237', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528152914-faf83b028bab4d91820af5a389ae2c7d', NULL, '116.179.37.13', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528152920-8e4d4e9a4d0f4a7bafab02b9301d4ee2', NULL, '116.179.37.106', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528161907-f0b75167411344d5a93d11ff400ba42a', NULL, '119.162.120.246', '中国', '山东', '济南', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528171037-08590af42fc744a6b1f72e62feb697c9', NULL, '121.12.147.249', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528191748-27ae9d5696a941aeacd081fa6aa2806d', NULL, '183.36.181.208', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528205304-e5a068104299463db2a38bdb16adad86', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528212837-885963c815db4f47bcf58a759201df8c', NULL, '101.93.11.50', '中国', '上海', '长宁', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528213900-b007bff3bee040139b1a52cacc122f2e', NULL, '117.136.60.89', '中国', '江西', '上饶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528214104-f267c7375d3640198fc6b943b00177ca', NULL, '112.224.19.154', '中国', '山东', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528220240-f851ead8eef54356984a1b773c2238fc', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528222211-25a8ffdb5d1843bfbf84a7d328cd3816', NULL, '101.93.11.50', '中国', '上海', '长宁', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210528233657-081bbcb5fc624b378d3825261048ef0d', NULL, '14.116.145.112', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529013520-4b3efb25f2c7477a9700496ca302afa2', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529053554-a630e871b0064dd4b3a4ce8e7e2d4c51', NULL, '117.136.60.80', '中国', '江西', '上饶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529072542-bef7e9cd64e345e19d9c06ef8467d49e', NULL, '117.136.60.80', '中国', '江西', '上饶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529095859-b9ace035614e4202abc3d930c9b067fa', NULL, '40.77.188.244', '美国', '伊利诺斯', '芝加哥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529104550-0857bc6ba4f2476e9b3b22919f255a39', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529113333-e233f7cab3244796aa99a4cfb76a73d2', NULL, '218.199.113.6', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529123214-75884b5002fe43a2a7c85d4c680ddf16', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529162854-30daef32f273433a8637ed9709041249', NULL, '222.76.251.164', '中国', '福建', '厦门', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210529164357-829ea9ecce4b4bd6a64c03c95b056987', NULL, '125.47.18.98', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530085816-ac26f25274ee434890a2450eeaf03eac', NULL, '42.236.10.114', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530085833-a308fa50672f48708c7c1e5d07922b50', NULL, '42.236.10.106', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530121017-b952310558f84e9681fb92317e2d63e7', NULL, '116.179.37.75', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530140822-c0daa517b09441829ae084983ec3220c', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530144715-dd9cb8b1f41b45e491baa553f2b09ada', NULL, '117.174.31.50', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530155330-7717b8f007b54497aca279a65f1effdf', NULL, '117.181.145.9', '中国', '广西', '南宁', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530155413-4bcdb4bfc7344a59a19c668b5b579d79', NULL, '116.179.37.101', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530170128-2455edc842154d1ca91a2ff838571a9c', NULL, '14.116.145.116', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530193821-2402f9340efe407ba6a3b496a6e1a573', NULL, '116.179.37.229', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530195723-024c724280494ffd94f3d9d735bc41d9', NULL, '183.236.187.196', '中国', '广东', '湛江', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530202301-c9a83f5abcf949c8b40c68414513879a', NULL, '14.211.18.143', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530215013-ce8825f5d58f4321b1fa0229dc93b323', NULL, '39.148.79.111', '中国', '河南', '商丘', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530225656-6999133646264ab0bb68fc8261f3f4b8', NULL, '106.113.33.89', '中国', '河北', '石家庄', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530232117-5787d79350c04144b26614499dd90a1f', NULL, '116.179.37.216', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210530233754-ded67fe3aea44a6483d2516beb34d069', NULL, '14.211.18.143', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531011039-b687c0f2768849d0ae7b544d2ce5edf8', NULL, '61.140.171.220', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531030410-df467db4d26241e4bb49e449534f8e2d', NULL, '116.179.37.184', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531030412-d67c799b743d462c86370522be7504c8', NULL, '116.179.37.75', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531064818-65d573b2f625415d8e2100c5872ed2e0', NULL, '116.179.37.115', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531064819-eafa42c9440f4f2c89deee0f80c62a61', NULL, '116.179.37.141', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531103109-cd365f30b65d4c62ad2b670ba1b2fe60', NULL, '116.179.37.78', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531103446-b4c0a5cd2bc64512984847c9bfd8887a', NULL, '123.103.9.7', '中国', '北京', '朝阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531112227-2a8d4077f4b446399b88705d5abb8fe0', NULL, '118.116.19.51', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531115139-ba4a209901da467ab618ae62f510da8f', NULL, '14.116.145.92', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531125614-ec7f069876fa472ab3b9941ffd300e9b', NULL, '36.152.140.135', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531133141-d2f1f631e4684ca5bdd03fadaca3afd5', NULL, '116.179.37.204', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531161436-bed55618013143af8d8d15869383c6cc', NULL, '116.179.37.136', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531184212-8e1553532b7d4300a5bd7a51101c5d97', NULL, '47.245.11.40', '日本', '东京', '阿里云', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531185839-8d298d9896954e00abeb8e31af95bac7', NULL, '116.179.37.138', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531190830-986e2ea9a2f84bf891de09c123e1b58c', NULL, '111.7.100.22', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210531214242-9d2c706453a74b97a7bab2daa902f98a', NULL, '116.179.37.89', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601002539-e93bcfae20714bb98edfc357a71a782b', NULL, '116.179.37.55', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601002541-e42be23372d14381b60637895ac3c4e1', NULL, '116.179.37.14', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601030836-f50d5757c9a2405fa40737d135e028cd', NULL, '116.179.37.218', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601030837-83cd742ec54a4090bfbd31aadb6ac241', NULL, '116.179.37.177', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601055136-c444a325d8d34ca48acd7ebb00998cd3', NULL, '116.179.37.160', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601075930-1dca2262a0d44c6b83b231fd6b9ef1b0', NULL, '42.236.10.106', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601075957-ad18d740d1324c70b2e50fba174af89c', NULL, '42.236.10.114', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601081352-92973c762f3b4bf2b16efc0a1c381c70', NULL, '124.93.196.14', '中国', '辽宁', '大连', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601083435-2c6291a62892433698f67c852ee3f0f1', NULL, '116.179.37.107', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601091344-9a74f287cd3a4fd99dbb1e5dc2e21c14', NULL, '220.195.72.93', '中国', '内蒙古', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601094354-e2520256eef24d4aa93f255fdad6d2d4', NULL, '116.236.51.213', '中国', '上海', '上海', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601100619-8b90bc9a789948f285a3d32bc8ecc93f', NULL, '121.225.84.245', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601103342-299dd8dde82d43fea908ac399689b607', NULL, '111.32.91.20', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601103348-2b8e38d5743546de9d1f1529b85996eb', NULL, '111.32.91.20', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601104813-035efa95c5a04dcb8a19520d4986029e', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601111858-ff3564e8b5b749c59b6ba3519307f202', NULL, '116.179.37.96', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601111900-7b29d826788340ec83d21c73b694ff66', NULL, '116.179.37.150', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601140037-ce65d352ddd743629b7196fd20b0522c', NULL, '173.82.206.54', '美国', '加利福尼亚', '洛杉矶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601140252-9a29e6a158c34e45813a51e5c0773708', NULL, '116.179.37.181', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601144016-72a8b6ffc02e40cfb995379c9cd16f83', NULL, '58.220.95.90', '中国', '江苏', '扬州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601145042-df8bc33c4da141e9aa9ce8807068136d', NULL, '223.75.68.114', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601151127-f824f50b92bc4538b1b7837f98560eae', NULL, '218.17.158.46', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601152120-8f79c234f99c472d9d88a2d625eae372', NULL, '218.29.191.132', '中国', '河南', '新乡', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601160537-957ff8079cbc4127a1e42343446ad5d0', NULL, '218.199.113.6', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601163056-768e9e3986e34b4ab3c742d576915999', NULL, '111.32.90.141', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601164853-96b22f8864d64799b1114f686f733df7', NULL, '116.179.37.54', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601164920-7d57345e82f541dba16f12274f917f46', NULL, '116.179.37.30', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601165958-3eb32d58e658445b8f5f1ee4865d40d7', NULL, '218.92.4.253', '中国', '江苏', '连云港', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601172821-ced4efc66a47403eaa155c2a9c4d27b9', NULL, '61.130.109.199', '中国', '浙江', '宁波', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601191620-9f08c7fcc7164f5f8b086a0d08309615', NULL, '125.43.69.140', '中国', '河南', '洛阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601193258-76721247f7a14193adc0d147ca3ba520', NULL, '116.179.37.12', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601193608-22af58527504438a9772c25dd5147525', NULL, '49.7.6.250', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601205110-4cf2bf09a031458ebbe4eea6d137e834', NULL, '119.45.44.74', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601221541-e3197132988746e2970996dfb5114f9c', NULL, '116.179.37.168', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601221708-c8713a3cb3fb4f1aab9d975b77a8a22d', NULL, '116.179.37.173', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210601233144-cee7174f4c8a4053b7ca77c09fca5f56', NULL, '17.121.115.194', '美国', '001', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602010059-3ebb929ceee54f9c8117967a43aab488', NULL, '116.179.37.10', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602034449-8813edb69d7a4fc38a0cb1347bb8fceb', NULL, '116.179.37.47', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602062850-7e74ac32507546e2bdcb3066e5bf2892', NULL, '116.179.37.150', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602084658-8101d91b6ba04c169146dabcd2e01fab', NULL, '122.96.46.104', '中国', '江苏', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602084815-0b5ab6de7270490aad7f9e81f4ac0a23', NULL, '112.27.196.106', '中国', '安徽', '合肥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602085002-5078530661924f968d5c822416ec9220', NULL, '111.33.154.5', '中国', '天津', '天津', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602091250-88af80ae9d214391953cf056688498ab', NULL, '116.179.37.43', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602093038-c548c4431e824b7e98c7222c74ad64ad', NULL, '183.221.116.2', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602101710-98d6e5b624fe4150acb4a4488215eada', NULL, '117.173.226.179', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602102545-92e42ebcc1704b7ebd6e5104b00b49a3', NULL, '218.80.192.233', '中国', '上海', '浦东', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602113122-1c7a55bb441541f09b459e7e68c57bae', NULL, '117.21.5.54', '中国', '江西', '南昌', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602120030-b3c48f94c45140ee8898c85f83e29868', NULL, '116.179.37.19', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602120054-f41240e138a44ceab49812016abf7072', NULL, '116.179.37.217', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602144916-cfd4c56a64ca499d8da9650b5d6f77b9', NULL, '116.179.37.216', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602152830-31f39fca1e2349e09729b8f759c59b56', NULL, '65.49.38.143', '美国', '加利福尼亚', '费利蒙', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602153042-6ce1645c1fc0495d8c6ad4d47fb7e0c8', NULL, '112.27.196.106', '中国', '安徽', '合肥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602170419-d0a57c68e88844f2958d0be06a30a3c9', NULL, '114.254.0.190', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602170806-5a0aec235d164ae0984dc4e94d62dd90', NULL, '111.32.90.156', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602171624-56898cc9a19b474cb14724ba1c079e9a', NULL, '103.4.125.25', '新加坡', '0065', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602171739-01cb35a2e52f46b6ad1097b60b516582', NULL, '205.169.39.158', '美国', '德克萨斯', 'CenturyLink', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602172727-65dcdf2593b7407fa372e2f106bf65a5', NULL, '115.193.122.150', '中国', '浙江', '杭州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602172921-38cef788db1f4c86b108bf83222579a8', NULL, '115.193.122.150', '中国', '浙江', '杭州', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602173817-cf31d464136f44cc8be5e8983cb55a84', NULL, '116.179.37.3', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602180838-2cdafa2f9a214cb59fc94d38bc5ff16a', NULL, '23.83.227.33', '美国', '加利福尼亚', '费利蒙', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602202718-987a0999376d4884ad6701f700262ae4', NULL, '116.179.37.238', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602213419-10c217169a7e41ddac703dd5437d13cb', NULL, '111.32.90.156', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602214248-f493cc22087a4549b2393fcf6675dbcd', NULL, '114.135.181.70', '中国', '贵州', '电信', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602220828-b9961dddf52e470a90a5fd7fa2844b58', NULL, '112.44.106.206', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602222606-f40f8cc3ab8e4aab8aa2de28795fbcf7', NULL, '117.151.32.101', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602223434-c719851853c243058d9e009da64009c4', NULL, '106.52.69.195', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 9', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602225031-ecf1edc850ea4a5988adc86f97452f1e', NULL, '118.212.92.213', '中国', '江西', '赣州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210602231513-b39a16314c2645d29980c6fc49f1453f', NULL, '116.179.37.99', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603020315-5d91eae361984ac0a051c14a7c88879f', NULL, '116.179.37.27', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603045119-c0ed91d0d1dc4828af570e03d6fc7e16', NULL, '116.179.37.81', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603073121-0271a4c3bd0c475c95b9d2c5eb44f3bf', NULL, '116.179.37.245', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603074031-d8e17599574b48a9ba91de879f0bd18d', NULL, '116.179.37.244', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603095127-7fddcc8cbfb945dda14a22867d4abe67', NULL, '58.248.193.179', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603101540-6a97341b5e8745cd9603c1a1a82885b1', NULL, '111.32.91.233', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603101929-cad4fc0fd11c4f5fb739d1926cdfc784', NULL, '116.179.37.167', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603125635-9f76229e6b114ec5a249686c8ad5f122', NULL, '116.179.37.164', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603125637-719ac17ebaf74bc4bdcd46b4705bf39d', NULL, '116.179.37.138', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603153531-594bc29113fc4345a5926dc4fe70483b', NULL, '116.179.37.102', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603160027-8b317e7666b54e82b603eba0edca8330', NULL, '106.113.30.163', '中国', '河北', '石家庄', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603170852-ff69e04f2c2d4d888786ba992196ed4e', NULL, '110.249.134.190', '中国', '河北', '石家庄', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603181228-caa2506880444800add8c39785fd5297', NULL, '116.179.37.221', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603194956-e8460871dca64e8faf9ab20c7def7fc2', NULL, '58.248.193.193', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210603205030-e73fb9b52dbf45078e8a2371e203faff', NULL, '116.179.37.113', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604020427-9f36445ea6184e378ae25d2b9d80b23c', NULL, '116.179.37.102', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604021845-f93b1cd177774c05bf1c4b4ad796a801', NULL, '116.179.37.216', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604044130-cb91e07b222f4882971ca36897581081', NULL, '116.179.37.246', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604044131-31f716be76f14e2eb4f52edc58ae744e', NULL, '116.179.37.30', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604071827-aa41c4da1cb74bb9978f0e7ce51e4cac', NULL, '116.179.37.7', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604071828-cec76a7f39084d12b8d3341c8770c85a', NULL, '116.179.37.229', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604073622-7229b444cd074346813168d28218c876', NULL, '116.179.37.244', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604085941-9a8c2ff622ad4411a0401c48a3c66fa3', NULL, '218.244.241.210', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604091332-a841fa3166a34d378df2e96fa00756d9', NULL, '111.32.91.208', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604095535-338a78a5b2054947bf7c91b56e02a782', NULL, '116.179.37.47', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604095756-2cda4062efd64c25abfc9a750355f930', NULL, '40.77.189.184', '美国', '伊利诺斯', '芝加哥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604150632-4018e563c00c4b57a1d34c8f437d0273', NULL, '116.179.37.49', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604152432-c582e87599de4bc0b0c9c4b3e163017e', NULL, '116.179.37.172', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604174232-9d78dd2e6b424ff7b4f1e0de498e79be', NULL, '116.179.37.4', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604174236-2e9d6f8e8922427184030ed9a6fae95e', NULL, '116.179.37.136', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604201536-464435d57d7f4f17b1cfce8076ecafc3', NULL, '116.179.37.148', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604221211-f83daca0f372434192d700f9fbb724a5', NULL, '221.198.195.7', '中国', '天津', '红桥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210604222546-473cd85b7e6546008dce0750468e50d4', NULL, '125.47.18.98', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605000410-f1038d9a14ed4c61bff2a6ea52aaecc5', NULL, '112.44.106.206', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605013337-daba7d5a111e451caf4ac007da9771d4', NULL, '116.179.37.187', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605035730-4a3e205a90b04599bb2c9482b92e9944', NULL, '116.179.37.6', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605065037-280f6137285441a4ab94261892960d73', NULL, '116.179.37.83', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605065038-3a2f1636e0ca4e1aa1143803107174c5', NULL, '116.179.37.187', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605113853-417cbbb5c77f476d949017561c4cef2c', NULL, '121.8.136.202', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605114601-164890a1c8c0461cba3c192e5c3c5835', NULL, '116.179.37.31', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605143006-76df124a64484eb1883db73445c124dc', NULL, '116.179.37.118', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605154308-735884aef5dc4aea80ab3e55e2792e3e', NULL, '112.44.72.21', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605164544-acf13da91fb84408a8f7a0ccbab8dc9a', NULL, '1.85.41.158', '中国', '陕西', '西安', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605165504-1cb640b97b004dbb8b9e134d96a56baf', NULL, '45.77.183.9', '日本', '东京', '0081', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605165608-ff2e4c251a6343c2b152db91660928c2', NULL, '45.77.183.9', '日本', '东京', '0081', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605171306-c5d30d696c314cbe8f9aaddc98ec87a6', NULL, '116.179.37.58', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605180910-afb333f6d9b048818b496255560c2383', NULL, '58.16.228.156', '中国', '贵州', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Linux x86_64', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605183222-75be8d0c4f1b4b3e8e4528f5c510ca7d', NULL, '116.179.37.239', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605183226-077e89bcb93c4d1995235307e56bb661', NULL, '116.179.37.131', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605195745-b369f51061644990bcde31cf7527270f', NULL, '116.179.37.102', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605215407-4fbf86dfc9394048bca5709b502b1ade', NULL, '111.60.10.231', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210605223904-bd2ceedebecd4a75b276068ac2e896e1', NULL, '116.179.37.109', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606012214-c7ff0d67913b47e59be8d790ac2d7e86', NULL, '116.179.37.196', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606040500-c940c5d32f78432cb6d759a3dbc29c35', NULL, '116.179.37.61', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606040501-1035718a272243319cabb5793367c0b5', NULL, '116.179.37.41', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606064801-601a9acd5bdc4dfdbeba8d5811fde475', NULL, '116.179.37.253', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606083559-46769f8385bb475397bfd8e5dcd3b573', NULL, '119.103.247.19', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606093104-87215d6005854341867e95d59d62fc9e', NULL, '111.206.221.28', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606093105-fce07d1005354632a8e48fe43e3f83c8', NULL, '116.179.37.5', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606093943-b42da170d0e4462cacfc7639444b1cc9', NULL, '59.54.165.108', '中国', '江西', '上饶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606155153-a230bedc0a4c4428ad23b4654d3f9b45', NULL, '58.252.133.131', '中国', '广东', '湛江', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606161950-ee7aa7912c2241d1a71c8c258253d0aa', NULL, '116.179.37.50', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606163527-04a6d176f473476eab47495aa5ddbe81', NULL, '112.44.106.206', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606171003-d3762779f6054b47aaf090bf33c9c4aa', NULL, '112.2.253.203', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606171341-aa57b41e289a4ed49dcafeffb35878ab', NULL, '116.179.37.212', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210606190148-44283872cd4545c280ce7e11bf527fdc', NULL, '125.85.203.126', '中国', '重庆', '九龙坡', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607012605-6459e06189c44dad98a7ef73feeb42fe', NULL, '58.248.193.76', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607094112-2d8c180a12d541fbb807d219c5d8b92b', NULL, '117.176.185.73', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607095743-c55a320ce5234e368a5c9586f5c94566', NULL, '40.77.189.190', '美国', '伊利诺斯', '芝加哥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607104332-0a8a841079274fffa4df1bbf3337cea4', NULL, '110.184.179.84', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607105845-3365958ccafa45dba14a48e65d783856', NULL, '120.209.44.9', '中国', '安徽', '淮南', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607113849-8768862d896c40f3a680318a9e658628', NULL, '183.6.41.99', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607124029-0e4fdd6b13024c498800c8e628243fa6', NULL, '222.64.157.98', '中国', '上海', '闵行', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607143111-85a66a314af54ceba9c2475dd960c966', NULL, '117.176.185.105', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607160813-c35afe810f9b4e3c8a740dedeca0350f', NULL, '116.179.37.148', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607163021-da2c28a5da254df28820649302aee6b6', NULL, '117.59.91.71', '中国', '重庆', '重庆', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607203047-6753700c9096458e96cd4a74583b337c', NULL, '121.225.84.245', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607205438-2b4078c7468546f39a2d484ad6ef16fa', NULL, '120.227.56.135', '中国', '湖南', '长沙', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607210412-dd560b555f29402a8a6ec59e1acce1c5', NULL, '121.225.84.245', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210607231432-c9204bb851bf481182771e7a196293ab', NULL, '112.44.106.206', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608003800-81ab756142f8488a9e0b35f926983411', NULL, '199.255.98.30', '美国', '加利福尼亚', '洛杉矶', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608093652-2811a0ab9336439380c5b75f01f4294d', NULL, '116.179.37.163', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608104011-d7f9a81b10bd45bf9bf5f356c8fcd516', NULL, '117.176.185.70', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608110404-6d9bea228e974f819878aa166cb0a368', NULL, '171.44.69.44', '中国', '湖北', '十堰', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608150929-816e7db2bf4743b5a7384fad741aa970', NULL, '117.176.185.70', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608165439-df2e52d7721a4ec1869aa4c9c88b475e', NULL, '198.200.51.39', '美国', '加利福尼亚', '圣何塞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608170506-2a32923d59844782aa67f6524da73205', NULL, '117.176.185.70', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608173013-7a43e83becb440a3bab4e2e5e7389f33', NULL, '39.72.30.205', '中国', '山东', '日照', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608184818-48367d36f4e84196af16eb7604977888', NULL, '14.109.96.183', '中国', '重庆', '重庆', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608234306-3b8e10966f124f0a80f2316228014e04', NULL, '163.125.43.107', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608234544-072d05d6865b44a1a5bbb1290ef7304c', NULL, '117.174.27.121', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608235008-357a8e695f5440a49502dc5f89ce705e', NULL, '27.115.124.38', '中国', '上海', '上海', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608235019-4f2108cb8f974d82bc1307022665c403', NULL, '223.104.218.28', '中国', '四川', '移动', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210608235041-baf46b495bcc48dd8241b087fbcf8d74', NULL, '27.115.124.38', '中国', '上海', '上海', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609004212-294b2d7e5c88448eb6b94cd12e799c63', NULL, '218.197.153.221', '中国', '湖北', '武汉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609005352-5fbac2285bc64d2c8262bbc6cce53bac', NULL, '117.186.7.138', '中国', '上海', '浦东', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609094138-5572a1fafe0b4297ba2b30202f19ac9c', NULL, '124.93.196.12', '中国', '辽宁', '大连', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609184834-64b427145ee740a3a864872457ddeedc', NULL, '218.241.193.67', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609190730-c7ed6c164ada4ac19337e95a17d416ce', NULL, '20.194.41.121', '韩国', '首尔', '微软云', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609201403-fff64ebb63214e188432a5a9140c0e51', NULL, '116.179.37.120', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609210743-8142c5de2fad4a1a8b01a1d91fdca35f', NULL, '109.166.38.61', '日本', '东京', '0081', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609211545-e4638c0d65e14b14b4587358863d7dd2', NULL, '116.179.37.101', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609212043-84f4f07283fc4ff59100eeb699686ab9', NULL, '221.176.167.228', '中国', '河南', '信阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609223255-38f1ef92cda04482b25675968d3c3a21', NULL, '17.121.114.223', '美国', '001', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210609224452-54607d54c3014514947485c1757ebb47', NULL, '125.121.59.114', '中国', '浙江', '杭州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610033631-bad4107609a4411cbf3a4242c79d34f0', NULL, '182.150.123.43', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610094052-dd504a74a2a547d5be55a78f114d83fa', NULL, '218.12.15.29', '中国', '河北', '石家庄', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610121246-b80e8cc4512e41f19fc64c8d72a2aa76', NULL, '36.113.146.101', '中国', '江苏', '电信', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610141654-6b64f49b4e1f484b98e7679d04d141a3', NULL, '222.171.151.228', '中国', '黑龙江', '哈尔滨', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610150301-4275b0a943934b1cae6cf0478aa13ece', NULL, '160.16.120.53', '日本', '东京', '0081', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610172156-ee311634e8924547a687a7ea132e9e01', NULL, '42.236.10.120', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610182636-4926ec626b33495187126a42d93466d4', NULL, '195.154.122.133', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610204829-894f8424a5014903be89097735a5053a', NULL, '203.208.60.90', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610205917-20620e9bfd0a41b082ed6fe5b2bef336', NULL, '116.179.37.134', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610221948-1d6c9acaa9cc4b6798f4a60e3b4cd938', NULL, '117.174.27.121', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210610222850-636b0cc2fc2b4e10a62c4154c3013292', NULL, '203.208.60.104', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611090954-b38fb4201c444d1eaf48b3fc29e9745f', NULL, '113.110.224.133', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611113304-8771f0bbe2dc416aaa7827b3128da7c7', NULL, '195.154.122.133', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611120839-f056ad969551429db381cd7846d8e59d', NULL, '223.11.132.187', '中国', '山西', '太原', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611121738-90addef3be4b4333aa5e6b06af3f310f', NULL, '183.6.41.109', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611131436-e7fa42926f604bbf98ce3e151377da51', NULL, '203.208.60.101', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611132455-4d7d6a23357742c395b92aab5493bfcf', NULL, '117.178.113.225', '中国', '江西', '赣州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611144153-5a765a43cb3c46de8afc0ef294d7b72f', NULL, '124.65.97.50', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611152337-706ffede293746daa45076cfee6af9a0', NULL, '124.65.97.50', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 8', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611161418-151d193e619c4540b6631f2a7407e9a9', NULL, '113.66.0.57', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611171233-ee918391ea47477fa6af5fb789204516', NULL, '47.88.56.163', '美国', '加利福尼亚', '圣克拉拉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611172804-6c0252479c514f25827f4af78c3f3d4f', NULL, '157.0.72.243', '中国', '江苏', '南京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611202808-160bf8b6bf4441c9aed5c37c30ddec42', NULL, '117.176.185.110', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611212623-93e082724edd47d99201323594657abd', NULL, '195.154.122.204', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210611221227-8b33c7ebfd384555894417a45062f0a0', NULL, '116.179.37.169', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612051131-2d2d8fa3ca69419a9d9bb0ab0b4dc54a', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612073153-a820c758ccf74e60b11aa322f47b86a8', NULL, '106.121.132.122', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 11', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612105857-6a59a09512fa4a68a7be0150e360cc0b', NULL, '116.179.37.163', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612151546-4012fe48ee154fbab8a6d62f7782923e', NULL, '195.154.122.133', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612221228-53ab6967331d4482b19c6ada36120734', NULL, '116.179.37.181', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210612221713-63171987b01d4a8ba7111e980871ac52', NULL, '113.116.246.141', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613000545-0ce7d839dc5d4318bce53c51c3132cf0', NULL, '101.80.121.102', '中国', '上海', '浦东', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613032022-14553465edad4d4084c13e3a1286b0ed', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613120026-a07f591055a34b2884e44b3605a1ecea', NULL, '27.225.153.246', '中国', '甘肃', '庆阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613121030-b85442cf24a6487aad0ff2cbaa2b8e0d', NULL, '27.225.153.238', '中国', '甘肃', '庆阳', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 9', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613140831-28e6ca8217c54131be01aaac31c19708', NULL, '101.80.121.102', '中国', '上海', '浦东', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613160930-bced11d5df3146b4af0edb2c20dfa2df', NULL, '101.80.121.102', '中国', '上海', '浦东', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613192546-69dabecf12e941b29f1bcb9e649eb4c5', NULL, '117.188.11.125', '中国', '贵州', '贵阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613221227-71f2365b3d8747358719a123ccc37347', NULL, '116.179.37.226', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613222502-2a062f7bcb0c4da99c70022d045e00d3', NULL, '42.3.27.204', '中国', '香港', '电讯盈科', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613224433-1d31913302a74a1ca0445df6c5e0f791', NULL, '223.89.184.144', '中国', '河南', '驻马店', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210613225511-f9df4b1dd12b4566b4c9445e979606f1', NULL, '203.208.60.24', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614022424-4baaf0a40aa54c1f95bf2709dc54a883', NULL, '14.204.8.68', '中国', '云南', '昆明', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614070842-92da0bae95c042dcae3b61a3cb048c1f', NULL, '203.208.60.24', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', ' compatible', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614085734-8d519c2c08a346ffb4757f43a511aac4', NULL, '195.154.122.204', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614105805-40e7c916b6df46fb968aa7422bdfa5dc', NULL, '116.179.37.109', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614132712-1113938388b14deeaab0fa262b0d38b2', NULL, '42.89.201.222', '中国', '甘肃', '酒泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614170416-f7b809f0e7af4ee89165acc2ce0b9146', NULL, '109.166.38.61', '日本', '东京', '0081', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614171453-2d0ceadd52824d3b976ad8a094c2860d', NULL, '125.68.16.52', '中国', '四川', '德阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614180655-cb1fa79f8de14513a096092ac9077e29', NULL, '111.32.91.75', '中国', '天津', '西青', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614182043-8155bf56bb724089a78826b51ef876fa', NULL, '183.246.21.215', '中国', '浙江', '杭州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210614231500-df5702f102c549ef94b79251eab965b7', NULL, '113.13.158.214', '中国', '广西', '柳州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615010041-410caeec4e2749388ae8119cacd9ed1b', NULL, '14.211.18.151', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615012537-4f9f9730421e4b72b279c508cb6d50d1', NULL, '183.238.79.3', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615040127-2bb19a82fc3949939940b7a22e8542e6', NULL, '168.119.68.124', '德国', '萨克森自由州', '0049', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615091726-4b2824b0f6174493b9af05983fdbf131', NULL, '220.178.80.202', '中国', '安徽', '合肥', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615092254-a839ab90e71f4acba7eda939015d90c4', NULL, '61.150.43.56', '中国', '陕西', '西安', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615093139-e0f76c985b2145f2b978a3b3a07bc13d', NULL, '112.224.21.214', '中国', '山东', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615101219-69196bf984dc49a087bd4fb37c312de8', NULL, '172.105.112.65', '新加坡', '0065', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615101346-6d3a3c95eddf4d7d9551fd639df06260', NULL, '119.123.0.31', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615111454-c577271599c340edaac65b07cff15fd7', NULL, '111.0.8.1', '中国', '浙江', '杭州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615112020-c2c1f137517440339937f8e0b8dd1c06', NULL, '117.61.22.222', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615112737-5c5f47592c1e4eaaa94c8099622d8e43', NULL, '183.6.41.109', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615114103-7439187075dc4e1d83362b82ff946403', NULL, '114.242.26.45', '中国', '北京', '海淀', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615115110-0414fdfd4d174121b98d90355c77dd62', NULL, '183.6.41.109', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615140057-b9ff69043fa2400eb816645f85b951ba', NULL, '168.119.68.240', '德国', '萨克森自由州', '0049', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615143314-2fb3111500ca4a8d91c063d377e86e18', NULL, '117.61.22.222', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615143802-1a576ec20e5b4deca6f739400c32fa01', NULL, '123.132.248.70', '中国', '山东', '临沂', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615144146-89c1cb741f2d4c3c8ee806be2a9f636b', NULL, '121.12.147.249', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615145546-7dbab6becab44cf88db22687f400d3d2', NULL, '182.150.20.179', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615151955-0656e257022a45d1a71b5521f34bc56f', NULL, '121.13.218.233', '中国', '广东', '东莞', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615162854-c1e0daf12c1f4c12b9e7573878d85cc7', NULL, '117.61.22.222', '中国', '北京', '北京', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615163725-ef1c5b52c0de411f8a99c6b4cfca5c2a', NULL, '116.162.92.188', '中国', '湖南', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615164449-cf3095114d1844fdbab8752f5bf09f1f', NULL, '114.242.26.45', '中国', '北京', '海淀', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615221517-fcf57126c11a41b4bc897e409ec3b37c', NULL, '116.179.37.26', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615235521-8a3fa0b6431a429e8b591b52dd6a9a39', NULL, '183.92.250.227', '中国', '湖北', '联通', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210615235543-2e938ab3e69f45739b96732278dadf14', NULL, '157.230.253.75', '新加坡', '0065', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616012126-9983a7f857b34e11aca198bb934eedb7', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616075526-53b11476c7764269a677dffa45b1b33a', NULL, '101.88.74.40', '中国', '上海', '闵行', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616091612-dc77f6719fcf4083889f68a084a3b348', NULL, '172.105.112.65', '新加坡', '0065', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616101429-3e165cd8071c4024875f85d8cda85411', NULL, '113.103.89.145', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616105747-732d895b78f040dcae3d90eae1417731', NULL, '14.211.18.248', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616131846-fa6e56602f8a49acbe2c3dd2c185a242', NULL, '66.249.74.26', '美国', '谷歌云', '001', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616142200-6f94d4d230a94c2f8d27fb2594397ffb', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616143013-396692ce583841a2a7d10c1143d014ff', NULL, '180.136.162.17', '中国', '广西', '南宁', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616154255-da2bdb449e15451baed8f3d286adfc20', NULL, '14.211.18.67', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616154256-9be67a8254ec496c9068aa89f838ce66', NULL, '153.101.144.111', '中国', '江苏', '镇江', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616162731-11b2e7179c3245ca87eedfd0873dbb0e', NULL, '183.238.79.3', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616171325-fee49e51ec5e46ec91aaffbc5b58ca8a', NULL, '27.38.52.11', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616173401-17407b838e414d568dc2103a7bbfa464', NULL, '14.211.18.67', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616180642-4ae2b90c8c7448efb223f9ae61957110', NULL, '116.179.37.141', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616212604-4901aef5a71d424593e499b06e6508fa', NULL, '14.211.18.248', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616221113-c745c83d6c8b4a01add791b5499f0355', NULL, '112.94.101.109', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616231620-75772c1300b24b519c3539bc57ffd163', NULL, '195.154.122.133', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210616232628-90446e7118d7447fa5d9f571e71664aa', NULL, '14.211.18.248', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617005622-532c459a66e047d598cf3e5226bc27d7', NULL, '14.211.18.248', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617061248-754626b8486742f59d211c551d21b8c8', NULL, '195.154.122.204', '法国', '0033', NULL, 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617093724-5693725896f24e0eaeda9396d699e9cf', NULL, '14.211.18.25', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617111641-21fecf20eb10489dac680eb06176104f', NULL, '112.94.101.245', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617114056-b17d1e31c105482fb2ff484476c09016', NULL, '14.211.18.25', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617115232-4d9261c7526b406196dbcfca2d0efe7e', NULL, '123.147.251.85', '中国', '重庆', '重庆', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617115328-b4996281b9e0417e8041ce3152b3dc23', NULL, '27.115.124.70', '中国', '上海', '上海', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617115448-431b093e0c674385a68ed254f737cb2c', NULL, '42.236.10.117', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', ' U', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617122105-c64ab4ffbb7e4d06b95eef7dc1b570bf', NULL, '14.211.18.25', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617164815-ad6910c7d92f4fee8672ed55b2582414', NULL, '113.110.226.100', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617165619-daa128e4cc0d4ae592b4841b1d72f4f2', NULL, '168.119.68.124', '德国', '萨克森自由州', '0049', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617170736-9864c4ef2f31495c8c3243458a1ebe1f', NULL, '116.232.66.85', '中国', '上海', '徐汇', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617180645-8dbda9b8bed14d46b2d4a4202ba4d936', NULL, '116.179.37.233', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617185839-692b12842c8f45f0a871cd9e044aa941', NULL, '120.235.228.199', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617211227-ce7e9fe48398426987b9a39deb47b901', NULL, '183.64.128.12', '中国', '重庆', '合川', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210617230903-86838d665d8f48e5bab8348240a3d351', NULL, '113.66.35.200', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618033713-342fb790b2044bb7b53f387410eaa330', NULL, '8.209.197.110', '日本', '东京', '阿里云', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618041611-f324cdf9a5574ab5bde3638061484ba7', NULL, '111.7.100.24', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618084803-3b89389cbc2d41169933ddd64fbcc7fa', NULL, '36.99.136.140', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618090331-cc697324cbe44a82acbf594ab96c313b', NULL, '117.173.231.15', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618093112-373f6a58caf64148bab175e4d92b510b', NULL, '168.119.68.124', '德国', '萨克森自由州', '0049', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618110324-8345dbcd436d429791f4c26499ea366c', NULL, '59.41.245.14', '中国', '广东', '广州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618120010-a5c8bfdd6b024b99a67ad08685995897', NULL, '14.211.18.25', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618125413-240a2439b67b45808f52950c464ae6b2', NULL, '14.211.18.25', '中国', '广东', '中山', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618162250-1b52b19982c44bb0a67e4edadc43a18c', NULL, '1.196.238.251', '中国', '河南', '信阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618170908-c19a94a716fa455fb57cfe11e872b78a', NULL, '113.110.227.223', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618172206-af98596777a0487fb0f3a001694d1b6e', NULL, '210.21.248.138', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618181047-46286aee2b8849dc92ccc15774d3caf3', NULL, '113.110.227.223', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618182122-e5be642cc07f4fc1bdecc146e04207eb', NULL, '210.21.248.138', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618185124-3db6345079f94f94ad9e22c4833db438', NULL, '116.179.37.160', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618201910-d638906dcf1d4c87840f8af89da9b3ac', NULL, '66.249.66.7', '美国', '南卡罗来纳', '蒙克斯科纳', 'iZwz98s1wklbtsgjwvh6ejZ', ' Android 6.0.1', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618220647-06e436f53cc34f1dac27d1f8d9c7341c', NULL, '1.193.71.208', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618220813-fc1c4fad3c4c46f2a6c483108c32c890', NULL, '221.176.129.168', '中国', '河南', '安阳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210618230612-f497bc8bbcbc4e1d91494272406a8c71', NULL, '195.154.123.92', '法国', '巴黎', '0033', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619025853-8f3fb754d3924241b6bb111cd665c279', NULL, '116.179.37.189', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619025857-6c8be7c05bf349d4aa7d50cc56c18629', NULL, '116.179.37.110', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619051316-8246a528dbba452c95e593ace3094bad', NULL, '116.179.37.167', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619095232-d282dcabf89a458c8d8f85df27ce36fc', NULL, '113.110.227.223', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 7', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619103555-cfd4cfd487b5431893fa02e22c253e35', NULL, '112.44.105.249', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619105401-b46c740ce5c04a019e806994f80f7b81', NULL, '123.160.221.35', '中国', '河南', '郑州', 'iZwz98s1wklbtsgjwvh6ejZ', 'Mac OS X', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619123529-fb14436cf3034d889d552fddfb7fe4e9', NULL, '112.44.105.249', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619123917-f97fd77a5fdd42c4aa15678ac02b1b89', NULL, '168.119.68.240', '德国', '萨克森自由州', '0049', 'iZwz98s1wklbtsgjwvh6ejZ', ' AhrefsBot/7.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619143145-d79f7f1537304a58922e547292fe9865', NULL, '223.87.242.10', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619161221-8b1dc78cdc82415ba8adc7a6f68b944b', NULL, '223.87.242.10', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619183142-b7a896041b854011a1a4f6fb60859d64', NULL, '112.95.88.150', '中国', '广东', '深圳', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619185122-8dc8f953c22544ffaa36a33b5565865a', NULL, '116.179.37.72', '中国', '山西', '阳泉', 'iZwz98s1wklbtsgjwvh6ejZ', ' Baiduspider-render/2.0', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619210516-a8438e16fba5457ab9e46fa3485bd29f', NULL, '119.49.32.3', '中国', '吉林', '吉林', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619214116-4630255506c64b9986e590b85c9f3a8d', NULL, '119.49.34.42', '中国', '吉林', '吉林', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');
INSERT INTO `visit` VALUES ('20210619230449-d0d90b07e68544549d4d18965faefa18', NULL, '223.87.242.10', '中国', '四川', '成都', 'iZwz98s1wklbtsgjwvh6ejZ', 'Windows 10', '2025-08-04 15:14:50');

SET FOREIGN_KEY_CHECKS = 1;
