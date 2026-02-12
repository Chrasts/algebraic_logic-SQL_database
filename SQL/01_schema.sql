-- =========================================
-- Schema
-- =========================================
CREATE DATABASE IF NOT EXISTS `algebraic_logic`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `algebraic_logic`;

-- Pro opakované spouštění skriptu:
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `Alg_has_prop`;
DROP TABLE IF EXISTS `L_has_prop`;
DROP TABLE IF EXISTS `subclasses`;
DROP TABLE IF EXISTS `Blok_Pigozzi`;
DROP TABLE IF EXISTS `Algclass_axiom`;
DROP TABLE IF EXISTS `bridge`;

DROP TABLE IF EXISTS `axioms`;
DROP TABLE IF EXISTS `L_prop`;
DROP TABLE IF EXISTS `Alg_prop`;
DROP TABLE IF EXISTS `Logics`;
DROP TABLE IF EXISTS `Algclasses`;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================
-- Základní tabulky
-- =========================================
CREATE TABLE `Algclasses` (
  `id_algclass`        VARCHAR(10)  NOT NULL,
  `algclass_name`      VARCHAR(50)  NOT NULL,
  `alg_abbreviation`   VARCHAR(20)  NOT NULL,
  `signature`          VARCHAR(20)  NOT NULL,
  PRIMARY KEY (`id_algclass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Logics` (
  `id_logic`           VARCHAR(10)  NOT NULL,
  `logic_name`         VARCHAR(50)  NOT NULL,
  `logic_abbreviation` VARCHAR(20)  NOT NULL,
  PRIMARY KEY (`id_logic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Alg_prop` (
  `id_algprop`      VARCHAR(10)  NOT NULL,
  `alg_property`    VARCHAR(50)  NOT NULL,
  `algprop_abbrev`  VARCHAR(20)  NOT NULL,
  PRIMARY KEY (`id_algprop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `L_prop` (
  `id_lprop`      VARCHAR(10)  NOT NULL,
  `l_property`    VARCHAR(50)  NOT NULL,
  `lprop_abbrev`  VARCHAR(20)  NOT NULL,
  PRIMARY KEY (`id_lprop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `axioms` (
  `id_axiom`       VARCHAR(10)  NOT NULL,
  `axiom_name`     VARCHAR(100) NOT NULL,
  `axiom_formula`  VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_axiom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================
-- Propojovací tabulky (složené PK)
-- =========================================
CREATE TABLE `bridge` (
  `id_lprop`     VARCHAR(10) NOT NULL,
  `id_algprop`   VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_lprop`, `id_algprop`),
  CONSTRAINT `fk_bridge_lprop`
    FOREIGN KEY (`id_lprop`) REFERENCES `L_prop`(`id_lprop`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_bridge_algprop`
    FOREIGN KEY (`id_algprop`) REFERENCES `Alg_prop`(`id_algprop`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Algclass_axiom` (
  `id_algclass`  VARCHAR(10) NOT NULL,
  `id_axiom`     VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_algclass`, `id_axiom`),
  CONSTRAINT `fk_algclass_axiom_algclass`
    FOREIGN KEY (`id_algclass`) REFERENCES `Algclasses`(`id_algclass`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_algclass_axiom_axiom`
    FOREIGN KEY (`id_axiom`) REFERENCES `axioms`(`id_axiom`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Blok_Pigozzi` (
  `id_logic`     VARCHAR(10) NOT NULL,
  `id_algclass`  VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_logic`, `id_algclass`),
  CONSTRAINT `fk_bp_logic`
    FOREIGN KEY (`id_logic`) REFERENCES `Logics`(`id_logic`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_bp_algclass`
    FOREIGN KEY (`id_algclass`) REFERENCES `Algclasses`(`id_algclass`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `subclasses` (
  `id_superclass`  VARCHAR(10) NOT NULL,
  `id_subclass`    VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_superclass`, `id_subclass`),
  CONSTRAINT `fk_subclasses_super`
    FOREIGN KEY (`id_superclass`) REFERENCES `Algclasses`(`id_algclass`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_subclasses_sub`
    FOREIGN KEY (`id_subclass`) REFERENCES `Algclasses`(`id_algclass`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `L_has_prop` (
  `id_logic`   VARCHAR(10) NOT NULL,
  `id_lprop`   VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_logic`, `id_lprop`),
  CONSTRAINT `fk_l_has_prop_logic`
    FOREIGN KEY (`id_logic`) REFERENCES `Logics`(`id_logic`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_l_has_prop_lprop`
    FOREIGN KEY (`id_lprop`) REFERENCES `L_prop`(`id_lprop`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Alg_has_prop` (
  `id_algclass`  VARCHAR(10) NOT NULL,
  `id_algprop`   VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_algclass`, `id_algprop`),
  CONSTRAINT `fk_alg_has_prop_algclass`
    FOREIGN KEY (`id_algclass`) REFERENCES `Algclasses`(`id_algclass`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_alg_has_prop_algprop`
    FOREIGN KEY (`id_algprop`) REFERENCES `Alg_prop`(`id_algprop`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
