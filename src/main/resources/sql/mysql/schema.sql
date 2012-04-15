CREATE SCHEMA IF NOT EXISTS `cms4j_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cms4j_dev` ;

-- -----------------------------------------------------
-- Table `cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_category` ;

CREATE  TABLE IF NOT EXISTS `cms_category` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT COMMENT '栏目ID' ,
  `father_category_id` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '上级栏目ID' ,
  `category_name` VARCHAR(255) NOT NULL COMMENT '栏目名称' ,
  `display_order` MEDIUMINT(8) NOT NULL DEFAULT 1 COMMENT '显示顺序' ,
  `show_type` VARCHAR(20) NOT NULL DEFAULT 0 COMMENT '显示方式' ,
  `url` VARCHAR(80) NOT NULL DEFAULT 0 COMMENT '自定义链接地址' ,
  `description` TEXT NOT NULL COMMENT 'SEO描述' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '文章数' ,
  `allow_publish` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否允许发布文章' ,
  `show_nav` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否显示在导航栏' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否关闭' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_upid_catid` (`father_category_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '栏目表';


-- -----------------------------------------------------
-- Table `cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms_article` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子ID' ,
  `user_id` MEDIUMINT(8) NOT NULL COMMENT '用户id' ,
  `category_id` MEDIUMINT(8) NOT NULL COMMENT '分类id' ,
  `subject` VARCHAR(80) NOT NULL COMMENT '标题' ,
  `message` MEDIUMTEXT NOT NULL COMMENT '帖子内容' ,
  `image_name` VARCHAR(30) NOT NULL COMMENT '文章图片',
  `digest` VARCHAR(255) NOT NULL ,
  `keyword` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '帖子标签' ,
  `top` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否是首贴' ,
  `rate` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '评分分数' ,
  `rate_times` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '评分次数' ,
  `views` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否允许点评' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '帖子审核状态' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已删除' ,
  PRIMARY KEY (`id`),
  INDEX `fk_cms_article_user` (`user_id` ASC),
  INDEX `fk_cms_artical_category` (`category_id` ASC)
)ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '文章表';

-- DELIMITER $$
-- DROP FUNCTION IF EXISTS `nextval` $$
-- CREATE DEFINER=`cms4j`@`%` FUNCTION `nextval`(seq_name VARCHAR(50)) RETURNS TINYINT(3)
-- BEGIN
--  UPDATE cms_article
--  SET views = views + 1
--  WHERE id = seq_name;
--  RETURN views;
-- END $$
-- DELIMITER;

-- -----------------------------------------------------
-- Table `cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms_user` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id' ,
  `group_id` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT '用户组id' ,
  `email` VARCHAR(40) NOT NULL COMMENT '电子邮箱' ,
  `username` VARCHAR(40) NOT NULL COMMENT '用户名' ,
  `password` VARCHAR(40) NOT NULL COMMENT '密码' ,
  `salt` VARCHAR(16) NOT NULL COMMENT '密码加强' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '用户状态0未审核1已审核' ,
  `email_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '邮箱验证状态 未认证= 0 认证= 1' ,
  `avatar_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否有头像 0没有 1有' ,
  `photo_url` VARCHAR(40) NOT NULL DEFAULT '/default.jpg' COMMENT '头像地址' ,
  `time_offset` VARCHAR(4) NOT NULL DEFAULT '0800' COMMENT '时区' ,
  `last_ip` INT(10) NOT NULL ,
  `last_time` DATETIME NOT NULL DEFAULT 0 COMMENT '注册时间' ,
  `last_act_time` DATETIME NOT NULL DEFAULT 0 ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`),
  INDEX `fk_cms_user_group` (`group_id` ASC)
)ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms_comment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID' ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(255) NOT NULL COMMENT '用户名' ,
  `message` TEXT NOT NULL COMMENT '评论内容' ,
  `post_ip` INT(10) NOT NULL COMMENT '评论IP' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核  2=可删除' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_comment_cms_artical1` (`article_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms_manage_log` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理日志ID' ,
  `user_id` MEDIUMINT(8) NOT NULL ,
  `action` TINYINT(1) NOT NULL COMMENT '0=创建菜单 1=修改菜单 2=移动菜单 3=删除菜单 4=发表文章 5=修改文章 6=审核文章 7=删除文章 8=添加用户 9=修改用户信息 10=审核用户 11=删除用户' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_log_cms_user1` (`user_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group` ;

CREATE  TABLE IF NOT EXISTS `cms_group` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_name` VARCHAR(40) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user_group` ;

CREATE  TABLE IF NOT EXISTS `cms_user_group` (
  `user_id` MEDIUMINT(8) NOT NULL ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_user_group_cms_user1` (`user_id` ASC) ,
  INDEX `fk_cms_user_group_cms_group1` (`group_id` ASC) ,
  PRIMARY KEY (`user_id`, `group_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_group_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group_permission` ;

CREATE  TABLE IF NOT EXISTS `cms_group_permission` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  `permission` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_group_permission_cms_group1` (`group_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_archive` ;

CREATE  TABLE IF NOT EXISTS `cms_archive` (
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `article_count` TINYINT(3) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_archive_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_archive_article` ;

CREATE  TABLE IF NOT EXISTS `cms_archive_article` (
  `archive_id` MEDIUMINT(8) NOT NULL ,
  `category_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_archive_article_cms_archive1` (`archive_id` ASC) ,
  INDEX `fk_cms_archive_article_cms_category1` (`category_id` ASC) ,
  PRIMARY KEY (`archive_id`, `category_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_image` ;

CREATE  TABLE IF NOT EXISTS `cms_image` (
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `image_url` VARCHAR(80) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `show_index` TINYINT(1) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;

-- -----------------------------------------------------
-- Table `cms_link`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `cms_link`;

CREATE TABLE IF NOT EXISTS `cms_link` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `url` VARCHAR(80) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (id) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;



-- -----------------------------------------------------
-- 用户测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user`(`id`, `group_id`, `email`, `username`, `password`, `salt`, `status`, `email_status`, `avatar_status`, `photo_url`, `time_offset`, `last_ip`, `last_time`, `last_act_time`, `last_modified_date`, `created_date`, `deleted`) VALUES (1,1,'dreambt@126.com','纪柏涛','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f',1,1,0,'male.gif','0800',134744072,'1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00',1);


-- -----------------------------------------------------
-- 用户组测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (1,'后台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (2,'前台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (3,'自由撰稿人');


-- -----------------------------------------------------
-- 用户组权限测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (1,1,"user:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (2,1,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (3,1,"user:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (4,1,"user:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (5,1,"user:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (6,1,"group:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (7,1,"group:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (8,1,"group:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (9,1,"group:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (10,1,"group:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (11,1,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (12,1,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (13,1,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (14,1,"article:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (15,1,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (16,1,"comment:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (17,1,"comment:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (18,1,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (19,1,"comment:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (20,1,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (21,1,"category:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (22,1,"category:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (23,1,"category:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (24,1,"category:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (25,1,"category:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (26,1,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (27,1,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (28,1,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (29,1,"gallery:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (30,1,"gallery:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (32,1,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (33,1,"user:save");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (36,2,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (37,2,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (38,2,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (39,2,"article:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (40,2,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (41,2,"comment:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (42,2,"comment:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (43,2,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (44,2,"comment:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (45,2,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (56,2,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (57,2,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (58,2,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (59,2,"gallery:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (60,2,"gallery:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (62,3,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (63,3,"user:save");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (66,3,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (67,3,"article:edit");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (68,3,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (70,3,"article:list");


-- -----------------------------------------------------
-- 分类测试数据
-- -----------------------------------------------------
INSERT INTO `cms_category` (`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `show_nav`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, '系统公告', 0, 'NONE', 'index', '无', 0, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),

(2, 1, '新闻资讯', 2, 'NONE', '', '本中心的最新新闻资讯', 0, 0, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(3, 2, '新闻动态', 4, 'LIST', '', '新闻动态', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(4, 2, '行业资讯', 6, 'LIST', '', '行业资讯', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(5, 2, '学术交流', 8, 'LIST', '', '学术交流', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),

(6, 1, '中心概况', 10, 'NONE', '', '中心概况', 0, 0, 1, '2012-04-07 08:30:17', '2012-03-22 15:58:00', 0),
(7, 6, '中心简介', 12, 'CONTENT', '', '中心简介', 0, 1, 1, '2012-04-07 08:42:41', '2012-03-22 15:58:00', 0),
(8, 6, '组织结构', 14, 'CONTENT', '', '组织结构', 0, 1, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),
(9, 6, '运作机制', 16, 'CONTENT', '', '运作机制', 0, 1, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),
(10, 6, '联系我们', 18, 'NONE', 'about', '联系我们', 1, 0, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),

(11, 1, '学术团队', 20, 'NONE', '', '', 0, 0, 1, '2012-04-07 12:24:15', '2012-03-22 15:58:00', 0),
(12, 11, '学术带头人', 22, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:49:57', '2012-04-07 08:49:57', 0),
(13, 11, '学术骨干', 24, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:51:08', '2012-04-07 08:50:25', 0),
(14, 11, '专家顾问', 26, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:52:14', '2012-04-07 08:52:14', 0),

(15, 1, '学术研究', 30, 'NONE', '', '', 0, 0, 1, '2012-04-07 12:24:43', '2012-03-22 15:58:00', 0),
(16, 15, '研究方向', 32, 'DIGEST', '', '', 0, 1, 1, '2012-04-07 08:52:33', '2012-04-07 08:52:33', 0),
(17, 15, '科研成果', 34, 'DIGEST', '', '', 1, 1, 1, '2012-04-07 08:52:49', '2012-04-07 08:52:49', 0),

(18, 1, '资讯服务', 40, 'NONE', '', '', 0, 0, 1, '2012-04-07 12:25:15', '2012-03-22 15:58:00', 0),
(19, 18, '财政税务', 41, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:57:31', '2012-04-07 08:57:31', 0),
(20, 18, '中小银行', 42, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:57:44', '2012-04-07 08:57:44', 0),
(21, 18, '证券保险', 43, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:58:00', '2012-04-07 08:58:00', 0),
(22, 18, '政府决策', 44, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:58:15', '2012-04-07 08:58:15', 0),

(23, 1, '教育培训', 50, 'NONE', '', '', 0, 0, 1, '2012-04-07 12:25:16', '2012-04-07 08:31:17', 0),

(24, 1, '产学研合作', 60, 'NONE', '', '', 0, 0, 1, '2012-04-07 08:31:51', '2012-04-07 08:31:51', 0),
(25, 24, '成果转化', 62, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:58:46', '2012-04-07 08:58:46', 0),
(26, 24, '合作伙伴', 64, 'FULL', '', '', 0, 1, 1, '2012-04-07 08:59:07', '2012-04-07 08:59:07', 0),
(27, 24, '对外交流', 66, 'ALBUM', '', '', 0, 1, 1, '2012-04-07 08:59:29', '2012-04-07 08:59:29', 0),

(28, 1, '网上办公', 70, 'NONE', '', '', 0, 0, 1, '2012-04-07 08:53:09', '2012-04-07 08:53:09', 0),
(29, 28, '办公系统', 72, 'DIGEST', 'http://oa.sdufe.edu.cn/', '', 0, 0, 1, '2012-04-07 08:53:09', '2012-04-07 08:53:09', 0),
(30, 28, '文件交换', 34, 'DIGEST', 'http://filex.sdufe.edu.cn/', '', 0, 0, 1, '2012-04-07 08:56:05', '2012-04-07 08:56:05', 0);


-- -----------------------------------------------------
-- 文章测试数据
-- -----------------------------------------------------
INSERT INTO `cms_article` (`id`, `user_id`, `category_id`, `subject`, `message`, `digest`, `keyword`, `top`, `rate`, `rate_times`, `views`, `allow_comment`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, 3, '北京用友政务领导和专家来本中心交流', '&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;2012&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;年&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;3&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;月&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;27&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;会见中，徐如志主任介绍了本中心的基本情况，着重突出了山东财经大学的优势学科，本中心将计算机技术与金融、财税结合的特点，并阐明了本中心&ldquo;产学研&rdquo;一体化的定位，表达了与社会企业开放合作的意愿。用友政务的周海樯总经理也介绍了用友政务的发展概况，业务优势，以及在企业发展中遇到的一些困惑和难题。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;双方的专家和教授就税务信息化方面的热点问题，展开了具有前瞻性和建设性的讨论。最后，双方本着合作共赢、开放发展的理念，就服务支持、客户培训、高端咨询、共建技术平台、合作研究等合作事项，进行了深入的探讨，对于未来的合作达成了初步的共识。&lt;/span&gt;&lt;/p&gt;', '', '    2012年3月27日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。     会见中，徐如志主任介绍了本中心的基本情况，着重突出了山东财经大学的优势学科，本中心将计算机技术与金融、财税结合的特点，并阐明', '', 0, 0, 0, 6, 1, 1, '2012-04-15 03:40:48', '2012-04-15 02:01:51', 0),
(2, 1, 3, '与山东中孚信息产业股份有限公司见面交流会', '&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;2012&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;年&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;3&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;月&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;28&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;日，山东省金融信息工程技术中心与山东中孚信息产业股份有限公司在本中心会议室举行了合作交流会。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;交流会受到双方的高度重视。本中心主任徐如志率领聂秀山副教授、赵华伟副教授及办公室主任与中孚公司的领导和专家进行了友好的交流会谈。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;交流会伊始，由徐如志主任对山东财经大学的历史沿革、本中心的创建背景、研究方向以及目标定位等方面做了说明，并对近阶段中心已取得的科研成果进行了介绍。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;会上山东中孚和本中心就&lt;/span&gt;&lt;span style=&quot;font-size:19px;background-color:white&quot;&gt;面向金融、财税部门的信息安全培训、咨询等业务的开展，成立信息安全联合实验室以及人才培养&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;等合作事项进行了建设性的探讨。&lt;/span&gt;&lt;span style=&quot;font-size:19px;&quot;&gt;&amp;nbsp;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;此次会议，增进了双方的友谊和了解，为今后打造更优秀的产学研一体的金融信息工程技术研究中心奠定了良好的基础。&lt;/span&gt;&lt;/p&gt;', '', '&nbsp;&nbsp;&nbsp;&nbsp;2012年3月28日，山东省金融信息工程技术中心与山东中孚信息产业股份有限公司在本中心会议室举行了合作交流会。 &nbsp;&nbsp;&nbsp;&nbsp;交流会受到双方的高度重视。本中心主任徐如志率领聂秀山副教授、赵华伟副教授及办公室主任与中孚公司的领导和专家进行了友好的交流会谈。 交流会伊始，由徐如志主任对山东财经大学的历', '', 0, 0, 0, 2, 1, 1, '2012-04-15 03:40:39', '2012-04-15 03:32:49', 0),
(3, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(4, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(5, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(6, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(7, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(8, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(9, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(10, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(11, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(12, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(13, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(14, 1, 1, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0);


-- -----------------------------------------------------
-- 评论测试数据
-- -----------------------------------------------------
INSERT INTO `cms_comment` (`id`, `article_id`, `username`, `message`, `post_ip`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(2, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(3, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(4, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(5, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(6, 2, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(7, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(8, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0);


-- -----------------------------------------------------
-- 相册测试数据
-- -----------------------------------------------------
INSERT INTO `cms_image` (`id`, `title`, `image_url`, `description`, `show_index`, `last_modified_date`, `created_date`) VALUES
(1, 'a1a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(2, 'a2a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(3, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(4, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(5, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(6, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(7, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(8, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(9, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(10, '0aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(11, '1aa', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(12, '2aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(13, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(14, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(15, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(16, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(17, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(18, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(19, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(20, '0aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(21, '1aa', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31');

-- -----------------------------------------------------
-- 友情链接测试数据
-- -----------------------------------------------------
INSERT INTO `cms_link` (`id`, `title`, `url`, `status`, `last_modified_date`, `created_date`) VALUES
(1,'山东财经大学','http://www.sdufi.edu.cn/','1', null, null),
(2,'山东华软金盾','http://www.neiwang.cn/','1', null, null),
(3,'山东舜德数据','http://www.sundatasoft.com/','1', null, null),
(4,'戈尔特西斯','http://www.goitsys.com/','1', null, null),
(5,'山东省城商联盟','','1', null, null),
(6,'山东省农信社','http://www.sdnxs.com/','1', null, null),
(7,'山东财经大学','http://www.sdufi.edu.cn/','1', null, null),
(8,'山东华软金盾','http://www.neiwang.cn/','1', null, null),
(9,'山东舜德数据','http://www.sundatasoft.com/','1', null, null),
(10,'戈尔特西斯','http://www.goitsys.com/','1', null, null),
(11,'山东省城商联盟','','1', null, null),
(12,'山东省农信社','http://www.sdnxs.com/','1', null, null);