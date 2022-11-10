Use web_Sale_motorcycles;

-- 1. trigger tự tạo 1 row mới trong bảng specification khi tạo 1 row mới trong bảng motorcycles
create trigger new_spec 
after insert on motorcycles
for each row
insert into specification (motors_id) values ( NEW.motors_id);


-- 2. trigger tự set attribute check_sold trong bảng a_motorcycle thành NULL nếu check_sale = stop sale trong bảng motorcycles, và trả về số lượng xe đó bằng 0 trogn bảng motorcycles
delimiter // 
create trigger after_update_check_sale
after update on motorcycles
for each row
begin
if old.check_sale != "stop sale" and NEW.check_sale = "stop sale" then
update a_motorcycle set check_sold = NULL where check_sold ="not sole yet" and motors_id = new.motors_id;
update motorcycles set quantity = 0 where motors_id = new.motors_id;
end if;
end;


-- 3. trigger sau khi insert 1 row mới trong a_motorcycle thì trong motorcycles phần quantity sẽ tự + thêm 1
create trigger after_insert_new_motor
after insert on a_motorcycle
for each row
update motorcycles set quantity = quantity+1 where motors_id = new.motors_id;


-- 4. trigger khi xóa 1 row trong a_motorcycle thì quantity tự -1 trong motorcycles
create trigger after_delete_a_motor
after delete on a_motorcycle
for each row
update motorcycles set quantity = quantity-1 where motors_id = old.motors_id;


-- 5. trigger sau khi update bảng a_motorcycle cột check_sold=sold thì trong bảng motorcycles cột quantity-1
-- 6. trigger sau khi update bảng a_motorcycle cột check_sold= not sold yet thì trong bảng motorcycles cột quantity+1
delimiter //
create trigger after_update_checksold_sold
after update on a_motorcycle
for each row
begin
if old.check_sold != new.check_sold and NEW.check_sold = "sold" then
update motorcycles set quantity = quantity-1 where motors_id = new.motors_id;

elseif old.check_sold != new.check_sold and NEW.check_sold = "not sold yet" then
update motorcycles set quantity = quantity+1 where motors_id = new.motors_id;
end if;
end;


-- 7. trigger sau khi insert user_id và a_motor_id vào bảng payment thì tự động thêm price
create trigger after_insert_payment
after insert on payment
for each row
update payment set price = (select price from a_motorcycle where a_motorcycle. a_motor_id = new.a_motor_id) where payment_id = new.payment_id;


-- 8. trigger sau khi update bảng payment status = notpaid hoặc paid, update bảng a_motocycle check_sold = ordered
-- 9. trigger sau khi update bảng payment status = successful, update bảng a_motocycle check_sold = sold
-- 10. trigger sau khi update bảng payment status = cancel, update bảng a_motocycle check_sold = not_sold_yet
delimiter //
create trigger update_status_payment
after update on payment
for each row
begin
if old.status != new.status and (new.status = "paid" or new.status = "not paid") then
update a_motorcycle set check_sold = "ordered" where a_motorcycle.a_motor_id = new.a_motor_id;

elseif old.status != new.status and new.status = "successful" then
update payment set date_buy = current_timestamp where payment_id = new.payment_id;
update a_motorcycle set check_sold = "sold" where a_motorcycle.a_motor_id = new.a_motor_id;

elseif old.status != new.status and new.status = "cancel" then
update a_motorcycle set check_sold = "not sold yet" where a_motorcycle.a_motor_id = new.a_motor_id;

end if;
end;


-- 11. trigger sau khi update money_prepaid của bảng payment thì xét xem giá trị nó lớn thế nào rồi set lại status là unpaid, prepaid, hay paid.
delimiter //
create trigger update_money_prepaid_payment
after update on payment
for each row
begin
if old.money_prepaid != new.money_prepaid then
if new.money_prepaid >= new.price then
update payment set status = "paid" where payment_id = new.payment_id;
else 
update payment set status = "not paid" where payment_id = new.payment_id;
end if;
end if;
end;
 
-- 12. trigger sau khi thêm một cột trong user thì phần role_id của cột đó sẽ tự set thành role_id có role_name = user
create trigger insert_user
after insert on user
for each row
update user set role_id = ( select role_id from role where role.role_name = "user") where user_id = new.user_id;

-- 13. Sau khi update a_motorcycle thì sẽ tự động set date_update bằng current_timestamp
delimiter // 
create trigger date_update_a_motorcycle
after update on a_motorcycle
for each row
begin
if old.date_update = new.date_update then
update a_motorcycle set date_update = current_timestamp() where date_insert = old.date_insert;
end if;
end;

-- 14. Sau khi update blog thì sữ tự động set date_update bằng curent_timestamp
delimiter // 
create trigger date_update_blog
after update on blog
for each row
begin
if old.date_update = new.date_update then
update a_motorcycle set date_update = current_timestamp() where date_write = old.date_write;
end if;
end;






 




