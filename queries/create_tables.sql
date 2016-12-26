create table driver (
	id serial,
	full_name varchar(128) not null,
	birth_date date not null,
	driving_licence_number varchar(10),
	expire_date date not null,
	working boolean not null default(false),

	primary key(id),
	constraint valid_licence_number check(
		driving_licence_number ~ '^([0-9]|[a-zA-Z]){10}$')
);

create table car_model (
	id serial,
	model_name varchar(25) not null,
	model_description text null,

	primary key (id)
);

create table cab (
	id serial,
	license_plate varchar(6) not null,
	car_model_id int not null,
	owner_id int null,
	active boolean not null default(false),

	primary key(id),
	foreign key(car_model_id) references car_model(id),
	foreign key(owner_id) references driver(id)
);

create table shift (
	id serial,
	driver_id int not null,
	cab_id int not null,
	shift_start_time time not null,
	shift_finish_time time not null,

	primary key(id),
	foreign key(driver_id) references driver(id),
	foreign key(cab_id) references cab(id)
);

create type payment as enum (
	'cash', 'credit card', 'bonuses');

create table payment_type (
	id serial,
	type_name payment not null,

	primary key(id)
);

-- Call center agent
create table cc_agent (
	id serial, 
	first_name varchar(25),
	last_name varchar(25),

	primary key(id),
	constraint valid_first_name check(
		first_name ~ '[a-zA-Z]+'),
	constraint valid_last_name check(
		last_name ~ '[a-zA-Z]+')
);

create type state as enum(
	'new', 'assigned', 'started', 'ended', 'canceled');

create table status (
	id serial,
	status_name state not null,

	primary key(id)
);

create table customer (
	id serial,
	email varchar(50) not null,
	password varchar(64) not null,
	credit_card_number varchar(16) null,

	primary key(id)
	-- Не пашет регулярка в базе, в дебаггере норм работает!
	-- constraint ck_validate_email check (
	-- 	email ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
);

create table cab_ride (
	id serial,
	shift_id int,
	customer_id int not null,
	ride_start_time time null,
	ride_end_time time null,
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

create table cab_ride_status (
	id serial,
	cab_ride_id int not null,
	status_id int not null,
	status_time time,
	cc_agent_id int null,
	shift_id int null,
	status_details text null,

	primary key(id),
	foreign key(cab_ride_id) references cab_ride(id),
	foreign key(status_id) references status(id),
	foreign key(cc_agent_id) references cc_agent(id),
	foreign key(shift_id) references shift(id)
);
