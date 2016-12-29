-- 1. Функция создания статусов поездки.

drop function  create_cab_ride_status(
		cab_ride_id_ integer,
		status_id_ integer,
		cc_agent_id_ integer,
		shift_id_ integer,
		status_details_ text
	);

create or replace function create_cab_ride_status(
		cab_ride_id_ integer,
		status_id_ integer,
		cc_agent_id_ integer,
		shift_id_ integer,
		status_details_ text
	)
	returns void 
as $$
	insert into cab_ride_status (
			cab_ride_id,
			status_id,
			cc_agent_id,
			shift_id,
			status_details
		) values 
			(cab_ride_id_, status_id_, cc_agent_id_, shift_id_, status_details_);
$$ language sql;


-- select create_cab_ride_status(3=, 4, 3, 3, 'function is working');


-- 2. Функция проверки истечения срока действия 
-- водительской лицензии и замены поля working 
-- на false в случае просроченной лицензии.

drop function check_expire_date_on_valid();

create or replace function check_expire_date_on_valid()
	returns integer 
as $$
declare
	number_of_expiry integer;
begin

	select count(*) from driver
		where expire_date < current_date into number_of_expiry; 

	update driver 
		set working = false
	where expire_date < current_date;

	return number_of_expiry;
end;
$$ language plpgsql; 

-- select check_expire_date_on_valid();

