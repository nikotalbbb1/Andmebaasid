CREATE DATABASE ivanovSQL;
use ivanovSQL;

--tabeli loomine
CREATE TABLE opilane(
opilaneID int primary key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) NOT null,
synniaeg date,
aadress TEXT,
kas_opib bit);
select * from opilane;
