
use assignment2;

-- trigger product 
drop trigger if exists update_product_before_trigger
delimiter //
create trigger update_product_before_trigger
	BEFORE UPDATE
	ON product FOR EACH ROW
    begin
		declare errormessage varchar(250) default '';
		if new.product_listed_price <0 then 
			set errormessage = concat('','the price of product must not be negative!'        
			);
			signal sqlstate '45000'
				set message_text = errormessage;        
        end if;
        
        
        if new.product_number <0 then 
			set errormessage = concat('','the number of product must be positive!'        
			);
			signal sqlstate '45000'
				set message_text = errormessage;  
        end if;
        
        if new.product_start_avg < 0.0 then 
			set errormessage = concat('','the star of product must be positive!'        
			);
			signal sqlstate '45000'
				set message_text = errormessage;  
        end if;
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


-- trigger category
drop trigger if exists category_name_check_insert_trigger;
delimiter //
create trigger category_name_check_insert_trigger
  before insert on category for each row
  begin 
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

  end //
delimiter ;

drop trigger if exists category_name_check_update_trigger;
delimiter //
create trigger category_name_check_update_trigger
  before update on category for each row
  begin 
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

  end //
delimiter ;


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

-- gift trigger
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

-- productorder trigger
drop trigger if exists productorder_check_insert_trigger;
delimiter //
create trigger productorder_check_insert_trigger
  before insert on productorder for each row
  begin 

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

  end //
delimiter ;


drop trigger if exists productorder_check_update_trigger;
delimiter //
create trigger productorder_check_update_trigger
  before update on productorder for each row
  begin
    DECLARE errorMessage VARCHAR(255) default'';
    declare isexists int(1) default 0;


    set isexists = productOrderExist_function(new.order_id,new.product_id);

    IF isexists !=1 THEN
		  SET errorMessage = CONCAT(errorMessage,'Product not in cart');

      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = errorMessage;

    END IF;

    if new.quantity < 0 then 

		 SET errorMessage = CONCAT(errorMessage,'the quantity of product must not negative number');
      
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = errorMessage;

     end if;    
	
    set new.price=new.quantity * get_price_from_product_id(new.product_id);

  end//

delimiter ;

drop trigger if exists productorder_check_delete_trigger;
delimiter //
create trigger productorder_check_delete_trigger
  before delete on productorder for each row
  begin 

    declare Product_in_order_exist int(2) default 0;
    declare errormessage varchar(100) default '';

    select count(*)
    into Product_in_order_exist
    from productorder
    where order_id = old.order_id and product_id = old.product_id;

    if Product_in_order_exist <= 0 then 
      set errormessage = concat('Order not exist !'        
      );
      signal sqlstate '45000'
            set message_text = errormessage;

    end if;


  end //
delimiter ;



drop trigger if exists update_product_after_1_trigger;
delimiter //
create trigger update_product_after_1_trigger
	after UPDATE
	ON product FOR EACH ROW
    begin
		
        update productorder as a 
		inner join (
			select p1.order_id,p1.product_id
			from productorder as p1
			where p1.product_id=new.product_id and p1.order_id in (
				select order_id
				from order_
				where order_status='processing'
			)
		) as b
		on (a.order_id,a.product_id) = (b.order_id,b.product_id)
		set  a.price =new.product_listed_price * a.quantity;
        
    end //

delimiter ;



drop trigger if exists update_product_after_2_trigger;
delimiter //
create trigger update_product_after_2_trigger
	after UPDATE
	ON product FOR EACH ROW
    FOLLOWS update_product_after_1_trigger
    bodyblock:begin
    
    declare testtemp integer default 0;
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE order_id_item int(6) DEFAULT 0;
    declare price_temp_toStore decimal(10,3) default 0.0;
    
    DEClARE curOrderId 
		CURSOR FOR 
			select p1.order_id
			from productorder as p1
			where p1.product_id=new.product_id and p1.order_id in (
				select order_id
				from order_
				where order_status='processing'
			);

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
    
    set testtemp = numberOfOrder_Have_Product_Proccessing(new.product_id);
    if testtemp = 0 then 
		leave bodyblock;
    end if;
    
    open curOrderId;
    
    getcount:loop
		FETCH curOrderId INTO order_id_item;
		IF finished = 1 THEN 
			LEAVE getcount;
		END IF;
        set price_temp_toStore = get_total_priceOfOrder(order_id_item);
        
        UPDATE order_
		SET order_total_money = price_temp_toStore
		WHERE order_id=order_id_item  ;
        
    end loop getcount;
    close curOrderId;   
		
    end //
delimiter ;




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