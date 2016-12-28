drop table test_cab_rides;

create table test_cab_rides (
	id int,
	shift_id int,
	customer_id int not null,
	ride_start_time timestamp null,
	ride_end_time timestamp null,
	address_starting_point text null,
	gps_starting_point text null,
	address_destination text null,
	gps_destination text null,
	canceled boolean,
	payment_type_id int not null,
	price numeric(4, 2) null
);

insert into test_cab_rides (
		id,
		shift_id,
		customer_id,
		canceled,
		payment_type_id,
		price
	) select i, random()*(100-1)+1, random()*(500-1)+1, false, 1, 40.00
		from generate_series(0, 999999) as i;

-- Без индексов.
select * from test_cab_rides; 
-- Время: 1129,458 мс.
select * from test_cab_rides where shift_id = 100; 
-- Время: 152,385 мс.

-- В postgres нету кластерных ключей как таковых
-- используется CLUSTER, которого нету в стандарте SQL.
create index index_id on test_cab_rides(id);
cluster test_cab_rides using index_id;

create index index_shift_id on test_cab_rides(shift_id);

-- С индексами.
select * from test_cab_rides; 
-- Время: 1050,400 мс.
select * from test_cab_rides where shift_id = 100; 
-- Время: 32,999 мс.
