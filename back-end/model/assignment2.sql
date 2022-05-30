
-- database: assignment2
drop database if exists assignment2;
create database assignment2;
use assignment2;


--table branch


create table branch (
  branch_id int(6) unsigned not null,
  branch_name varchar(250) default null,
  brach_location varchar(250) default null,
  primary key (branch_id)
);

--table category

create table category (
  category_id int(6) unsigned not null,
  category_name varchar(250) not null,
  primary key (category_id)
);

--table customer

create table customer (
  cus_id int(6) unsigned not null,
  cus_fullname varchar(250) not null,
  cus_address varchar(250) default null,
  cus_phone varchar(250) not null,
  cus_email varchar(50) default null,
  cus_password varchar(250) not null,
  primary key (cus_id)
);



--table employee

create table employee (
  emp_id int(6) unsigned not null,
  emp_fullname varchar(250) not null,
  emp_address varchar(250) default null,
  emp_phone varchar(250) not null,
  emp_email varchar(50) default null,
  emp_birthday year(4) not null,
  emp_salary_per_hour decimal(10,3) default null,
  emp_password varchar(250) not null,
  emp_role_id int(6) unsigned not null,
  emp_branch_id int(6) unsigned not null,
  emp_shift_id int(6) unsigned not null
);

--table giftcode

create table giftcode (
  gift_code int(6) unsigned not null,
  gift_startdate time not null,
  gift_expiredate time not null,
  gift_value decimal(10,3) not null,
  primary key (gift_code)
);

--table managerbranch

create table managerbranch (
  emp_id int(6) unsigned not null,
  branch_id int(6) unsigned not null,
  startdate date default null
);

--table order_

create table order_ (
  order_id int(6) unsigned not null,
  order_date time not null,
  order_address varchar(250) not null,
  order_total_money decimal(10,3) not null default 0.000,
  order_status varchar(50) not null default 'processing',
  order_emp_id int(6) unsigned default null,
  order_customer_id int(6) unsigned default null,
  order_code int(6) unsigned default null
);

--table product

create table product (
  product_id int(6) unsigned not null,
  product_name varchar(250) not null,
  product_listed_price decimal(10,3) not null,
  product_image text not null,
  product_number int(11) not null default 0,
  product_start_avg decimal(3,3) not null default 0.000,
  product_category_id int(6) unsigned not null
);

--table productorder

create table productorder (
  order_id int(6) unsigned not null,
  product_id int(6) unsigned not null,
  quantity int(10) not null default 1,
  price decimal(10,3) not null default 0.000
);

--table rating

create table rating (
  customer_id int(6) unsigned not null,
  product_id int(6) unsigned not null,
  star decimal(3,3) not null default 0.000
);

--table role

create table `role` (
  role_id int(6) unsigned not null,
  role_name varchar(250) not null default 'sale',
  primary key (role_id)
);

--table shift

create table shift (
  shift_id int(6) unsigned not null,
  shift_time varchar(250) not null,
  primary key (shift_id)
);

--table workhours

create table workhours (
  work_emp_id int(6) unsigned not null,
  work_month int(5) not null,
  work_hours decimal(10,3) not null default 0.000,
  primary key (work_emp_id,work_month)
);

--
-- indexes for dumped tables
--


--
-- indexes for table employee
--
alter table employee
  add primary key (emp_id),
  add key emp_role_id (emp_role_id),
  add key emp_branch_id (emp_branch_id),
  add key emp_shift_id (emp_shift_id);



--
-- indexes for table managerbranch
--
alter table managerbranch
  add primary key (emp_id,branch_id),
  add key branch_id (branch_id);

--
-- indexes for table order_
--
alter table order_
  add primary key (order_id),
  add key order_code (order_code),
  add key order_emp_id (order_emp_id),
  add key order_customer_id (order_customer_id);

--
-- indexes for table product
--
alter table product
  add primary key (product_id),
  add key product_category_id (product_category_id);

--
-- indexes for table productorder
--
alter table productorder
  add primary key (order_id,product_id),
  add key product_id (product_id);

--
-- indexes for table rating
--
alter table rating
  add primary key (customer_id,product_id),
  add key product_id (product_id);


--
-- auto_increment for dumped tables
--

--
-- auto_increment for table branch
--
alter table branch
  modify branch_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table category
--
alter table category
  modify category_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table customer
--
alter table customer
  modify cus_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table employee
--
alter table employee
  modify emp_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table giftcode
--
alter table giftcode
  modify gift_code int(6) unsigned not null auto_increment;

--
-- auto_increment for table order_
--
alter table order_
  modify order_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table product
--
alter table product
  modify product_id int(6) unsigned not null auto_increment, auto_increment=2;

--
-- auto_increment for table role
--
alter table role
  modify role_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table shift
--
alter table shift
  modify shift_id int(6) unsigned not null auto_increment;

--
-- auto_increment for table workhours
--
alter table workhours
  modify work_emp_id int(6) unsigned not null auto_increment;

--
-- constraints for dumped tables
--

--
-- constraints for table employee
--
alter table employee
  add constraint employee_ibfk_1 foreign key (emp_role_id) references role (role_id),
  add constraint employee_ibfk_2 foreign key (emp_branch_id) references branch (branch_id),
  add constraint employee_ibfk_3 foreign key (emp_shift_id) references shift (shift_id);

--
-- constraints for table managerbranch
--
alter table managerbranch
  add constraint managerbranch_ibfk_1 foreign key (emp_id) references employee (emp_id),
  add constraint managerbranch_ibfk_2 foreign key (branch_id) references branch (branch_id);

--
-- constraints for table order_
--
alter table order_
  add constraint order__ibfk_1 foreign key (order_code) references giftcode (gift_code),
  add constraint order__ibfk_2 foreign key (order_emp_id) references employee (emp_id),
  add constraint order__ibfk_3 foreign key (order_customer_id) references customer (cus_id);

--
-- constraints for table product
--
alter table product
  add constraint product_ibfk_1 foreign key (product_category_id) references category (category_id),
  add constraint product_ibfk_2 foreign key (product_category_id) references category (category_id);

--
-- constraints for table productorder
--
alter table productorder
  add constraint productorder_ibfk_1 foreign key (order_id) references order_ (order_id),
  add constraint productorder_ibfk_2 foreign key (product_id) references product (product_id),
  add constraint productorder_ibfk_3 foreign key (order_id) references order_ (order_id);

--
-- constraints for table rating
--
alter table rating
  add constraint rating_ibfk_1 foreign key (customer_id) references customer (cus_id),
  add constraint rating_ibfk_2 foreign key (product_id) references product (product_id);

--
-- constraints for table workhours
--
alter table workhours
  add constraint workhours_ibfk_1 foreign key (work_emp_id) references employee (emp_id);
