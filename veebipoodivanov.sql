-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 16, 2026 kell 03:45 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `veebipoodivanov`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaBrand` (IN `id` INT)   begin
select * from brands;
delete from brands where brandsID = @id;
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaCategory` (IN `id` INT)   begin
select * from categories;
delete from categories where categoryID = @id;
select * from categories;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaOrder` (IN `id` INT)   BEGIN
select * from orders;
delete from orders where orderid = id;
select * from orders;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brand_name` VARCHAR(30))   begin
insert into brands(brand_name)
values (@brand_name);
select * from brands;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaCategory` (IN `categoryname` VARCHAR(50))   begin
insert into categories(categoryname)
values(@categoryname);
select * from categories;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1tahte` (IN `taht` CHAR(1))   begin
select * from brands where brand_name like concat(taht,'%');
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stocksSuurendamine` (IN `quantity` INT)   BEGIN
UPDATE stocks set quantity = uusQuanity
WHERE quantity * 1.1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uendadaCategory` (IN `id` INT)   begin
update categories set categoryname = @uus_categoyNimi
where categoryID = @id;
select * from categories;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuendaBrand` (IN `id` INT, IN `uusBrand_nimi` VARCHAR(30))   BEGIN
SELECT * from brands;
UPDATE brands set brand_name = uusBrand_nimi where brandsID=id;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `brands`
--

CREATE TABLE `brands` (
  `brandsID` int(11) NOT NULL,
  `brand_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `brands`
--

INSERT INTO `brands` (`brandsID`, `brand_name`) VALUES
(1, NULL),
(4, 'Adidas'),
(3, 'Nike'),
(2, 'uusnimi');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

CREATE TABLE `categories` (
  `categoryID` int(11) NOT NULL,
  `categoryname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `categories`
--

INSERT INTO `categories` (`categoryID`, `categoryname`) VALUES
(1, 'Särk'),
(2, 'Pusa'),
(3, 'Arvutid'),
(4, 'jalatsid');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `stateName` varchar(30) DEFAULT NULL,
  `zip_code` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `stateName`, `zip_code`) VALUES
(1, 'dfgfg', 'fgfgf', 5677688, 'dsfgdfgfdgdgf', 'dfdsf', 'fdsfsd', 'ssfsf', '46476'),
(2, 'Oliver', 'Oliver', 5551234, 'oliver.tamm@email.com', 'Pärnu mnt 25', 'Tallinn', 'Harjumaa', '10141'),
(3, 'Maria', 'Saar', 5556789, 'maria.saar@email.com', 'Turu 18', 'Tartu', 'Tartumaa', '51004'),
(4, 'Karl', 'Mägi', 5567890, 'karl.magi@email.com', 'Tallinna 7', 'Pärnu', 'Pärnumaa', '80010');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `orders`
--

CREATE TABLE `orders` (
  `orderid` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_status` varchar(30) DEFAULT NULL CHECK (`order_status` = 'valmis' or `order_status` = 'töötlemisel'),
  `order_date` date DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `order_items`
--

CREATE TABLE `order_items` (
  `item_id` int(11) NOT NULL,
  `productid` int(11) DEFAULT NULL,
  `orderid` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `list_price` decimal(4,2) DEFAULT NULL,
  `discount` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `products`
--

CREATE TABLE `products` (
  `productid` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `brandsID` int(11) DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `model_year` int(11) DEFAULT NULL,
  `list_price` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `products`
--

INSERT INTO `products` (`productid`, `product_name`, `brandsID`, `categoryID`, `model_year`, `list_price`) VALUES
(1, 'särk', 4, 1, 2022, 45.00),
(2, 'pusa', 3, 2, 2020, 100.00),
(3, 'Arvuti', 2, 3, 2022, 1000.00),
(4, 'bvnbn', 2, 1, 2022, 745.00),
(5, 'dfdsd', 4, 4, 2022, 7899.00);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `staffs`
--

CREATE TABLE `staffs` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(17) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `email1` varchar(30) DEFAULT NULL,
  `phone1` int(11) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stocks`
--

CREATE TABLE `stocks` (
  `store_id` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stocks`
--

INSERT INTO `stocks` (`store_id`, `productid`, `quantity`) VALUES
(1, 1, 23);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state_name` varchar(20) DEFAULT NULL,
  `zip_code` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stores`
--

INSERT INTO `stores` (`store_id`, `store_name`, `phone`, `email`, `street`, `city`, `state_name`, `zip_code`) VALUES
(1, 'arvutipood', 3456788, 'safghgjhkjg', 'sdfdgh', 'dghh', 'dfgh', '25677');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brandsID`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indeksid tabelile `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indeksid tabelile `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indeksid tabelile `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderid`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indeksid tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `productid` (`productid`),
  ADD KEY `orderid` (`orderid`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productid`),
  ADD KEY `brandsID` (`brandsID`),
  ADD KEY `categoryID` (`categoryID`);

--
-- Indeksid tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indeksid tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`store_id`,`productid`),
  ADD KEY `productid` (`productid`);

--
-- Indeksid tabelile `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `brands`
--
ALTER TABLE `brands`
  MODIFY `brandsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `orders`
--
ALTER TABLE `orders`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `order_items`
--
ALTER TABLE `order_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `productid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`);

--
-- Piirangud tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `products` (`productid`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`orderid`) REFERENCES `orders` (`orderid`);

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brandsID`) REFERENCES `brands` (`brandsID`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`);

--
-- Piirangud tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Piirangud tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `products` (`productid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
