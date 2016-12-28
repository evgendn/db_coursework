insert into driver (
		full_name,
		birth_date,
		driving_licence_number,
		expire_date,
		working
	) values
		('John Doe', '1985-07-10', '10ej38ru82', '2018-10-01', true),
		('Jerald Broflovski', '1970-12-04', '13ks02lmsu', '2021-12-24', true),
		('Alex King', '1964-04-18', 'jdyu492nx8', '2018-07-14', true),
		('Sam Ganji', '1978-08-23', '7yhj03jsl4', '2017-03-26', true),
		('Victor Reznov', '1983-03-03', 'aj37nsi3m3', '2019-06-12', true),
		('Aizek Clark', '1992-06-11', '10ej38ur38', '2020-05-22', true),
		('Matt Preston', '1987-03-01', 'djr392ms90', '2016-11-03', true),
		('Cir Brick', '1987-10-05', 'kjdf034nkd', '2016-12-12', true),
		('Sir Dumb', '1987-12-27', '93jdf0rfls', '2015-03-03', true);


insert into car_model (
		model_name,
		model_description
	) values
		('Ford focus', 'blue'),
		('Toyota prius', 'San-Francisco Sticker'),
		('Ford focus', 'blue'),
		('BMW cabrio', 'cabriolet'),
		('HAMMER', 'with stupid back label'),
		('Tesla', ''),
		('Mustang', 'green'),
		('Audi x5', 'red');


insert into cab (
		license_plate,
		car_model_id,
		owner_id,
		active
	) values 
		('23jj2f', 3, 2, true),
		('90er4b', 2, 2, true),
		('u73ns0', 4, 4, true),
		('snj30j', 6, 5, true),
		('nz30m3', 8, 6, false);


insert into shift (
		driver_id, 
		cab_id,
		shift_start_time,
		shift_finish_time
	) values
		(4, 3, '09:00:00', '17:30:00'),
		(2, 1, '12:00:00', '20:00:00'),
		(6, 5, '01:30:00', '08:45:00'),
		(6, 5, '07:00:00', '15:00:00'),
		(5, 4, '10:00:00', '13:00:00');


insert into payment_type (
		type_name
	) values 
		('cash'),
		('credit card');


insert into cc_agent (
		first_name,
		last_name
	) values 
		('Bob', 'Burnwood'),
		('Anton', 'MacGee'),
		('Jason', 'Lee'),
		('Frank', 'Corn'),
		('Matt', 'Stone');


insert into status (
		status_name
	) values
		('new'),
		('assigned'),
		('started'),
		('ended'),
		('canceled');


insert into customer (
		email,
		password,
		credit_card_number, 
		balance
	) values
		('qwer2020@mail.com', 'ksdhbfbsldkfe', '1111111111111111', 50.00),
		('sadmanhello@mail.com', 'akkhhej394mld', '2222222222222222', 200.00),
		('candy93@mail.com', '324nsadlij465', '3333333333333333', 150.00),
		('house13@ya.com', 'ndfjdfdflkj91', '4444444444444444', 0.00),
		('alex@ml.com', 'drnejflicjdlr', '5555555555555555', 0.00),
		('updown@mail.com', 'n43od94nkc904', '6666666666666666', 623.00),
		('setlink@mail.com', 'nklfjh93no40e', '7777777777777777', 27.0),
		('dleknr@mail.com', '34lji@34we534', '8888888888888888', 483.23),
		('summer@gmail.com', '4jbf9503kck30', '9999999999999999', 343.20);


insert into cab_ride (
		shift_id,
		customer_id,
		ride_start_time,
		ride_end_time,
		address_starting_point,
		gps_starting_point,
		address_destination,
		gps_destination,
		canceled,
		payment_type_id,
		price
	) values
		(1, 3, '2016-11-10 12:53:42', '2016-11-10 13:15:34',
			'linkoln 14th', '239082403872', 
			'marystreet 83th', '232324872643',
			false, 1, '15'),

		(2, 1, '2016-09-12 03:05:42', '2016-09-12 03:45:34',
			'subway 93th', '934834035544', 
			'brooklin str 83th', '9495029203',
			false, 2, '35'),

		(3, 3, '2016-12-05 12:53:42', '2016-12-05 13:15:34',
			'marystreet 83th', '232324872643', 
			'linkoln 14th', '239082403872',
			false, 1, '15'),

		(4, 5, '2016-10-21 20:23:42', '2016-10-21 20:52:34',
			'greenbay 98th', '485064058956', 
			'broadway 3th', '187239834094',
			true, 2, '32'),

		(5, 9, '2016-11-29 21:53:42', '2016-11-29 22:13:34',
			'redcapes 34th', '342343403872', 
			'marystreet 83th', '232324872643',
			false, 2, '8');


insert into cab_ride_status (
		cab_ride_id,
		status_id,
		status_time,
		cc_agent_id,
		shift_id,
		status_details
	) values 
		(1, 3, '2016-11-10 12:53:42', 5, 1, ''),
		(2, 1, '2016-09-12 02:55:12', 4, 2, '3 person'),
		(3, 2, '2016-12-05 12:49:31', 3, 3, ''),
		(4, 5, '2016-10-21 20:52:34', 2, 4, 'drunk customer'),
		(5, 4, '2016-11-29 22:13:34', 1, 5, 'ok');
