-- MySQL Script generated by MySQL Workbench
-- Thu Dec  1 16:32:17 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
-- -----------------------------------------------------
-- SAVE OLD WORKBENCH SETTINGS
-- -----------------------------------------------------

DROP DATABASE IF EXISTS `airline_db`;

SET
  @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
  UNIQUE_CHECKS = 0;

SET
  @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
  FOREIGN_KEY_CHECKS = 0;

SET
  @OLD_SQL_MODE = @@SQL_MODE,
  SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema airline_db
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema airline_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airline_db` DEFAULT CHARACTER SET utf8;

USE `airline_db`;

-- -----------------------------------------------------
-- Table `airline_db`.`Aircraft`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Aircraft`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Aircraft` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Airline_Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Model` VARCHAR(45) NULL,
  `Capacity` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Aircraft_Airline1` FOREIGN KEY (`Airline_Id`) REFERENCES `airline_db`.`Airline` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Aircraft` (`Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `Name_UNIQUE` ON `airline_db`.`Aircraft` (`Name` ASC) VISIBLE;

CREATE INDEX `fk_Aircraft_Airline1_idx` ON `airline_db`.`Aircraft` (`Airline_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Airline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Airline`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Airline` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Code` VARCHAR(4) NOT NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Longitude` VARCHAR(45) NULL,
  `Latitude` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Airline` (`Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `Name_UNIQUE` ON `airline_db`.`Airline` (`Name` ASC) VISIBLE;

CREATE UNIQUE INDEX `Code_UNIQUE` ON `airline_db`.`Airline` (`Code` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Airport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Airport`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Airport` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `City` VARCHAR(45) NULL,
  `Name` VARCHAR(200) NULL,
  `State` VARCHAR(45) NULL,
  `Abbreviation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Airport` (`Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `Abbreviation_UNIQUE` ON `airline_db`.`Airport` (`Abbreviation` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`BillingDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`BillingDetail`;

CREATE TABLE IF NOT EXISTS `airline_db`.`BillingDetail` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `User_Id` INT NULL,
  `CardNumberLastFourDigit` VARCHAR(45) NULL,
  `CardToken` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_BillingDetail_User1` FOREIGN KEY (`User_Id`) REFERENCES `airline_db`.`User` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`BillingDetail` (`Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `CardToken_UNIQUE` ON `airline_db`.`BillingDetail` (`CardToken` ASC) VISIBLE;

CREATE INDEX `fk_BillingDetail_User1_idx` ON `airline_db`.`BillingDetail` (`User_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Class`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Class` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Airline_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Tier` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Airline1_Name1_idx` (`Airline_Id`, `Name`),
  CONSTRAINT `fk_Class_Airline1` FOREIGN KEY (`Airline_Id`) REFERENCES `airline_db`.`Airline` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Class` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_Class_Airline1_idx` ON `airline_db`.`Class` (`Airline_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Confirmation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Confirmation`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Confirmation` (
  `Confirmation_Name` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `ConfirmationDate` DATETIME NULL,
  `Ticket_Id` INT NOT NULL,
  `Passenger_Id` INT NOT NULL,
  PRIMARY KEY (`Confirmation_Name`),
  CONSTRAINT `fk_Confirmation_Ticket1` FOREIGN KEY (`Ticket_Id`) REFERENCES `airline_db`.`Ticket` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Confirmation_Passenger1` FOREIGN KEY (`Passenger_Id`) REFERENCES `airline_db`.`Passenger` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Name_UNIQUE` ON `airline_db`.`Confirmation` (`Confirmation_Name` ASC) VISIBLE;

CREATE INDEX `fk_Confirmation_Ticket1_idx` ON `airline_db`.`Confirmation` (`Ticket_Id` ASC) VISIBLE;

CREATE INDEX `fk_Confirmation_Passenger1_idx` ON `airline_db`.`Confirmation` (`Passenger_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Flight`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Flight`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Flight` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Aircraft_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `DepartureGate_Id` INT NOT NULL,
  `ArrivalGate_Id` INT NOT NULL,
  `DepartureDate` DATETIME NULL,
  `ArrivalDate` DATETIME NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Flight_Gate1` FOREIGN KEY (`DepartureGate_Id`) REFERENCES `airline_db`.`Gate` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Gate2` FOREIGN KEY (`ArrivalGate_Id`) REFERENCES `airline_db`.`Gate` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Aircraft1` FOREIGN KEY (`Aircraft_Id`) REFERENCES `airline_db`.`Aircraft` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `FlightId_UNIQUE` ON `airline_db`.`Flight` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_Flight_Gate1_idx` ON `airline_db`.`Flight` (`DepartureGate_Id` ASC) VISIBLE;

CREATE INDEX `fk_Flight_Gate2_idx` ON `airline_db`.`Flight` (`ArrivalGate_Id` ASC) VISIBLE;

CREATE INDEX `fk_Flight_Aircraft1_idx` ON `airline_db`.`Flight` (`Aircraft_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Gate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Gate`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Gate` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Terminal_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Longitude` VARCHAR(45) NULL,
  `Latitude` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Terminal1_Name1_idx` (`Terminal_Id`, `Name`),
  CONSTRAINT `fk_Gate_Terminal1` FOREIGN KEY (`Terminal_Id`) REFERENCES `airline_db`.`Terminal` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE INDEX `fk_Gate_Terminal1_idx` ON `airline_db`.`Gate` (`Terminal_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Passenger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Passenger`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Passenger` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `PassportNumber` VARCHAR(45) NULL DEFAULT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `CountryCode` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Passenger` (`Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `PassportNumber_UNIQUE` ON `airline_db`.`Passenger` (`PassportNumber` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Payment`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Payment` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Amount` INT NULL,
  `DateCreated` DATETIME NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `idPayment_UNIQUE` ON `airline_db`.`Payment` (`Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Refund`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Refund`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Refund` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Payment_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Refund_Payment1` FOREIGN KEY (`Payment_Id`) REFERENCES `airline_db`.`Payment` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `idRefund_UNIQUE` ON `airline_db`.`Refund` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_Refund_Payment1_idx` ON `airline_db`.`Refund` (`Payment_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Seat`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Seat` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Aircraft_Id` INT NOT NULL,
  `Class_Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Aircraft1_Name1_idx` (`Aircraft_Id`, `Name`),
  CONSTRAINT `fk_AircraftSeat_Aircraft1` FOREIGN KEY (`Aircraft_Id`) REFERENCES `airline_db`.`Aircraft` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seat_Class1` FOREIGN KEY (`Class_Id`) REFERENCES `airline_db`.`Class` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE INDEX `fk_AircraftSeat_Aircraft1_idx` ON `airline_db`.`Seat` (`Aircraft_Id` ASC) VISIBLE;

CREATE INDEX `fk_Seat_Class1_idx` ON `airline_db`.`Seat` (`Class_Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `Id_UNIQUE` ON `airline_db`.`Seat` (`Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Terminal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Terminal`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Terminal` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Airport_Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Terminal_Airline1` FOREIGN KEY (`Airport_Id`) REFERENCES `airline_db`.`Airport` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `TerminalId_UNIQUE` ON `airline_db`.`Terminal` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_Terminal_Airline1_idx` ON `airline_db`.`Terminal` (`Airport_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`TicektAssignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`TicektAssignment`;

CREATE TABLE IF NOT EXISTS `airline_db`.`TicektAssignment` (
  `Id` INT NOT NULL ,
  `Ticket_Id` INT NOT NULL,
  `Passenger_Id` INT NOT NULL,
  PRIMARY KEY (`Ticket_Id`, `Id`),
  CONSTRAINT `fk_TicektAssignment_Ticket1` FOREIGN KEY (`Ticket_Id`) REFERENCES `airline_db`.`Ticket` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicektAssignment_Passenger1` FOREIGN KEY (`Passenger_Id`) REFERENCES `airline_db`.`Passenger` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE INDEX `fk_TicektAssignment_Ticket1_idx` ON `airline_db`.`TicektAssignment` (`Ticket_Id` ASC) VISIBLE;

CREATE INDEX `fk_TicektAssignment_Passenger1_idx` ON `airline_db`.`TicektAssignment` (`Passenger_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Ticket`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Ticket` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Flight_Id` INT NOT NULL,
  `Seat_Id` INT NOT NULL,
  `Price` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_Ticket_Flight1` FOREIGN KEY (`Flight_Id`) REFERENCES `airline_db`.`Flight` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Seat1` FOREIGN KEY (`Seat_Id`) REFERENCES `airline_db`.`Seat` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `idTicket_UNIQUE` ON `airline_db`.`Ticket` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_Ticket_Flight1_idx` ON `airline_db`.`Ticket` (`Flight_Id` ASC) VISIBLE;

CREATE INDEX `fk_Ticket_Seat1_idx` ON `airline_db`.`Ticket` (`Seat_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`Ticket_Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`Ticket_Payment`;

CREATE TABLE IF NOT EXISTS `airline_db`.`Ticket_Payment` (
  `Ticket_Id` INT NOT NULL,
  `Payment_Id` INT NOT NULL,
  PRIMARY KEY (`Ticket_Id`, `Payment_Id`),
  CONSTRAINT `fk_Ticket_has_Payment_Ticket1` FOREIGN KEY (`Ticket_Id`) REFERENCES `airline_db`.`Ticket` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_has_Payment_Payment1` FOREIGN KEY (`Payment_Id`) REFERENCES `airline_db`.`Payment` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE INDEX `fk_Ticket_has_Payment_Payment1_idx` ON `airline_db`.`Ticket_Payment` (`Payment_Id` ASC) VISIBLE;

CREATE INDEX `fk_Ticket_has_Payment_Ticket1_idx` ON `airline_db`.`Ticket_Payment` (`Ticket_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `airline_db`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airline_db`.`User`;

CREATE TABLE IF NOT EXISTS `airline_db`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `Airline_Id` INT NOT NULL,
  `LastName` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_User_Airline1` FOREIGN KEY (`Airline_Id`) REFERENCES `airline_db`.`Airline` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `airline_db`.`User` (`Id` ASC) VISIBLE;

CREATE INDEX `fk_User_Airline1_idx` ON `airline_db`.`User` (`Airline_Id` ASC) VISIBLE;

-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_airline
-- -----------------------------------------------------
DELIMITER $$ 
CREATE PROCEDURE `create_airline`(
  name varchar(45),
  code varchar(4),
  city varchar(45),
  state varchar(45)
) BEGIN
INSERT INTO
  `airline_db`.`Airline` (`Name`, `Code`,`City`, `State`)
VALUES
  (name, code,city, state);
END 
$$ DELIMITER;

-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_aircrafts
-- -----------------------------------------------------
DELIMITER $$ 
CREATE PROCEDURE `create_aircrafts`(
  airline_Id int,
  name varchar(45)

) BEGIN
INSERT INTO
  `airline_db`.`Aircraft` (`Airline_Id`, `Name`)
VALUES
  (airline_Id, name);
END 
$$ DELIMITER;
-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.find_available_tickets
-- -----------------------------------------------------
DELIMITER $$ 
CREATE PROCEDURE `find_available_tickets`(in flight_id int) BEGIN
SELECT
  *
from
  Ticket
  left join Confirmation on Ticket.Id = Confirmation.Ticket_id
WHERE
  Confirmation.Status != "Active";
END 
$$ DELIMITER;


-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_class
-- -----------------------------------------------------
DELIMITER $$ 
CREATE PROCEDURE `create_class` (in name varchar(45), in tier int) BEGIN
INSERT INTO
  `airline_db`.`Class` (`Name`, `Tier`)
VALUES
  (name, tier);
END
$$ DELIMITER;


-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.add_billing_detail
-- -----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `add_billing_detail`(in FourDigits varchar(45), in Token varchar(45))
BEGIN
INSERT INTO
  `airline_db`.`billingdetail` (`CardNumberLastFourDigit`, `CardToken`)
VALUES
  (FourDigits, Token);
END
$$ DELIMITER;

-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_confirmations
-- -----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `create_confirmations`(in ConfirmationName int, in TicketId int, in passengerid int)
BEGIN
INSERT INTO `airline_db`.`confirmation`
(`Confirmation_Name`,
`Status`,
`ConfirmationDate`,
`Ticket_Id`,
`Passenger_Id`)
VALUES
  (ConfirmationName, 'Active', 'curdate()', TicketId, passengerId);
END
$$ DELIMITER;
-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_payments
-- -----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `create_payments`(in amount int, in DateCreated datetime)
BEGIN
INSERT INTO
  `airline_db`.`payment` (`Amount`, `DateCreated`)
VALUES
  (amount, DateCreated);
END
$$ DELIMITER;
-- -----------------------------------------------------
-- STORED PROCEDURE `airline_db`.create_trips
-- -----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE `create_trips`(in flightid int, in confirmation int)
BEGIN
INSERT INTO
  `airline_db`.`trip` (`'Flight_Id`, `Confirmation_Name`)
VALUES
  (flightid, confirmation);
END
$$ DELIMITER ;



-- -----------------------------------------------------
-- VIEW `airline_db`.Flight_Populated
-- -----------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `flight_populated` AS
    SELECT 
        `G1`.`Name` AS `DepartureGate_Name`,
        `G2`.`Name` AS `ArrivalGate_Name`,
        `C1`.`Name` AS `Aircraft_Name`,
        `L1`.`Name` AS `Airline_Name`,
        `T1`.`Name` AS `DepartureTerminal_Name`,
        `T2`.`Name` AS `ArrivalTerminal_Name`,
        `A1`.`Name` AS `DepartureAirport_Name`,
        `A2`.`Name` AS `ArrivalAirport_Name`,
        `A1`.`Abbreviation` AS `DepartureAirport_Abbreviation`,
        `A2`.`Abbreviation` AS `ArrivalAirport_Abbreviation`,
        `flight`.`Id` AS `Id`,
        `flight`.`Aircraft_Id` AS `Aircraft_Id`,
        `flight`.`Name` AS `Name`,
        `flight`.`DepartureGate_Id` AS `DepartureGate_Id`,
        `flight`.`ArrivalGate_Id` AS `ArrivalGate_Id`,
        `flight`.`DepartureDate` AS `DepartureDate`,
        `flight`.`ArrivalDate` AS `ArrivalDate`
    FROM
        ((((((((`flight`
        LEFT JOIN `gate` `G1` ON ((`flight`.`DepartureGate_Id` = `G1`.`Id`)))
        LEFT JOIN `gate` `G2` ON ((`flight`.`ArrivalGate_Id` = `G2`.`Id`)))
        LEFT JOIN `aircraft` `C1` ON ((`flight`.`Aircraft_Id` = `C1`.`Id`)))
        LEFT JOIN `terminal` `T1` ON ((`G1`.`Terminal_Id` = `T1`.`Id`)))
        LEFT JOIN `terminal` `T2` ON ((`G2`.`Terminal_Id` = `T2`.`Id`)))
        LEFT JOIN `airport` `A1` ON ((`T1`.`Airport_Id` = `A1`.`Id`)))
        LEFT JOIN `airport` `A2` ON ((`T2`.`Airport_Id` = `A2`.`Id`)))
        LEFT JOIN `airline` `L1` ON ((`C1`.`Airline_Id` = `L1`.`Id`)))


-- -----------------------------------------------------
-- VIEW `airline_db`.Ticket_Populated
-- -----------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `ticket_populated` AS
    SELECT 
        `ticket`.`Id` AS `Id`,
        `ticket`.`Flight_Id` AS `Flight_Id`,
        `ticket`.`Seat_Id` AS `Seat_Id`,
        `ticket`.`Price` AS `Price`,
        `seat`.`Name` AS `Seat_Name`,
        `class`.`Name` AS `Class_Name`,
        `confirmation`.`Status` AS `Confirmation_Status`
    FROM
        (((`ticket`
        LEFT JOIN `seat` ON ((`seat`.`Id` = `ticket`.`Seat_Id`)))
        LEFT JOIN `class` ON ((`seat`.`Class_Id` = `class`.`Id`)))
        LEFT JOIN `confirmation` ON ((`confirmation`.`Ticket_Id` = `ticket`.`Id`)))



-- -----------------------------------------------------
-- RESTORE WORKBENCH SETTINGS
-- -----------------------------------------------------
DELIMITER $$ 
SET
  SQL_MODE = @OLD_SQL_MODE;

SET
  FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET
  UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
