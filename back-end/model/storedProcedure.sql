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