-- -----------------------------------------------------
-- Schema otus_shop version 1 28062019
-- created by Yaroslav Levanenko
-- project database schema for online shop
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS otus_shop DEFAULT CHARACTER SET utf8 ;
USE otus_shop;

-- -----------------------------------------------------
-- Table otus_shop.categories
-- -----------------------------------------------------
DROP TABLE IF EXISTS categories;

CREATE TABLE IF NOT EXISTS categories 
(
  id_categ INT(11) UNSIGNED NOT NULL,
  name_categ VARCHAR(45) NOT NULL,
  perent_id_categ INT(11) NULL,
  PRIMARY KEY (id_categ)
)
ENGINE = InnoDB;

CREATE INDEX parent_id_categ_idx ON categories (id_categ ASC, perent_id_categ ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`VENDORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS VENDORS;

CREATE TABLE IF NOT EXISTS otus_shop.VENDORS
(
  id_vendor INT(11) NOT NULL,
  vend_name VARCHAR(125) NOT NULL,
  vend_address VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_vendor)
 )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_vendor_idx` ON `otus_shop`.`VENDORS` (`id_vendor` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`dealers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`dealers` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`dealers` (
  `id_dealer` INT(11) UNSIGNED NOT NULL COMMENT 'Идентификатор поставщика в таблице',
  `dealer_name` VARCHAR(45) NOT NULL COMMENT 'Имя поставщика',
  `dealer_adress` VARCHAR(255) NOT NULL COMMENT 'Адрес поставщика',
  PRIMARY KEY (`id_dealer`) COMMENT 'Индекс на ключевое поле')
ENGINE = InnoDB;

CREATE INDEX `id_dealer_idx` ON `otus_shop`.`dealers` (`id_dealer` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;

-- -----------------------------------------------------
-- Table `otus_shop`.`dealers2vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`dealers2vendors` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`dealers2vendors` (
  `id_dealer` INT(11) NOT NULL COMMENT 'Идентификатор поставщика',
  `id_vendor` INT(11) NOT NULL COMMENT 'Идентификатор производителя',
  `data_start` DATETIME NULL COMMENT 'Дата начала отношений Дилер-Вендор',
  `data_end` DATETIME NULL COMMENT 'Дата завершения отношений Дилер-Вендор',
  PRIMARY KEY (`id_vendor`, `id_dealer`)
)
ENGINE = InnoDB;

CREATE INDEX `id_dealer_idx` ON `otus_shop`.`dealers2vendors` (`id_dealer` ASC) COMMENT 'Индекс на внешний ключ' INVISIBLE;

CREATE INDEX `id_vendor_idx` ON `otus_shop`.`dealers2vendors` (`id_vendor` ASC) COMMENT 'Индекс на внешний ключ' INVISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
