-- stored procedure branch
use assignment2;
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

-- stored procedure category
drop procedure if exists category_insert_procedure;
delimiter //
create procedure category_insert_procedure(
        in category_name_pa varchar(250)
    )
    begin 
        insert into category(category_name)
        values(category_name_pa);
    end //
delimiter ;

drop procedure if exists category_update_procedure;
delimiter //
create procedure category_update_procedure(
        in category_name_old varchar(250),
        in category_name_new varchar(250)

    )
    begin 
        UPDATE category
        SET category_name = category_name_new
        WHERE category_name=category_name_old;
    end //
delimiter ;


-- stored procedure order_

drop procedure if exists order__insert_procedure;
delimiter //
create procedure order__insert_procedure(
        order_customer_id_pa int(6) unsigned ,
        order_emp_id_pa int(6) unsigned,
        order_address_pa varchar(250)
    )
    begin 
        insert into order_(order_date,order_address,order_emp_id,order_customer_id)
        values(NOW(),order_address_pa,order_emp_id_pa,order_customer_id_pa);
    end//
delimiter ;


drop procedure if exists order__insert_with_giftcode_procedure;
delimiter //
create procedure order__insert_with_giftcode_procedure(
        order_customer_id_pa int(6) unsigned ,
        order_emp_id_pa int(6) unsigned,
        order_code_pa varchar(20),
        order_address_pa varchar(250)
    )
    begin 
        insert into order_(order_date,order_address,order_emp_id,order_customer_id,order_code)
        values(NOW(),order_address_pa,order_emp_id_pa,order_customer_id_pa,order_code_pa);
    end//
delimiter ;


-- stored procedure productOrder

drop procedure if exists productOrder_insert_procedure;
delimiter //
create procedure productOrder_insert_procedure(
        in order_id_pa int(6),
        product_id_pa int(6),
        quantity_pa int(10)
    )
    begin 
        declare priceCounted decimal(10,3);

        set priceCounted = get_price_from_product_id(product_id_pa) * quantity_pa;
        insert into productorder(order_id,product_id,quantity,price)
        values(order_id_pa,product_id_pa,quantity_pa,priceCounted);

        call product_decrease_procedure(product_id_pa,quantity_pa);

        UPDATE order_
        SET order_total_money = order_total_money+priceCounted
        WHERE order_id=order_id_pa;
    end //
delimiter ;


drop procedure if exists productOrder_update_procedure;
delimiter //
create procedure productOrder_update_procedure(
        in order_id_pa int(6),
        product_id_pa int(6),
        quantity_pa int(10)
    )
    begin 
        declare priceCounted decimal(10,3);
        set priceCounted = get_price_from_product_id(product_id_pa) * quantity_pa;
        UPDATE productorder
        set price = priceCounted
        where order_id = order_id_pa and product_id=product_id_pa;
    end //
delimiter ;

drop procedure if exists productOrder_delete_procedure;
delimiter //
create procedure productOrder_delete_procedure(
        order_id_pa int(6),
        product_id_pa int(6)
    )
    begin 
        

        declare quantity_pa int(10) default 0;
        declare priceCounted decimal(10,3) default 0.000;
        declare numberremain int(5) default 0;

        set quantity_pa = product_quantity_from_productOrder_function(order_id_pa,product_id_pa);
        
        set priceCounted = product_price_from_productOrder_function(order_id_pa,product_id_pa);

        

        DELETE FROM productorder
        where order_id = order_id_pa and product_id=product_id_pa;


        set numberremain = theNumberOf_Product_in_productOrder_function(order_id_pa);

        if numberremain = 0 then 
            DELETE FROM order_
            where order_id = order_id_pa;
        end if;
        
        call product_increase_procedure(product_id_pa,quantity_pa);

        UPDATE order_
        SET order_total_money = order_total_money-priceCounted
        WHERE order_id=order_id_pa;



    end //
delimiter ;

-- stored procedure of product
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
