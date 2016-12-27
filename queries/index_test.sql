drop table test_shit_cab_rides;

create table test_cab_rides (
	id serial,
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
	price numeric(4, 2) null,

	primary key(id),
	foreign key(shift_id) references shift(id),
	foreign key(customer_id) references customer(id),
	foreign key(payment_type_id) references payment_type(id)
);

insert into test_cab_rides (
		shift_id,
		customer_id,
		canceled,
		payment_type_id,
		price
	) select i, i, false, 1, 40.00
		from generate_series(0, 999999) as i;


drop table test_cab_ride_status;

create table test_cab_ride_status (
	id serial,
	cab_ride_id int not null,
	status_id int not null,
	status_time timestamp default(current_timestamp),
	cc_agent_id int null,
	shift_id int null,
	status_details text null,

	primary key(id),
	foreign key(cab_ride_id) references cab_ride(id),
	foreign key(status_id) references status(id),
	foreign key(cc_agent_id) references cc_agent(id),
	foreign key(shift_id) references shift(id)
);


insert into test_cab_ride_status (
		cab_ride_id,
		status_id,
		cc_agent_id,
		shift_id,
		status_details
	) select 1, 2, 1, 3, i::text
		from generate_series(0, 999999) as i;


-- Индексы будут далее.

