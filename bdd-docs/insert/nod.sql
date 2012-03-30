SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `nod` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `nod` ;

-- -----------------------------------------------------
-- Table `nod`.`contacts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`contacts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `phone` INT(11) NOT NULL ,
  `email` INT(11) NOT NULL ,
  `website` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`fees`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`fees` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `individual` INT(11) NOT NULL ,
  `group` INT(11) NOT NULL ,
  `subscription` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`gps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`gps` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `longitude` FLOAT NOT NULL ,
  `latitude` FLOAT NOT NULL ,
  `address` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `zip` INT(11) NOT NULL ,
  `city` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`parks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`parks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `games` TINYINT(1) NOT NULL ,
  `parc_picnic_furniture` TINYINT(1) NOT NULL ,
  `wading_pool` TINYINT(1) NOT NULL ,
  `fountain` TINYINT(1) NOT NULL ,
  `restrooms` TINYINT(1) NOT NULL ,
  `shed` TINYINT(1) NOT NULL ,
  `disabled_access` TINYINT(1) NOT NULL ,
  `vegetal_collection` TINYINT(1) NOT NULL ,
  `keeper` TINYINT(1) NOT NULL ,
  `parc_close_garden` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`points_of_interest`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`points_of_interest` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `contact_id` INT(11) NOT NULL ,
  `gps_id` INT(11) NOT NULL ,
  `type` VARCHAR(80) NOT NULL ,
  `type_id_in_table` INT(11) NOT NULL ,
  `schedule` INT(11) NOT NULL ,
  `schedule_exc` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_points_of_interest_gps1` (`gps_id` ASC) ,
  INDEX `fk_points_of_interest_contacts1` (`contact_id` ASC) ,
  CONSTRAINT `fk_points_of_interest_gps1`
    FOREIGN KEY (`gps_id` )
    REFERENCES `nod`.`gps` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_points_of_interest_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `nod`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`popularities`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`popularities` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `rate` INT(11) NOT NULL ,
  `poi_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_popularities_points_of_interest` (`poi_id` ASC) ,
  CONSTRAINT `fk_popularities_points_of_interest`
    FOREIGN KEY (`poi_id` )
    REFERENCES `nod`.`points_of_interest` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`schedules`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`schedules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_start_period` DATE NOT NULL ,
  `date_end_period` DATE NOT NULL ,
  `time_start` TIME NOT NULL ,
  `time_end` TIME NOT NULL ,
  `days` VARCHAR(7) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `fee_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_schedules_fees1` (`fee_id` ASC) ,
  CONSTRAINT `fk_schedules_fees1`
    FOREIGN KEY (`fee_id` )
    REFERENCES `nod`.`fees` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`tan_stops`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`tan_stops` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `number_of_line` INT(11) NOT NULL ,
  `name_stop` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `longitude` FLOAT NOT NULL ,
  `latitude` FLOAT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `nod`.`tan_stop_poi`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `nod`.`tan_stop_poi` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `poi_id` INT(11) NOT NULL ,
  `tan_stop_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_tan_stop_poi_points_of_interest1` (`poi_id` ASC) ,
  INDEX `fk_tan_stop_poi_tan_stops1` (`tan_stop_id` ASC) ,
  CONSTRAINT `fk_tan_stop_poi_points_of_interest1`
    FOREIGN KEY (`poi_id` )
    REFERENCES `nod`.`points_of_interest` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tan_stop_poi_tan_stops1`
    FOREIGN KEY (`tan_stop_id` )
    REFERENCES `nod`.`tan_stops` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
