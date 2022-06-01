-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2022 at 07:15 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `branch_insert_procedure` (IN `branch_name_pa` VARCHAR(250), IN `branch_location_pa` VARCHAR(250))   begin
        insert into branch (branch_name, brach_location)
        VALUES (branch_name_pa, branch_location_pa);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `branch_update_location_procedure` (IN `branch_name_pa` VARCHAR(250), IN `branch_location_pa` VARCHAR(250))   begin
        UPDATE branch
        SET brach_location = branch_location_pa
        WHERE branch_name = branch_name_pa ;

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `branch_update_name_procedure` (IN `branch_name_old` VARCHAR(250), IN `branch_name_new` VARCHAR(250))   begin
        UPDATE branch
        SET branch_name = branch_name_new
        WHERE branch_name = branch_name_old ;

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `category_insert_procedure` (IN `category_name_pa` VARCHAR(250))   begin 
        insert into category(category_name)
        values(category_name_pa);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `category_update_procedure` (IN `category_name_old` VARCHAR(250), IN `category_name_new` VARCHAR(250))   begin 
        UPDATE category
        SET category_name = category_name_new
        WHERE category_name=category_name_old;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order__insert_procedure` (`order_customer_id_pa` INT(6) UNSIGNED, `order_emp_id_pa` INT(6) UNSIGNED, `order_address_pa` VARCHAR(250))   begin 
        insert into order_(order_date,order_address,order_emp_id,order_customer_id)
        values(NOW(),order_address_pa,order_emp_id_pa,order_customer_id_pa);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order__insert_with_giftcode_procedure` (`order_customer_id_pa` INT(6) UNSIGNED, `order_emp_id_pa` INT(6) UNSIGNED, `order_code_pa` VARCHAR(20), `order_address_pa` VARCHAR(250))   begin 
        insert into order_(order_date,order_address,order_emp_id,order_customer_id,order_code)
        values(NOW(),order_address_pa,order_emp_id_pa,order_customer_id_pa,order_code_pa);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productOrder_delete_procedure` (`order_id_pa` INT(6), `product_id_pa` INT(6))   begin 
        

        declare quantity_pa int(10) default 0;
        declare priceCounted decimal(10,3) default 0.000;
        set quantity_pa = product_quantity_from_productOrder_function(order_id_pa,product_id_pa);
        
        set priceCounted = product_price_from_productOrder_function(order_id_pa,product_id_pa);

        DELETE FROM productorder
        where order_id = order_id_pa and product_id=product_id_pa;

        call product_increase_procedure(product_id_pa,quantity_pa);

        UPDATE order_
        SET order_total_money = order_total_money-priceCounted
        WHERE order_id=order_id_pa;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productOrder_insert_procedure` (IN `order_id_pa` INT(6), `product_id_pa` INT(6), `quantity_pa` INT(10))   begin 
        declare priceCounted decimal(10,3);

        set priceCounted = get_price_from_product_id(product_id_pa) * quantity_pa;
        insert into productorder(order_id,product_id,quantity,price)
        values(order_id_pa,product_id_pa,quantity_pa,priceCounted);

        call product_decrease_procedure(product_id_pa,quantity_pa);

        UPDATE order_
        SET order_total_money = order_total_money+priceCounted
        WHERE order_id=order_id_pa;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productOrder_update_procedure` (IN `order_id_pa` INT(6), `product_id_pa` INT(6), `quantity_pa` INT(10))   begin 
        declare priceCounted decimal(10,3);
        set priceCounted = get_price_from_product_id(product_id_pa) * quantity_pa;
        UPDATE productorder
        set price = priceCounted
        where order_id = order_id_pa and product_id=product_id_pa;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `product_decrease_procedure` (IN `product_id_pa` INT(6), `quantity_pa` INT(10))   begin 
        declare number_counted int(11);
        set number_counted = get_quantity_from_product_id(product_id_pa) - quantity_pa;
        UPDATE product
        set product_number = number_counted
        where product_id = product_id_pa;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `product_increase_procedure` (IN `product_id_pa` INT(6), `quantity_pa` INT(10))   begin 
        declare number_counted int(11);
        set number_counted = get_quantity_from_product_id(product_id_pa) + quantity_pa;
        UPDATE product
        set product_number = number_counted
        where product_id = product_id_pa;
    end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `check_product_exists` (`product_id_pa` INT(6)) RETURNS INT(2) DETERMINISTIC begin
        declare result int(2) default 0;
        select COUNT(product_id)
        into result
        from product
        where product_id=product_id_pa and product_number > 0;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_customer_id_from_phone` (`cus_phone_pa` VARCHAR(11)) RETURNS INT(6) DETERMINISTIC begin
        declare result int(6) default 0;
        select cus_id
        into result
        from customer
        where cus_phone = cus_phone_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_employee_id_from_phone` (`emp_phone_pa` VARCHAR(11)) RETURNS INT(6) DETERMINISTIC begin
        declare result int(6) default 0;
        select emp_id
        into result
        from employee
        where emp_phone=emp_phone_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_giftValue_from_orderCode` (`Code_param` VARCHAR(20)) RETURNS DECIMAL(10,3) DETERMINISTIC begin
        declare result decimal(10,3) default 0.000;
        select gift_value
        into result
        from giftcode
        where Code_param = gift_code;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_price_from_product_id` (`product_id_pa` INT(6)) RETURNS DECIMAL(10,3) DETERMINISTIC begin
        declare result decimal(10,3) default 0;
        select product_listed_price
        into result
        from product
        where product_id=product_id_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_quantity_from_product_id` (`product_id_pa` INT(6)) RETURNS INT(11) DETERMINISTIC begin
        declare result int(11) default 0;
        select product_number
        into result
        from product
        where product_id=product_id_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `order_exists_function` (`order_id_pa` INT(6)) RETURNS INT(2) DETERMINISTIC begin
        declare result int(2) default 0;

        select count(*)
        into result
        from order_
        where order_id = order_id_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `product_price_from_productOrder_function` (`order_id_pa` INT(6), `product_id_pa` INT(6)) RETURNS DECIMAL(10,3) DETERMINISTIC begin 
        declare result decimal(10,3) default 0;
        select price
        into result
        from productorder
        where order_id=order_id_pa and product_id = product_id_pa;
        return result;
    end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `product_quantity_from_productOrder_function` (`order_id_pa` INT(6), `product_id_pa` INT(6)) RETURNS INT(10) DETERMINISTIC begin 
        declare result int(10) default 0;
        select quantity
        into result
        from productorder
        where order_id=order_id_pa and product_id = product_id_pa;
        return result;
    end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(6) UNSIGNED NOT NULL,
  `branch_name` varchar(250) DEFAULT NULL,
  `brach_location` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `brach_location`) VALUES
(1, 'nyc', '111 centre st, new york, ny 10013, united states'),
(2, 'london', 'exhibition rd, south kensington, london sw7 2bx, united kingdom'),
(3, 'paris', '24 rue du commandant guilbaud, 75016 paris, france'),
(4, 'madrid', 'de concha espina, 1, 28036 madrid, spain'),
(5, 'hanoi', 'ho guom, hanoi, vietnam');

--
-- Triggers `branch`
--
DELIMITER $$
CREATE TRIGGER `branch_name_check_insert_trigger` BEFORE INSERT ON `branch` FOR EACH ROW begin
		  declare numb int default 10;
		  declare newbranchname varchar(50) default '';
      declare errormessage varchar(300) default '';

        set newbranchname = new.branch_name;
        select count(*)
        into numb
        from branch
        where branch_name = newbranchname;

        set errormessage = concat('this branch ', newbranchname,' is exists! inserting wrong'        
		    );

        if numb > 0 then 
          signal sqlstate '45000'
            set message_text = errormessage;
        end if;
    
    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(6) UNSIGNED NOT NULL,
  `category_name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(4, 'cafe'),
(1, 'cake'),
(5, 'ice cream'),
(3, 'milk'),
(2, 'tea');

--
-- Triggers `category`
--
DELIMITER $$
CREATE TRIGGER `category_name_check_insert_trigger` BEFORE INSERT ON `category` FOR EACH ROW begin 
    declare newname varchar(250) default '' ;
    declare errormessage varchar(300) default '';
    declare numb int default 10;

    set newname = new.category_name;
    select count(*)
    into numb
    from category
    where category_name = newname;

    set errormessage = concat('this category ', newname,' is exists! inserting wrong'        
    );

    if numb > 0 then 
      signal sqlstate '45000'
        set message_text = errormessage;
    end if;

  end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `category_name_check_update_trigger` BEFORE UPDATE ON `category` FOR EACH ROW begin 
    declare newname varchar(250) default '' ;
    declare errormessage varchar(300) default '';
    declare numb int default 10;

    set newname = new.category_name;
    select count(*)
    into numb
    from category
    where category_name = newname and category_id <> new.category_id;

    set errormessage = concat('this category ', newname,
      ' is exists! updating wrong'        
    );
    
    if numb > 0 then 
      signal sqlstate '45000'
        set message_text = errormessage;
    end if;

  end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cus_id` int(6) UNSIGNED NOT NULL,
  `cus_fullname` varchar(250) NOT NULL,
  `cus_address` varchar(250) DEFAULT NULL,
  `cus_phone` varchar(11) NOT NULL,
  `cus_email` varchar(50) DEFAULT NULL,
  `cus_password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cus_id`, `cus_fullname`, `cus_address`, `cus_phone`, `cus_email`, `cus_password`) VALUES
(1, 'will smith', '111 centre st, new york', '0147852369', 'willsmith@gmail.com', 'null'),
(2, 'tom hanks', '111 centre st, new york', '0124552369', 'tomhanksh@gmail.com', 'null'),
(3, 'brad pitt', '111 centre st, new york', '0965852369', 'bradpitt@gmail.com', 'null');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(6) UNSIGNED NOT NULL,
  `emp_fullname` varchar(250) NOT NULL,
  `emp_address` varchar(250) DEFAULT NULL,
  `emp_phone` varchar(11) NOT NULL,
  `emp_email` varchar(50) DEFAULT NULL,
  `emp_birthday` date NOT NULL,
  `emp_salary_per_hour` decimal(10,3) DEFAULT NULL,
  `emp_password` varchar(250) NOT NULL,
  `emp_role_id` int(6) UNSIGNED NOT NULL,
  `emp_branch_id` int(6) UNSIGNED NOT NULL,
  `emp_shift_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_fullname`, `emp_address`, `emp_phone`, `emp_email`, `emp_birthday`, `emp_salary_per_hour`, `emp_password`, `emp_role_id`, `emp_branch_id`, `emp_shift_id`) VALUES
(1, 'will smith', 'sir matt busby way, old trafford, stretford, manchester', '0147851234', 'willsmith@gmail.com', '1994-02-15', '13.770', 'null', 1, 2, 1),
(2, 'tom hanks', '111 centre st, new york', '0147851231', 'tomhanksh@gmail.com', '1990-02-15', '14.770', 'null', 2, 1, 1),
(3, 'brad pitt', 'sir matt busby way, old trafford, stretford, manchester', '0965851234', 'bradpitt@gmail.com', '1998-02-15', '12.770', 'null', 1, 2, 2),
(4, 'nguyen van teo', 'london sw1a 1aa, united kingdom', '01478523547', 'ahihi2@gmail.com', '1999-01-15', '12.500', 'emp_password', 3, 1, 2),
(5, 'hoang van ty', 'london ec3n 4ab, united kingdom', '03698521456', 'ahihi3@gmail.com', '1995-02-15', '25.400', 'emp_password', 3, 1, 2),
(6, 'luong trieu vy', ' london, united kingdom', '0123654852', 'ahihi4@gmail.com', '1995-08-25', '15.800', 'emp_password', 1, 2, 1),
(7, 'luu duc hoa', 'bd de parc, 77700 coupvray, france', '0147532159', 'ahihi6@gmail.com', '1995-03-15', '14.900', 'emp_password', 1, 2, 1),
(8, 'nguyen chi tue', 'BK tphcm', '01212352381', 'tue@gmail.com', '2000-03-17', '15000.000', 'emp_password', 2, 3, 2),
(9, 'nguyen van', 'spkt tphcm', '0123523815', 'van@gmail.com', '2000-03-18', '14000.000', 'emp_password', 2, 3, 2),
(10, 'van bui', 'kien truc tphcm', '01123142381', 'vui@gmail.com', '2000-03-17', '121000.000', 'emp_password', 2, 4, 2),
(11, 'van tran', 'kien truc tphcm', '0111423815', 'vui123@gmail.com', '2000-03-14', '131000.000', 'emp_password', 2, 4, 2),
(12, 'huy do', '54c duong so 4', '01453451234', 'huydo@gmail.com', '2000-03-15', '13.770', 'null', 1, 1, 1),
(13, 'hoang kim', 'vo van ngan', '01464651234', 'hoangkim@gmail.com', '2001-04-15', '13.770', 'null', 1, 1, 1),
(14, 'ngoc hung', 'dang van bi', '0147885234', '@gmail.com', '1995-05-15', '13.770', 'null', 1, 1, 1),
(15, 'thanh binh', 'hanoi', '0147351234', 'thanhbinh@gmail.com', '1991-06-15', '13.770', 'null', 1, 1, 1),
(16, 'thien phuc', 'thanh pho quang ngai', '01478587934', 'thienphuc@gmail.com', '1999-02-15', '13.770', 'null', 1, 1, 1),
(17, 'kim ngan', 'phan thiet', '01476541234', 'ngan@gmail.com', '2000-02-15', '13.770', 'null', 1, 1, 1),
(18, 'nguyen thanh binh', 'hanoi1', '01473511231', 'thanhbin11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 3, 1),
(19, 'con mua bang gia', 'thanh pho quang ngai city', '01478123158', 'thien11phuc@gmail.com', '1999-02-15', '13.770', 'null', 1, 3, 1),
(20, 'bui nhu', 'phan thiet city legend', '01412376541', 'ng11an@gm11ail.com', '2000-02-15', '13.770', 'null', 1, 3, 1),
(21, 'nguyen thanh ', 'hanoi1', '01471234', 'thanhbinasd11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 4, 1),
(22, 'binh nguyen', 'thanh pho quang ngai city3', '01478125687', 'thien11asdphuc@gmail.com', '1999-02-15', '13.770', 'null', 1, 4, 1),
(23, 'minh tuyen', 'hanoi11', '0141231234', 'thanhbinas11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 4, 1),
(24, 'ribi', 'hanoi12', '01473231234', 'thanhbiasdn11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 4, 1),
(25, 'the anh', 'phan thiet city legend haha', '01412341234', 'ngasd11an@gm11ail.com', '2000-02-15', '13.770', 'null', 1, 4, 1),
(26, 'nguyen than1h ', 'han1oi1', '014712134', 'thanhbin1asd11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(27, 'binh nguy1en', 'than1h pho quang ngai city3', '01478125618', 'thien111asdphuc@gmail.com', '1999-02-15', '13.770', 'null', 1, 5, 1),
(28, 'minh tuy1en', 'hano1i11', '01412311234', 'thanh1binas11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(29, 'ri1bi', 'han1oi12', '01473231123', 'thanhb1iasdn11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(30, 'th1e anh', 'phan 1thiet city legend haha', '01412314123', 'ngasd111an@gm11ail.com', '2000-02-15', '13.770', 'null', 1, 5, 1),
(51, 'nguyen thanh1 ', 'hanoi1', '12345894', 'thanhbinasd11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(52, 'binh n1guyen', 'thanh pho quang ngai city3', '15234567894', 'thien11asdphuc@gmail.com', '1999-02-15', '13.770', 'null', 1, 5, 1),
(53, 'minh tu1yen', 'hanoi11', '12345678494', 'thanhbinas11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(54, 'ri1bi', 'hanoi12', '12345657894', 'thanhbiasdn11h@gmail.com', '1991-06-15', '13.770', 'null', 1, 5, 1),
(55, 'th1e anh', 'phan thiet city legend haha', '1234567894', 'ngasd11an@gm11ail.com', '2000-02-15', '13.770', 'null', 1, 5, 1);

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `employee_age_check_insert_trigger` BEFORE INSERT ON `employee` FOR EACH ROW begin 
		declare age integer  ;
        declare namenew varchar(50) default '';
        declare errormessage varchar(300) default '';
        
		-- select date_format(from_days(datediff(now(),new.emp_birthday)), '%y')+0 as ages
        
        
       

    --     select date_format(from_days(datediff(now(),emp_birthday)), '%y')+0 as ages ,emp_fullname
    --     into age,namenew
		-- from employee
		-- where emp_id=new.emp_id;

      set age=date_format(from_days(datediff(now(),new.emp_birthday)), '%y')+0;
      set namenew=new.emp_fullname;

  --         select year(new.emp_birthday),new.emp_fullname
  --         into age,namenew
  -- 		from employee
  -- ;
			

		set errormessage = concat('the age of employee ',namenew,
									  ' is ', age,' less than 18'        
		);
        
		if age  < 18 then
			 signal sqlstate '45000' 
            set message_text = errormessage;
		end if;
        
       
    
    end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employee_age_check_update_trigger` BEFORE UPDATE ON `employee` FOR EACH ROW begin 
		declare age integer  ;
        declare namenew varchar(50) default '';
        declare errormessage varchar(300) default '';
        
    --         select date_format(from_days(datediff(now(),emp_birthday)), '%y')+0 as ages ,emp_fullname
    --         into age,namenew
    -- 		from employee
    -- 		where emp_id=new.emp_id;
        
        set age = date_format(from_days(datediff(now(),new.emp_birthday)), '%y')+0;
		set namenew=new.emp_fullname;
		set errormessage = concat('the age is updated of employee ',namenew,
									  ' is ', age,' less than 18'        
		);
        
		if age  < 18 then
			 signal sqlstate '45000' 
            set message_text = errormessage;
		end if;       
       
    
    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `giftcode`
--

CREATE TABLE `giftcode` (
  `gift_code_id` int(6) UNSIGNED NOT NULL,
  `gift_code` varchar(20) NOT NULL,
  `gift_startdate` datetime NOT NULL,
  `gift_expiredate` datetime NOT NULL,
  `gift_value` decimal(10,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `giftcode`
--

INSERT INTO `giftcode` (`gift_code_id`, `gift_code`, `gift_startdate`, `gift_expiredate`, `gift_value`) VALUES
(1, 'NoneGift', '2001-01-01 00:00:00', '2221-01-01 00:00:01', '0.000'),
(2, 'ahihi2022', '2022-04-05 00:00:00', '2022-08-05 00:00:00', '12.700'),
(3, 'ok2222', '2022-05-05 00:00:00', '2022-09-05 00:00:00', '13.800'),
(4, 'heheh202', '2022-05-25 00:00:00', '2022-05-25 00:00:01', '20.200');

--
-- Triggers `giftcode`
--
DELIMITER $$
CREATE TRIGGER `giftcode_time_check_insert_trigger` AFTER INSERT ON `giftcode` FOR EACH ROW begin
     DECLARE giftname varchar(200);
    DECLARE startday datetime;
    DECLARE endday datetime;
    declare errormessage varchar(300) default '';
    
    select gift_startdate,gift_expiredate,gift_code
    into startday,endday,giftname
    from giftcode
    where gift_code_id = new.gift_code_id;
	
	set errormessage = concat('the day of gift code: ',giftname,' start day ',startday,
									  ' not suitable for end day:  ', endday,' of gift code'        
		);
    
    if endday<=startday then
		signal sqlstate '45000' 
            set message_text = errormessage;
    end if;
    
    end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `giftcode_time_check_update_trigger` BEFORE UPDATE ON `giftcode` FOR EACH ROW begin
    DECLARE giftname varchar(200);
    DECLARE startday datetime;
    DECLARE endday datetime;
    declare errormessage varchar(300) default '';


    set giftname=new.gift_code;
    set startday = new.gift_startdate;
    set endday = new.gift_expiredate;

	  set errormessage = concat('the day of gift update code: ',giftname,' start day ',startday,
									  ' not suitable for end day:  ', endday,' of gift code'        
		);

    if endday<=startday then
		signal sqlstate '45000' 
            set message_text = errormessage;
    end if;

  end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `managerbranch`
--

CREATE TABLE `managerbranch` (
  `emp_id` int(6) UNSIGNED NOT NULL,
  `branch_id` int(6) UNSIGNED NOT NULL,
  `startdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `managerbranch`
--

INSERT INTO `managerbranch` (`emp_id`, `branch_id`, `startdate`) VALUES
(1, 4, '2020-09-01'),
(2, 3, '2022-01-01'),
(3, 2, '2021-03-01'),
(4, 1, '2020-07-01');

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
  `order_code` varchar(20) DEFAULT 'NoneGift'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_`
--

INSERT INTO `order_` (`order_id`, `order_date`, `order_address`, `order_total_money`, `order_status`, `order_emp_id`, `order_customer_id`, `order_code`) VALUES
(1, '21:49:12', 'NYC', '0.000', 'processing', 10, 1, 'NoneGift');

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
  `product_start_avg` decimal(5,3) NOT NULL DEFAULT 0.000,
  `product_category_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_listed_price`, `product_image`, `product_number`, `product_start_avg`, `product_category_id`) VALUES
(4, 'chocolate cream cold brew', '10.200', 'https://www.simplejoy.com/wp-content/uploads/2022/03/how-to-make-irish-cream-cold-brew-3-683x1024.jpg', 5000, '4.400', 4),
(5, 'matcha tea latte', '9.800', 'https://ostomyconnection.com/.image/ar_16:9%2cc_fill%2ccs_srgb%2cfl_progressive%2cg_faces:center%2cq_auto:good%2cw_768/mtu1mze4odyymdywmda0ntqw/green-macha-tea.jpg', 3000, '4.000', 2),
(6, 'mango dragonfruit lemonade', '7.800', 'https://cookathomemom.com/wp-content/uploads/2021/04/mango-dragonfruit-lemonade.jpg', 500, '3.100', 2),
(7, 'hello', '1200.000', 'image change', 160, '4.000', 2),
(8, 'hello', '1200.000', 'image', 160, '4.000', 2),
(9, 'hello', '120.000', 'image', 12, '4.000', 1),
(10, 'hello', '120.000', 'image', 12, '4.000', 1),
(11, 'hello', '120.000', 'image', 12, '4.000', 1),
(12, 'hello', '120.000', 'image', 12, '4.000', 1),
(13, 'hello', '120.000', 'image', 12, '4.000', 1),
(14, 'hello', '120.000', 'image', 160, '4.000', 2),
(15, 'rename', '1200.000', 'image change', 160, '4.000', 2),
(16, 'abczay', '110.000', 'image changed', 90, '2.000', 1);

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

--
-- Dumping data for table `productorder`
--

INSERT INTO `productorder` (`order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 4, 10, '102.000');

--
-- Triggers `productorder`
--
DELIMITER $$
CREATE TRIGGER `productorder_check_insert_trigger` BEFORE INSERT ON `productorder` FOR EACH ROW begin 

    declare orderExist int(2) default 0;
    declare productExist int(2) default 0;
    declare errormessage varchar(300) default '';

    set orderExist = order_exists_function(new.order_id);
    set productExist = check_product_exists(new.product_id);

    if orderExist < 1 then
      set errormessage = concat('Order not exist !'        
		    );
      signal sqlstate '45000'
            set message_text = errormessage;
    end if;

    if productExist < 1 then
      set errormessage = concat('Product not exist !'        
		    );
      signal sqlstate '45000'
            set message_text = errormessage;
    end if;

    if new.quantity > get_quantity_from_product_id(new.product_id) then
      set errormessage = concat('The quantity too large to serve, sorry'        
		    );
      signal sqlstate '45000'
            set message_text = errormessage;
    end if;

  end
$$
DELIMITER ;

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
  `role_name` varchar(250) NOT NULL DEFAULT 'sale'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`) VALUES
(1, 'barista'),
(2, 'waiter'),
(3, 'cashier');

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `shift_id` int(6) UNSIGNED NOT NULL,
  `shift_time` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shift`
--

INSERT INTO `shift` (`shift_id`, `shift_time`) VALUES
(1, '06:00-14:00'),
(2, '14:00-22:00');

-- --------------------------------------------------------

--
-- Table structure for table `workhours`
--

CREATE TABLE `workhours` (
  `work_emp_id` int(6) UNSIGNED NOT NULL,
  `work_month` int(5) NOT NULL,
  `work_hours` decimal(10,3) NOT NULL DEFAULT 0.000
) ;

--
-- Dumping data for table `workhours`
--

INSERT INTO `workhours` (`work_emp_id`, `work_month`, `work_hours`) VALUES
(1, 4, '100.500'),
(2, 3, '80.200'),
(3, 2, '25.700'),
(4, 1, '15.200'),
(5, 5, '115.200'),
(6, 6, '140.200'),
(7, 7, '160.200'),
(8, 8, '180.200');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`),
  ADD UNIQUE KEY `branch_name_unique_constraint` (`branch_name`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name_unique_constraint` (`category_name`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cus_id`),
  ADD UNIQUE KEY `cus_phone_unique_constraint` (`cus_phone`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `emp_phone_unique_constraint` (`emp_phone`),
  ADD KEY `fk_employee_emp_role_id` (`emp_role_id`),
  ADD KEY `fk_employee_emp_branch_id` (`emp_branch_id`),
  ADD KEY `fk_employee_emp_shift_id` (`emp_shift_id`);

--
-- Indexes for table `giftcode`
--
ALTER TABLE `giftcode`
  ADD PRIMARY KEY (`gift_code_id`),
  ADD UNIQUE KEY `gift_code` (`gift_code`);

--
-- Indexes for table `managerbranch`
--
ALTER TABLE `managerbranch`
  ADD PRIMARY KEY (`emp_id`,`branch_id`),
  ADD KEY `fk_managerbranch_branch_id` (`branch_id`);

--
-- Indexes for table `order_`
--
ALTER TABLE `order_`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_order__order_code` (`order_code`),
  ADD KEY `fk_order__order_emp_id` (`order_emp_id`),
  ADD KEY `fk_order__order_customer_id` (`order_customer_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_product_product_category_id` (`product_category_id`);

--
-- Indexes for table `productorder`
--
ALTER TABLE `productorder`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `fk_productorder_product_id` (`product_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`customer_id`,`product_id`),
  ADD KEY `fk_rating_product_id` (`product_id`);

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
  MODIFY `branch_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cus_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `giftcode`
--
ALTER TABLE `giftcode`
  MODIFY `gift_code_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_`
--
ALTER TABLE `order_`
  MODIFY `order_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
  MODIFY `shift_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `fk_employee_emp_branch_id` FOREIGN KEY (`emp_branch_id`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `fk_employee_emp_role_id` FOREIGN KEY (`emp_role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `fk_employee_emp_shift_id` FOREIGN KEY (`emp_shift_id`) REFERENCES `shift` (`shift_id`);

--
-- Constraints for table `managerbranch`
--
ALTER TABLE `managerbranch`
  ADD CONSTRAINT `fk_managerbranch_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `fk_managerbranch_emp_id` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `order_`
--
ALTER TABLE `order_`
  ADD CONSTRAINT `fk_order__order_code` FOREIGN KEY (`order_code`) REFERENCES `giftcode` (`gift_code`),
  ADD CONSTRAINT `fk_order__order_customer_id` FOREIGN KEY (`order_customer_id`) REFERENCES `customer` (`cus_id`),
  ADD CONSTRAINT `fk_order__order_emp_id` FOREIGN KEY (`order_emp_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product_product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `productorder`
--
ALTER TABLE `productorder`
  ADD CONSTRAINT `fk_productorder_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`),
  ADD CONSTRAINT `fk_productorder_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `fk_rating_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`cus_id`),
  ADD CONSTRAINT `fk_rating_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `workhours`
--
ALTER TABLE `workhours`
  ADD CONSTRAINT `fk_workhours_work_emp_id` FOREIGN KEY (`work_emp_id`) REFERENCES `employee` (`emp_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
