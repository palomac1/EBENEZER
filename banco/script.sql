-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_ebenezer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_ebenezer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_ebenezer` DEFAULT CHARACTER SET utf8mb4 ;
USE `db_ebenezer` ;

-- -----------------------------------------------------
-- Table `db_ebenezer`.`voluntarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`voluntarios` (
  `cod_voluntario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `data_nasc` DATETIME NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_voluntario`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`ong` (
  `cod_ong` INT(11) NOT NULL AUTO_INCREMENT,
  `CNPJ` INT(11) NOT NULL,
  `descricao` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`cod_ong`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`endereco` (
  `cod_endereco` INT(11) NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(8) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `num` VARCHAR(30) NOT NULL,
  `complemento` VARCHAR(100) NULL DEFAULT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `cod_voluntario` INT(11) NOT NULL,
  `cod_ong` INT(11) NOT NULL,
  `cod_filial` INT(11) NOT NULL,
  PRIMARY KEY (`cod_endereco`),
  INDEX `fk_endereco_cl_voluntarios1_idx` (`cod_voluntario` ASC) VISIBLE,
  INDEX `fk_endereco_ong_idx` (`cod_ong` ASC) VISIBLE,
  INDEX `fk_endereco_filial_idx` (`cod_filial` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_cl_voluntarios1`
    FOREIGN KEY (`cod_voluntario`)
    REFERENCES `db_ebenezer`.`voluntarios` (`cod_voluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_ong`
    FOREIGN KEY (`cod_ong`)
    REFERENCES `db_ebenezer`.`ong` (`cod_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_filial`
    FOREIGN KEY (`cod_filial`)
    REFERENCES `db_ebenezer`.`filial` (`cod_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`telefone` (
  `cod_telefone` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(9) NOT NULL,
  `ddd` VARCHAR(2) NOT NULL,
  `cod_voluntario` INT(11) NOT NULL,
  `cod_filial` INT(11) NOT NULL,
  `cod_ong` INT(11) NOT NULL,
  PRIMARY KEY (`cod_telefone`),
  INDEX `fk_telefone_voluntarios1_idx` (`cod_voluntario` ASC) VISIBLE,
  INDEX `fk_telefone_filial_idx` (`cod_filial` ASC) VISIBLE,
  INDEX `fk_telefone_ong_idx` (`cod_ong` ASC) VISIBLE,
  CONSTRAINT `fk_telefone_voluntarios1`
    FOREIGN KEY (`cod_voluntario`)
    REFERENCES `db_ebenezer`.`voluntarios` (`cod_voluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_filial`
    FOREIGN KEY (`cod_filial`)
    REFERENCES `db_ebenezer`.`filial` (`cod_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_ong`
    FOREIGN KEY (`cod_ong`)
    REFERENCES `db_ebenezer`.`ong` (`cod_ong`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`filial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`filial` (
  `cod_filial` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cod_filial`),
  CONSTRAINT `fk_cod_endereco`
    FOREIGN KEY ()
    REFERENCES `db_ebenezer`.`endereco` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT ``
    FOREIGN KEY ()
    REFERENCES `db_ebenezer`.`telefone` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cod_filial`
    FOREIGN KEY ()
    REFERENCES `db_ebenezer`.`filial` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`atividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`atividades` (
  `cod_atividade` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `tipo` VARCHAR(30) NOT NULL,
  `cod_filial` INT(11) NOT NULL,
  PRIMARY KEY (`cod_atividade`),
  INDEX `fk_atividades_ong_idx` (`cod_filial` ASC) VISIBLE,
  CONSTRAINT `fk_atividades_filial`
    FOREIGN KEY (`cod_filial`)
    REFERENCES `db_ebenezer`.`filial` (`cod_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`nivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`nivel` (
  `cod_nivel` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`cod_nivel`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`usuarios` (
  `cod_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `data_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  `cod_nivel` INT(11) NOT NULL,
  PRIMARY KEY (`cod_usuario`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_usuarios_niveis1_idx` (`cod_nivel` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_niveis1`
    FOREIGN KEY (`cod_nivel`)
    REFERENCES `db_ebenezer`.`nivel` (`cod_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
