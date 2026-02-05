CREATE DATABASE RaamatIvanov;
use RaamatIvanov;
--TABELI ZANR LOOMINE--
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(50) not Null,
krijeldus TEXT);
Select * from zanr;
--TABELI TÄITMINE
INSERT INTO zanr(zanrNimetus,krijeldus)
values ('luule', 'see on luule zanr'),
('ilukirjandus', 'see on ilukirjandus zanr'),
('komöödia', ' lõbus'),
('tragöödia', 'kurb zanr')
--TABEL AUTOR
CREATE TABLE autor(
autorID int PRIMARY KEY identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
synniaasta int check(synniaasta > 1900),
elukoht varchar(30)
);
select * from autor;
insert into autor(eesnimi, perenimi, synniaasta)
values ('Jane','Austen', 1956),
--Tabeli uuendamine
Update autor set elukoht = 'Tallinn';
--Kutsutamine tabelist 
delete from autor where autorID=1;

--TABEL RAAMAT
CREATE TABLE raamat(
raamatID int PRIMARY KEY identity(1,1),
raamatuNimetus varchar(100) unique,
lk int,
autorID int,
foreign key (autorID) references autor(autorID),
zanrID int,
foreign key (zanrID) references zanr(zanrID)
);

insert into raamat (raamatuNimetus, lk, autorID, zanrID)
VALUES ('Armastus vihma all', 200, 1, 1);
SELECT * FROM raamat;
Select * from autor;
Select * from zanr;

create table trykikoda(
trykikodaID int primary key identity(1,1),
nimetus varchar(20) not null,
aadress varchar(50) not null
);
insert into trykikoda(nimetus,aadress)
values ('Tallinna Trükikoda','Pärnu mnt 12, Tallinn'),
('Põhja Print', 'Tartu mnt 45'),
('Vikerkaar Trükk', 'Riia 8, Tartu')
select * from trykikoda;
drop table trykikoda;

create table trykitudRaamat(
trRaamatID int primary key identity(1,1),
trykikodaID int,
foreign key (trykikodaID) references trykikoda(trykikodaID),
raamatID int,
foreign key (raamatID) references raamat(raamatID)
);
select * from trykitudRaamat;
