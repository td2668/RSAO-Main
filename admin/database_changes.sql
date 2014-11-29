

-- 20090611 CSN THIS IS THE MEDIA TABLE ADDITIONS FOR THE MULTIMEDIA CATALOGUE


-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jun 11, 2009 at 02:07 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.9
-- 
-- Database: `mrclaero_research`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `media`
-- 

CREATE TABLE `media` (
  `media_id` int(11) NOT NULL auto_increment,
  `media_type_id` int(11) NOT NULL,
  `date_added` date NOT NULL,
  `date` date NOT NULL,
  `title` varchar(255) NOT NULL,
  `synopsis` text NOT NULL,
  `description` text NOT NULL,
  `embed_code` text NOT NULL,
  `external_link` varchar(255) NOT NULL,
  `image_name` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL,
  `original_image_name` varchar(255) NOT NULL,
  `movie_name` varchar(255) NOT NULL,
  `original_movie_name` varchar(255) NOT NULL,
  `movie_file_size` int(11) NOT NULL,
  `soundtrack_name` varchar(255) NOT NULL,
  `original_soundtrack_name` varchar(255) NOT NULL,
  `feature_flag` tinyint(1) NOT NULL,
  `public_flag` tinyint(1) NOT NULL,
  `internal_flag` tinyint(1) NOT NULL,
  PRIMARY KEY  (`media_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `media_attachment`
-- 

CREATE TABLE `media_attachment` (
  `media_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  PRIMARY KEY  (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `media_type`
-- 

CREATE TABLE `media_type` (
  `media_type_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`media_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;
INSERT INTO `media_type` VALUES (1, 'Presentation');
INSERT INTO `media_type` VALUES (2, 'Video Clip');
INSERT INTO `media_type` VALUES (3, 'Audio Clip');
INSERT INTO `media_type` VALUES (4, 'Text Clip');







-- 20090611 CSN THIS IS THE SQL DUMP FOR THE PRODUCTION DATABASE ON JUNE 11, 2009, AND WILL SERVE AS A STARTING POINT FOR THIS LOG

-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jun 11, 2009 at 02:17 PM
-- Server version: 5.0.45
-- PHP Version: 5.2.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `research`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `admin`
-- 

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) unsigned NOT NULL auto_increment,
  `department_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `division_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `apars`
-- 

CREATE TABLE IF NOT EXISTS `apars` (
  `apar_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `date_submitted` int(11) NOT NULL default '0',
  `chair_sig` tinyint(4) NOT NULL default '0',
  `chair` int(10) unsigned NOT NULL default '0',
  `chair_comments` text NOT NULL,
  `dean_sig` tinyint(4) NOT NULL default '0',
  `dean` int(10) unsigned NOT NULL default '0',
  `dean_comments` text NOT NULL,
  PRIMARY KEY  (`apar_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Data regarding annual reports' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `apar_items`
-- 

CREATE TABLE IF NOT EXISTS `apar_items` (
  `apar_item_id` int(10) unsigned NOT NULL auto_increment,
  `apar_id` int(10) unsigned NOT NULL default '0',
  `cv_item_id` int(10) unsigned NOT NULL default '0',
  `user_id` int(10) unsigned NOT NULL default '0',
  `cv_item_type_id` int(10) unsigned NOT NULL default '0',
  `f1` text NOT NULL,
  `f2` int(11) NOT NULL default '0',
  `f3` int(11) NOT NULL default '0',
  `f4` text NOT NULL,
  `f5` text NOT NULL,
  `f6` text NOT NULL,
  `f7` text NOT NULL,
  `f8` text NOT NULL,
  `f9` text NOT NULL,
  `f10` tinyint(4) NOT NULL default '0',
  `f11` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`apar_item_id`),
  KEY `user_id` (`user_id`),
  KEY `cv_item_type_id` (`cv_item_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Contents of annual reports' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `apar_perm`
-- 

CREATE TABLE IF NOT EXISTS `apar_perm` (
  `user_id` int(11) unsigned NOT NULL default '0',
  `perm` tinyint(4) NOT NULL default '0',
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `ar_profiles`
-- 

CREATE TABLE IF NOT EXISTS `ar_profiles` (
  `user_id` int(10) unsigned NOT NULL,
  `short_profile` text NOT NULL,
  `teaching_philosophy` text NOT NULL,
  `top_3_achievements` text NOT NULL,
  `teaching_goals` text NOT NULL,
  `teaching_goals_lastyear` text NOT NULL,
  `activities` text NOT NULL,
  `scholarship_achievements` text,
  `scholarship_goals` text,
  `scholarship_goals_lastyear` text NOT NULL,
  `service_goals` text NOT NULL,
  `service_goals_lastyear` text NOT NULL,
  `service_achievements` text NOT NULL,
  `chair_duties_flag` tinyint(1) NOT NULL default '0',
  `service_chair_goals` text NOT NULL,
  `service_chair_achievements` text NOT NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `ar_reports`
-- 

CREATE TABLE IF NOT EXISTS `ar_reports` (
  `report_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) default NULL,
  `filename` varchar(255) default NULL,
  `submitted_flag` tinyint(1) NOT NULL default '0',
  `submitted_date` datetime default NULL,
  `approved_flag` tinyint(1) NOT NULL default '0',
  `approved_date` datetime default NULL,
  `approved_user_id` int(10) NOT NULL,
  `comments` text,
  PRIMARY KEY  (`report_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `committees`
-- 

CREATE TABLE IF NOT EXISTS `committees` (
  `committee_id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`committee_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Names of research-related committees' AUTO_INCREMENT=44 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `committee_members`
-- 

CREATE TABLE IF NOT EXISTS `committee_members` (
  `committee_member_id` int(11) unsigned NOT NULL auto_increment,
  `committee_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `chair` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`committee_member_id`),
  KEY `committee_id` (`committee_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Relates Committees to Users' AUTO_INCREMENT=98 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `courses`
-- 

CREATE TABLE IF NOT EXISTS `courses` (
  `course_id` int(4) unsigned NOT NULL auto_increment,
  `crn` int(4) NOT NULL COMMENT 'Course Registration Number - Unique identifier from Banner',
  `schedcode` varchar(5) NOT NULL,
  `subject` varchar(15) NOT NULL COMMENT 'The alpha part of the course name - eg BIOL',
  `crsenumb` varchar(15) NOT NULL COMMENT 'numeric part of course name',
  `crsedescript` varchar(255) NOT NULL COMMENT 'Descriptor of course',
  `sectnumb` int(4) NOT NULL COMMENT 'Section number',
  `term` int(4) NOT NULL COMMENT 'Term number',
  `numstudents` int(4) NOT NULL COMMENT 'Number of students in section',
  `hours` float NOT NULL COMMENT 'Number of course hours',
  PRIMARY KEY  (`course_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2148 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `course_teaching`
-- 

CREATE TABLE IF NOT EXISTS `course_teaching` (
  `course_teaching_id` int(10) NOT NULL auto_increment,
  `course_id` int(10) NOT NULL COMMENT 'Key from course table',
  `user_id` int(10) NOT NULL COMMENT 'Key from user table',
  `empid` int(10) NOT NULL COMMENT 'Extra working key for cross-reference',
  `sei` float NOT NULL COMMENT 'mean eval score',
  `q1` float NOT NULL,
  `q2` float NOT NULL,
  `q3` float NOT NULL,
  `q4` float NOT NULL,
  `q5` float NOT NULL,
  `comments1` text NOT NULL COMMENT 'comments on evaluations',
  `comments2` text NOT NULL COMMENT 'key points',
  `deliverytype` varchar(255) NOT NULL,
  `report_flag` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`course_teaching_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2220 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `cv_items`
-- 

CREATE TABLE IF NOT EXISTS `cv_items` (
  `cv_item_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `cv_item_type_id` int(10) unsigned NOT NULL default '0',
  `f1` text NOT NULL,
  `f2` int(11) NOT NULL default '0',
  `f3` int(11) NOT NULL default '0',
  `f4` text NOT NULL,
  `f5` text NOT NULL,
  `f6` text NOT NULL,
  `f7` text NOT NULL,
  `f8` text NOT NULL,
  `f9` text NOT NULL,
  `f10` tinyint(4) NOT NULL default '0',
  `f11` tinyint(4) NOT NULL default '0',
  `current_par` tinyint(4) NOT NULL default '0',
  `web_show` tinyint(4) NOT NULL default '0',
  `report_flag` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`cv_item_id`),
  KEY `user_id` (`user_id`),
  KEY `cv_item_type_id` (`cv_item_type_id`),
  FULLTEXT KEY `f1` (`f1`,`f4`,`f5`,`f6`,`f8`,`f9`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Items for faculty CV ' AUTO_INCREMENT=8640 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `cv_items2`
-- 

CREATE TABLE IF NOT EXISTS `cv_items2` (
  `cv_item_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `cv_item_type_id` int(10) unsigned NOT NULL default '0',
  `f1` text NOT NULL,
  `f2` int(11) NOT NULL default '0',
  `f3` int(11) NOT NULL default '0',
  `f4` text NOT NULL,
  `f5` text NOT NULL,
  `f6` text NOT NULL,
  `f7` text NOT NULL,
  `f8` text NOT NULL,
  `f9` text NOT NULL,
  `f10` tinyint(4) NOT NULL default '0',
  `f11` tinyint(4) NOT NULL default '0',
  `current_par` tinyint(4) NOT NULL default '0',
  `web_show` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`cv_item_id`),
  KEY `user_id` (`user_id`),
  KEY `cv_item_type_id` (`cv_item_type_id`),
  FULLTEXT KEY `f1` (`f1`,`f4`,`f5`,`f6`,`f8`,`f9`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Temp - need to compare and drop' AUTO_INCREMENT=2509 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `cv_item_headers`
-- 

CREATE TABLE IF NOT EXISTS `cv_item_headers` (
  `cv_item_header_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `rank` float NOT NULL default '0',
  `category` varchar(255) NOT NULL,
  PRIMARY KEY  (`cv_item_header_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='The groupings of CV items' AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `cv_item_types`
-- 

CREATE TABLE IF NOT EXISTS `cv_item_types` (
  `cv_item_type_id` int(10) unsigned NOT NULL auto_increment,
  `cv_item_header_id` int(10) unsigned NOT NULL default '0',
  `rank` float NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `title_plural` varchar(255) NOT NULL default '',
  `f1_name` varchar(255) NOT NULL default '',
  `f1_eg` text NOT NULL,
  `f1_type` varchar(20) NOT NULL,
  `f2_name` varchar(255) NOT NULL default '',
  `f2_eg` text NOT NULL,
  `f2_type` varchar(5) NOT NULL default '',
  `f3_name` varchar(255) NOT NULL default '',
  `f3_eg` text NOT NULL,
  `f3_type` varchar(5) NOT NULL default '',
  `f4_name` varchar(255) NOT NULL default '',
  `f4_eg` text NOT NULL,
  `f4_type` varchar(10) NOT NULL,
  `f5_name` varchar(255) NOT NULL default '',
  `f5_eg` text NOT NULL,
  `f5_type` varchar(10) NOT NULL,
  `f6_name` varchar(255) NOT NULL default '',
  `f6_eg` text NOT NULL,
  `f6_type` varchar(10) NOT NULL,
  `f7_name` varchar(255) NOT NULL default '',
  `f7_eg` text NOT NULL,
  `f7_type` varchar(10) NOT NULL,
  `f8_name` varchar(255) NOT NULL default '',
  `f8_eg` text NOT NULL,
  `f8_type` varchar(10) NOT NULL,
  `f9_name` varchar(255) NOT NULL default '',
  `f9_eg` text NOT NULL,
  `f9_type` varchar(10) NOT NULL,
  `f10_name` varchar(255) NOT NULL default '',
  `f10_eg` text NOT NULL,
  `f11_name` varchar(255) NOT NULL default '',
  `f11_eg` text NOT NULL,
  `default_web` tinyint(4) NOT NULL default '0',
  `display_code` text NOT NULL,
  `show_url` varchar(255) NOT NULL COMMENT 'phrase to use showing URL (Blank = don''t show)',
  `url_type` varchar(100) NOT NULL COMMENT 'term to classify item, eg video, text, pdf, etc.',
  `show_abstract` varchar(255) NOT NULL COMMENT 'show link to abstract - phrase to use',
  PRIMARY KEY  (`cv_item_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Types of items with display code ' AUTO_INCREMENT=90 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `DB_Available_Installs`
-- 

CREATE TABLE IF NOT EXISTS `DB_Available_Installs` (
  `id` int(11) NOT NULL auto_increment,
  `databaseName_Data` varchar(128) NOT NULL,
  `tableName_Data_MainData` varchar(128) NOT NULL default '',
  `tableName_Data_BelongsIn` varchar(128) NOT NULL default '',
  `tableName_Data_ReadibleNames` varchar(128) NOT NULL,
  `databaseName_Settings` varchar(128) NOT NULL default '',
  `tableName_Settings_Options` varchar(128) NOT NULL default '',
  `tableName_Settings_SortControls` varchar(128) NOT NULL default '',
  `tableName_Settings_Styles` varchar(128) NOT NULL default '',
  `tableName_Settings_SummaryFields` varchar(128) NOT NULL default '',
  `databaseName_Users` varchar(128) NOT NULL default '',
  `tableName_Users_Users` varchar(128) NOT NULL default '',
  `tableName_Users_Roles` varchar(128) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `deadlines`
-- 

CREATE TABLE IF NOT EXISTS `deadlines` (
  `deadline_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `warning_message` text NOT NULL,
  `description` text NOT NULL,
  `synopsis` text NOT NULL,
  `topics` text NOT NULL,
  `approved` varchar(10) NOT NULL default '',
  `internal` varchar(10) NOT NULL default '',
  `override` tinyint(4) NOT NULL default '0' COMMENT 'Do not send a warning message',
  `no_deadline` tinyint(4) NOT NULL default '0' COMMENT 'TRUE for opend deadline items',
  PRIMARY KEY  (`deadline_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=75 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `deadline_dates`
-- 

CREATE TABLE IF NOT EXISTS `deadline_dates` (
  `date_id` int(10) unsigned NOT NULL auto_increment,
  `deadline_id` int(10) unsigned NOT NULL default '0',
  `d_date` int(11) NOT NULL default '0',
  `close_warning_date` int(11) NOT NULL default '0',
  `early_warning_date` int(11) NOT NULL default '0',
  `expiry_date` int(11) NOT NULL default '0',
  `days_in_advance` int(11) NOT NULL default '0',
  PRIMARY KEY  (`date_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `departments`
-- 

CREATE TABLE IF NOT EXISTS `departments` (
  `department_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `shortname` varchar(60) NOT NULL,
  `division_id` int(10) unsigned NOT NULL default '0',
  `chair` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`department_id`),
  KEY `chair` (`chair`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `directors`
-- 

CREATE TABLE IF NOT EXISTS `directors` (
  `director_id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `department_id` int(11) unsigned NOT NULL COMMENT 'Affiliation',
  `division_id` int(11) unsigned NOT NULL COMMENT 'Only use if not affiliated with a dept',
  `title` varchar(255) NOT NULL COMMENT 'Title of job',
  PRIMARY KEY  (`director_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `divisions`
-- 

CREATE TABLE IF NOT EXISTS `divisions` (
  `division_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `dean` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`division_id`),
  KEY `dean` (`dean`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps` (
  `eth_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `approved` tinyint(4) NOT NULL default '0',
  `mod_date` int(11) NOT NULL default '0',
  `submit_date` int(11) NOT NULL default '0',
  `approval_date` int(11) NOT NULL default '0',
  `f000` varchar(255) NOT NULL default '',
  `f000a` tinyint(4) NOT NULL default '0',
  `f000b` tinyint(4) NOT NULL default '0',
  `f000c` varchar(30) NOT NULL default '',
  `f001` varchar(255) NOT NULL default '',
  `f002` int(10) unsigned NOT NULL default '0',
  `f003` varchar(255) NOT NULL default '',
  `f004` varchar(255) NOT NULL default '',
  `f005` varchar(255) NOT NULL default '',
  `f006` text NOT NULL,
  `f007` varchar(255) NOT NULL default '',
  `f008` varchar(255) NOT NULL default '',
  `f009a` int(11) NOT NULL default '0',
  `f009b` int(11) NOT NULL default '0',
  `f010a` tinyint(4) NOT NULL default '0',
  `f010b` tinyint(4) NOT NULL default '0',
  `f010c` tinyint(4) NOT NULL default '0',
  `f010b1` varchar(255) NOT NULL default '',
  `f010b2` varchar(255) NOT NULL default '',
  `f010b3` varchar(255) NOT NULL default '',
  `f010b4` text NOT NULL,
  `f010c1` text NOT NULL,
  `f010c2` text NOT NULL,
  `f011` text NOT NULL,
  `f012` int(11) NOT NULL default '0',
  `f013` int(11) NOT NULL default '0',
  `f013a` varchar(255) NOT NULL default '',
  `f014` int(11) NOT NULL default '0',
  `f014a` varchar(255) NOT NULL default '',
  `f015` text NOT NULL,
  `f015attach` varchar(255) NOT NULL default '',
  `f016` text NOT NULL,
  `f017` text NOT NULL,
  `f018` text NOT NULL,
  `f019` text NOT NULL,
  `f019attach` varchar(255) NOT NULL default '',
  `f020` text NOT NULL,
  `f021` text NOT NULL,
  `f022` text NOT NULL,
  `f023` text NOT NULL,
  `f024` text NOT NULL,
  `f025a` tinyint(4) NOT NULL default '0',
  `f025a1` text NOT NULL,
  `f026a` tinyint(4) NOT NULL default '0',
  `f026a1` tinyint(4) NOT NULL default '0',
  `f026b` tinyint(4) NOT NULL default '0',
  `f026b1` tinyint(4) NOT NULL default '0',
  `f026c` tinyint(4) NOT NULL default '0',
  `f026c1` tinyint(4) NOT NULL default '0',
  `f026d` tinyint(4) NOT NULL default '0',
  `f026d1` tinyint(4) NOT NULL default '0',
  `f026e` text NOT NULL,
  `f027` text NOT NULL,
  `f028` text NOT NULL,
  `f029` text NOT NULL,
  `f030` text NOT NULL,
  `f031` text NOT NULL,
  `f032` text NOT NULL,
  `f033` text NOT NULL,
  `f033a` text NOT NULL,
  `f034` text NOT NULL,
  `f035a` tinyint(4) NOT NULL default '0',
  `f035a1` text NOT NULL,
  `f035aattach` varchar(255) NOT NULL default '',
  `f035b` tinyint(4) NOT NULL default '0',
  `f035b1` text NOT NULL,
  `f035battach` varchar(255) NOT NULL default '',
  `f035c` tinyint(4) NOT NULL default '0',
  `f035c1` text NOT NULL,
  `f035d` tinyint(4) NOT NULL default '0',
  `f035d1` text NOT NULL,
  `f035e` tinyint(4) NOT NULL default '0',
  `f036a` tinyint(4) NOT NULL default '0',
  `f036b` tinyint(4) NOT NULL default '0',
  `f036c` tinyint(4) NOT NULL default '0',
  `f036d` tinyint(4) NOT NULL default '0',
  `f036e` tinyint(4) NOT NULL default '0',
  `f036f` tinyint(4) NOT NULL default '0',
  `f036g` tinyint(4) NOT NULL default '0',
  `f036g1` varchar(255) NOT NULL default '',
  `f036h` tinyint(4) NOT NULL default '0',
  `f036h1` text NOT NULL,
  `f036i` text NOT NULL,
  `f036j` text NOT NULL,
  `f036k` text NOT NULL,
  `f036l` text NOT NULL,
  `f036m` text NOT NULL,
  `f040` text NOT NULL,
  `f041` varchar(255) NOT NULL default '',
  `f041attach` varchar(255) NOT NULL default '',
  `f042` varchar(255) NOT NULL default '',
  `f042attach` varchar(255) NOT NULL default '',
  `f043` varchar(255) NOT NULL default '',
  `f043attach` varchar(255) NOT NULL default '',
  `f044` tinyint(4) NOT NULL default '0',
  `f044a` text NOT NULL,
  `f044b` text NOT NULL,
  `f044c` text NOT NULL,
  `f044d` text NOT NULL,
  `f045` tinyint(4) NOT NULL default '0',
  `f045a` text NOT NULL,
  `f045b` text NOT NULL,
  `f045c` text NOT NULL,
  `f046attach` varchar(255) default NULL,
  `f047attach` varchar(255) default NULL,
  `f048attach` varchar(255) default NULL,
  `admin_id` int(11) default NULL,
  `grad_signature` varchar(255) default NULL,
  `other_signature` varchar(255) default NULL,
  `reqnumber` varchar(255) NOT NULL default '',
  `user_id2` int(11) NOT NULL default '0',
  `user_id3` int(11) NOT NULL default '0',
  PRIMARY KEY  (`eth_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=106 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_activity`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_activity` (
  `eth_id` int(11) unsigned NOT NULL default '0',
  `date` int(11) unsigned NOT NULL default '0',
  KEY `eth_id` (`eth_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_admin`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_admin` (
  `ethicsapps_admin_id` int(11) NOT NULL auto_increment,
  `eth_id` int(11) default NULL,
  `timetarget` int(11) NOT NULL default '0',
  `notifyreviewers` tinyint(4) default NULL,
  `piresp1` tinyint(4) default NULL,
  `remindreviewers` tinyint(4) default NULL,
  `signed` tinyint(4) default NULL,
  `renotify` tinyint(4) default NULL,
  `issue` tinyint(4) default NULL,
  `superv_comments` text NOT NULL,
  `date_received` int(11) unsigned NOT NULL default '0',
  `date_notified` int(11) unsigned NOT NULL default '0',
  `date_approved` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ethicsapps_admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_amendments`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_amendments` (
  `ethicsapps_amendment_id` int(11) unsigned NOT NULL auto_increment,
  `eth_id` int(11) unsigned NOT NULL default '0',
  `date_received` int(11) unsigned NOT NULL default '0',
  `date_certificate` int(11) unsigned NOT NULL default '0',
  `comments` text NOT NULL,
  PRIMARY KEY  (`ethicsapps_amendment_id`),
  KEY `eth_id` (`eth_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_certificates`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_certificates` (
  `ethicsapps_certificate_id` int(11) unsigned NOT NULL auto_increment,
  `eth_id` int(11) unsigned NOT NULL default '0',
  `date_created` int(11) unsigned NOT NULL default '0',
  `certificate` longblob NOT NULL,
  PRIMARY KEY  (`ethicsapps_certificate_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_reports`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_reports` (
  `ethicsapps_report_id` int(11) unsigned NOT NULL auto_increment,
  `eth_id` int(11) unsigned NOT NULL default '0',
  `date_sent` int(11) unsigned NOT NULL default '0',
  `date_due` int(11) unsigned NOT NULL default '0',
  `date_form_completed` int(11) unsigned NOT NULL default '0',
  `date_project_completed` int(11) unsigned NOT NULL default '0',
  `comments` text NOT NULL,
  PRIMARY KEY  (`ethicsapps_report_id`),
  KEY `eth_id` (`eth_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Annual reports and new certificates' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_reviewers`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_reviewers` (
  `ethicsapps_reviewer_id` int(11) NOT NULL auto_increment,
  `hs_member_id` int(11) default NULL,
  `role` varchar(30) default NULL,
  `status` int(11) default NULL,
  `reminder` int(11) default NULL,
  `comments` text,
  `eth_id` int(11) default NULL,
  `last_access` int(11) NOT NULL default '0',
  `q1` text,
  `q2` text,
  `q3` text,
  `q4` text,
  `q5` text,
  `q6` text,
  `round` tinyint(4) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ethicsapps_reviewer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=193 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethicsapps_reviewtopics`
-- 

CREATE TABLE IF NOT EXISTS `ethicsapps_reviewtopics` (
  `qfield` varchar(255) NOT NULL default '',
  `qtext` text,
  `qurl` varchar(255) NOT NULL default '',
  `qhelp` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethics_letters`
-- 

CREATE TABLE IF NOT EXISTS `ethics_letters` (
  `title` varchar(255) NOT NULL default '',
  `body` text,
  PRIMARY KEY  (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethics_mailouts`
-- 

CREATE TABLE IF NOT EXISTS `ethics_mailouts` (
  `mailout_id` int(11) NOT NULL auto_increment,
  `eth_id` int(11) NOT NULL default '0',
  `subject` varchar(255) default NULL,
  `date` int(11) default NULL,
  `text` text,
  `mailed` tinyint(4) default NULL,
  PRIMARY KEY  (`mailout_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethics_renewals`
-- 

CREATE TABLE IF NOT EXISTS `ethics_renewals` (
  `ethics_renewal_id` int(11) unsigned NOT NULL auto_increment,
  `eth_id` int(11) unsigned NOT NULL default '0',
  `date_reminder` int(11) unsigned NOT NULL default '0',
  `date_renewed` int(11) unsigned NOT NULL default '0',
  `comment` text NOT NULL,
  PRIMARY KEY  (`ethics_renewal_id`),
  KEY `eth_id` (`eth_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `ethics_staff`
-- 

CREATE TABLE IF NOT EXISTS `ethics_staff` (
  `type` varchar(255) NOT NULL default '',
  `user_id` int(11) unsigned NOT NULL default '0',
  `comment` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `eth_attach`
-- 

CREATE TABLE IF NOT EXISTS `eth_attach` (
  `eth_attach_id` int(11) NOT NULL auto_increment,
  `filename` varchar(255) default NULL,
  `fieldref` int(11) default NULL,
  PRIMARY KEY  (`eth_attach_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `eth_problems`
-- 

CREATE TABLE IF NOT EXISTS `eth_problems` (
  `id` int(11) NOT NULL auto_increment,
  `eth_id` int(11) default NULL,
  `problem` varchar(40) default NULL,
  `answer` text NOT NULL,
  `active` tinyint(4) NOT NULL default '0',
  `problem_text` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=997 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `events`
-- 

CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `post_date` int(11) NOT NULL default '0',
  `start_date` int(10) unsigned NOT NULL default '0',
  `start_time` int(10) unsigned NOT NULL default '0',
  `end_time` int(11) NOT NULL default '0',
  `expiry_date` int(11) NOT NULL default '0',
  `location` varchar(255) NOT NULL default '',
  `address` varchar(255) NOT NULL default '',
  `contact` varchar(255) NOT NULL default '',
  `synopsis` text NOT NULL,
  `description` text NOT NULL,
  `approved` varchar(255) NOT NULL default '',
  `reminders_sent` varchar(255) NOT NULL default '',
  `internal` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`event_id`),
  FULLTEXT KEY `description` (`description`),
  FULLTEXT KEY `description_2` (`description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `faculties`
-- 

CREATE TABLE IF NOT EXISTS `faculties` (
  `faculty_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`faculty_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `finance_account`
-- 

CREATE TABLE IF NOT EXISTS `finance_account` (
  `account_id` int(11) NOT NULL auto_increment,
  `owner1` int(11) NOT NULL,
  `owner2` int(11) NOT NULL,
  `owner3` int(11) NOT NULL,
  `fund` int(11) NOT NULL,
  `organization` int(11) NOT NULL,
  `program` int(11) NOT NULL,
  `description` text NOT NULL,
  `date_open` date NOT NULL,
  `date_closed` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`account_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=77 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `finance_category_activity`
-- 

CREATE TABLE IF NOT EXISTS `finance_category_activity` (
  `Banner Code` text NOT NULL,
  `Name` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `finance_catigory_2`
-- 

CREATE TABLE IF NOT EXISTS `finance_catigory_2` (
  `Banner Code` varchar(256) NOT NULL,
  `Name` varchar(256) NOT NULL,
  PRIMARY KEY  (`Banner Code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `finance_entry`
-- 

CREATE TABLE IF NOT EXISTS `finance_entry` (
  `id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `date_entered` date NOT NULL,
  `date_reconciled` date NOT NULL,
  `ammount` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `advance_flag` tinyint(1) NOT NULL,
  `reconciled_flag` tinyint(1) NOT NULL,
  `category_activity` tinytext NOT NULL COMMENT 'MRC Categories',
  `category_2` tinytext NOT NULL COMMENT 'Federal',
  `category_3` tinytext NOT NULL,
  `category_4` tinytext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `funding_apps`
-- 

CREATE TABLE IF NOT EXISTS `funding_apps` (
  `funding_app_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `pi` varchar(255) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `status` varchar(255) NOT NULL default '',
  `department` varchar(255) NOT NULL default '',
  `agency` varchar(255) NOT NULL default '',
  `program` varchar(255) NOT NULL default '',
  `type_id` int(11) NOT NULL default '0',
  `location` varchar(255) NOT NULL default '',
  `date_from` int(10) unsigned NOT NULL default '0',
  `date_to` int(10) unsigned NOT NULL default '0',
  `current_grant` tinyint(4) NOT NULL default '0',
  `account` varchar(255) NOT NULL default '',
  `human` tinyint(4) NOT NULL default '0',
  `animal` tinyint(4) NOT NULL default '0',
  `review_status` varchar(20) NOT NULL default '',
  `certif_num` varchar(20) NOT NULL default '',
  `resources` text NOT NULL,
  `pi_sig` int(10) unsigned NOT NULL default '0',
  `chair_id` int(10) unsigned NOT NULL default '0',
  `chair_sig` int(10) unsigned NOT NULL default '0',
  `chair_comments` text NOT NULL,
  `dean_id` int(10) unsigned NOT NULL default '0',
  `dean_sig` int(10) unsigned NOT NULL default '0',
  `dean_comments` text NOT NULL,
  `ro_id` int(10) unsigned NOT NULL default '0',
  `ro_sig` int(10) unsigned NOT NULL default '0',
  `ro_comments` text NOT NULL,
  `target_date` int(10) unsigned NOT NULL default '0',
  `date_created` int(10) unsigned NOT NULL default '0',
  `date_modified` int(10) unsigned NOT NULL default '0',
  `app_status` tinyint(4) NOT NULL default '0',
  `final_sig_date` int(10) unsigned NOT NULL default '0',
  `courier_date` int(10) unsigned NOT NULL default '0',
  `courier_details` varchar(255) NOT NULL default '',
  `exp_notification` int(10) unsigned NOT NULL default '0',
  `notification` int(10) unsigned NOT NULL default '0',
  `g_result` varchar(255) NOT NULL default '',
  `summary` text NOT NULL,
  PRIMARY KEY  (`funding_app_id`),
  KEY `title` (`title`,`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `funding_apps_budgets`
-- 

CREATE TABLE IF NOT EXISTS `funding_apps_budgets` (
  `funding_apps_budget_id` int(10) unsigned NOT NULL auto_increment,
  `funding_app_id` int(10) unsigned NOT NULL default '0',
  `year` int(4) NOT NULL default '0',
  `pers` float NOT NULL default '0',
  `rts` float NOT NULL default '0',
  `fees` float NOT NULL default '0',
  `equip` float NOT NULL default '0',
  `other` float NOT NULL default '0',
  `overhead` float NOT NULL default '0',
  PRIMARY KEY  (`funding_apps_budget_id`),
  KEY `funding_app_id` (`funding_app_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=761 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `funding_app_budgets`
-- 

CREATE TABLE IF NOT EXISTS `funding_app_budgets` (
  `funding_app_budget_id` int(11) unsigned NOT NULL auto_increment,
  `funding_app_id` int(11) unsigned NOT NULL default '0',
  `year` int(11) NOT NULL default '0',
  `requested` int(11) unsigned NOT NULL default '0',
  `awarded` int(11) unsigned NOT NULL default '0',
  `can_bach_sal` int(11) NOT NULL default '0',
  `for_bach_sal` int(11) NOT NULL default '0',
  `can_mas_sal` int(11) NOT NULL default '0',
  `for_mas_sal` int(11) NOT NULL default '0',
  `can_doc_sal` int(11) NOT NULL default '0',
  `for_doc_sal` int(11) NOT NULL default '0',
  `can_postdoc_sal` int(11) NOT NULL default '0',
  `for_postdoc_sal` int(11) NOT NULL default '0',
  `other_sal` int(11) NOT NULL default '0',
  `contracts` int(11) NOT NULL default '0',
  `equipment` int(11) NOT NULL default '0',
  `supplies` int(11) NOT NULL default '0',
  `travel` int(11) NOT NULL default '0',
  `rts` int(11) NOT NULL default '0',
  `other` int(11) NOT NULL default '0',
  `overhead` int(11) NOT NULL default '0',
  PRIMARY KEY  (`funding_app_budget_id`),
  KEY `year` (`year`),
  KEY `grant_id` (`funding_app_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2246 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `funding_list`
-- 

CREATE TABLE IF NOT EXISTS `funding_list` (
  `funding_id` int(10) unsigned NOT NULL auto_increment,
  `agency` varchar(255) NOT NULL default '',
  `type` varchar(255) NOT NULL default '',
  `program` varchar(255) NOT NULL default '',
  `grant` varchar(255) NOT NULL default '',
  `url` varchar(255) NOT NULL default '',
  `loi_deadline` int(10) unsigned NOT NULL default '0',
  `loi_type` enum('','Reg','LOI','Nom') NOT NULL default '',
  `local_deadline` int(10) unsigned NOT NULL default '0',
  `agency_deadline` int(10) unsigned NOT NULL default '0',
  `confirmed_yr` int(10) unsigned NOT NULL default '0',
  `opportunity_id` int(10) unsigned NOT NULL default '0',
  `deadline_id` int(10) unsigned NOT NULL default '0',
  `occasional` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`funding_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `grants`
-- 

CREATE TABLE IF NOT EXISTS `grants` (
  `grant_id` int(11) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `funding_app_id` int(11) unsigned NOT NULL default '0',
  `pi_id` int(10) unsigned NOT NULL default '0',
  `pi_name` varchar(255) NOT NULL default '',
  `date_award` int(10) unsigned NOT NULL default '0',
  `agency_name` varchar(255) NOT NULL default '',
  `program` varchar(255) NOT NULL default '',
  `grant_type_id` int(11) unsigned NOT NULL default '0',
  `agency_address` text NOT NULL,
  `contact` varchar(255) NOT NULL default '',
  `finance_contact` varchar(255) NOT NULL default '',
  `agency_grant_num` varchar(40) NOT NULL default '',
  `conditions` text NOT NULL,
  `coapp1_id` int(10) unsigned NOT NULL default '0',
  `coapp1_name` varchar(255) NOT NULL default '',
  `coapp2_id` int(10) unsigned NOT NULL default '0',
  `coapp2_name` varchar(255) NOT NULL default '',
  `human_ethics_req` tinyint(4) NOT NULL default '0',
  `animal_ethics_req` tinyint(4) NOT NULL default '0',
  `ethics_certif` varchar(20) NOT NULL default '',
  `ethics_certif_from` varchar(255) NOT NULL default '',
  `ethics_certif_date` int(11) unsigned NOT NULL default '0',
  `budget_auth` tinyint(4) NOT NULL default '0',
  `budget_done` tinyint(4) NOT NULL default '0',
  `summary` text NOT NULL,
  PRIMARY KEY  (`grant_id`),
  KEY `funding_app_id` (`funding_app_id`),
  KEY `project_id` (`project_id`),
  KEY `pi_id` (`pi_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `grant_activity`
-- 

CREATE TABLE IF NOT EXISTS `grant_activity` (
  `grant_activity_id` int(11) unsigned NOT NULL auto_increment,
  `grant_id` int(11) unsigned NOT NULL default '0',
  `comment` text NOT NULL,
  PRIMARY KEY  (`grant_activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `grant_budgets`
-- 

CREATE TABLE IF NOT EXISTS `grant_budgets` (
  `grant_budget_id` int(11) unsigned NOT NULL auto_increment,
  `grant_id` int(11) unsigned NOT NULL default '0',
  `year` int(11) NOT NULL default '0',
  `requested` int(11) unsigned NOT NULL default '0',
  `awarded` int(11) unsigned NOT NULL default '0',
  `can_bach_sal` int(11) NOT NULL default '0',
  `for_bach_sal` int(11) NOT NULL default '0',
  `can_mas_sal` int(11) NOT NULL default '0',
  `for_mas_sal` int(11) NOT NULL default '0',
  `can_doc_sal` int(11) NOT NULL default '0',
  `for_doc_sal` int(11) NOT NULL default '0',
  `can_postdoc_sal` int(11) NOT NULL default '0',
  `for_postdoc_sal` int(11) NOT NULL default '0',
  `other_sal` int(11) NOT NULL default '0',
  `contracts` int(11) NOT NULL default '0',
  `equipment` int(11) NOT NULL default '0',
  `supplies` int(11) NOT NULL default '0',
  `travel` int(11) NOT NULL default '0',
  `rts` int(11) NOT NULL default '0',
  `other` int(11) NOT NULL default '0',
  `overhead` int(11) NOT NULL default '0',
  PRIMARY KEY  (`grant_budget_id`),
  KEY `year` (`year`),
  KEY `grant_id` (`grant_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2376 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `grant_types`
-- 

CREATE TABLE IF NOT EXISTS `grant_types` (
  `grant_type_id` int(11) unsigned NOT NULL auto_increment,
  `type` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`grant_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `hs_members`
-- 

CREATE TABLE IF NOT EXISTS `hs_members` (
  `hs_member_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `active` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`hs_member_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `index_ids`
-- 

CREATE TABLE IF NOT EXISTS `index_ids` (
  `index_num` int(4) NOT NULL,
  `index_id` int(4) NOT NULL,
  PRIMARY KEY  (`index_num`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `mail`
-- 

CREATE TABLE IF NOT EXISTS `mail` (
  `mail_id` int(11) NOT NULL auto_increment,
  `subject` varchar(255) default NULL,
  `body` text,
  `s_date` int(11) NOT NULL default '0',
  `topics_research` text NOT NULL,
  `departments` text NOT NULL,
  `sent` tinyint(4) NOT NULL default '0',
  `assoc_id` int(11) default NULL,
  `type` varchar(255) default NULL,
  `ft_faculty` tinyint(4) NOT NULL default '0',
  `pt_faculty` tinyint(4) NOT NULL default '0',
  `management` tinyint(4) NOT NULL,
  `support` tinyint(4) NOT NULL,
  `outside` tinyint(4) NOT NULL default '0',
  `chairs` tinyint(4) NOT NULL default '0',
  `deans` tinyint(4) NOT NULL default '0',
  `students` tinyint(4) NOT NULL default '0',
  `tss` tinyint(4) NOT NULL,
  `single_user` text NOT NULL,
  `filename` varchar(255) NOT NULL,
  `prepend` varchar(255) NOT NULL default '[ResearchNet]' COMMENT 'Prepend for subject line',
  PRIMARY KEY  (`mail_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=158 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `maillog`
-- 

CREATE TABLE IF NOT EXISTS `maillog` (
  `log_id` int(10) unsigned NOT NULL auto_increment,
  `subject` varchar(255) NOT NULL default '',
  `mailto` varchar(255) NOT NULL default '',
  `date` int(10) unsigned NOT NULL default '0',
  `date_text` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`log_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90699 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `mail_history`
-- 

CREATE TABLE IF NOT EXISTS `mail_history` (
  `mail_history_id` int(10) unsigned NOT NULL auto_increment,
  `mail_id` int(10) unsigned NOT NULL,
  `groups` mediumtext NOT NULL,
  `people` mediumtext NOT NULL,
  `topics` mediumtext NOT NULL,
  `count` int(10) NOT NULL,
  `date` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`mail_history_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Activity for each mail item' AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `mail_queue`
-- 

CREATE TABLE IF NOT EXISTS `mail_queue` (
  `id` bigint(20) NOT NULL default '0',
  `create_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `time_to_send` datetime NOT NULL default '0000-00-00 00:00:00',
  `sent_time` datetime default NULL,
  `id_user` bigint(20) NOT NULL default '0',
  `ip` varchar(20) NOT NULL default 'unknown',
  `sender` varchar(50) NOT NULL default '',
  `recipient` text NOT NULL,
  `headers` text NOT NULL,
  `body` longtext NOT NULL,
  `try_sent` tinyint(4) NOT NULL default '0',
  `delete_after_send` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `time_to_send` (`time_to_send`),
  KEY `id_user` (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `mail_queue_seq`
-- 

CREATE TABLE IF NOT EXISTS `mail_queue_seq` (
  `id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90655 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `media`
-- 

CREATE TABLE IF NOT EXISTS `media` (
  `media_id` int(11) NOT NULL auto_increment,
  `media_type_id` int(11) NOT NULL,
  `date_added` date NOT NULL,
  `date` date NOT NULL,
  `title` varchar(255) NOT NULL,
  `synopsis` text NOT NULL,
  `description` text NOT NULL,
  `embed_code` text NOT NULL,
  `external_link` varchar(255) NOT NULL,
  `image_name` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL,
  `original_image_name` varchar(255) NOT NULL,
  `movie_name` varchar(255) NOT NULL,
  `original_movie_name` varchar(255) NOT NULL,
  `movie_file_size` int(11) NOT NULL,
  `soundtrack_name` varchar(255) NOT NULL,
  `original_soundtrack_name` varchar(255) NOT NULL,
  `feature_flag` tinyint(1) NOT NULL,
  `public_flag` tinyint(1) NOT NULL,
  `internal_flag` tinyint(1) NOT NULL,
  PRIMARY KEY  (`media_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `media_attachment`
-- 

CREATE TABLE IF NOT EXISTS `media_attachment` (
  `media_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  PRIMARY KEY  (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `media_type`
-- 

CREATE TABLE IF NOT EXISTS `media_type` (
  `media_type_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`media_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `menu`
-- 

CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` int(10) unsigned NOT NULL auto_increment,
  `order1` float unsigned NOT NULL default '0',
  `order2` int(10) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `help` varchar(255) NOT NULL default '',
  `url` varchar(255) NOT NULL default '',
  `colour` varchar(12) NOT NULL default '',
  `onClick` varchar(255) NOT NULL default '',
  `not_logged_in` tinyint(4) NOT NULL default '0',
  `logged_in` tinyint(4) NOT NULL default '0',
  `projects` tinyint(4) NOT NULL default '0',
  `sac_grant` tinyint(4) NOT NULL default '0',
  `sac_admin` tinyint(4) NOT NULL default '0',
  `ethics_admin` tinyint(4) NOT NULL default '0',
  `finance_admin` tinyint(4) NOT NULL default '0',
  `sys_admin` tinyint(4) NOT NULL default '0',
  `admin_admin` tinyint(4) NOT NULL default '0',
  `pr_admin` tinyint(4) NOT NULL default '0',
  `hs_member` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `messages`
-- 

CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `message` text NOT NULL,
  PRIMARY KEY  (`message_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_Options`
-- 

CREATE TABLE IF NOT EXISTS `MRC_Options` (
  `optionName` varchar(128) NOT NULL,
  `optionValue` text,
  PRIMARY KEY  (`optionName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_Roles`
-- 

CREATE TABLE IF NOT EXISTS `MRC_Roles` (
  `name` varchar(32) NOT NULL default '',
  `editableTiles` text,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_SortControls`
-- 

CREATE TABLE IF NOT EXISTS `MRC_SortControls` (
  `sortControl_id` int(11) NOT NULL auto_increment,
  `buttonName` varchar(32) NOT NULL default '',
  `buttonSortCriteria` varchar(32) default NULL,
  PRIMARY KEY  (`sortControl_id`,`buttonName`),
  UNIQUE KEY `sortControl_id` (`sortControl_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=42 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_Styles`
-- 

CREATE TABLE IF NOT EXISTS `MRC_Styles` (
  `styleName` varchar(128) NOT NULL default '0',
  `fontSize` int(11) default '14',
  `fontColor` varchar(12) default '0x000000',
  `fontFamily` varchar(32) default 'sans-serif',
  `fontStyles` varchar(128) default 'plain',
  `fontAlignment` varchar(32) default 'left',
  `xoffset` int(11) default '0',
  `yoffset` int(11) default '0',
  `heightMultiplier` float default '1.5',
  `marginTopAndBottom` int(11) default '5',
  PRIMARY KEY  (`styleName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_SummaryFields`
-- 

CREATE TABLE IF NOT EXISTS `MRC_SummaryFields` (
  `id` int(11) NOT NULL auto_increment,
  `path` text,
  `type` varchar(32) default NULL,
  `region` varchar(32) default NULL,
  `weight` int(11) default NULL,
  `textStyle` varchar(128) default NULL,
  `label` varchar(128) default NULL,
  `label_Enabled` int(11) default NULL,
  `label_Placement` varchar(32) default NULL,
  `textStyle_Label` varchar(128) default NULL,
  `link_Enabled` int(11) default NULL,
  `link_Type` varchar(32) default NULL,
  `list_Seperator` varchar(16) default NULL,
  `list_TitleField` varchar(128) default NULL,
  `link` tinytext,
  `textStyle_Link` varchar(128) default NULL,
  `editStyle` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1502 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `MRC_Users`
-- 

CREATE TABLE IF NOT EXISTS `MRC_Users` (
  `name` varchar(64) NOT NULL default '',
  `password` varchar(128) default NULL,
  `role` varchar(32) default NULL,
  `tileID` int(11) default NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `news`
-- 

CREATE TABLE IF NOT EXISTS `news` (
  `news_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `post_date` int(10) unsigned NOT NULL default '0',
  `event_date` int(10) unsigned NOT NULL default '0',
  `expiry_date` int(10) unsigned NOT NULL default '0',
  `description` text NOT NULL,
  `synopsis` text NOT NULL,
  `source` varchar(255) NOT NULL default '',
  `topics` text NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `feature` tinyint(1) NOT NULL,
  `news_for` tinyint(1) NOT NULL COMMENT 'TRUE if article is News for Faculty, FALSE if articel is news about faculty',
  PRIMARY KEY  (`news_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=47 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `nicknames`
-- 

CREATE TABLE IF NOT EXISTS `nicknames` (
  `researcher_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `opportunities`
-- 

CREATE TABLE IF NOT EXISTS `opportunities` (
  `opportunity_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `post_date` int(10) unsigned NOT NULL default '0',
  `due_date` int(10) unsigned NOT NULL default '0',
  `expiry_date` int(10) unsigned NOT NULL default '0',
  `agency` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `synopsis` text NOT NULL,
  `topics` text NOT NULL,
  `approved` varchar(255) NOT NULL default '',
  `annual` varchar(255) NOT NULL default '',
  `url` varchar(255) default NULL,
  `internal` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`opportunity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pictures`
-- 

CREATE TABLE IF NOT EXISTS `pictures` (
  `picture_id` int(10) unsigned NOT NULL auto_increment,
  `caption` varchar(255) NOT NULL default '',
  `file_name` varchar(255) NOT NULL default '',
  `feature` int(11) default NULL,
  PRIMARY KEY  (`picture_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=262 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pictures_associated`
-- 

CREATE TABLE IF NOT EXISTS `pictures_associated` (
  `associated_id` int(10) unsigned NOT NULL auto_increment,
  `picture_id` int(10) unsigned NOT NULL default '0',
  `object_id` int(10) unsigned NOT NULL default '0',
  `table_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`associated_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=232 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `profiles`
-- 

CREATE TABLE IF NOT EXISTS `profiles` (
  `user_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL default '',
  `faculty_display_as` varchar(255) NOT NULL,
  `dept_display_as` varchar(255) NOT NULL,
  `title` varchar(100) NOT NULL,
  `secondary_title` varchar(255) NOT NULL,
  `office` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `fax` varchar(30) NOT NULL,
  `homepage` varchar(255) NOT NULL,
  `profile_ext` text NOT NULL,
  `profile_short` text NOT NULL,
  `keywords` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `projects`
-- 

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `name_long` varchar(255) NOT NULL,
  `synopsis` text NOT NULL,
  `description` text NOT NULL,
  `feature` int(11) default NULL,
  `keywords` varchar(255) default NULL,
  `studentproj` int(11) default NULL,
  `student_names` varchar(255) default NULL,
  `end_date` int(11) default NULL,
  `approved` int(11) default NULL,
  `doll_per_yr` int(11) default NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY  (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `projects_associated`
-- 

CREATE TABLE IF NOT EXISTS `projects_associated` (
  `associated_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(11) NOT NULL default '0',
  `object_id` int(11) NOT NULL default '0',
  `table_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`associated_id`),
  KEY `project_id` (`project_id`),
  KEY `object_id` (`object_id`),
  KEY `table_name` (`table_name`(16))
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=337 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_accounts`
-- 

CREATE TABLE IF NOT EXISTS `proj_accounts` (
  `account_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `fund` tinyint(2) unsigned zerofill NOT NULL default '00',
  `biz_unit` mediumint(3) unsigned zerofill NOT NULL default '000',
  `descriptor` mediumint(5) unsigned zerofill NOT NULL default '00000',
  `user_id_1` int(10) unsigned NOT NULL default '0',
  `user_id_2` int(10) unsigned NOT NULL default '0',
  `user_id_3` int(10) unsigned NOT NULL default '0',
  `sig_auth_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`account_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_admin_status`
-- 

CREATE TABLE IF NOT EXISTS `proj_admin_status` (
  `project_id` int(10) unsigned NOT NULL auto_increment,
  `info` varchar(255) default NULL,
  `stages` varchar(255) default NULL,
  `finance` varchar(255) default NULL,
  `comm` varchar(255) default NULL,
  `milestones` varchar(255) default NULL,
  `documents` varchar(255) default NULL,
  `equipment` varchar(255) default NULL,
  `logs` varchar(255) default NULL,
  `perms` varchar(255) default NULL,
  PRIMARY KEY  (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_communications`
-- 

CREATE TABLE IF NOT EXISTS `proj_communications` (
  `comm_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `from_type` varchar(255) NOT NULL default '',
  `from_id` int(10) unsigned NOT NULL default '0',
  `from_other_name` varchar(255) NOT NULL default '',
  `from_other_address` text NOT NULL,
  `to_type` varchar(255) NOT NULL default '',
  `to_id` int(10) unsigned NOT NULL default '0',
  `to_other_name` varchar(255) NOT NULL default '',
  `to_other_email` varchar(255) NOT NULL default '',
  `to_other_address` text NOT NULL,
  `content` text NOT NULL,
  `datestamp` int(11) NOT NULL default '0',
  PRIMARY KEY  (`comm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_docs`
-- 

CREATE TABLE IF NOT EXISTS `proj_docs` (
  `doc_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `author` varchar(255) NOT NULL default '',
  `docdate` int(11) NOT NULL default '0',
  `entrydate` int(11) NOT NULL default '0',
  `equipment_id` int(10) unsigned NOT NULL default '0',
  `vendor_id` int(10) unsigned NOT NULL default '0',
  `milestone_id` int(10) unsigned NOT NULL default '0',
  `transaction_id` int(10) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `extension` varchar(10) NOT NULL default '',
  `type` varchar(255) NOT NULL default '',
  `location` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`doc_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_equipment`
-- 

CREATE TABLE IF NOT EXISTS `proj_equipment` (
  `equipment_id` int(10) unsigned NOT NULL auto_increment,
  `make` varchar(255) NOT NULL default '',
  `model` varchar(255) NOT NULL default '',
  `description` text,
  `serial_num` varchar(255) default NULL,
  `made_by` varchar(255) default NULL,
  `vendor_id` int(10) unsigned default NULL,
  `vendor_other` varchar(255) default NULL,
  `purchase_transaction_id` int(10) unsigned default NULL,
  `project_id` int(10) unsigned default NULL,
  `category_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`equipment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_equip_categories`
-- 

CREATE TABLE IF NOT EXISTS `proj_equip_categories` (
  `category_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_finance_codes`
-- 

CREATE TABLE IF NOT EXISTS `proj_finance_codes` (
  `code_id` int(10) unsigned NOT NULL auto_increment,
  `code` varchar(11) NOT NULL default '',
  `descrip` varchar(255) NOT NULL default '',
  `type` varchar(10) NOT NULL default '',
  `subhead` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`code_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_logs`
-- 

CREATE TABLE IF NOT EXISTS `proj_logs` (
  `log_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned default NULL,
  `timestamp` int(11) default NULL,
  `user_id` int(10) unsigned default NULL,
  `action` varchar(255) default NULL,
  `signif` char(1) default NULL,
  PRIMARY KEY  (`log_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=732 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_milestones`
-- 

CREATE TABLE IF NOT EXISTS `proj_milestones` (
  `milestone_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned default NULL,
  `milestone_type_id` int(10) unsigned default NULL,
  `secondary_type` varchar(255) default NULL,
  `description` text,
  `target_date` int(11) default NULL,
  `actual_date` int(11) default NULL,
  PRIMARY KEY  (`milestone_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=788 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_milestones_def`
-- 

CREATE TABLE IF NOT EXISTS `proj_milestones_def` (
  `name` varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_milestone_types`
-- 

CREATE TABLE IF NOT EXISTS `proj_milestone_types` (
  `milestone_type_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `synopsis` text,
  `morder` int(11) NOT NULL default '0',
  PRIMARY KEY  (`milestone_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_perms`
-- 

CREATE TABLE IF NOT EXISTS `proj_perms` (
  `perm_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned default NULL,
  `user_id` int(10) unsigned default NULL,
  `view` tinyint(4) default NULL,
  `basic` tinyint(4) default NULL,
  `admin` tinyint(4) default NULL,
  PRIMARY KEY  (`perm_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=79 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_projects`
-- 

CREATE TABLE IF NOT EXISTS `proj_projects` (
  `project_id` int(10) unsigned NOT NULL auto_increment,
  `type_id` int(10) unsigned default NULL,
  `name` varchar(255) default NULL,
  `descrip` text,
  `shortname` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_projects_stages`
-- 

CREATE TABLE IF NOT EXISTS `proj_projects_stages` (
  `project_id` int(10) unsigned default NULL,
  `stage_id` int(10) unsigned default NULL,
  `sequence` int(11) default NULL,
  `pps_id` int(10) unsigned NOT NULL auto_increment,
  `complete` int(11) default NULL,
  `comments` text,
  PRIMARY KEY  (`pps_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=284 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_project_accounts`
-- 

CREATE TABLE IF NOT EXISTS `proj_project_accounts` (
  `project_account_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `account_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`project_account_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_sources`
-- 

CREATE TABLE IF NOT EXISTS `proj_sources` (
  `source_id` int(10) unsigned NOT NULL auto_increment,
  `agency_name` varchar(255) NOT NULL default '',
  `program` varchar(255) NOT NULL default '',
  `research_contact` varchar(255) NOT NULL default '',
  `financial_contact` varchar(255) NOT NULL default '',
  `url_info1` varchar(255) NOT NULL default '',
  `url_info2` varchar(255) NOT NULL default '',
  `url_login` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`source_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_source_project`
-- 

CREATE TABLE IF NOT EXISTS `proj_source_project` (
  `source_project_id` int(10) unsigned NOT NULL auto_increment,
  `source_id` int(10) unsigned default NULL,
  `project_id` int(10) unsigned default NULL,
  `details` text,
  PRIMARY KEY  (`source_project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_stages`
-- 

CREATE TABLE IF NOT EXISTS `proj_stages` (
  `stage_id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `synopsis` text,
  `order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`stage_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_stages_milestones`
-- 

CREATE TABLE IF NOT EXISTS `proj_stages_milestones` (
  `psm_id` int(10) unsigned NOT NULL auto_increment,
  `stage_id` int(10) unsigned NOT NULL default '0',
  `milestone_type_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`psm_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=52 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_transactions`
-- 

CREATE TABLE IF NOT EXISTS `proj_transactions` (
  `transaction_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `account_id` int(10) unsigned NOT NULL default '0',
  `transaction_date` int(11) NOT NULL default '0',
  `enter_date` int(11) NOT NULL default '0',
  `amount` decimal(12,2) NOT NULL default '0.00',
  `description` text NOT NULL,
  `code_id` int(10) unsigned NOT NULL default '0',
  `vendor_id` int(10) unsigned NOT NULL default '0',
  `type` varchar(12) NOT NULL default '',
  `source_id` int(10) unsigned NOT NULL default '0',
  `reconciled` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`transaction_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_types`
-- 

CREATE TABLE IF NOT EXISTS `proj_types` (
  `type_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `synopsis` text,
  `financial` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_types_stages`
-- 

CREATE TABLE IF NOT EXISTS `proj_types_stages` (
  `type_id` int(10) unsigned default NULL,
  `stage_id` int(10) unsigned default NULL,
  `sequence` int(11) default NULL,
  `pts_id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`pts_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_vendors`
-- 

CREATE TABLE IF NOT EXISTS `proj_vendors` (
  `vendor_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `contact1` varchar(255) default NULL,
  `role1` varchar(255) default NULL,
  `email1` varchar(255) default NULL,
  `phone1` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `contact2` varchar(255) default NULL,
  `role2` varchar(255) default NULL,
  `email2` varchar(255) default NULL,
  `phone2` varchar(255) default NULL,
  `contact3` varchar(255) default NULL,
  `role3` varchar(255) default NULL,
  `email3` varchar(255) default NULL,
  `phone3` varchar(255) default NULL,
  `address` text,
  PRIMARY KEY  (`vendor_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_warnings`
-- 

CREATE TABLE IF NOT EXISTS `proj_warnings` (
  `warning_id` int(10) unsigned NOT NULL auto_increment,
  `milestone_id` int(10) unsigned NOT NULL default '0',
  `perm_id` int(10) NOT NULL default '0',
  `type` tinyint(4) NOT NULL default '0',
  `advance` int(11) NOT NULL default '0',
  `priority` tinyint(10) NOT NULL default '3',
  `warning_text` text NOT NULL,
  `replace_text` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`warning_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_workingdocs`
-- 

CREATE TABLE IF NOT EXISTS `proj_workingdocs` (
  `doc_id` int(10) unsigned NOT NULL auto_increment,
  `project_id` int(10) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `author` varchar(255) NOT NULL default '',
  `docdate` int(11) NOT NULL default '0',
  `equipment_id` int(10) unsigned NOT NULL default '0',
  `vendor_id` int(10) unsigned NOT NULL default '0',
  `milestone_id` int(10) unsigned NOT NULL default '0',
  `transaction_id` int(10) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `extension` varchar(10) NOT NULL default '',
  `status` tinyint(4) NOT NULL default '0',
  `user_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`doc_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `proj_workingdoc_ver`
-- 

CREATE TABLE IF NOT EXISTS `proj_workingdoc_ver` (
  `version_id` int(10) unsigned NOT NULL auto_increment,
  `doc_id` int(10) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `extension` varchar(10) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `comment` text NOT NULL,
  `verdate` int(11) NOT NULL default '0',
  PRIMARY KEY  (`version_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `redirects`
-- 

CREATE TABLE IF NOT EXISTS `redirects` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `url` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=163 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `refworks`
-- 

CREATE TABLE IF NOT EXISTS `refworks` (
  `type_id` int(11) NOT NULL,
  `RT` varchar(100) NOT NULL,
  `A1` varchar(100) NOT NULL,
  `T1` varchar(255) NOT NULL,
  `JF` varchar(255) NOT NULL,
  `JO` varchar(100) NOT NULL,
  `YR` int(11) NOT NULL,
  `FD` varchar(100) NOT NULL,
  `VO` varchar(100) NOT NULL,
  `IS` varchar(100) NOT NULL,
  `SP` varchar(100) NOT NULL,
  `OP` varchar(100) NOT NULL,
  `K1` varchar(100) NOT NULL,
  `AB` varchar(100) NOT NULL,
  `NO` varchar(100) NOT NULL,
  `A2` varchar(100) NOT NULL,
  `T2` varchar(100) NOT NULL,
  `ED` varchar(100) NOT NULL,
  `PB` varchar(100) NOT NULL,
  `PP` varchar(100) NOT NULL,
  `A3` varchar(100) NOT NULL,
  `A4` varchar(100) NOT NULL,
  `A5` varchar(100) NOT NULL,
  `T3` varchar(100) NOT NULL,
  `SN` varchar(100) NOT NULL,
  `AV` varchar(100) NOT NULL,
  `AD` varchar(100) NOT NULL,
  `AN` varchar(100) NOT NULL,
  `LA` varchar(100) NOT NULL,
  `CL` varchar(100) NOT NULL,
  `SF` varchar(100) NOT NULL,
  `OT` varchar(100) NOT NULL,
  `LK` varchar(100) NOT NULL,
  `DO` varchar(100) NOT NULL,
  `CN` varchar(100) NOT NULL,
  `DB` varchar(100) NOT NULL,
  `DS` varchar(100) NOT NULL,
  `IP` varchar(100) NOT NULL,
  `RD` varchar(100) NOT NULL,
  `ST` varchar(100) NOT NULL,
  `U1` varchar(100) NOT NULL,
  `U2` varchar(100) NOT NULL,
  `U3` varchar(100) NOT NULL,
  `U4` varchar(100) NOT NULL,
  `U5` varchar(100) NOT NULL,
  `f1` varchar(255) NOT NULL,
  `f2` varchar(255) NOT NULL,
  `f3` varchar(255) NOT NULL,
  `f4` varchar(255) NOT NULL,
  `f5` varchar(255) NOT NULL,
  `f6` varchar(255) NOT NULL,
  `f7` varchar(255) NOT NULL,
  `f8` varchar(255) NOT NULL,
  `f9` varchar(255) NOT NULL,
  `f10` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Data imported from RefWorks';

-- --------------------------------------------------------

-- 
-- Table structure for table `researchers`
-- 

CREATE TABLE IF NOT EXISTS `researchers` (
  `researcher_id` int(10) unsigned NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `feature` int(11) default NULL,
  `keywords` varchar(255) default NULL,
  `faculty_id` int(11) NOT NULL,
  PRIMARY KEY  (`researcher_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=184 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `researchers_associated`
-- 

CREATE TABLE IF NOT EXISTS `researchers_associated` (
  `associated_id` int(10) unsigned NOT NULL auto_increment,
  `researcher_id` int(11) NOT NULL default '0',
  `object_id` int(11) NOT NULL default '0',
  `table_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`associated_id`),
  KEY `researcher_id` (`researcher_id`),
  KEY `table_name` (`table_name`),
  KEY `object_id` (`object_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_belongsin`
-- 

CREATE TABLE IF NOT EXISTS `rpb_belongsin` (
  `parentDataTableName` varchar(32) NOT NULL default '',
  `parentDataFieldName` varchar(32) NOT NULL default '',
  `item_id` int(11) NOT NULL default '0',
  `sharedItem_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`parentDataTableName`,`parentDataFieldName`,`item_id`,`sharedItem_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_departments`
-- 

CREATE TABLE IF NOT EXISTS `rpb_departments` (
  `id` int(10) NOT NULL default '0',
  `department_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `shortname` varchar(60) NOT NULL,
  `division_id` int(10) unsigned NOT NULL default '0',
  `chair` int(10) unsigned NOT NULL default '0',
  `department_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `department_name` (`department_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_divisions`
-- 

CREATE TABLE IF NOT EXISTS `rpb_divisions` (
  `id` int(10) NOT NULL default '0',
  `division_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `dean` int(10) unsigned NOT NULL default '0',
  `division_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `division_name` (`division_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_id_conversion`
-- 

CREATE TABLE IF NOT EXISTS `rpb_id_conversion` (
  `id` int(11) default NULL,
  `table_name` varchar(64) default NULL,
  `id_field_name` varchar(64) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_profiles`
-- 

CREATE TABLE IF NOT EXISTS `rpb_profiles` (
  `id` int(10) NOT NULL default '0',
  `user_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL default '',
  `faculty_display_as` varchar(255) NOT NULL,
  `dept_display_as` varchar(255) NOT NULL,
  `title` varchar(100) NOT NULL,
  `secondary_title` varchar(255) NOT NULL,
  `office` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `fax` varchar(30) NOT NULL,
  `homepage` varchar(255) NOT NULL,
  `profile_ext` text NOT NULL,
  `profile_short` text NOT NULL,
  `keywords` text NOT NULL,
  `description` text NOT NULL,
  `full_cv_link` varchar(512) default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_readiblenames`
-- 

CREATE TABLE IF NOT EXISTS `rpb_readiblenames` (
  `readibleName` varchar(64) NOT NULL default '',
  `fieldName` varchar(128) NOT NULL default '',
  `tableName` varchar(128) NOT NULL default '',
  `path` text NOT NULL,
  `priority` int(11) default '0',
  PRIMARY KEY  (`readibleName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_topics_research`
-- 

CREATE TABLE IF NOT EXISTS `rpb_topics_research` (
  `id` int(10) NOT NULL default '0',
  `topic_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `topic_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `topic_name` (`topic_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_users`
-- 

CREATE TABLE IF NOT EXISTS `rpb_users` (
  `id` int(10) NOT NULL default '0',
  `user_id` int(10) unsigned NOT NULL default '0',
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `username` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `visits` int(11) default NULL,
  `date` int(11) unsigned NOT NULL,
  `mail_events` tinyint(1) unsigned NOT NULL default '0',
  `mail_deadlines` tinyint(1) unsigned NOT NULL default '0',
  `password2` varchar(255) NOT NULL default '',
  `department_id` int(10) unsigned NOT NULL default '0',
  `department2_id` int(10) unsigned NOT NULL COMMENT 'Secondary Department',
  `emp_type` varchar(50) NOT NULL,
  `feature` tinyint(1) NOT NULL COMMENT 'Flag for front page feature',
  `sys_admin` tinyint(1) NOT NULL,
  `ethics_admin` tinyint(1) NOT NULL,
  `finance_admin` tinyint(1) NOT NULL,
  `user_level` tinyint(4) NOT NULL COMMENT '0=normal 1=hidden 2=hidden+disabled',
  `faculty_id` int(11) NOT NULL,
  `browser` tinyint(1) NOT NULL default '0' COMMENT 'Flag for inclusion in researcher browser',
  `imageName` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `rpb_user_topics_profile`
-- 

CREATE TABLE IF NOT EXISTS `rpb_user_topics_profile` (
  `id` int(10) NOT NULL default '0',
  `user_topics_profile_id` int(11) unsigned NOT NULL default '0',
  `topic_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `sac_budget`
-- 

CREATE TABLE IF NOT EXISTS `sac_budget` (
  `budget_id` int(10) unsigned NOT NULL auto_increment,
  `grant_id` int(10) unsigned NOT NULL default '0',
  `category_id` int(10) unsigned NOT NULL default '0',
  `amount` float NOT NULL default '0',
  PRIMARY KEY  (`budget_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=155 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `sac_categories`
-- 

CREATE TABLE IF NOT EXISTS `sac_categories` (
  `category_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `sac_grants`
-- 

CREATE TABLE IF NOT EXISTS `sac_grants` (
  `grant_id` int(10) unsigned NOT NULL auto_increment,
  `active` tinyint(3) unsigned NOT NULL default '0',
  `start_date` int(11) NOT NULL default '0',
  `end_date` int(11) NOT NULL default '0',
  `main_user` int(10) unsigned NOT NULL default '0',
  `second_user` int(10) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `review_required` tinyint(4) NOT NULL default '0',
  `reviewed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`grant_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `sac_transactions`
-- 

CREATE TABLE IF NOT EXISTS `sac_transactions` (
  `transaction_id` int(10) unsigned NOT NULL auto_increment,
  `grant_id` int(10) unsigned NOT NULL default '0',
  `category_id` int(10) unsigned NOT NULL default '0',
  `code_id` int(10) unsigned NOT NULL default '0',
  `date` int(11) NOT NULL default '0',
  `amount` float NOT NULL default '0',
  `advance` tinyint(4) NOT NULL default '0',
  `reconciled` tinyint(4) NOT NULL default '0',
  `description` varchar(255) NOT NULL default '',
  `description2` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`transaction_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `students`
-- 

CREATE TABLE IF NOT EXISTS `students` (
  `student_id` int(10) unsigned NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `username` varchar(255) NOT NULL default '',
  `visits` int(11) default NULL,
  `date` int(11) unsigned NOT NULL,
  `mail_events` tinyint(1) unsigned NOT NULL default '0',
  `mail_deadlines` tinyint(1) unsigned NOT NULL default '0',
  `user_level` tinyint(4) NOT NULL COMMENT '0=normal 1=hidden 2=hidden+disabled',
  `email` varchar(255) NOT NULL,
  PRIMARY KEY  (`student_id`),
  KEY `username` (`username`(16))
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=201477467 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `student_awards`
-- 

CREATE TABLE IF NOT EXISTS `student_awards` (
  `student_award_id` int(10) unsigned NOT NULL auto_increment,
  `student_name` varchar(255) NOT NULL default '',
  `phone` varchar(20) NOT NULL default '',
  `address` varchar(255) NOT NULL default '',
  `student_num` varchar(20) NOT NULL default '',
  `institution` varchar(255) NOT NULL default '',
  `sin` varchar(12) NOT NULL default '',
  `supervisor` varchar(255) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `dept` varchar(255) NOT NULL default '',
  `award_type` varchar(30) NOT NULL default '',
  `date_from` int(10) unsigned NOT NULL default '0',
  `date_to` int(10) unsigned NOT NULL default '0',
  `account_num_0` varchar(30) NOT NULL default '',
  `s_amount_0` float NOT NULL default '0',
  `s_date_0` int(10) unsigned NOT NULL default '0',
  `account_num_1` varchar(30) NOT NULL default '',
  `s_amount_1` float NOT NULL default '0',
  `s_date_1` int(10) unsigned NOT NULL default '0',
  `account_num_2` varchar(30) NOT NULL default '',
  `s_amount_2` float NOT NULL default '0',
  `s_date_2` int(10) unsigned NOT NULL default '0',
  `account_num_3` varchar(30) NOT NULL default '',
  `s_amount_3` float NOT NULL default '0',
  `s_date_3` int(10) unsigned NOT NULL default '0',
  `monthly` tinyint(4) NOT NULL default '0',
  `reason` text NOT NULL,
  `description` text NOT NULL,
  `supervisor_sig` int(10) unsigned NOT NULL default '0',
  `chair_id` int(10) unsigned NOT NULL default '0',
  `chair_sig` int(10) unsigned NOT NULL default '0',
  `date_submitted` int(10) unsigned NOT NULL default '0',
  `closed` tinyint(4) NOT NULL default '0',
  `sigs_received` tinyint(4) NOT NULL default '0',
  `approved` tinyint(4) NOT NULL default '0',
  `processed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`student_award_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `student_award_disb`
-- 

CREATE TABLE IF NOT EXISTS `student_award_disb` (
  `student_award_disb_id` int(10) unsigned NOT NULL auto_increment,
  `student_award_id` int(10) unsigned NOT NULL default '0',
  `d_amount` float NOT NULL default '0',
  `d_date` int(10) unsigned NOT NULL default '0',
  `comment` varchar(255) NOT NULL default '',
  `actual_date` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`student_award_disb_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=657 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `st_ras`
-- 

CREATE TABLE IF NOT EXISTS `st_ras` (
  `st_ra_id` int(10) unsigned NOT NULL auto_increment,
  `student_name` varchar(255) NOT NULL default '',
  `phone` varchar(20) NOT NULL default '',
  `address` varchar(255) NOT NULL default '',
  `student_num` varchar(20) NOT NULL default '',
  `institution` varchar(255) NOT NULL default '',
  `sin` varchar(12) NOT NULL default '',
  `supervisor` varchar(255) NOT NULL default '',
  `user_id` int(10) unsigned NOT NULL default '0',
  `dept` varchar(255) NOT NULL default '',
  `award_type` varchar(30) NOT NULL default '',
  `date_from` int(10) unsigned NOT NULL default '0',
  `date_to` int(10) unsigned NOT NULL default '0',
  `account_num_0` varchar(30) NOT NULL default '',
  `s_amount_0` float NOT NULL default '0',
  `s_date_0` int(10) unsigned NOT NULL default '0',
  `account_num_1` varchar(30) NOT NULL default '',
  `s_amount_1` float NOT NULL default '0',
  `s_date_1` int(10) unsigned NOT NULL default '0',
  `account_num_2` varchar(30) NOT NULL default '',
  `s_amount_2` float NOT NULL default '0',
  `s_date_2` int(10) unsigned NOT NULL default '0',
  `account_num_3` varchar(30) NOT NULL default '',
  `s_amount_3` float NOT NULL default '0',
  `s_date_3` int(10) unsigned NOT NULL default '0',
  `monthly` tinyint(4) NOT NULL default '0',
  `reason` text NOT NULL,
  `description` text NOT NULL,
  `supervisor_sig` int(10) unsigned NOT NULL default '0',
  `chair_id` int(10) unsigned NOT NULL default '0',
  `chair_sig` int(10) unsigned NOT NULL default '0',
  `avp_id` int(10) unsigned NOT NULL default '0',
  `avp_sig` int(10) unsigned NOT NULL default '0',
  `avp_comment` text NOT NULL,
  `date_submitted` int(10) unsigned NOT NULL default '0',
  `closed` tinyint(4) NOT NULL default '0',
  `sigs_received` tinyint(4) NOT NULL default '0',
  `approved` tinyint(4) NOT NULL default '0',
  `processed` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`st_ra_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `st_ra_disb`
-- 

CREATE TABLE IF NOT EXISTS `st_ra_disb` (
  `st_ra_disb_id` int(10) unsigned NOT NULL auto_increment,
  `st_ra_id` int(10) unsigned NOT NULL default '0',
  `d_amount` float NOT NULL default '0',
  `d_date` int(10) unsigned NOT NULL default '0',
  `comment` varchar(255) NOT NULL default '',
  `actual_date` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`st_ra_disb_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=649 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `topics_research`
-- 

CREATE TABLE IF NOT EXISTS `topics_research` (
  `topic_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `username` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `visits` int(11) default NULL,
  `date` int(11) unsigned NOT NULL,
  `mail_events` tinyint(1) unsigned NOT NULL default '0',
  `mail_deadlines` tinyint(1) unsigned NOT NULL default '0',
  `password2` varchar(255) NOT NULL default '',
  `department_id` int(10) unsigned NOT NULL default '0',
  `department2_id` int(10) unsigned NOT NULL COMMENT 'Secondary Department',
  `emp_type` varchar(50) NOT NULL,
  `feature` tinyint(1) NOT NULL COMMENT 'Flag for front page feature',
  `sys_admin` tinyint(1) NOT NULL,
  `ethics_admin` tinyint(1) NOT NULL,
  `finance_admin` tinyint(1) NOT NULL,
  `user_level` tinyint(4) NOT NULL COMMENT '0=normal 1=hidden 2=hidden+disabled',
  `faculty_id` int(11) NOT NULL,
  `browser` tinyint(1) NOT NULL default '0' COMMENT 'Flag for inclusion in researcher browser',
  PRIMARY KEY  (`user_id`),
  KEY `department_id` (`department_id`),
  KEY `username` (`username`(16))
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1634 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users_disabled`
-- 

CREATE TABLE IF NOT EXISTS `users_disabled` (
  `user_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `users_ext`
-- 

CREATE TABLE IF NOT EXISTS `users_ext` (
  `emp_num` int(10) unsigned default NULL,
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `emp_status` varchar(10) NOT NULL COMMENT 'TN=Tenure-track, TC=Term Certain',
  `start_date` int(10) unsigned NOT NULL,
  `tss` tinyint(2) unsigned NOT NULL,
  `tss_start` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1642 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users_ext2`
-- 

CREATE TABLE IF NOT EXISTS `users_ext2` (
  `emp_num` int(10) unsigned default NULL,
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `emp_type` varchar(50) NOT NULL,
  `emp_status` varchar(10) NOT NULL COMMENT 'TN=Tenure-track, TC=Term Certain',
  `start_date` int(10) unsigned NOT NULL,
  `tss` tinyint(2) unsigned NOT NULL,
  `tss_start` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `emp_num` (`emp_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1601 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users_hidden`
-- 

CREATE TABLE IF NOT EXISTS `users_hidden` (
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Users that should not show in any listing';

-- --------------------------------------------------------

-- 
-- Table structure for table `user_export`
-- 

CREATE TABLE IF NOT EXISTS `user_export` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `date` varchar(255) default NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `user_topics_filter`
-- 

CREATE TABLE IF NOT EXISTS `user_topics_filter` (
  `user_topics_filter_id` int(11) unsigned NOT NULL auto_increment,
  `topic_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`user_topics_filter_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Relate users and topics for personal filter' AUTO_INCREMENT=4427 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `user_topics_profile`
-- 

CREATE TABLE IF NOT EXISTS `user_topics_profile` (
  `user_topics_profile_id` int(11) unsigned NOT NULL auto_increment,
  `topic_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`user_topics_profile_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Relate users and topics for external profile' AUTO_INCREMENT=2382 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `user_types`
-- 

CREATE TABLE IF NOT EXISTS `user_types` (
  `code` varchar(12) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Proper names for the user type codes from BANNER + additions';

-- --------------------------------------------------------

-- 
-- Table structure for table `vps`
-- 

CREATE TABLE IF NOT EXISTS `vps` (
  `vp_id` int(10) unsigned NOT NULL auto_increment,
  `vp` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`vp_id`),
  KEY `vp` (`vp`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;
