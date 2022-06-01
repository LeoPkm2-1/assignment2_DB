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


drop procedure if exists product_decrease_procedure;
delimiter //
create procedure product_decrease_procedure(
        in product_id_pa int(6),
        quantity_pa int(10)
    )
    begin 
        declare number_counted int(11);
        set number_counted = get_quantity_from_product_id(product_id_pa) - quantity_pa;
        UPDATE product
        set product_number = number_counted
        where product_id = product_id_pa;
    end //
delimiter ;

drop procedure if exists product_increase_procedure;
delimiter //
create procedure product_increase_procedure(
        in product_id_pa int(6),
        quantity_pa int(10)
    )
    begin 
        declare number_counted int(11);
        set number_counted = get_quantity_from_product_id(product_id_pa) + quantity_pa;
        UPDATE product
        set product_number = number_counted
        where product_id = product_id_pa;
    end //
delimiter ;