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
  PRIMARY KEY (`cod_endereco`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`telefone` (
  `cod_telefone` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(9) NOT NULL,
  `ddd` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`cod_telefone`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`filial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`filial` (
  `cod_filial` INT(11) NOT NULL AUTO_INCREMENT,
  `cod_endereco` INT(11) NOT NULL,
  `cod_telefone` INT(11) NOT NULL,
  PRIMARY KEY (`cod_filial`),
  INDEX `cod_endereco_idx` (`cod_endereco` ASC) VISIBLE,
  INDEX `cod_telefone_idx` (`cod_telefone` ASC) VISIBLE,
  CONSTRAINT `cod_endereco`
    FOREIGN KEY (`cod_endereco`)
    REFERENCES `db_ebenezer`.`endereco` (`cod_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_telefone`
    FOREIGN KEY (`cod_telefone`)
    REFERENCES `db_ebenezer`.`telefone` (`cod_telefone`)
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
-- Table `db_ebenezer`.`doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`doacoes` (
  `cod_doacoes` INT(11) NOT NULL,
  `nome_doador` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`cod_doacoes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`dinheiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`dinheiro` (
  `valor` FLOAT NOT NULL,
  `cod_doacao` INT(11) NOT NULL,
  INDEX `cod_doacao` (`cod_doacao` ASC) VISIBLE,
  CONSTRAINT `cod_doacao`
    FOREIGN KEY (`cod_doacao`)
    REFERENCES `db_ebenezer`.`doacoes` (`cod_doacoes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`voluntarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`voluntarios` (
  `cod_voluntario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `data_nasc` DATETIME NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_voluntario`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`end_voluntario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`end_voluntario` (
  `cod_voluntario` INT(11) NOT NULL,
  `cod_endereco` INT(11) NOT NULL,
  PRIMARY KEY (`cod_voluntario`, `cod_endereco`),
  INDEX `cod_endereco_idx` (`cod_endereco` ASC) VISIBLE,
  CONSTRAINT `cod_end_vol`
    FOREIGN KEY (`cod_endereco`)
    REFERENCES `db_ebenezer`.`endereco` (`cod_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_voluntario`
    FOREIGN KEY (`cod_voluntario`)
    REFERENCES `db_ebenezer`.`voluntarios` (`cod_voluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
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
-- Table `db_ebenezer`.`ong`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`ong` (
  `cod_ong` INT(11) NOT NULL AUTO_INCREMENT,
  `CNPJ` INT(14) NOT NULL,
  `descricao` LONGTEXT NOT NULL,
  PRIMARY KEY (`cod_ong`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`outro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`outro` (
  `objeto` VARCHAR(45) NOT NULL,
  `cod_doacao` INT(11) NOT NULL,
  INDEX `cod_outro_doacao` (`cod_doacao` ASC) VISIBLE,
  CONSTRAINT `cod_outro_doacao`
    FOREIGN KEY (`cod_doacao`)
    REFERENCES `db_ebenezer`.`doacoes` (`cod_doacoes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`tel_filial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`tel_filial` (
  `cod_telefone` INT(11) NOT NULL,
  `cod_filial` INT(11) NOT NULL,
  PRIMARY KEY (`cod_telefone`, `cod_filial`),
  INDEX `codl_filial_filial` (`cod_filial` ASC) VISIBLE,
  CONSTRAINT `cod_tel_filial`
    FOREIGN KEY (`cod_telefone`)
    REFERENCES `db_ebenezer`.`telefone` (`cod_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `codl_filial_filial`
    FOREIGN KEY (`cod_filial`)
    REFERENCES `db_ebenezer`.`filial` (`cod_filial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_ebenezer`.`tel_voluntario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ebenezer`.`tel_voluntario` (
  `cod_voluntario` INT(11) NOT NULL,
  `cod_telefone` INT(11) NOT NULL,
  PRIMARY KEY (`cod_voluntario`, `cod_telefone`),
  INDEX `cod_tel_voluntario` (`cod_telefone` ASC) VISIBLE,
  CONSTRAINT `cod_tel_voluntario`
    FOREIGN KEY (`cod_telefone`)
    REFERENCES `db_ebenezer`.`telefone` (`cod_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cod_vol_voluntario`
    FOREIGN KEY (`cod_voluntario`)
    REFERENCES `db_ebenezer`.`voluntarios` (`cod_voluntario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
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
  `cod_nivel` INT(11) NULL DEFAULT NULL,
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
