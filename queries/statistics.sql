-- 1. Топ-3 водителя, которые работали больше всего.

drop function top_3_workers();

create or replace function top_3_workers()
	returns setof record as $$
	select d.full_name, count(t.driver_id) as cnt
  		from (
    		select *
      			from cab_ride as cr
        		join shift as s on s.id = cr.shift_id
    		) as t
  		join driver as d on t.driver_id = d.id 
  		group by d.full_name
           		,t.driver_id
  		order by d.full_name, 
  				t.driver_id desc
  		limit 3;
$$ language sql;

select top_3_workers();

-- 2. Вывод отношения отмены заказов к количеству заказов в период времени. 

drop function get_cancel_ratio();

create or replace function get_cancel_ratio()
	returns float as $$
declare
	canceled_id integer;
	number_of_canceled integer;
	total_number integer;
begin
		select id from status
			where status_name = 'canceled' into canceled_id;
		select count(id) from cab_ride_status 
          	where status_id = canceled_id into number_of_canceled;
		select count(*) from cab_ride into total_number;

		return (number_of_canceled / total_number::float);
end;
$$ language plpgsql;

select get_cancel_ratio();


3. Вывод полной информации о водителе при вводе имени.

drop function get_full_information(name varchar);

create or replace function get_full_information(name varchar)
	returns setof record as $$
	select dr.id, dr.full_name, 
		   dr.birth_date, dr.driving_licence_number, 
		   dr.expire_date, dr.working, 
		   cm.model_name, sh.shift_start_time,
		   sh.shift_finish_time 
		from driver as dr
		left join cab on (dr.id = cab.owner_id)
		left join car_model as cm on (cm.id = cab.car_model_id)
		left join shift as sh on (dr.id = sh.driver_id)
			where dr.full_name = name; 
$$ language sql;

select get_full_information('Jerald Broflovski');

