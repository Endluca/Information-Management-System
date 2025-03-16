/*
 Navicat Premium Data Transfer

 Source Server         : 本地（8.0）
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : homework

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 16/12/2024 08:56:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (10, 'user', 'pass7', 'user7@example.com', '2024-11-28 18:22:45');
INSERT INTO `admin` VALUES (11, 'user8', 'pass8', 'user8@example.com', '2024-11-28 18:22:45');
INSERT INTO `admin` VALUES (12, 'user9', 'pass9', 'user9@example.com', '2024-11-28 18:22:45');
INSERT INTO `admin` VALUES (14, 'lcpd', 'dsadada', '793686633@qq.com', '2024-11-28 18:37:15');
INSERT INTO `admin` VALUES (16, 'admin32', 'abc123', 'admin3@example.com', '2024-11-28 19:27:02');
INSERT INTO `admin` VALUES (17, 'admin321', 'abc123', 'admin3@example.com', '2024-11-28 19:27:17');
INSERT INTO `admin` VALUES (19, 'admin7', 'abc123', 'admin3@example.com', '2024-11-29 19:23:21');
INSERT INTO `admin` VALUES (23, 'user33333', 'pass3', 'user3@example.com', '2024-11-29 19:42:17');
INSERT INTO `admin` VALUES (24, 'user41111111111', 'pass4', 'user4@example.com', '2024-11-29 20:21:53');
INSERT INTO `admin` VALUES (25, 'javaweb', '123456', NULL, '2024-12-02 22:08:42');

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sort` int NULL DEFAULT NULL,
  `brand_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (1, 1, 'Brand1', 'This is the description of Brand1');
INSERT INTO `brand` VALUES (2, 2, 'Brand2', 'This is the description of Brand2');
INSERT INTO `brand` VALUES (3, 3, 'Brand3', 'This is the description of Brand3');
INSERT INTO `brand` VALUES (4, 4, 'Brand4', 'This is the description of Brand4');
INSERT INTO `brand` VALUES (5, 5, 'Brand5', 'This is the description of Brand5');
INSERT INTO `brand` VALUES (6, 6, 'Brand6', 'This is the description of Brand6');
INSERT INTO `brand` VALUES (7, 7, 'Brand7', 'This is the description of Brand7');
INSERT INTO `brand` VALUES (8, 8, 'Brand8', 'This is the description of Brand8');
INSERT INTO `brand` VALUES (9, 9, 'Brand9', 'This is the description of Brand9');
INSERT INTO `brand` VALUES (10, 10, 'Brand10', 'This is the description of Brand10');
INSERT INTO `brand` VALUES (11, 2, '风格和风格和风格', '很过分韩国发货');
INSERT INTO `brand` VALUES (12, 1, '风格和风格和风格', '很过分韩国发货');
INSERT INTO `brand` VALUES (13, 5, '5555', '13');
INSERT INTO `brand` VALUES (14, 1, '11', '很过分韩国发货');
INSERT INTO `brand` VALUES (15, 20, '22', '很过分韩国发货');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (20, '张三', '这是第一条评论', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (21, '李四', '非常不错的内容', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (22, '王五', '我很喜欢', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (23, '赵六', '有待改进', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (24, '孙七', '很棒的分享', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (25, '周八', '不太满意', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (26, '吴九', '期待更多', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (27, '郑十', '很好的见解', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (28, '陈十一', '还需要优化', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (29, '林十二', '继续努力', '2024-12-02 22:38:03');
INSERT INTO `comments` VALUES (30, '张三', '测试', '2024-12-02 22:41:43');
INSERT INTO `comments` VALUES (31, '张三', '犯得上翻跟斗', '2024-12-02 22:48:04');
INSERT INTO `comments` VALUES (32, '张三', '犯得上翻跟斗', '2024-12-02 22:48:33');
INSERT INTO `comments` VALUES (33, '张三', '犯得上翻跟斗', '2024-12-02 22:48:57');

-- ----------------------------
-- Table structure for comments_202205010147
-- ----------------------------
DROP TABLE IF EXISTS `comments_202205010147`;
CREATE TABLE `comments_202205010147`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments_202205010147
-- ----------------------------
INSERT INTO `comments_202205010147` VALUES (20, '宋宇欣', '留言1', '2024-11-30 21:34:26');
INSERT INTO `comments_202205010147` VALUES (21, '宋宇欣', '留言2', '2024-11-30 21:36:26');
INSERT INTO `comments_202205010147` VALUES (22, '宋宇欣', '留言3', '2024-11-30 21:37:45');
INSERT INTO `comments_202205010147` VALUES (23, '宋宇欣', '留言4', '2024-11-30 21:40:42');
INSERT INTO `comments_202205010147` VALUES (24, '宋宇欣', '留言5', '2024-11-30 21:42:02');
INSERT INTO `comments_202205010147` VALUES (25, '宋宇欣', '留言6', '2024-11-30 21:43:47');
INSERT INTO `comments_202205010147` VALUES (26, '课程学习社区系统', '脚后跟v忽悠', '2024-11-30 21:44:23');
INSERT INTO `comments_202205010147` VALUES (27, '课程学习社区系统', '脚后跟v忽悠', '2024-11-30 21:45:27');

-- ----------------------------
-- Table structure for comments_202205010168
-- ----------------------------
DROP TABLE IF EXISTS `comments_202205010168`;
CREATE TABLE `comments_202205010168`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments_202205010168
-- ----------------------------
INSERT INTO `comments_202205010168` VALUES (20, '张莹', '测试', '2024-11-30 20:59:46');
INSERT INTO `comments_202205010168` VALUES (21, '张莹', '多少', '2024-11-30 21:06:05');
INSERT INTO `comments_202205010168` VALUES (22, '张莹', '多少', '2024-11-30 21:07:08');
INSERT INTO `comments_202205010168` VALUES (23, '张莹', '多少是的', '2024-11-30 21:08:10');
INSERT INTO `comments_202205010168` VALUES (24, '张莹', '多少是的', '2024-11-30 21:11:54');
INSERT INTO `comments_202205010168` VALUES (25, '张莹', '成都vv', '2024-11-30 21:13:07');
INSERT INTO `comments_202205010168` VALUES (26, '张莹', 'sdsafsfgd', '2024-11-30 21:17:36');
INSERT INTO `comments_202205010168` VALUES (27, '大苏打撒旦', 'sdsafsfgd', '2024-11-30 21:18:28');
INSERT INTO `comments_202205010168` VALUES (28, '大苏打撒旦', 'sdsafsfgd', '2024-11-30 21:20:15');

-- ----------------------------
-- Table structure for pictures
-- ----------------------------
DROP TABLE IF EXISTS `pictures`;
CREATE TABLE `pictures`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `updateTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `status` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pictures
-- ----------------------------
INSERT INTO `pictures` VALUES (5, 'Nature', '/info_system/uploads/1.jpg', 'Forest Waterfalla', 'forest,waterfall,nature1', '2024-12-16T01:12:51.439417300', 1);
INSERT INTO `pictures` VALUES (6, 'Animals', '/info_system/uploads/1.jpg', 'Lion in the Savannah', 'lion,savannah,wildlife', '2024-12-16T01:03:04.533862', 0);
INSERT INTO `pictures` VALUES (7, 'Animals', '/info_system/uploads/001.jpg', 'Panda Eating Bamboo', 'panda,bamboo,cute', '2024-12-15 21:18:31', 0);
INSERT INTO `pictures` VALUES (8, 'Cities', '/info_system/uploads/001.jpg', 'Night View of New York', 'new york,night city,urban', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (9, 'Cities', '/info_system/uploads/001.jpg', 'Sunrise Over Tokyo', 'tokyo,sunrise,cityscape', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (10, 'Art', '/info_system/uploads/001.jpg', 'Abstract Colorful Shapes', 'abstract,colorful,modern art', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (11, 'Art', '/info_system/uploads/001.jpg', 'Classical Oil Painting', 'classical,oil painting,art', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (12, 'Technology', '/info_system/uploads/001.jpg', 'Futuristic AI Robot', 'AI,robot,futuristic', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (13, 'Technology', 'https://example.com/images/tech2.jpg', 'Smartphone with Holographic Screen', 'smartphone,holographic,technology', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (14, 'Food', 'https://example.com/images/food1.jpg', 'Delicious Pizza', 'pizza,food,delicious', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (15, 'Food', 'https://example.com/images/food2.jpg', 'Fresh Sushi Platter', 'sushi,food,japanese', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (16, 'Sports', 'https://example.com/images/sports1.jpg', 'Soccer Match in Action', 'soccer,football,sports', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (17, 'Sports', 'https://example.com/images/sports2.jpg', 'Basketball Slam Dunk', 'basketball,dunk,sports', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (18, 'Nature', 'https://example.com/images/nature3.jpg', 'Ocean Waves at Sunset', 'ocean,waves,sunset', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (19, 'Animals', 'https://example.com/images/animals3.jpg', 'Elephant Family', 'elephant,wildlife,family', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (20, 'Cities', 'https://example.com/images/cities3.jpg', 'Paris Eiffel Tower', 'paris,eiffel tower,landmark', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (21, 'Art', 'https://example.com/images/art3.jpg', 'Street Art Mural', 'street art,mural,colorful', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (22, 'Technology', 'https://example.com/images/tech3.jpg', 'Cybersecurity Concept', 'cybersecurity,technology,security', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (23, 'Food', 'https://example.com/images/food3.jpg', 'Gourmet Chocolate Cake', 'chocolate,cake,dessert', '2024-12-15 21:18:31', 1);
INSERT INTO `pictures` VALUES (24, '测试', '/info_system/uploads/001.jpg', '传到', '11', '2024-12-15T23:29:20.676098200', 1);
INSERT INTO `pictures` VALUES (25, '111', '/info_system/uploads/1.jpg', '11', '111', '2024-12-16T00:05:05.359355200', 1);
INSERT INTO `pictures` VALUES (26, '测试', '/info_system/uploads/1.jpg', '测试', '1', '2024-12-16T00:56:28.788877700', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (4, '审核人员', '审核提交的内容', '2024-11-28 22:00:16');
INSERT INTO `role` VALUES (5, '访客', '只能查看部分公开内容', '2024-11-28 22:00:16');
INSERT INTO `role` VALUES (6, '超级管理员', '超越普通管理员的权限', '2024-11-28 22:00:16');
INSERT INTO `role` VALUES (7, '数据分析师111', '处理和分析数据', '2024-11-28 22:00:16');
INSERT INTO `role` VALUES (8, '市场专员', '负责市场推广工作', '2024-11-28 22:00:16');
INSERT INTO `role` VALUES (12, '小张', '组员', '2024-11-29 18:58:24');
INSERT INTO `role` VALUES (13, '编辑人', '负责内容编辑', '2024-12-02 22:36:50');

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `createdTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (3, 'Jane Smith撒', 'Female', '0987654321', 'janesmith@example.com', '北京', '2024-11-28 19:34:56', '是');
INSERT INTO `vip` VALUES (4, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '是');
INSERT INTO `vip` VALUES (5, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '是');
INSERT INTO `vip` VALUES (6, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (7, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '是');
INSERT INTO `vip` VALUES (8, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (9, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (10, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (11, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (12, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '456 Elm Ave', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (13, 'Bob Johnson', 'Male', '1112223333', 'bobjohnson@example.com', '789 Oak Rd', '2024-11-28 19:34:56', '否');
INSERT INTO `vip` VALUES (14, 'dsada', NULL, NULL, 'lyp1405419712@gmail.com', NULL, '2024-11-28 21:35:38', '是');
INSERT INTO `vip` VALUES (15, 'dsada', NULL, NULL, 'lyp1405419712@gmail.com', NULL, '2024-11-28 21:35:51', '是');
INSERT INTO `vip` VALUES (16, '20240854403222', '男', '18364073152', 'lcp793686633@gmail.com', '2', '2024-11-28 21:39:45', '否');
INSERT INTO `vip` VALUES (17, '20240854403222', '男', '18364073152', 'lcp793686633@gmail.com', '2', '2024-11-28 21:40:00', '否');
INSERT INTO `vip` VALUES (18, '20240854403dsa', '男', '18364073152', '793686633@qq.com', '上海', '2024-11-28 21:41:48', '是');
INSERT INTO `vip` VALUES (19, 'Jane Smith', 'Female', '0987654321', 'janesmith@example.com', '上海', '2024-11-28 21:51:19', '否');
INSERT INTO `vip` VALUES (20, 'Jane Smith1', 'Female', '0987654321', 'janesmith@example.com', '', '2024-11-28 22:16:04', '否');
INSERT INTO `vip` VALUES (21, 'Jane Smith的撒大', 'Female', '0987654321', 'janesmith@example.com', '', '2024-11-28 22:20:14', '是');
INSERT INTO `vip` VALUES (22, '小张', '男', '19314852041', 'xiangxiang@outlook.com', '上海', '2024-11-29 19:43:57', '是');
INSERT INTO `vip` VALUES (23, '小杨', '女', '19116415208', 'wan816929@outlook.com', '广州', '2024-11-29 19:44:29', '是');
INSERT INTO `vip` VALUES (24, 'root', '男', '19116415208', 'admin3@example.com', '北京', '2024-11-29 20:07:30', '是');
INSERT INTO `vip` VALUES (25, '11', '男', '19116415208', 'admin3@example.com', '', '2024-12-02 15:31:36', '是');
INSERT INTO `vip` VALUES (26, '22', '男', '19116415208', 'user4@example.com', '', '2024-12-02 15:31:50', '是');
INSERT INTO `vip` VALUES (27, 'yang9', '男', '19314852041', 'koukou20232023@outlook.com', '北京', '2024-12-02 22:19:25', '是');
INSERT INTO `vip` VALUES (28, 'Jane', '男', '0987654321', 'janesmith@example.com', '', '2024-12-02 22:23:51', '是');

SET FOREIGN_KEY_CHECKS = 1;
