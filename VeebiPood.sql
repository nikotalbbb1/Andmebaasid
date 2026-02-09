create database veebipoodIvanov;
USE veebipoodIvanov;
--CATEGORIES
create table categories(
categoryID INT PRIMARY KEY IDENTITY(1,1),
categoryname varchar(50) not null
);
--Brands
create table brands(
brandsID int primary key identity(1,1),
brand_name varchar(50) unique
);
--Categories loomine
insert into categories(categoryname)
values ('T-särk'),('mantel'),('pusa'),('pintsak');
select * from categories;
--Brands loomine
insert into brands(brand_name)
values ('nike'),('adidas'),('gfg'),('fdfdf');
select * from brands;
--tabel products
create table products(
productid int primary key identity(1,1),
product_name varchar(50) not null,
brandsID int,
foreign key (brandsID) references brands(brandsID),
categoryID int,
foreign key (categoryID) references categories(categoryID),
model_year int,
list_price decimal(7,2)
);
select * from products;
drop table products;


alter table products add constraint fk_brand
foreign key (brandsID) references brands(brandsID);
--tabel stocks
create table stocks(
store_id int,
productid int,
quantity int,
primary key(store_id,productid),
foreign key (productid) references products(productid)
);
drop table stocks
--Stores table
create table stores(
store_id int primary key identity(1,1),
store_name varchar(50),
 phone int,
email varchar(50),
street varchar(50),
city varchar(20),
state_name varchar(20),
zip_code char(5)
);
insert into stores(store_name, phone, city, zip_code)
values ('Adidas', '4576767', 'Tallinn', '46767');

select * from stores;

--Orders customers
create table customers(
customer_id int primary key identity (1,1),
first_name varchar(20) not null,
last_name varchar(20) not null,
phone int,
email varchar(30),
street varchar(30),
city varchar(30),
stateName varchar(30),
zip_code char(5)
);
drop table customers
--staffs table
create table staffs(
staff_id int primary key identity(1,1),
first_name varchar(17),
last_name varchar(25),
email1 varchar(30),
phone1 int,
active bit,
store_id int,
manager_id int,
foreign key (store_id) references stores(store_id)
);
drop table staffs
--order items table
create table order_items(
item_id int primary key identity(1,1),
productid int,
foreign key (productid) references products(productid),
orderid int,
foreign key (orderid) references orders(orderid),
quantity int,
list_price decimal(4,2),
discount bit);

drop table order_items

--orders table
create table orders(
orderid int primary key identity(1,1),
customer_id int,
foreign key (customer_id) references customers(customer_id),
order_status varchar(30) check(order_status = 'valmis' or order_status = 'töötlemisel'),
order_date date,
shipped_date date,
store_id int,
foreign key (store_id) references stores(store_id),
staff_id int,
foreign key (staff_id) references staffs(staff_id)
);

drop table orders

alter table stocks add constraint fk_store
foreign key (store_id) references stores(store_id);
