-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2022 at 11:53 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assignment2`
--
create database assignment2;
use assignment2;
-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(6) UNSIGNED NOT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `brach_location` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(6) UNSIGNED NOT NULL,
  `category_name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cus_id` int(6) UNSIGNED NOT NULL,
  `cus_fullname` varchar(250) NOT NULL,
  `cus_address` varchar(250) DEFAULT NULL,
  `cus_phone` varchar(250) NOT NULL,
  `cus_email` varchar(50) DEFAULT NULL,
  `cus_password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(6) UNSIGNED NOT NULL,
  `emp_fullname` varchar(250) NOT NULL,
  `emp_address` varchar(250) DEFAULT NULL,
  `emp_phone` varchar(250) NOT NULL,
  `emp_email` varchar(50) DEFAULT NULL,
  `emp_birthday` year(4) NOT NULL,
  `emp_salary_per_hour` decimal(10,3) DEFAULT NULL,
  `emp_password` varchar(250) NOT NULL,
  `emp_role_id` int(6) UNSIGNED NOT NULL,
  `emp_branch_id` int(6) UNSIGNED NOT NULL,
  `emp_shift_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `giftcode`
--

CREATE TABLE `giftcode` (
  `gift_code` int(6) UNSIGNED NOT NULL,
  `gift_startdate` time NOT NULL,
  `gift_expiredate` time NOT NULL,
  `gift_value` decimal(10,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `managerbranch`
--

CREATE TABLE `managerbranch` (
  `emp_id` int(6) UNSIGNED NOT NULL,
  `branch_id` int(6) UNSIGNED NOT NULL,
  `startdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_`
--

CREATE TABLE `order_` (
  `order_id` int(6) UNSIGNED NOT NULL,
  `order_date` time NOT NULL,
  `order_address` varchar(250) NOT NULL,
  `order_total_money` decimal(10,3) NOT NULL DEFAULT 0.000,
  `order_status` varchar(50) NOT NULL DEFAULT 'processing',
  `order_emp_id` int(6) UNSIGNED DEFAULT NULL,
  `order_customer_id` int(6) UNSIGNED DEFAULT NULL,
  `order_code` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(6) UNSIGNED NOT NULL,
  `product_name` varchar(250) NOT NULL,
  `product_listed_price` decimal(10,3) NOT NULL,
  `product_image` text NOT NULL,
  `product_number` int(11) NOT NULL DEFAULT 0,
  `product_start_avg` decimal(3,3) NOT NULL DEFAULT 0.000,
  `product_category_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `productorder`
--

CREATE TABLE `productorder` (
  `order_id` int(6) UNSIGNED NOT NULL,
  `product_id` int(6) UNSIGNED NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT 1,
  `price` decimal(10,3) NOT NULL DEFAULT 0.000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `customer_id` int(6) UNSIGNED NOT NULL,
  `product_id` int(6) UNSIGNED NOT NULL,
  `star` decimal(3,3) NOT NULL DEFAULT 0.000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(6) UNSIGNED NOT NULL,
  `role_name` varchar(250) NOT NULL DEFAULT 'Sale'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `shift_id` int(6) UNSIGNED NOT NULL,
  `shift_time` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `workhours`
--

CREATE TABLE `workhours` (
  `work_emp_id` int(6) UNSIGNED NOT NULL,
  `work_month` int(5) NOT NULL,
  `work_hours` decimal(10,3) NOT NULL DEFAULT 0.000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cus_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `emp_role_id` (`emp_role_id`),
  ADD KEY `emp_branch_id` (`emp_branch_id`),
  ADD KEY `emp_shift_id` (`emp_shift_id`);

--
-- Indexes for table `giftcode`
--
ALTER TABLE `giftcode`
  ADD PRIMARY KEY (`gift_code`);

--
-- Indexes for table `managerbranch`
--
ALTER TABLE `managerbranch`
  ADD PRIMARY KEY (`emp_id`,`branch_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `order_`
--
ALTER TABLE `order_`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_code` (`order_code`),
  ADD KEY `order_emp_id` (`order_emp_id`),
  ADD KEY `order_customer_id` (`order_customer_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `product_category_id` (`product_category_id`);

--
-- Indexes for table `productorder`
--
ALTER TABLE `productorder`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`customer_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `shift`
--
ALTER TABLE `shift`
  ADD PRIMARY KEY (`shift_id`);

--
-- Indexes for table `workhours`
--
ALTER TABLE `workhours`
  ADD PRIMARY KEY (`work_emp_id`,`work_month`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `branch_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cus_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `giftcode`
--
ALTER TABLE `giftcode`
  MODIFY `gift_code` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_`
--
ALTER TABLE `order_`
  MODIFY `order_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
  MODIFY `shift_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workhours`
--
ALTER TABLE `workhours`
  MODIFY `work_emp_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`emp_role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`emp_branch_id`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`emp_shift_id`) REFERENCES `shift` (`shift_id`);

--
-- Constraints for table `managerbranch`
--
ALTER TABLE `managerbranch`
  ADD CONSTRAINT `managerbranch_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  ADD CONSTRAINT `managerbranch_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `order_`
--
ALTER TABLE `order_`
  ADD CONSTRAINT `order__ibfk_1` FOREIGN KEY (`order_code`) REFERENCES `giftcode` (`gift_code`),
  ADD CONSTRAINT `order__ibfk_2` FOREIGN KEY (`order_emp_id`) REFERENCES `employee` (`emp_id`),
  ADD CONSTRAINT `order__ibfk_3` FOREIGN KEY (`order_customer_id`) REFERENCES `customer` (`cus_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`product_category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `productorder`
--
ALTER TABLE `productorder`
  ADD CONSTRAINT `productorder_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`),
  ADD CONSTRAINT `productorder_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `productorder_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`cus_id`),
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `workhours`
--
ALTER TABLE `workhours`
  ADD CONSTRAINT `workhours_ibfk_1` FOREIGN KEY (`work_emp_id`) REFERENCES `employee` (`emp_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
