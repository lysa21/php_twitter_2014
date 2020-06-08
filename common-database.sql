-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 14, 2016 at 12:47 PM
-- Server version: 5.6.28-0ubuntu0.15.10.1
-- PHP Version: 5.6.11-1ubuntu3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `common-database`
--
CREATE DATABASE IF NOT EXISTS `common-database` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `common-database`;

-- --------------------------------------------------------

--
-- Table structure for table `followers`
--

CREATE TABLE IF NOT EXISTS `followers` (
  `id_user` int(11) NOT NULL COMMENT 'ID de l''utilisateur',
  `id_follower` int(11) NOT NULL COMMENT 'ID de follower',
  `date_follow` datetime NOT NULL COMMENT 'Date et heure du follow'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `hashtags`
--

CREATE TABLE IF NOT EXISTS `hashtags` (
  `id_tweet` int(11) NOT NULL COMMENT 'Id du tweeter',
  `id_tag` int(11) NOT NULL COMMENT 'tag'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE IF NOT EXISTS `likes` (
  `id_user` int(11) NOT NULL COMMENT 'Id de l''utilisateur qui like',
  `id_tweet` int(11) NOT NULL COMMENT 'id du tweet qui like'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id_mess` int(11) NOT NULL COMMENT 'Id du message',
  `id_sender` int(11) NOT NULL COMMENT 'Id de l''émetteur',
  `id_receiver` int(11) NOT NULL COMMENT 'id du destinataire',
  `content` text NOT NULL COMMENT 'contenue',
  `date` datetime NOT NULL COMMENT 'date',
  `sender_deleted` tinyint(1) NOT NULL COMMENT 'Si le sender delete le msg',
  `receiver_deleted` tinyint(1) NOT NULL COMMENT 'si le destinataire delete le message',
  `read` tinyint(1) NOT NULL COMMENT 'Si le message est lu par le destinataire',
  `media` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL COMMENT 'ID utilisateur',
  `type` int(11) NOT NULL COMMENT 'type de la notif',
  `id_notif` int(11) NOT NULL COMMENT 'id du tweet retweet ou like en fonction du type de la notif',
  `status` tinyint(1) NOT NULL COMMENT 'si vue ou non',
  `date_notif` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Table structure for table `short_links`
--

CREATE TABLE IF NOT EXISTS `short_links` (
  `token` varchar(255) NOT NULL COMMENT 'Lien raccourcis',
  `path` text NOT NULL COMMENT 'Chemin du fichier'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id_tag` int(11) NOT NULL COMMENT 'Id du tag',
  `tag` text NOT NULL COMMENT 'nom du hastag'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id_tag`, `tag`) VALUES
(5, '#nya'),
(6, '#miaou'),
(7, '#MortalKombat'),
(8, '#smoke'),
(9, '#ShaoKahn');

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE IF NOT EXISTS `themes` (
  `id_user` int(11) NOT NULL COMMENT 'ID de l''utilisateur',
  `bg_img` text NOT NULL COMMENT 'Image de background',
  `bg_color` varchar(255) NOT NULL COMMENT 'couleur de background',
  `theme_color` varchar(255) NOT NULL COMMENT 'Couleur du theme',
  `postion` varchar(255) NOT NULL COMMENT 'Position du background'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `id_tweet` int(11) NOT NULL COMMENT 'id du tweet',
  `id_user` int(11) NOT NULL COMMENT 'id de l''utilisateur',
  `content` text NOT NULL COMMENT 'contenue',
  `creation_date` datetime NOT NULL COMMENT 'Date de création',
  `media` text NOT NULL COMMENT 'Media',
  `deleted` tinyint(1) NOT NULL COMMENT 'Statut de la suppression',
  `is_origin` int(11) NOT NULL COMMENT 'Parent(Si définis retweet)',
  `is_reply` tinyint(1) NOT NULL COMMENT 'Si definis alors c''est un réponse',
  `location` text NOT NULL COMMENT 'Localisation'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL COMMENT 'ID utilisateur',
  `username` varchar(255) NOT NULL COMMENT 'nom de l''utilsateur',
  `nickname` varchar(255) DEFAULT NULL COMMENT 'Pseudo de la personne(Nom complet sur tweeter)',
  `password` text NOT NULL COMMENT 'Mot de passe',
  `avatar` text NOT NULL COMMENT 'avatar',
  `email` text NOT NULL COMMENT 'email',
  `cover` text NOT NULL COMMENT 'image de banniere',
  `phone` text DEFAULT NULL COMMENT 'numéro de téléphone',
  `website` text DEFAULT NULL COMMENT 'url du site web lié au compte',
  `registration_token` text DEFAULT NULL COMMENT 'token pour l''activation par mail',
  `birthdate` date DEFAULT NULL COMMENT 'date de naissance',
  `private` tinyint(1) DEFAULT NULL COMMENT 'status du compte si privée ou non',
  `token_cookie` text DEFAULT NULL COMMENT 'token pour la fonction : se souvenir de moi (afin d''éviter la reconnexion)',
  `location` text DEFAULT NULL COMMENT 'Lieu',
  `activated` tinyint(1) DEFAULT NULL COMMENT 'statut de l''activation',
  `biography` text DEFAULT NULL COMMENT 'Biographie',
  `creation_date` date DEFAULT NULL COMMENT 'Date et heure de la création du compte'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;


-- Indexes for table `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`id_user`,`id_follower`);

--
-- Indexes for table `hashtags`
--
ALTER TABLE `hashtags`
  ADD PRIMARY KEY (`id_tweet`,`id_tag`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id_user`,`id_tweet`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id_mess`);

--
-- Indexes for table `DEFAULTifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `short_links`
--
ALTER TABLE `short_links`
  ADD PRIMARY KEY (`token`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id_tag`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `tweets`
--
ALTER TABLE `tweets`
  ADD PRIMARY KEY (`id_tweet`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id_mess` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id du message',AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id_tag` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id du tag',AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `tweets`
--
ALTER TABLE `tweets`
  MODIFY `id_tweet` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id du tweet',AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID utilisateur',AUTO_INCREMENT=18;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
