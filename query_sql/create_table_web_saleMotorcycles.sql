Create database web_programing_database;
Use web_programing_database;

CREATE TABLE MOTORCYCLES(
	motors_id INT PRIMARY KEY,
	motors_name varchar(50) not null,
	version varchar(50) not null,
	motor_type varchar(50),
	branch varchar(50) not null,
    style varchar(50),
    quantity INT not null default 0,
    motor_desc text,
    prepaid_price FLOAT,
    price FLOAT,
    check_sale ENUM('sale','stop sale') not null default 'sale',
    constraint motors_id_name_ver unique(motors_id, motors_name, version)
);

CREATE TABLE A_MOTORCYCLE(
	a_motor_id INT PRIMARY KEY,
	motors_id INT not null,
	color varchar(20),
	check_sold ENUM('sold','not sold yet') default 'not sold yet',
    foreign key(motors_id) References 	MOTORCYCLES(motors_id)
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
    login_name varchar(30) unique not null,
    user_pass varchar(50) not null,
    user_name varchar(50) not null,
    num_phone INT,
    email varchar(50),
    address varchar(100),
    money_purchased INT default 0,
    check_delete ENUM('still','deleted') default 'still',
	foreign key(role_id) References ROLE(role_id)
);

CREATE TABLE BLOG(
	blog_id INT Primary key auto_increment,
	title text,
	body text, 
	date_write datetime not null default current_timestamp	
);

CREATE TABLE PAYMENT(
	payment_id INT(6) zerofill PRIMARY KEY auto_increment,
	user_id INT(5) zerofill not null,
	a_motor_id INT not null,
    date_buy datetime,
    price FLOAT,
    payment_menthod varchar(30),
    status ENUM('unpaid','prepaid','canceled','paid') default 'unpaid',
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

