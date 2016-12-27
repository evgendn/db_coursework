
drop table logs;

create table logs (
	id serial,
	table_name varchar(25),
	last_operation varchar(25),
	trigger_name varchar(50),
	when_happen varchar(25),
	datetime timestamp default(current_timestamp)
);


-- Данный триггер должен сработать, когда 
-- введенная дата лицензии водителя уже просрочена, тогда
-- поднимается уведомление.



drop function check_expire_date() cascade;

create or replace function check_expire_date() 
	returns trigger as $$
begin
	if new.expire_date < current_date then
		insert into logs (table_name, last_operation, trigger_name, when_happen) 
			values (tg_table_name, tg_op, tg_name, tg_when);
		raise notice 'Bad expire date, check logs table.';								
	end if;
	return new;
end;
$$ language plpgsql;

create trigger check_expire_date
before insert or update
	on driver for each row execute procedure check_expire_date();


-- После удаления модели машины информация заносится в logs.

drop function insert_about_delete();

create or replace function insert_about_delete()
	returns trigger as $$
begin
	insert into logs (table_name, last_operation, trigger_name, when_happen)
		values (tg_table_name, tg_op, tg_name, tg_when);
	raise notice 'The car was deleted, check logs table';
	return old;
end;
$$ language plpgsql;

create trigger insert_about_delete
before delete 
	on car_model execute procedure insert_about_delete();


-- После добавления статуса поездки - ended 
-- происходит списание цены за поездку  
-- с баланаса покупателя.

drop function meet_bill();

create trigger meet_bill
before insert
	on cab_ride_status execute procedure meet_bill();

create or replace procedure meet_bill()
	returns trigger as $$
	if new.status_id = select id from status 
							where status_name = 'canceled'
		and  then
		update customer as c
			set balance = customer.balance - cr.price
			from cab_ride
				where   
	end if;

$$ language plpgsql;


select cr.id, cr.customer_id, cr.price, crs.status_id 
	from cab_ride as cr 
	left join cab_ride_status as crs 
		on (crs.cab_ride_id = cr.id);
