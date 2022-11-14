Create database web_Sale_motorcycles;
Use web_Sale_motorcycles;

CREATE TABLE MOTORCYCLES(
	motors_id INT PRIMARY KEY,
	motors_name varchar(50) not null,
	version varchar(50) not null,
	motor_type varchar(50),
	branch varchar(50) not null,
    	style varchar(50),
    	quantity INT not null default 0,
    	motor_desc text,
    	check_sale ENUM('sale','stop sale') not null default 'sale',
    	constraint motors_id_name_ver unique(motors_id, motors_name, version)
);

CREATE TABLE A_MOTORCYCLE(
	a_motor_id INT PRIMARY KEY,
	motors_id INT not null,
	color varchar(20),
    	prepaid_price FLOAT,
    	price FLOAT,
    	date_insert datetime default current_timestamp,
    	date_update datetime,
	check_sold ENUM('sold','ordered','not sold yet') default 'not sold yet',
    	foreign key(motors_id) References MOTORCYCLES(motors_id)
);

CREATE TABLE SPECIFICATION(
	motors_id INT PRIMARY KEY,
	size varchar(20),
	mass_kg	FLOAT,
	saddle_height_cm FLOAT,
	rpm INT,
	engine_torque FLOAT,
	horse_power varchar(30),
	foreign key(motors_id) References MOTORCYCLES(motors_id)	
);

CREATE TABLE ROLE(
	role_id INT PRIMARY KEY,
	role_name varchar(50) unique,
	role_decs text
);

CREATE TABLE USER(
	user_id INT(5) zerofill PRIMARY KEY auto_increment ,
	role_id INT,
    	email varchar(50),
    	user_pass varchar(50) not null,
    	user_name varchar(50) not null,
    	cccd varchar(20),
    	num_phone varchar(20),
    	address varchar(100),
    	check_delete ENUM('still','deleted') default 'still',
	foreign key(role_id) References ROLE(role_id),
    	constraint email_check unique(email, check_delete)
);

CREATE TABLE BLOG(
	blog_id INT Primary key auto_increment,
	title text,
	body text, 
	date_write datetime default current_timestamp,
	date_update datetime
);

CREATE TABLE PAYMENT(
	payment_id INT(6) zerofill PRIMARY KEY auto_increment,
	user_id INT(5) zerofill,
	a_motor_id INT,
    	name_cus varchar(50),
    	cccd varchar(20),
    	date_buy datetime,
    	date_prepaid datetime,
    	money_prepaid float,
    	price FLOAT,
    	payment_menthod varchar(30),
    	status ENUM('not paid', 'paid', 'successful', 'cancel'),
	foreign key(a_motor_id) References A_MOTORCYCLE(a_motor_id),
    	foreign key(user_id) References USER(user_id)
);

CREATE TABLE COMMENT(
	 cmt_id INT(5) zerofill PRIMARY KEY auto_increment,
	 blog_id INT not null,
	 parent_id INT not null,
	 user_id INT(5) zerofill not null,
	 date_cmt datetime default current_timestamp,
	 cmt_desc text,
	 foreign key(blog_id) References BLOG(blog_id),
	 foreign key(user_id) References USER(user_id)
);

