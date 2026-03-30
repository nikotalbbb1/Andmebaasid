create database ivanovPraktibaas
use ivanovPraktibaas



CREATE TABLE firma(
    firmaID INT NOT NULL PRIMARY KEY identity(1,1),
    firmanimi VARCHAR(20),
    aadress VARCHAR(20),
    telefon VARCHAR(20)
);

create table praktikajuhendaja(
praktikajuhendajaID int primary key identity(1,1),
eesnimi varchar(20),
perekonnanimi varchar(20),
synniaeg date,
telefon char(11));
CREATE TABLE praktikabaas(
    praktikabaasID INT NOT NULL PRIMARY KEY identity(1,1),
    firmaID INT,
    praktikatingimused VARCHAR(20),
    arvutiprogramm VARCHAR(20),
    juhendajaID INT,
    FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
    FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

INSERT INTO firma (firmanimi, aadress, telefon) VALUES
('TechSolutions OÜ', 'Tartu mnt 15', '+372 5551 2345'),
('Baltic IT Group', 'Liivalaia 22', '+372 5562 3456'),
('DigiAgentuur AS', 'Pärnu mnt 8', '+372 5573 4567'),
('SmartCode OÜ',    'Narva mnt 31', '+372 5584 5678'),
('DataPro Estonia',  'Viru väljak 4', '+372 5595 6789');

-- tabeli praktikajuhendaja loomine
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) VALUES
('Mart',    'Tamm',     '1985-03-12', '37255512345'),
('Liis',    'Kask',     '1990-07-25', '37255623456'),
('Jaan',    'Mägi',     '1978-11-03', '37255734567'),
('Anna',    'Rebane',   '1992-05-18', '37255845678'),
('Peeter',  'Ojaots',   '1983-09-30', '37255956789');

-- tabeli praktikabaas loomine
INSERT INTO praktikabaas (firmaID, praktikatingimused, arvutiprogramm, juhendajaID) VALUES
(1, 'Täiskoormus',   'Microsoft Office', 1),
(2, 'Osaline koormus', '1C Raamatupidamine', 2),
(3, 'Kaugpraktika',  'Adobe Creative',   3),
(4, 'Täiskoormus',   'AutoCAD',          4),
(5, 'Paindlik aeg',  'Python/Django',    5);

SELECT * FROM firma
WHERE firmanimi LIKE '%a%';

SELECT *
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
ORDER BY firmanimi;

SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;


SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) = 9 
   OR MONTH(synniaeg) = 10 
   OR MONTH(synniaeg) = 11;

alter table praktikajuhendaja add  praktikakohtadearv int
   UPDATE praktikajuhendaja SET praktikakohtadearv = 5 WHERE praktikajuhendajaID = 1;
UPDATE praktikajuhendaja SET praktikakohtadearv = 3 WHERE praktikajuhendajaID = 2;
UPDATE praktikajuhendaja SET praktikakohtadearv = 7 WHERE praktikajuhendajaID = 3;
UPDATE praktikajuhendaja SET praktikakohtadearv = 4 WHERE praktikajuhendajaID = 4;
UPDATE praktikajuhendaja SET praktikakohtadearv = 6 WHERE praktikajuhendajaID = 5;







--Veeru palk lisamine ja loomine
alter table praktikajuhendaja add  palk float
UPDATE praktikajuhendaja SET palk = 2500.00 WHERE praktikajuhendajaID = 1;
UPDATE praktikajuhendaja SET palk = 1800.50 WHERE praktikajuhendajaID = 2;
UPDATE praktikajuhendaja SET palk = 3200.75 WHERE praktikajuhendajaID = 3;
UPDATE praktikajuhendaja SET palk = 2100.00 WHERE praktikajuhendajaID = 4;
UPDATE praktikajuhendaja SET palk = 2750.25 WHERE praktikajuhendajaID = 5;


--keskmine palk
select AVG(palk) as keskmine from praktikajuhendaja

summa
select SUM(palk) as kokku from praktikajuhendaja

--ise paring, kuvab kõik inimsed kellel nimel on täht s või perekonnanimel d
select eesnimi, perekonnanimi from praktikajuhendaja where eesnimi like '%s%' or perekonnanimi like '%d%'



CREATE VIEW firma_praktikakohtade_arv AS
SELECT f.firmanimi, p.praktikakohtadearv
FROM firma f, praktikajuhendaja p, praktikabaas pb
WHERE pb.firmaID = f.firmaID AND pb.juhendajaID = p.praktikajuhendajaID;

CREATE VIEW sugisel_sundinud_juhendajad AS
SELECT eesnimi, perekonnanimi, synniaeg
FROM praktikajuhendaja
WHERE MONTH(synniaeg) BETWEEN 9 AND 11;

--1. protseduur
create procedure lisaNimi
@juhendaja_nimi varchar(30),
@juhendaja_perenimi varchar(30)
as
begin
insert into praktikajuhendaja(eesnimi,perekonnanimi)
values (@juhendaja_nimi, @juhendaja_perenimi);
select * from praktikajuhendaja;
end;

exec lisaNimi 'test','test'
select * from praktikajuhendaja

--2. protseduur
create procedure muuda
@valik varchar(20),
@tabeli_nimi varchar(25),
@veeru_nimi varchar(25),
@tyyp varchar(20)=null
as
begin
     declare @sql as varchar(max)
     set @sql=case
     when @valik='add' then 
     concat('alter table ', @tabeli_nimi, ' add ', @veeru_nimi, ' ', @tyyp)
     when @valik='drop' then
     concat('alter table ', @tabeli_nimi, ' drop column ', @veeru_nimi)
	 end;
     print @sql;
     begin
     exec(@sql);
     end;
end;
exec muuda 'add','firma','test','char(13)'
select * from firma

--3. protseduur 
create procedure keskminePalk
as
begin
select AVG(palk) from praktikajuhendaja
end;
exec keskminePalk


create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB
		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(GETDATE())) or (MONTH(@DOB)
		= month (getdate()) and day(@DOB) > DAY(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)
		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(MONTH, @months, @tempdate)
		select @days = datediff(day, @tempdate, getdate())
	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + 
		' Months ' + cast(@days as nvarchar(2)) + ' Days old'
	return @Age
end

select eesnimi,perekonnanimi,synniaeg,dbo.fnComputeAge(synniaeg)
from praktikajuhendaja
