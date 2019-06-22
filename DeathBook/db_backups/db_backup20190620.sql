-- Adminer 4.7.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `deathbook` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `deathbook`;

DROP TABLE IF EXISTS `auth_cas`;
CREATE TABLE `auth_cas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `service` varchar(512) DEFAULT NULL,
  `ticket` varchar(512) DEFAULT NULL,
  `renew` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_cas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `auth_event`;
CREATE TABLE `auth_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_stamp` datetime DEFAULT NULL,
  `client_ip` varchar(512) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `origin` varchar(512) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  CONSTRAINT `auth_event_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_event` (`id`, `time_stamp`, `client_ip`, `user_id`, `origin`, `description`) VALUES
(1,	'2019-06-22 14:50:18',	'127.0.0.1',	1,	'auth',	'User 1 Registered'),
(2,	'2019-06-22 14:50:21',	'127.0.0.1',	1,	'auth',	'User 1 Logged-out'),
(3,	'2019-06-22 14:50:41',	'127.0.0.1',	2,	'auth',	'User 2 Registered'),
(4,	'2019-06-22 14:50:46',	'127.0.0.1',	2,	'auth',	'User 2 Logged-out'),
(5,	'2019-06-22 14:50:54',	'127.0.0.1',	1,	'auth',	'User 1 Logged-in');

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(512) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_group` (`id`, `role`, `description`) VALUES
(1,	'user1',	'User1'),
(2,	'normal',	NULL),
(3,	'admin',	NULL);

DROP TABLE IF EXISTS `auth_membership`;
CREATE TABLE `auth_membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id__idx` (`user_id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_membership_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auth_membership_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_membership` (`id`, `user_id`, `group_id`) VALUES
(1,	1,	2),
(2,	2,	2),
(3,	1,	3);

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `name` varchar(512) DEFAULT NULL,
  `table_name` varchar(512) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id__idx` (`group_id`),
  CONSTRAINT `auth_permission_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `registration_key` varchar(512) DEFAULT NULL,
  `reset_password_key` varchar(512) DEFAULT NULL,
  `registration_id` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_user` (`id`, `first_name`, `last_name`, `email`, `password`, `registration_key`, `reset_password_key`, `registration_id`) VALUES
(1,	'admin',	'admin',	'admin@admin.admin',	'pbkdf2(1000,20,sha512)$8508ec76d489ce34$350b53f52ab4e2f38024ca5e3ddd8e43b67d9eb1',	'',	'',	''),
(2,	'云',	'陈',	'xtiqin@163.com',	'pbkdf2(1000,20,sha512)$88137250342bb178$4a85a59f3f32ee6cf9e2e73dd4988a2dc8b92422',	'',	'',	'');

DROP TABLE IF EXISTS `creature`;
CREATE TABLE `creature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soul` int(11) DEFAULT NULL,
  `creature_name` varchar(512) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `creature_state` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `soul__idx` (`soul`),
  CONSTRAINT `creature_ibfk_1` FOREIGN KEY (`soul`) REFERENCES `soul` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `creature` (`id`, `soul`, `creature_name`, `lifetime`, `birthday`, `description`, `creature_state`) VALUES
(1,	4,	'谢程序',	10000,	'1970-06-22 14:52:04',	NULL,	'dead'),
(2,	4,	'龚城师',	10000,	'1998-06-22 14:52:29',	NULL,	'alive'),
(3,	2,	'许仙',	20000,	'2000-06-22 15:34:36',	NULL,	'alive'),
(4,	5,	'张三',	30000,	'1980-06-22 15:45:26',	NULL,	'alive');

DROP TABLE IF EXISTS `life_log`;
CREATE TABLE `life_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creature` int(11) DEFAULT NULL,
  `log_msg` varchar(512) DEFAULT NULL,
  `log_content` longtext DEFAULT NULL,
  `add_lifetime` int(11) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creature__idx` (`creature`),
  CONSTRAINT `life_log_ibfk_1` FOREIGN KEY (`creature`) REFERENCES `creature` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `life_log` (`id`, `creature`, `log_msg`, `log_content`, `add_lifetime`, `log_time`) VALUES
(1,	2,	'出生时天边五彩祥云',	NULL,	0,	'2000-06-22 14:52:59'),
(2,	2,	'施舍一个乞丐',	'那孩子被人控制，施舍的钱成了控制人继续犯罪的资本',	-20,	'2008-06-22 14:54:16'),
(3,	2,	'收养一个流浪猫',	NULL,	1,	'2012-06-22 14:54:31'),
(4,	3,	'救下一条小蛇',	NULL,	20,	'2007-06-22 15:35:08');

DROP TABLE IF EXISTS `soul`;
CREATE TABLE `soul` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soul_name` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `soul` (`id`, `soul_name`) VALUES
(1,	'东海仙石'),
(2,	'牧童'),
(3,	'蛇仙'),
(4,	'永世程序员'),
(5,	'懒人');

DROP VIEW IF EXISTS `sum_lifetime`;
CREATE TABLE `sum_lifetime` (`id` int(11), `creature` int(11), `log_msg` varchar(512), `log_content` longtext, `add_lifetime` int(11), `log_time` datetime, `total_add_lifetime` decimal(32,0));


DROP TABLE IF EXISTS `sum_lifetime`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `sum_lifetime` AS select `life_log`.`id` AS `id`,`life_log`.`creature` AS `creature`,`life_log`.`log_msg` AS `log_msg`,`life_log`.`log_content` AS `log_content`,`life_log`.`add_lifetime` AS `add_lifetime`,`life_log`.`log_time` AS `log_time`,sum(`life_log`.`add_lifetime`) AS `total_add_lifetime` from `life_log` group by `life_log`.`creature`;

-- 2019-06-22 11:52:30
