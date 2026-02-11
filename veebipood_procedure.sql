create database VebPoodIvanov;
use VebPoodIvanov;

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
insert into brands(brand_name)
values ('GJFDFD');

--Categories loomine
insert into categories(categoryname)
values ('T-särk'),('mantel'),('pusa'),('pintsak');
select * from categories;

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
insert into products (product_name, brandsID, categoryID, model_year, list_price)
values('särk', 1, 1, 2023, 25.20);

select * from products;
select * from categories;
select * from brands;

update categories set categoryname='kingad'
where categoryID = 2;

--procedure mis lisab insert andmeid tabelisse brands
create procedure lisaBrand
@brand_name varchar(30)
as
begin
insert into brands(brand_name)
values (@brand_name);
select * from brands;
end;

--procedure käivitus / kutse
exec lisaBrand 'ghkg';

--procedure mis kustutab delete tabelist id järgi
create procedure kustutaBrand
@id int
as
begin
select * from brands;
delete from brands where brandsID = @id;
select * from brands;
end;

--kutse
exec kustutaBrand 4;
--procedure mis otsib brandinimi 1 tähte järgi
create procedure otsing1tahte
@taht char(1)
as
begin
select * from brands where brand_name like @taht+'%';
end;
--kutse
exec otsing1tahte g;

--procedure mis uuendab UPDATE brandinimi id järgi
create procedure uuendabrand
@id int,
@uus_brandNimi varchar(30)
as
begin
select * from brands;
update brands set brand_name = @uus_brandNimi
where brandsID=@id;
select * from brands
end;
--kutse
exec uuendabrand 3, 'jhgk' 

  
  --iseseisev 
  
--1. lisamine

create procedure lisaCategory
@categoryname varchar(35)
as
begin
insert into categories(categoryname)
values(@categoryname)
select * from categories;
end;

exec lisaCategory 'särk'

--2. uuendamine
create procedure uendadaCategory
@id int,
@uus_categoyNimi varchar(30)
as
begin
update categories set categoryname = @uus_categoyNimi
where categoryID = @id;
select * from categories;
end;
drop procedure uendadaCategory

exec uendadaCategory 3, 'ddsds'

--3. kustutamine
create procedure kustutaCategory
@id int
as
begin
select * from categories;
delete from categories where categoryID = @id;
select * from categories;
end;

exec kustutaCategory 3;
