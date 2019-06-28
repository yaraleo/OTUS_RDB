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
  PRIMARY KEY (id_categ),
  CONSTRAINT parent_id_categ
    FOREIGN KEY (id_categ,perent_id_categ)
    REFERENCES otus_shop.categories (id_categ , id_categ)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE INDEX parent_id_categ_idx ON categories (id_categ ASC, perent_id_categ ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`VENDORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`VENDORS` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`VENDORS` (
  `id_vendor` INT(11) NOT NULL COMMENT 'Идентификатор производителя в таблице',
  `vend_name` VARCHAR(125) NOT NULL COMMENT 'Название производителя',
  `vend_address` VARCHAR(255) NOT NULL COMMENT 'Адрес производителя',
  PRIMARY KEY (`id_vendor`) COMMENT 'Индекс на ключевое поле')
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
-- Table `otus_shop`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`product` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`product` (
  `id_product` INT(11) UNSIGNED NOT NULL COMMENT 'Идентификатор продукта в таблице',
  `id_categ` INT(11) NULL COMMENT 'Идентификатор категории',
  `product_name` VARCHAR(45) NULL COMMENT 'Имя продукта',
  `price` DECIMAL(10,4) NULL COMMENT 'Цена продажи',
  PRIMARY KEY (`id_product`) COMMENT 'Индекс на ключевое поле',
  CONSTRAINT `id_categ`
    FOREIGN KEY (`id_categ`)
    REFERENCES `otus_shop`.`categories` (`id_categ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_categ_idx` ON `otus_shop`.`product` (`id_categ` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`dealers2vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`dealers2vendors` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`dealers2vendors` (
  `id_dealer` INT(11) NOT NULL COMMENT 'Идентификатор поставщика',
  `id_vendor` INT(11) NOT NULL COMMENT 'Идентификатор производителя',
  `data_start` DATETIME NULL COMMENT 'Дата начала отношений Дилер-Вендор',
  `data_end` DATETIME NULL COMMENT 'Дата завершения отношений Дилер-Вендор',
  PRIMARY KEY (`id_vendor`, `id_dealer`),
  CONSTRAINT `id_dealer`
    FOREIGN KEY (`id_dealer`)
    REFERENCES `otus_shop`.`dealers` (`id_dealer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_vendor`
    FOREIGN KEY (`id_vendor`)
    REFERENCES `otus_shop`.`VENDORS` (`id_vendor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_dealer_idx` ON `otus_shop`.`dealers2vendors` (`id_dealer` ASC) COMMENT 'Индекс на внешний ключ' INVISIBLE;

CREATE INDEX `id_vendor_idx` ON `otus_shop`.`dealers2vendors` (`id_vendor` ASC) COMMENT 'Индекс на внешний ключ' INVISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`stock` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`stock` (
  `id_stock` INT(11) NOT NULL COMMENT 'Идентификатор записи в таблице',
  `id_date` DATE NOT NULL COMMENT 'Статус единицы товара на складе',
  `id_dealer` INT(11) NULL,
  `id_vendor` INT(11) NOT NULL COMMENT 'Внешний ключ модель',
  `item_serial_num` VARCHAR(45) NULL COMMENT 'Сериальный уникальный номер  единцы товара',
  `item_cost` DECIMAL(10,4) NOT NULL COMMENT 'Закупочная цена поставщика',
  `id_categ` INT(11) NULL COMMENT 'Идентфикатор категории - Внешний ключ',
  `reserve_sold` ENUM('1', '2', '3', '4') NULL COMMENT 'Статус 1-резерв, 2- продано, 3 - неисправно, 4 - выставочный образец',
  `id_product` INT(11) NULL,
  PRIMARY KEY (`id_stock`) COMMENT 'Индекс на ключевое поле',
  CONSTRAINT `id_categ`
    FOREIGN KEY (`id_categ`)
    REFERENCES `otus_shop`.`categories` (`id_categ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `otus_shop`.`product` (`id_categ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_dealer`
    FOREIGN KEY (`id_dealer`)
    REFERENCES `otus_shop`.`dealers2vendors` (`id_dealer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_vendor`
    FOREIGN KEY (`id_vendor`)
    REFERENCES `otus_shop`.`dealers2vendors` (`id_vendor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_categ_idx` ON `otus_shop`.`stock` (`id_categ` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;

CREATE INDEX `id_product_idx` ON `otus_shop`.`stock` (`id_product` ASC) VISIBLE;

CREATE INDEX `id_dealer_idx` ON `otus_shop`.`stock` (`id_dealer` ASC) VISIBLE;

CREATE INDEX `id_vendor_idx` ON `otus_shop`.`stock` (`id_vendor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`description` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`description` (
  `id_description` INT(11) NOT NULL COMMENT 'Идентификатор характеристики в таблице',
  `description_name` VARCHAR(45) NOT NULL COMMENT 'Название характеристики',
  `description_vol` VARCHAR(255) NULL COMMENT 'Значение или описание характеристики',
  PRIMARY KEY (`id_description`) COMMENT 'Индекс на ключевое поле')
ENGINE = InnoDB;

CREATE INDEX `id_description_idx` ON `otus_shop`.`description` (`id_description` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`product2description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`product2description` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`product2description` (
  `id_description` INT(11) NOT NULL COMMENT 'Идентификатор характеристики',
  `id_product` INT(11) NOT NULL COMMENT 'Идентификатор продукта',
  PRIMARY KEY (`id_description`, `id_product`),
  CONSTRAINT `id_description`
    FOREIGN KEY (`id_description`)
    REFERENCES `otus_shop`.`description` (`id_description`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `otus_shop`.`product` (`id_categ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_product_idx` ON `otus_shop`.`product2description` (`id_product` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`users` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`users` (
  `id_user` INT(11) UNSIGNED NOT NULL COMMENT 'Идентификация пользователя (покупателя)',
  `name` VARCHAR(45) NOT NULL COMMENT 'Имя пользователя',
  `lastname` VARCHAR(45) NOT NULL COMMENT 'Фамилия пользователя',
  `birthdate` DATE NOT NULL COMMENT 'Дата рождения пользователя',
  `login` VARCHAR(45) NOT NULL COMMENT 'Логин для входа на сайт',
  `hash_pass` VARCHAR(45) NOT NULL COMMENT 'Хэш пароля',
  PRIMARY KEY (`id_user`) COMMENT 'Индекс на ключевое поле')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus_shop`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`orders` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`orders` (
  `id_order` INT(11) UNSIGNED NOT NULL COMMENT 'Идентификатор заказа в таблице',
  `order_number` VARCHAR(45) NOT NULL COMMENT 'Номер заказа в бухгалтерской системе компании',
  `date` DATE NOT NULL COMMENT 'Дата заказа',
  `id_user` INT(11) NOT NULL COMMENT 'Идентификатор покупателя',
  PRIMARY KEY (`id_order`) COMMENT 'Индекс на ключевое поле',
  CONSTRAINT `id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `otus_shop`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `order_user_idx` ON `otus_shop`.`orders` (`id_user` ASC) COMMENT 'Индекс на внешний ключ' INVISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`order2product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`order2product` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`order2product` (
  `id_order` INT(11) NOT NULL COMMENT 'Идентификатор заказа в таблице',
  `id_product` INT(11) NOT NULL COMMENT 'Идентификатор продукта',
  `qty` INT(11) NOT NULL COMMENT 'Количество единиц продукта',
  PRIMARY KEY (`id_order`, `id_product`),
  CONSTRAINT `id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `otus_shop`.`orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `otus_shop`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_product_idx` ON `otus_shop`.`order2product` (`id_product` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;

CREATE INDEX `id_order_idx` ON `otus_shop`.`order2product` (`id_order` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;


-- -----------------------------------------------------
-- Table `otus_shop`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otus_shop`.`payments` ;

CREATE TABLE IF NOT EXISTS `otus_shop`.`payments` (
  `id_payments` INT(11) UNSIGNED NOT NULL COMMENT 'Идентификатор платежа в таблице',
  `transaction_id` INT(21) NOT NULL COMMENT 'Идентификатор транзакции в платежной системе',
  `datetime` DATETIME NOT NULL COMMENT 'Дата время транзакции',
  `id_order` INT(11) NOT NULL COMMENT 'Идентификатор заказа',
  `sum` INT(11) NOT NULL COMMENT 'Сумма платежа',
  `currency` VARCHAR(25) NOT NULL COMMENT 'Валюта платежа',
  PRIMARY KEY (`id_payments`) COMMENT 'Индекс на ключевое поле',
  CONSTRAINT `id_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `otus_shop`.`orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_order_idx` ON `otus_shop`.`payments` (`id_order` ASC) COMMENT 'Индекс на внешний ключ' VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
