Use web_programing_database;

-- 1. trigger tự tạo 1 row mới trong bảng specification khi tạo 1 row mới trong bảng motorcycles
create trigger new_spec 
after insert on motorcycles
for each row
insert into specification (motors_id) values ( NEW.motors_id);


-- 2. trigger tự set attribute check_sold trong bảng a_motorcycle thành NULL nếu check_sale = stop sale trong bảng motorcycles
delimiter // 
create trigger after_update_check_sale
after update on motorcycles
for each row
begin
if old.check_sale != "stop sale" and NEW.check_sale = "stop sale" then
update a_motorcycle set check_sold = NULL where motors_id = new.motors_id;
end if;
end;

-- 3. trigger sau khi insert 1 row mới trong a_motorcycle thì trong motorcycles phần quantity sẽ tự + thêm 1
create trigger after_insert_new_motor
after insert on a_motorcycle
for each row
update motorcycles set quantity = quantity+1 where motors_id = new.motors_id;

-- 4. trigger sau khi update bảng a_motorcycle cột check_sold=sold thì trong bảng motorcycles cột quantity-1
delimiter //
create trigger after_update_checksold
after update on a_motorcycle
for each row
begin
if old.check_sold != "sold" and NEW.check_sold = "sold" then
update motorcycles set quantity = quantity-1 where motors_id = new.motors_id;
end if;
end;

-- 5. trigger khi xóa 1 row trong a_motorcycle thì quantity tự -1 trong motorcycles
create trigger after_delete_a_motor
after delete on a_motorcycle
for each row
update motorcycles set quantity = quantity-1 where motors_id = old.motors_id;

-- 6. trigger sau khi insert user_id và a_motor_id vào bảng payment thì tự động thêm gái 
create trigger after_insert_payment
after insert on payment
for each row
update payment set price = (select price from a_motorcycle join motorcycles on a_motorcycle.motors_id = motorcycles.motors_id
							where a_motorcycle. a_motor_id = new.a_motor_id) where payment_id = new.payment_id;

-- 7. trigger sau khi update bảng payment status = paid thì update bảng a_motocycle check_sold = sold và money_paid + price
delimiter //
create trigger update_status_payment
after update on payment
for each row
begin
if old.status != "paid" and new.status = "paid" then
update a_motorcycle set check_sold = "sold" where a_motorcycle.a_motor_id = new.a_motor_id;
update user set money_purchased = money_purchased + new.price where user_id = new.user_id;
end if;
end;
 
-- 8. trigger sau khi update user check_delete = deleted thì update luôn cột login_name = null
delimiter //
create trigger update_delete_user
after update on user
for each row
begin
if old.check_delete != "deleted" and new.check_delete = "deleted" then
update user set login_name = NULL where user_id = new.user_id;
end if;
end;

-- 9. trigger sau khi thêm một cột trong user thì phần role_id của cột đó sẽ tự set thành role_id có role_name = user
create trigger insert_user
after insert on user
for each row
update user set role_id = ( select role_id from role where role.role_name = "user") where user_id = new.user_id;








 




