-- Данный триггер должен сработать, когда 
-- введенная дата лицензии водителя уже просрочена, тогда
-- поднимается исключение.
drop table logs;
create table logs (
	id serial,
	table_name varchar(25),
	last_operation varchar(25),
	trigger_name varchar(50),
	when_happen varchar(25)
);

drop function check_expire_date() cascade;

create or replace function check_expire_date() 
	returns trigger as $exp_date$
begin
	if new.expire_date < current_date then
		insert into logs (table_name, last_operation, trigger_name, when_happen) 
			values (tg_table_name, tg_op, tg_name, tg_when);
		raise notice 'Bad expire date, check logs table.';								
	end if;
	return new;
end;
$exp_date$ language plpgsql;

create trigger check_expire_date
before insert or update
	on driver for each row execute procedure check_expire_date();