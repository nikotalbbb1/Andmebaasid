create database ArvesToo
use ArvesToo

create table Klient(
klient_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50));

create table Toode(
toote_id int primary key identity(1,1),
toote_nimi varchar(100),
uhikuhind numeric,
ühik varchar(2));

create table Ost(
ost_id int primary key identity(1,1),
foreign key (klient_id) references Klient(klient_id),
klient_id int,
foreign key (toote_id) references Toode(toote_id),
toote_id int);

grant select,update,insert on Ost to klientNimi
grant select,update,insert on Klient to klientNimi
deny update,insert,delete on Toode to klientNimi
grant select on Toode to klientNimi
deny alter  to klientNimi

create table logi(
Id int primary key identity(1,1),
kuupaev datetime,
sisestatudAndmed text,
kasutaja varchar(30));

create trigger OstUuendamine
on Ost
for update
as
insert into logi(kuupaev,sisestatudAndmed,kasutaja)
select 
getdate(), 
CONCAT('vana andmed : ', 'id :' , deleted.ost_id, ',', 'klient :' , k1.eesnimi, ',', 'toode :' , t1.toote_nimi,
' || uue andmed : ', 'id : ', inserted.ost_id, ',', 'klient : ' , k2.eesnimi, ',', 'toode :' , t2.toote_nimi),
SYSTEM_USER
from deleted
inner join inserted on deleted.ost_id=inserted.ost_id
inner join Klient k1 on deleted.klient_id=k1.klient_id
inner join Klient k2 on inserted.klient_id=k2.klient_id
inner join Toode t1 on deleted.toote_id=t1.toote_id
inner join Toode t2 on inserted.toote_id=t2.toote_id;

drop trigger OstUuendamine

create trigger OstLisamine
on Ost
for insert
as
insert into logi(kuupaev,sisestatudAndmed,kasutaja)
select 
getdate(), 
CONCAT('lisatud andmed :', 'klient : ', k2.eesnimi, ',', 'toode : ', t2.toote_nimi),
SYSTEM_USER
from inserted inner join Klient k2 on inserted.klient_id=k2.klient_id
inner join Toode t2 on inserted.toote_id=t2.toote_id;

INSERT INTO Toode (toote_nimi, uhikuhind, ühik)
VALUES
('Piim', 1.50, 'tk'),
('Leib', 2.20, 'tk'),
('Juust', 4.75, 'kg'),
('Õun', 3.10, 'kg'),
('Mahl', 2.80, 'l');

SELECT * FROM Klient;
SELECT * FROM Toode;
select * from logi

INSERT INTO Klient (eesnimi, perenimi)
VALUES
('Ivan', 'Petrov'),
('Anna', 'Smirnova'),
('Marek', 'Tamm'),
('Olga', 'Ivanova'),
('Jaan', 'Kask');

DENY SELECT,INSERT,DELETE,ALTER on logi to klientNimi

create procedure lisaKlient
@klient_nimi varchar(30)
as
begin
insert into Klient(eesnimi)
values (@klient_nimi);
select * from Klient;
end;

create procedure kustutaToode
@id int
as
begin
select * from Toode;
delete from Toode where toote_id = @id;
select * from Toode;
end;

create procedure Klient1tahte
@taht char(1)
as
begin
select * from Klient where eesnimi like @taht+'%';
end;
exec Klient1tahte 'j'

create view Vaade_Klient as
select klient_id, eesnimi, perenimi
from Klient;

select * from Vaade_Klient;

create view Vaade_Toode as
select toote_nimi, uhikuhind
from Toode;
select * from Vaade_Toode;

create view Vaade_OdavadTooted as
select toote_nimi, uhikuhind
from Toode
where uhikuhind < 3;

select * from Vaade_OdavadTooted;

