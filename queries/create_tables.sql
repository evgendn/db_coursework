create table driver (
	id serial,
	full_name varchar(128) not null,
	birth_date date not null,
	driving_licence_number varchar(10),
	expire_date date not null,
	working boolean not null default(false),

	primary key(id),
	constraint uniq_licence_num unique(driving_licence_number),
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
	constraint uniq_licence_plate unique(license_plate),
	foreign key(car_model_id) references car_model(id) on delete cascade,
	foreign key(owner_id) references driver(id) on delete cascade
);

create table shift (
	id serial,
	driver_id int not null,
	cab_id int not null,
	shift_start_time time null,
	shift_finish_time time null,

	primary key(id),
	foreign key(driver_id) references driver(id) on delete cascade,
	foreign key(cab_id) references cab(id) on delete cascade
);

create type payment as enum (
	'cash', 'credit card');

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
	balance numeric(5, 2) default(0.0),

	primary key(id),
	constraint uniq_email unique(email),
	constraint uniq_credit_card_number unique(credit_card_number),
	constraint valid_balance check(balance >= 0.00)
	-- Не пашет регулярка в базе, в дебаггере норм работает!
	-- constraint ck_validate_email check (
	-- 	email ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
);

create table cab_ride (
	id serial,
	shift_id int null,
	customer_id int not null,
	ride_start_time timestamp null,
	ride_end_time timestamp null,
	address_starting_point text null,
	gps_starting_point text null,
	address_destination text null,
	gps_destination text null,
	canceled boolean,
	payment_type_id int not null,
	price numeric(5, 2) null,

	primary key(id),
	foreign key(shift_id) references shift(id) on delete cascade,
	foreign key(customer_id) references customer(id) on delete cascade,
	foreign key(payment_type_id) references payment_type(id),
	constraint valid_price check(price >= 0.00)
);

create table cab_ride_status (
	id serial,
	cab_ride_id int not null,
	status_id int not null,
	status_time timestamp default(current_timestamp),
	cc_agent_id int null,
	shift_id int null,
	status_details text null,

	primary key(id),
	foreign key(cab_ride_id) references cab_ride(id) on delete cascade,
	foreign key(status_id) references status(id) on delete cascade,
	foreign key(cc_agent_id) references cc_agent(id),
	foreign key(shift_id) references shift(id) on delete cascade
);
