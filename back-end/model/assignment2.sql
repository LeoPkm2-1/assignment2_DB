
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
  primary key (branch_id),
  constraint branch_name_unique_constraint UNIQUE (branch_name)
);

-- table category
drop table if exists category;
create table category (
  category_id int(6) unsigned not null auto_increment,
  category_name varchar(250) not null,
  primary key (category_id),
  constraint category_name_unique_constraint UNIQUE (category_name)
);

-- table customer
drop table if exists customer;
create table customer (
  cus_id int(6) unsigned not null auto_increment,
  cus_fullname varchar(250) not null,
  cus_address varchar(250) default null,
  cus_phone varchar(11) not null,
  cus_email varchar(50) default null,
  cus_password varchar(250) not null,
  primary key (cus_id),
  constraint cus_phone_unique_constraint UNIQUE (cus_phone)
);

-- table employee
drop table if exists employee;
create table employee (
  emp_id int(6) unsigned not null auto_increment,
  emp_fullname varchar(250) not null,
  emp_address varchar(250) default null,
  emp_phone varchar(11) not null,
  emp_email varchar(50) default null,
  emp_birthday date not null,
  emp_salary_per_hour decimal(10,3) default null,
  emp_password varchar(250) not null,
  emp_role_id int(6) unsigned not null,
  emp_branch_id int(6) unsigned not null,
  emp_shift_id int(6) unsigned not null,
  primary key (emp_id),
  constraint emp_phone_unique_constraint UNIQUE (emp_phone)

);

-- table giftcode
drop table if exists giftcode;
create table giftcode (
  gift_code_id int(6) unsigned not null auto_increment,
  gift_code varchar(20) not null unique,
  gift_startdate datetime not null,
  gift_expiredate datetime not null,
  gift_value decimal(10,3) not null,
  primary key (gift_code_id)
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
  order_code varchar(20) default 'NoneGift',
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
  product_start_avg decimal(5,3) not null default 0.000,
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
  star decimal(4,3) not null default 0.000
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
  primary key (work_emp_id,work_month),
  constraint workhours_month_check_constraint check (work_month>=1 and work_month<=12)
);

-- employee foreign key-- 
alter table employee
  add constraint fk_employee_emp_role_id
  foreign key (emp_role_id) references `role` (role_id);

alter table employee
  add constraint fk_employee_emp_branch_id
  foreign key (emp_branch_id) references branch (branch_id);

alter table employee
  add constraint fk_employee_emp_shift_id
  foreign key (emp_shift_id) references shift (shift_id);

-- managerbranch foreign key
alter table managerbranch
  add constraint fk_managerbranch_branch_id
  foreign key (branch_id) references branch (branch_id);

alter table managerbranch
  add constraint fk_managerbranch_emp_id
  foreign key (emp_id) references employee (emp_id);

alter table managerbranch
  add primary key (emp_id,branch_id);


-- order_ foreign key
alter table order_
  add constraint fk_order__order_code
  foreign key (order_code) references giftcode (gift_code);

alter table order_
  add constraint fk_order__order_emp_id
  foreign key (order_emp_id) references employee(emp_id);

alter table order_
  add constraint fk_order__order_customer_id
  foreign key (order_customer_id) references customer(cus_id);


-- product foreign key
alter table product
  add constraint fk_product_product_category_id
  foreign key (product_category_id) references category(category_id);


-- productorder foreign key
alter table productorder
  add constraint fk_productorder_product_id
  foreign key (product_id) references product(product_id);

alter table productorder
  add constraint fk_productorder_order_id
  foreign key (order_id) references order_(order_id);

alter table productorder
  add primary key (order_id,product_id);


-- rating foreign key
alter table rating
  add constraint fk_rating_customer_id
  foreign key (customer_id) references customer(cus_id);

alter table rating
  add constraint fk_rating_product_id
  foreign key (product_id) references product(product_id);

alter table rating
  add primary key (customer_id,product_id);

-- workhours foreign key
alter table workhours
  add constraint fk_workhours_work_emp_id
  foreign key (work_emp_id) references employee(emp_id);




-- insert data
insert into branch (branch_name, brach_location)
values ('nyc', '111 centre st, new york, ny 10013, united states'),
('london','exhibition rd, south kensington, london sw7 2bx, united kingdom'),
('paris','24 rue du commandant guilbaud, 75016 paris, france'),
('madrid','de concha espina, 1, 28036 madrid, spain')
;


insert into category (category_name)
values ('Bánh-Snack'),
('Cà Phê'),
('Hi-Tea Healthy'),
('Trà Trái Cây- Trà Sữa'),
('Đá Xay - Choco');

insert into `role` (role_name)
values ('barista'),
('waiter'),
('cashier');

insert into customer (cus_fullname,cus_address,cus_phone,cus_email,cus_password)
values ('will smith','111 centre st, new york','0147852369','willsmith@gmail.com','null'),
('tom hanks','111 centre st, new york','0124552369','tomhanksh@gmail.com','null'),
('brad pitt','111 centre st, new york','0965852369','bradpitt@gmail.com','null');

insert into shift (shift_time)
values ('06:00-14:00'),
('14:00-22:00');

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
(11, 'van tran', 'kien truc tphcm', '0111423815', 'vui123@gmail.com', '2000-03-14', '131000.000', 'emp_password', 2, 4, 2);


INSERT INTO `product` (`product_id`, `product_name`, `product_listed_price`, `product_image`, `product_number`, `product_start_avg`, `product_category_id`) VALUES
(2, 'Cà Phê Sữa Đá', '29.000', 'https://minio.thecoffeehouse.com/image/admin/1639377738_ca-phe-sua-da_400x400.jpg', 199, '4.000', 4),
(3, 'Trà Long Nhãn Hạt Sen', '51.000', 'https://minio.thecoffeehouse.com/image/admin/1649378747_tra-sen-nhan_400x400.jpg', 1000, '3.000', 2),
(4, 'Trà Đảo Cam Sả - Đá', '45.000', 'https://minio.thecoffeehouse.com/image/admin/tra-dao-cam-xa_668678_400x400.jpg', 5000, '4.400', 2),
(5, 'Trà Đào Cam Sả- Nóng', '51.000', 'https://minio.thecoffeehouse.com/image/admin/tdcs-nong_288997_400x400.jpg', 3000, '4.000', 2),
(6, 'Trà Hạt Sen - Đá', '45.000', 'https://minio.thecoffeehouse.com/image/admin/tdcs-nong_288997_400x400.jpg', 500, '3.100', 2),
(8, 'Cà Phê Sữa Nóng', '35.000', 'https://minio.thecoffeehouse.com/image/admin/1639377770_cfsua-nong_400x400.jpg', 199, '4.000', 4),
(9, 'Bạc Sỉu', '29.000', 'https://minio.thecoffeehouse.com/image/admin/1639377904_bac-siu_400x400.jpg', 199, '4.000', 4),
(10, 'Bạc Sỉu Nóng', '35.000', 'https://minio.thecoffeehouse.com/image/admin/1639377926_bacsiunong_400x400.jpg', 199, '4.000', 4),
(11, 'Cà Phê Đen Đá', '29.000', 'https://minio.thecoffeehouse.com/image/admin/1639377798_ca-phe-den-da_400x400.jpg', 199, '4.000', 4),
(12, 'Cà Phê Đen Nóng', '35.000', 'https://minio.thecoffeehouse.com/image/admin/1639377816_ca-phe-den-nong_400x400.jpg', 199, '4.000', 4),
(13, 'Trà Hạt Sen - Nóng', '51.000', 'https://minio.thecoffeehouse.com/image/admin/tra-sen-nong_025153_400x400.jpg', 500, '3.100', 2),
(14, 'Trà Đen Macchiato', '49.000', 'https://minio.thecoffeehouse.com/image/admin/tra-den-matchiato_430281_400x400.jpg', 500, '3.100', 2),
(15, 'Hi-Tea Dâu Tây Mận', '49.000', 'https://minio.thecoffeehouse.com/image/admin/1653274559_dau-tay-man-muoi-aloe-vera_400x400.jpg', 500, '3.100', 3),
(16, 'Hi-Tea Xoài', '45.000', 'https://minio.thecoffeehouse.com/image/admin/1653275101_xoai-aloe-vera_400x400.jpg', 500, '3.100', 3),
(17, 'Hi-Tea Đào', '45.000', 'https://minio.thecoffeehouse.com/image/admin/1653291185_hi-tea-dao_400x400.jpg', 500, '3.100', 3),
(18, 'Hi-Tea Đá Tuyết Mận', '59.000', 'https://minio.thecoffeehouse.com/image/admin/1653275302_sb-man-muoi-aloevra_400x400.jpg', 500, '3.100', 3),
(19, 'Chocolate Đá', '59.000', 'https://minio.thecoffeehouse.com/image/admin/chocolate-da_877186_400x400.jpg', 500, '3.100', 5),
(20, 'Chocolate Nóng', '59.000', 'https://minio.thecoffeehouse.com/image/admin/chocolatenong_949029_400x400.jpg', 500, '3.100', 5),
(21, 'Bánh Mỳ Que Pate', '12.000', 'https://minio.thecoffeehouse.com/image/admin/banhmique_056830_400x400.jpg', 500, '3.100', 1),
(22, 'Bánh Mỳ Việt Nam Thịt Nguội', '29.000', 'https://minio.thecoffeehouse.com/image/admin/1638440015_banh-mi-vietnam_400x400.jpg', 500, '3.100', 1),
(23, 'Croissant Trứng Muối', '35.000', 'https://minio.thecoffeehouse.com/image/admin/croissant-trung-muoi_880850_400x400.jpg', 500, '3.100', 1),
(24, 'Chà Bông Phô Mai', '35.000', 'https://minio.thecoffeehouse.com/image/admin/cha-bong-pho-mai_204282_400x400.jpg', 500, '3.100', 1),
(25, 'Mochi Kem', '19.000', 'https://minio.thecoffeehouse.com/image/admin/1643102019_mochi-phucbontu_400x400.jpg', 500, '3.100', 1);

insert into giftcode(gift_code,gift_startdate,gift_expiredate,gift_value)
values ('NoneGift','2001-01-01 00:00:00','2221-01-01 00:00:01',0.0),
('ahihi2022','2022-04-05 00:00:00','2022-08-05 00:00:00',12.7),
('ok2222','2022-05-05 00:00:00','2022-09-05 00:00:00',13.8),
('heheh202','2022-05-25 00:00:00','2022-05-25 00:00:01',20.2);


insert into managerbranch(emp_id, branch_id, startdate)
values (1, 4, '2020-09-01'),
(2, 3, '2022-01-01'),
(3, 2, '2021-03-01'),
(4, 1, '2020-07-01');


insert into workhours(work_emp_id, work_month, work_hours)
values (1, 4, 100.5),
(2, 3,80.2 ),
(3, 2,25.7 ),
(4, 1,15.2 );

insert into rating values(1,2,3.4);
insert into rating values(2,6,4);
insert into rating values(3,4,1.5);


-- INSERT INTO order_ (order_id, order_date, order_address, order_total_money, order_status, order_emp_id, order_customer_id, order_code) VALUES
-- (1, '00:00:00', 'KTX khu A', '120.700', 'processing', NULL, NULL, NULL),
-- (2, '01:22:11', 'KTX khu B', '200.000', 'processing', NULL, NULL, NULL),
-- (3, '01:22:11', 'KTX khu B', '200.000', 'processing', NULL, NULL, NULL),
-- (4, '02:42:11', 'SPKT', '300.000', 'processing', NULL, NULL, NULL),
-- (5, '03:54:11', 'Kien truc', '510.000', 'processing', NULL, NULL, NULL);

-- UPDATE employee
-- SET emp_birthday = '2021-01-01'
-- WHERE emp_id=1;

-- UPDATE branch
-- SET branch_name ='london'
-- WHERE branch_id=2;

-- call `branch_insert_procedure`('paris','123 man');

-- insert into giftcode(gift_code,gift_startdate,gift_expiredate,gift_value)
-- values ('ahihi2022','2022-04-05 00:00:00','2022-08-05 00:00:00',12.7),
-- ('ok2222','2022-05-05 00:00:00','2022-09-05 00:00:00',13.8),
-- ('heheh202','2022-05-25 00:00:00','2022-05-25 00:00:01',20.2);