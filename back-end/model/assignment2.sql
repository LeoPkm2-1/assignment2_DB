
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
  emp_birthday date not null,
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
  foreign key (order_code) references giftcode (gift_code_id);

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


-- trigger 
-- drop trigger if exists employee_age_check_trigger;
-- delimiter //
-- create trigger employee_age_check_trigger
-- 	before insert 
--     on employee for each row
--     begin 
-- 		declare age integer default 0;
--         declare finished integer default 0;        
--         declare errormessage varchar(255) default '';
--         declare newname varchar(255) default '';
-- 		declare dateofbirth date;
--         
--         -- declare cursor for employee age
--         declare cursorage 
-- 			cursor for 
-- 				select new.emp_birthday,new.emp_fullname from employee limit 1;
--                 
--         -- declare not found handler
-- 		declare continue handler 
-- 			for not found set finished = 1;
--             
-- 		open cursorage;
--         
--         checkage: loop
-- 			fetch cursorage into dateofbirth,newname ;
--             
--             if finished = 1 then 
-- 				leave checkage;
-- 			end if;
--             
--             select date_format(from_days(datediff(now(),dateofbirth)), '%y')+0 
-- 			into age
-- 			from employee;
--             
-- 			set errormessage = concat('the age of employee ',newname,
-- 										  ' is ', age,'less than 18'        
-- 			);
-- 			if age <18 then
-- 				signal sqlstate '45001'
-- 					set message_text= errormessage;
-- 			end if;
--         
--         end loop checkage;
--         close cursorage;    
--     
--     end//
-- delimiter ;


-- stored procedure branch
drop procedure if exists branch_insert_procedure;
delimiter //
create procedure branch_insert_procedure(
	in branch_name_pa varchar(250),
    in branch_location_pa varchar(250)
)
begin
	insert into branch (branch_name, brach_location)
	VALUES (branch_name_pa, branch_location_pa);
end //

delimiter ;

drop procedure if exists branch_update_location_procedure;
delimiter //
create procedure branch_update_location_procedure(
	in branch_name_pa varchar(250),
    in branch_location_pa varchar(250)
)
begin
	UPDATE branch
	SET brach_location = branch_location_pa
	WHERE branch_name = branch_name_pa ;

end //

delimiter ;

drop procedure if exists branch_update_name_procedure;
delimiter //
create procedure branch_update_name_procedure(
	in branch_name_old varchar(250),
    in branch_name_new varchar(250)
)
begin
	UPDATE branch
	SET branch_name = branch_name_new
	WHERE branch_name = branch_name_old ;

end //

delimiter ;


-- trigger branch
drop trigger if exists branch_name_check_insert_trigger;
delimiter //
create trigger branch_name_check_insert_trigger
	before insert on branch for each row
    begin
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
    
    end//
delimiter ;

-- drop trigger if exists branch_name_check_update_trigger;
-- delimiter //
-- create trigger branch_name_check_update_trigger
--   before update on branch for each row
--     begin
--       declare numb int default 10;
-- 		  declare newbranchname varchar(50) default '';
--       declare errormessage varchar(300) default '';

--       set newbranchname = new.branch_name;
--       select count(*)
--       into numb
--       from branch
--       where branch_name = newbranchname;

--       set errormessage = concat('this branch ', newbranchname,' is exists! so update wrong'        
--       );

--       if numb > 0 then 
--         signal sqlstate '45000'
--           set message_text = errormessage;
--       end if;


--     end//

-- delimiter ;

 -- trigger employee


drop trigger if exists employee_age_check_insert_trigger;
delimiter //
create trigger employee_age_check_insert_trigger
	before insert 
    on employee for each row
    begin 
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
        
       
    
    end//
delimiter ;

drop trigger if exists employee_age_check_update_trigger;
delimiter //
create trigger employee_age_check_update_trigger
	before update 
    on employee for each row
    begin 
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
       
    
    end//
delimiter ;


drop trigger if exists giftcode_time_check_insert_trigger;
delimiter //
create trigger giftcode_time_check_insert_trigger
	after insert
    on giftcode for each row
    begin
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
    
    end//
delimiter ;

drop trigger if exists giftcode_time_check_update_trigger;
delimiter //
  create trigger giftcode_time_check_update_trigger
  before update on giftcode for each row
  begin
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

  end //
delimiter ;

-- insert data
insert into branch (branch_name, brach_location)
values ('nyc', '111 centre st, new york, ny 10013, united states'),
('london','exhibition rd, south kensington, london sw7 2bx, united kingdom'),
('paris','24 rue du commandant guilbaud, 75016 paris, france'),
('madrid','de concha espina, 1, 28036 madrid, spain')
;


insert into category (category_name)
values ('cake'),
('tea'),
('milk'),
('cafe'),
('ice cream');

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

insert into employee (emp_fullname, emp_address, emp_phone, emp_email, emp_birthday, emp_salary_per_hour, emp_password, emp_role_id, emp_branch_id, emp_shift_id)
values 
 ('will smith','sir matt busby way, old trafford, stretford, manchester','0147851234','willsmith@gmail.com','1994-02-15',13.77,'null',1,2,1),
 ('tom hanks','111 centre st, new york','0147851234','tomhanksh@gmail.com','1990-02-15',14.77,'null',2,1,1),
 ('brad pitt','sir matt busby way, old trafford, stretford, manchester','0965851234','bradpitt@gmail.com','1998-02-15',12.77,'null',1,2,2),
 ('nguyen van teo', 'london sw1a 1aa, united kingdom', '01478523547', 'ahihi2@gmail.com', '1999-01-15', 12.5, 'emp_password', 3, 1, 2),
 ('hoang van ty', 'london ec3n 4ab, united kingdom', '03698521456', 'ahihi3@gmail.com', '1995-02-15', 25.4, 'emp_password', 3, 1, 2),
 ('luong trieu vy', ' london, united kingdom', '0123654852', 'ahihi4@gmail.com', '1995-08-25', 15.8, 'emp_password', 1, 2, 1), 
 ('luu duc hoa', 'bd de parc, 77700 coupvray, france', '0147532159', 'ahihi6@gmail.com', '1995-03-15', 14.9, 'emp_password', 1, 2, 1)
 ;


insert into product (product_name, product_listed_price, product_number, product_start_avg, product_category_id,product_image)
values ('bacon, sausage & egg wrap',12.5,150,2,1,'https://www.fastfoodpost.com/wp-content/uploads/2020/03/starbucks-new-southwest-veggie-wrap-and-new-bacon-sausage-egg.jpg'),
('bacon, gouda & egg sandwich',13.8,200,4,1,'https://i.dayj.com/image/720/food/1898448/starbucks-bacon-gouda-and-egg-sandwich-1-piece.png'),
('cold brew coffee', 8.2, 1000, 3, 4,'https://www.thespruceeats.com/thmb/gcbhhltxned8jdm4zqdrsenkshi=/1885x1414/smart/filters:no_upscale()/coldbrewcoffeemicrogen-95e6ef2fc2c1411bbcf1cefe5e9e6879.jpg'),
('chocolate cream cold brew', 10.2, 5000, 4.4, 4,'https://www.simplejoy.com/wp-content/uploads/2022/03/how-to-make-irish-cream-cold-brew-3-683x1024.jpg'),
('matcha tea latte', 9.8, 3000, 4, 2,'https://ostomyconnection.com/.image/ar_16:9%2cc_fill%2ccs_srgb%2cfl_progressive%2cg_faces:center%2cq_auto:good%2cw_768/mtu1mze4odyymdywmda0ntqw/green-macha-tea.jpg'),
('mango dragonfruit lemonade', 7.8, 500, 3.1, 2,'https://cookathomemom.com/wp-content/uploads/2021/04/mango-dragonfruit-lemonade.jpg');

insert into giftcode(gift_code,gift_startdate,gift_expiredate,gift_value)
values ('ahihi2022','2022-04-05 00:00:00','2022-08-05 00:00:00',12.7),
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