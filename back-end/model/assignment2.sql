
-- database: assignment2
drop database if exists assignment2;
create database assignment2;
use assignment2;


-- table branch

drop table if exists branch;
create table branch (
  branch_id int(6) unsigned not null auto_increment,
  branch_name varchar(250) default null,
  brach_location varchar(250) default null,
  primary key (branch_id)
);

-- table category
drop table if exists category;
create table category (
  category_id int(6) unsigned not null auto_increment,
  category_name varchar(250) not null,
  primary key (category_id)
);

-- table customer
drop table if exists customer;
create table customer (
  cus_id int(6) unsigned not null auto_increment,
  cus_fullname varchar(250) not null,
  cus_address varchar(250) default null,
  cus_phone varchar(250) not null,
  cus_email varchar(50) default null,
  cus_password varchar(250) not null,
  primary key (cus_id)
);

-- table employee
drop table if exists employee;
create table employee (
  emp_id int(6) unsigned not null auto_increment,
  emp_fullname varchar(250) not null,
  emp_address varchar(250) default null,
  emp_phone varchar(250) not null,
  emp_email varchar(50) default null,
  emp_birthday year(4) not null,
  emp_salary_per_hour decimal(10,3) default null,
  emp_password varchar(250) not null,
  emp_role_id int(6) unsigned not null,
  emp_branch_id int(6) unsigned not null,
  emp_shift_id int(6) unsigned not null,
  primary key (emp_id)
);

-- table giftcode
drop table if exists giftcode;
create table giftcode (
  gift_code int(6) unsigned not null auto_increment,
  gift_startdate time not null,
  gift_expiredate time not null,
  gift_value decimal(10,3) not null,
  primary key (gift_code)
);

-- table managerbranch
drop table if exists managerbranch;
create table managerbranch (
  emp_id int(6) unsigned not null,
  branch_id int(6) unsigned not null,
  startdate date default null
);

-- table order_
drop table if exists order_;
create table order_ (
  order_id int(6) unsigned not null auto_increment,
  order_date time not null,
  order_address varchar(250) not null,
  order_total_money decimal(10,3) not null default 0.000,
  order_status varchar(50) not null default 'processing',
  order_emp_id int(6) unsigned default null,
  order_customer_id int(6) unsigned default null,
  order_code int(6) unsigned default null,
  primary key (order_id)
);

-- table product
drop table if exists product;
create table product (
  product_id int(6) unsigned not null auto_increment,
  product_name varchar(250) not null,
  product_listed_price decimal(10,3) not null,
  product_image text not null,
  product_number int(11) not null default 0,
  product_start_avg decimal(3,3) not null default 0.000,
  product_category_id int(6) unsigned not null,
  primary key (product_id)
);

-- table productorder
drop table if exists productorder;
create table productorder (
  order_id int(6) unsigned not null,
  product_id int(6) unsigned not null,
  quantity int(10) not null default 1,
  price decimal(10,3) not null default 0.000
);

-- table rating
drop table if exists rating;
create table rating (
  customer_id int(6) unsigned not null,
  product_id int(6) unsigned not null,
  star decimal(3,3) not null default 0.000
);

-- table role
drop table if exists `role`;
create table `role` (
  role_id int(6) unsigned not null auto_increment,
  role_name varchar(250) not null default 'sale',
  primary key (role_id)
);

-- table shift
drop table if exists shift;
create table shift (
  shift_id int(6) unsigned not null auto_increment,
  shift_time varchar(250) not null,
  primary key (shift_id)
);

-- table workhours
drop table if exists workhours;
create table workhours (
  work_emp_id int(6) unsigned not null auto_increment,
  work_month int(5) not null,
  work_hours decimal(10,3) not null default 0.000,
  primary key (work_emp_id,work_month)
);


alter table employee
  add constraint fk_employee_emp_role_id
  foreign key (emp_role_id) references `role` (role_id);

alter table employee
  add constraint fk_employee_emp_branch_id
  foreign key (emp_branch_id) references branch (branch_id);

alter table employee
  add constraint fk_employee_emp_shift_id
  foreign key (emp_shift_id) references shift (shift_id);


alter table managerbranch
  add constraint fk_managerbranch_branch_id
  foreign key (branch_id) references branch (branch_id);

alter table managerbranch
  add constraint fk_managerbranch_emp_id
  foreign key (emp_id) references employee (emp_id);

alter table managerbranch
  add primary key (emp_id,branch_id);



alter table order_
  add constraint fk_order__order_code
  foreign key (order_code) references giftcode (gift_code);

alter table order_
  add constraint fk_order__order_emp_id
  foreign key (order_emp_id) references employee(emp_id);

alter table order_
  add constraint fk_order__order_customer_id
  foreign key (order_customer_id) references customer(cus_id);



alter table product
  add constraint fk_product_product_category_id
  foreign key (product_category_id) references category(category_id);



alter table productorder
  add constraint fk_productorder_product_id
  foreign key (product_id) references product(product_id);

alter table productorder
  add constraint fk_productorder_order_id
  foreign key (order_id) references order_(order_id);

alter table productorder
  add primary key (order_id,product_id);



alter table rating
  add constraint fk_rating_customer_id
  foreign key (customer_id) references customer(cus_id);

alter table rating
  add constraint fk_rating_product_id
  foreign key (product_id) references product(product_id);

alter table rating
  add primary key (customer_id,product_id);


alter table workhours
  add constraint fk_workhours_work_emp_id
  foreign key (work_emp_id) references employee(emp_id);
