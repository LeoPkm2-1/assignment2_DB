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

