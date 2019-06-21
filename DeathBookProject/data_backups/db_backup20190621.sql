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
(1,	'2019-06-21 00:41:03',	'172.20.0.1',	NULL,	'auth',	'Group 1 created'),
(2,	'2019-06-21 00:41:03',	'172.20.0.1',	1,	'auth',	'User 1 Registered'),
(3,	'2019-06-21 10:42:13',	'127.0.0.1',	1,	'auth',	'User 1 Logged-in');

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(512) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_group` (`id`, `role`, `description`) VALUES
(1,	'user_1',	'Group uniquely assigned to user 1'),
(2,	'normal',	'普通用户'),
(3,	'admin',	'管理员');

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
(1,	1,	1),
(2,	1,	3);

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
(1,	'admin',	'admin',	'admin@admin.admin',	'pbkdf2(1000,20,sha512)$968ad1e3d9c59d71$68d127287b1099697254f04559381884c3f5e684',	'',	'',	'');

DROP TABLE IF EXISTS `creature`;
CREATE TABLE `creature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soul` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `creature_name` varchar(512) DEFAULT NULL,
  `creature_state` varchar(512) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `soul__idx` (`soul`),
  CONSTRAINT `creature_ibfk_1` FOREIGN KEY (`soul`) REFERENCES `soul` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `creature` (`id`, `soul`, `description`, `lifetime`, `creature_name`, `creature_state`, `birthday`) VALUES
(2,	1002,	'书生',	30000,	'许仙',	'alive',	'1938-06-02 13:00:00'),
(3,	1001,	NULL,	10000,	'孙悟空',	'dead',	'1002-06-21 15:27:12'),
(4,	1001,	NULL,	40000,	'六小龄童',	'alive',	'1980-06-21 15:43:02'),
(5,	1003,	NULL,	10000,	'谢程序',	'dead',	'1970-06-21 16:11:35'),
(6,	1003,	NULL,	10000,	'龚城师',	'alive',	'1998-06-21 16:12:56');

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
(1,	2,	'救下一条小蛇',	NULL,	20,	'1994-06-21 13:26:59'),
(2,	2,	'顶撞父母',	NULL,	-1,	'2009-06-15 13:27:43'),
(3,	3,	'大闹龙宫',	NULL,	-200,	'1005-06-21 15:33:49'),
(4,	4,	'扮演孙悟空，弘扬佛法',	NULL,	100,	'1986-06-21 15:52:10'),
(5,	6,	'出生时有五彩祥云',	NULL,	0,	'2002-06-21 16:15:16');

DROP TABLE IF EXISTS `soul`;
CREATE TABLE `soul` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soul_name` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `soul` (`id`, `soul_name`) VALUES
(1001,	'东海仙石'),
(1002,	'牧童'),
(1003,	'永世程序员');

DROP VIEW IF EXISTS `sum_creature_add_lifetime`;
CREATE TABLE `sum_creature_add_lifetime` (`creature` int(11), `total_add_lifetime` decimal(32,0));


DROP TABLE IF EXISTS `sum_creature_add_lifetime`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `sum_creature_add_lifetime` AS select `life_log`.`creature` AS `creature`,sum(`life_log`.`add_lifetime`) AS `total_add_lifetime` from `life_log` group by `life_log`.`creature`;

-- 2019-06-21 08:55:57
