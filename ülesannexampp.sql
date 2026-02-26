--ülesanne
--SQL MANAGER 

--category tabel
create table  Category(
category_id int primary key identity(1,1),
category_name varchar(20));

--product tabel
create table Products(
product_id int primary key identity(1,1),
product_name varchar(25) unique,
category_id int,
foreign key (category_id) references Category(category_id),
price float not null);


--Sale tabel
create table Sale(
sale_id int primary key identity(1,1),
product_id int,
foreign key (product_id) references Products(product_id),
idCustomer int,
Count_pr char(2) not null,
Date_of_sale date);

--Sale lisamine
select * from Sale
alter table Sale add  Units varchar(20);
select * from Sale

--XAMPP
create table  Category(
category_id int primary key AUTO_INCREMENT,
category_name varchar(20));

create table Products(
product_id int primary key AUTO_INCREMENT,
product_name varchar(25) unique,
category_id int,
foreign key (category_id) references Category(category_id),
price float not null);

create table Sale(
sale_id int primary key AUTO_INCREMENT,
product_id int,
foreign key (product_id) references Products(product_id),
idCustomer int,
Count_pr char(2) not null,
Date_of_sale date);
