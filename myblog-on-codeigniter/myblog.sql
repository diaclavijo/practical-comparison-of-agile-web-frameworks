-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 05-09-2013 a las 14:12:04
-- Versión del servidor: 5.5.32
-- Versión de PHP: 5.3.10-1ubuntu3.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `myblog`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blog`
--

CREATE TABLE IF NOT EXISTS `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `blog`
--

INSERT INTO `blog` (`id`, `title`, `description`, `created_on`, `user_id`) VALUES
(17, 'adasd', 'adada', '2013-07-25 16:24:36', 24),
(22, 'uno blog', 'uno stories', '2013-07-26 12:34:40', 33),
(23, 'tres blog', 'tres stories', '2013-07-26 14:29:56', 34);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `ip_address` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `user_agent` varchar(150) COLLATE utf8_bin NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('af8084a9f28a8449736f4e8a64e93325', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:23.0) Gecko/20100101 Firefox/23.0', 1378324886, 'a:4:{s:9:"user_data";s:0:"";s:7:"user_id";s:2:"33";s:8:"username";s:3:"uno";s:6:"status";s:1:"1";}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `username` varchar(255) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=46 ;

--
-- Volcado de datos para la tabla `comment`
--

INSERT INTO `comment` (`username`, `website`, `email`, `body`, `id`, `post_id`, `user_id`, `posted_on`) VALUES
('unknownuno', 'unkown.com', 'unkonwuno@com.com', 'unkown uno', 44, 17, NULL, '2013-07-26 12:43:12'),
('tres', '0', 'tres@tres.com', 'tres comment', 45, 17, 34, '2013-07-26 12:43:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_attempts`
--

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) COLLATE utf8_bin NOT NULL,
  `login` varchar(50) COLLATE utf8_bin NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `ip_address`, `login`, `time`) VALUES
(1, '127.0.0.1', 'uno', '2013-07-17 17:13:21'),
(2, '127.0.0.1', 'unoo', '2013-07-17 17:13:26'),
(3, '127.0.0.1', 'uno', '2013-07-17 17:45:44'),
(4, '127.0.0.1', 'unoo', '2013-07-17 17:45:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `title` varchar(255) NOT NULL,
  `permalink` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permalink` (`permalink`),
  KEY `blog_id` (`blog_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Volcado de datos para la tabla `post`
--

INSERT INTO `post` (`title`, `permalink`, `body`, `posted_on`, `id`, `blog_id`) VALUES
('dos bloga', 'dos-bloga', 'dos dos dodso dsods', '2013-07-25 16:24:47', 12, 17),
('uno first post', 'uno-first-post', 'uno post post post first', '2013-07-26 12:34:51', 16, 22),
('uno second post, later', 'uno-second-post-later', 'second uno post', '2013-07-26 12:35:11', 17, 22),
('tres first post', 'tres-first-post', 'post tres post in the tres world dude !', '2013-07-26 14:30:11', 18, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(100) COLLATE utf8_bin NOT NULL,
  `activated` tinyint(1) NOT NULL DEFAULT '1',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `ban_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `new_password_key` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `new_password_requested` datetime DEFAULT NULL,
  `new_email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `new_email_key` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `last_ip` varchar(40) COLLATE utf8_bin NOT NULL,
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=35 ;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `activated`, `banned`, `ban_reason`, `new_password_key`, `new_password_requested`, `new_email`, `new_email_key`, `last_ip`, `last_login`, `created`, `modified`) VALUES
(15, 'diez', '$2a$08$6uUq5u3AYi2gdajfn4ztfuOZ6JYBGrBGWFASpeLExXlgy7VOXqdSW', 'diez@diez.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '0000-00-00 00:00:00', '2013-07-23 17:18:05', '2013-07-23 15:18:05'),
(16, 'once', '$2a$08$f41JjsRWyxo46MiWwg1LruzQ78JlkwaDR.PMOIpGeNN8.zCen4rX2', 'once@once.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '0000-00-00 00:00:00', '2013-07-23 17:20:09', '2013-07-23 15:20:09'),
(17, 'doce', '$2a$08$SKGESlozo8Ynkm6OWJUNyudrGZbuEiCuYD.aW54PaBwFVlGT9gRdu', 'doce@doce.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-23 17:21:10', '2013-07-23 17:20:54', '2013-07-23 15:21:10'),
(18, 'quince', '$2a$08$OZOzqcGWgP2duPBhVopAAumvQwH4O4CUUDUe4J3TztuaGHZFuyLpS', 'quince@quince.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '0000-00-00 00:00:00', '2013-07-23 17:28:51', '2013-07-23 15:28:51'),
(19, 'trece', '$2a$08$y22kkKsNZI6K4AdF3gkh3eRt/RLOf1dUEZ1cMoKVWhDRwqwFbYisK', 'trece@trece.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-23 17:31:03', '2013-07-23 17:29:50', '2013-07-23 15:31:03'),
(20, 'catorce', '$2a$08$A/j8JGPYT.eTBUMkBa.v1uupxbsi81iqhZZ33HrgdMFb8xfOkyLCa', 'catorce@catorce.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '0000-00-00 00:00:00', '2013-07-23 17:31:56', '2013-07-23 15:31:56'),
(21, 'dieciseis', '$2a$08$AvnXnc94LSuNSlLb.u01tONvMR6fPIsRGTRkwCT9KRkirKPiXXXX.', 'deciseis@diecises.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '0000-00-00 00:00:00', '2013-07-23 17:32:20', '2013-07-23 15:32:20'),
(22, 'dieciocho', '$2a$08$ySL4aofyvgiopL6pUQCsx.ocqWIFuEA.tkS0UcUZK9jIHeW2Nixm.', 'dieciocho@diecicoho.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-23 17:35:55', '2013-07-23 17:35:55', '2013-07-23 15:35:55'),
(23, 'diecinueve', '$2a$08$yMmUi4TkUC2t48dW/14wSOXZLG50anYLT6lf90K36oZaLiW4K/xHK', 'dienueve@dienueve.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-23 17:53:50', '2013-07-23 17:53:50', '2013-07-23 15:53:50'),
(24, 'dos', '$2a$08$eb2waXYOvmfShSL/6aD3eubZaGmWvCnMTYgx7GQJ10Wgl5QmGID3O', 'dos@dos.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-26 14:29:51', '2013-07-24 15:35:44', '2013-07-26 12:29:51'),
(33, 'uno', '$2a$08$KiDQLJd6LpyiMjZWwaNYS.3F2vpUK6Df/lcMCRa0Dd3U847pkilAO', 'uno@uno.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-09-04 20:06:08', '2013-07-26 14:34:30', '2013-09-04 18:06:08'),
(34, 'tres', '$2a$08$cTZC9TClTBgzJHqGTo.ne..QDuCXZzsszrOZOjN2HBM7Zg9430vpm', 'tres@tres.com', 1, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', '2013-07-26 14:43:36', '2013-07-26 14:43:36', '2013-07-26 12:43:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_autologin`
--

CREATE TABLE IF NOT EXISTS `user_autologin` (
  `key_id` char(32) COLLATE utf8_bin NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_agent` varchar(150) COLLATE utf8_bin NOT NULL,
  `last_ip` varchar(40) COLLATE utf8_bin NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_profiles`
--

CREATE TABLE IF NOT EXISTS `user_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `country` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=35 ;

--
-- Volcado de datos para la tabla `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_id`, `country`, `website`, `avatar`) VALUES
(15, 15, NULL, NULL, NULL),
(16, 16, NULL, NULL, NULL),
(17, 17, NULL, NULL, NULL),
(18, 18, NULL, NULL, NULL),
(19, 19, NULL, NULL, NULL),
(20, 20, NULL, NULL, NULL),
(21, 21, NULL, NULL, NULL),
(22, 22, NULL, NULL, NULL),
(23, 23, NULL, NULL, NULL),
(24, 24, NULL, NULL, NULL),
(33, 33, NULL, NULL, NULL),
(34, 34, NULL, NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
