SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`contacts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`contacts` (
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
-- Table `mydb`.`fees`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`fees` (
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
-- Table `mydb`.`gps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`gps` (
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
-- Table `mydb`.`parks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`parks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name`  VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
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
-- Table `mydb`.`points_of_interest`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`points_of_interest` (
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
    REFERENCES `mydb`.`gps` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_points_of_interest_contacts1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `mydb`.`contacts` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`popularities`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`popularities` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `rate` INT(11) NOT NULL ,
  `poi_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_popularities_points_of_interest` (`poi_id` ASC) ,
  CONSTRAINT `fk_popularities_points_of_interest`
    FOREIGN KEY (`poi_id` )
    REFERENCES `mydb`.`points_of_interest` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`schedules`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`schedules` (
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
    REFERENCES `mydb`.`fees` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`tan_stops`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tan_stops` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `number_of_line` INT(11) NOT NULL ,
  `name_stop` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `longitude` FLOAT NOT NULL ,
  `latitude` FLOAT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`tan_stop_poi`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tan_stop_poi` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `poi_id` INT(11) NOT NULL ,
  `tan_stop_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_tan_stop_poi_points_of_interest1` (`poi_id` ASC) ,
  INDEX `fk_tan_stop_poi_tan_stops1` (`tan_stop_id` ASC) ,
  CONSTRAINT `fk_tan_stop_poi_points_of_interest1`
    FOREIGN KEY (`poi_id` )
    REFERENCES `mydb`.`points_of_interest` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tan_stop_poi_tan_stops1`
    FOREIGN KEY (`tan_stop_id` )
    REFERENCES `mydb`.`tan_stops` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
