-- get customer infor
drop function if exists get_customer_id_from_phone;
delimiter //
create function get_customer_id_from_phone(
        cus_phone_pa varchar(11) 
    )
    returns int(6) 
    deterministic
    begin
        declare result int(6) default 0;
        select cus_id
        into result
        from customer
        where cus_phone = cus_phone_pa;
        return result;
    end //

delimiter ;

-- get employee infor
drop function if exists get_employee_id_from_phone;
delimiter //
create function get_employee_id_from_phone(
        emp_phone_pa varchar(11)
    )
    returns int(6)
    deterministic
    begin
        declare result int(6) default 0;
        select emp_id
        into result
        from employee
        where emp_phone=emp_phone_pa;
        return result;
    end//
delimiter ;

-- get order_ infor
drop function if exists order_exists_function;
delimiter //
create function order_exists_function(
        order_id_pa int(6)
    )
    returns int(2)
    deterministic
    begin
        declare result int(2) default 0;

        select count(*)
        into result
        from order_
        where order_id = order_id_pa;
        return result;
    end//
delimiter ;
-- get giftcode value infor
drop function if exists get_giftValue_from_orderCode;
delimiter //
create function get_giftValue_from_orderCode(
        Code_param varchar(20)
    )
    returns decimal(10,3)
    deterministic
    begin
        declare result decimal(10,3) default 0.000;
        select gift_value
        into result
        from giftcode
        where Code_param = gift_code;
        return result;
    end //

delimiter ;

-- get product value infor
drop function if exists get_price_from_product_id;
delimiter //
create function get_price_from_product_id(
        product_id_pa int(6)
    )
    returns decimal(10,3)
    deterministic
    begin
        declare result decimal(10,3) default 0;
        select product_listed_price
        into result
        from product
        where product_id=product_id_pa;
        return result;
    end//
delimiter ;

drop function if exists check_product_exists;
delimiter //
create function check_product_exists(
        product_id_pa int(6)
    )
    returns int(2)
    deterministic
    begin
        declare result int(2) default 0;
        select COUNT(product_id)
        into result
        from product
        where product_id=product_id_pa and product_number > 0;
        return result;
    end//
delimiter ;


drop function if exists get_quantity_from_product_id;
delimiter //
create function get_quantity_from_product_id(
        product_id_pa int(6)
    )
    returns int(11)
    deterministic
    begin
        declare result int(11) default 0;
        select product_number
        into result
        from product
        where product_id=product_id_pa;
        return result;
    end//
delimiter ;




drop function if exists product_quantity_from_productOrder_function;
delimiter //
create function product_quantity_from_productOrder_function(
        order_id_pa int(6),
        product_id_pa int(6)
    )
    returns int(10)
    deterministic
    begin 
        declare result int(10) default 0;
        select quantity
        into result
        from productorder
        where order_id=order_id_pa and product_id = product_id_pa;
        return result;
    end //

delimiter ;


drop function if exists product_price_from_productOrder_function;
delimiter //
create function product_price_from_productOrder_function(
        order_id_pa int(6),
        product_id_pa int(6)
    )
    returns decimal(10,3)
    deterministic
    begin 
        declare result decimal(10,3) default 0;
        select price
        into result
        from productorder
        where order_id=order_id_pa and product_id = product_id_pa;
        return result;
    end //

delimiter ;


drop function if exists theNumberOf_Product_in_productOrder_function;
delimiter //
create function theNumberOf_Product_in_productOrder_function(
        order_id_pa int(6)
    )
    returns int(6)
    deterministic
    begin 
        declare result int(6) default 0;

        select count(*)
        into result
        from productorder
        where order_id =order_id_pa;

        return result;
    end //

delimiter ;

drop function if exists productOrderExist_function;
delimiter //
create function productOrderExist_function(
        order_id_pa int(6),
        product_id_pa int(6)
    )
    returns int(2)
    deterministic
    begin 
        declare result int(2) default 0;
        declare numb int(6) default 0;

        select count(*)
        into numb
        from productorder
        where order_id =order_id_pa and product_id=product_id_pa;
        if numb<=0 then 
            set result =0;        
        else
            set result =1;
        end if;

        return result;

    end//
delimiter ;


drop function if exists get_total_priceOfOrder;
delimiter //
create function get_total_priceOfOrder(
		order_id_pa int(6)
	)
    returns decimal(10,3)
    DETERMINISTIC
    begin
		DECLARE finished INTEGER DEFAULT 0;
		DECLARE priceItem  decimal(10,3) DEFAULT 0;
        declare result decimal(10,3) DEFAULT 0.0;
        declare temp integer DEFAULT 0;

        
        DEClARE curprice
			CURSOR FOR 
				SELECT price FROM productorder where order_id = order_id_pa;
                
		DECLARE CONTINUE HANDLER 
			FOR NOT FOUND SET finished = 1;
		
        set temp = theNumberOf_Product_in_productOrder_function(order_id_pa);
		
        if temp =0 then 
			set result=0;
            return result;
        end if;
		
            
		open curprice ;
        coutloop: loop
			FETCH curprice INTO priceItem;
			IF finished = 1 THEN 
				LEAVE coutloop;
			end if;
            
            set result= result+priceItem;
        
        end loop coutloop;       
        
        close curprice;
        
        RETURN result;
    
    end //
delimiter ;


drop function if exists numberOfOrder_Have_Product_Proccessing;
delimiter //
create function numberOfOrder_Have_Product_Proccessing(
		product_id_pa int(6)
	)
    returns integer
    deterministic
    begin 
		
        declare result integer default 0;
        
        select count(*)
        into result
        from
        (
        	select p1.order_id,p1.product_id
			from productorder as p1
			where p1.product_id=product_id_pa and p1.order_id in (
				select order_id
				from order_
				where order_status='processing'
			)
        ) as tabletemp;
        return result;        
    
    end //  
delimiter ;




