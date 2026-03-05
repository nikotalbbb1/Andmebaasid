create database selectIvanov;
use selectIvanov;

--mockaroo.com - andmete genereerimiseks
create table auto (
	auto_id INT PRIMARY KEY,
	auto_number CHAR(6) NOT NULL,
	mark VARCHAR(50) NOT NULL,
	muudel VARCHAR(50),
	varv VARCHAR(50),
	v_aasta INT
);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (1, 'ET2424', 'Volkswagen', 'Fox', 'Violet', 1989);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (2, 'CX5539', 'Volvo', 'C30', 'Aquamarine', 2008);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (3, 'EK8832', 'GMC', 'Savana 3500', 'Turquoise', 2004);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (4, 'IB2915', 'Eagle', 'Talon', 'Indigo', 1993);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (5, 'AC9050', 'Chevrolet', 'Impala SS', 'Khaki', 1994);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (6, 'LA3944', 'Ford', 'Mustang', 'Goldenrod', 1970);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (7, 'AF6795', 'Volkswagen', 'Eurovan', 'Crimson', 1994);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (8, 'CX8450', 'Subaru', 'XT', 'Purple', 1987);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (9, 'UA4308', 'Rambler', 'Classic', 'Mauv', 1963);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (10, 'AM7841', 'Nissan', '300ZX', 'Khaki', 1993);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (11, 'AC9935', 'Mercedes-Benz', 'CL-Class', 'Blue', 1999);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (12, 'QF1329', 'BMW', 'Z3', 'Indigo', 1999);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (13, 'QF7612', 'Dodge', 'Dakota Club', 'Maroon', 2007);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (14, 'AC5567', 'Lamborghini', 'Aventador', 'Teal', 2012);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (15, 'LH4956', 'Mitsubishi', 'Precis', 'Maroon', 1992);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (16, 'NZ7014', 'BMW', 'X6', 'Yellow', 2010);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (17, 'AM2018', 'BMW', 'M3', 'Purple', 2008);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (18, 'TG6258', 'Ford', 'Taurus', 'Pink', 1986);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (19, 'SQ8074', 'Ford', 'Probe', 'Goldenrod', 1997);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (20, 'NZ1689', 'Audi', '80/90', 'Fuscia', 1988);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (21, 'AM5718', 'Volkswagen', 'Golf', 'Orange', 1988);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (22, 'BA3590', 'Mercedes-Benz', '300SL', 'Yellow', 1992);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (23, 'QR5213', 'Hyundai', 'Scoupe', 'Orange', 1994);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (24, 'SQ6766', 'Mercedes-Benz', 'GLK-Class', 'Mauv', 2010);
insert into auto (auto_id, auto_number, mark, muudel, varv, v_aasta) values (25, 'AZ7021', 'Buick', 'Century', 'Fuscia', 1997);

SELECT * FROM auto;

--andmete sorterimine 
--kasvavas järjekorras
select * from auto
ORDER BY v_aasta;
--kahanevas järjekorras
select * from auto
order by v_aasta desc;

--kuvab ainult  kaks veergu
Select mark, muudel from auto;

--kordavate väärtuste välistamine DISTINCT
SELECT DISTINCT mark from auto;

--võrdlemine
--1. suurem kui > , väiksem kui <, võrdub =
--leia kõik autod, kus on v_aasta 2000 peale
select mark, muudel, v_aasta from auto where v_aasta>=2000;

--leia kõik autod mis on v_aasta vahemikus 2000-2005
select mark, muudel, v_aasta from auto where v_aasta between 2000 and 2005;

--2. võrdlemine tekst või sümbooliga
--kuvab kõik ford'i autod
select mark, muudel, v_aasta from auto where mark like 'Ford';
--IN lause vastavus loetelus - соответствие перечислению
select mark, muudel, v_aasta from auto where mark in ('Ford', 'Nissan', 'Jeep');

--ilma IN
select mark, muudel, v_aasta from auto where mark like 'Ford' or mark like 'Nissan' or mark like 'Jeep';

--vastavus mustrile - шаблон
--algab F tähtega
select mark, muudel, v_aasta from auto where mark like 'F%';

--lõpeb p -tähega
select mark, muudel, v_aasta from auto where mark like '%p';

--sisaldab a-täht
select mark, muudel, v_aasta from auto where mark like '%a%';

--kuvada esimest 5 mudeli
select TOP 5 muudel, varv from auto
where varv like 'Yellow'
order by varv;

--agregaat funktsioonid: SUM, MIN, MAX, AVG, COUNT
SELECT COUNT(*) as autode_arv FROM auto;
select max(v_aasta) as suurem_aasta from auto;

--keerulisem variant 
select mark, AVG(v_aasta) as keskmine_aasta from auto group by mark;




