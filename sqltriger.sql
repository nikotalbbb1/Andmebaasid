create database trigerIvanov
use trigerIvanov
--tabel linnad
create table linnad(
linnId int primary key identity(1,1),
linnaNimi varchar(50) unique,
rahvaarv int);
--tabel logi
create table logi(
Id int primary key identity(1,1),
kuupaev datetime,
andmed text);

--Insert Triger
create trigger linnaLisamine
on linnad
for insert
as
insert into logi(kuupaev,andmed)
select 
getdate(), inserted.linnaNimi
from inserted;
--kontrollimiseks tuleb lisada uus linn tabelisse linnad
insert into linnad(linnaNimi,rahvaarv)
values('Tallinn', 600000);
select * from linnad;
select * from logi;

--kustutame triger
drop trigger linnaLisamine


create trigger linnaLisamine
on linnad
for insert
as
insert into logi(kuupaev,andmed)
select 
getdate(), 
concat('lisatud linn: ', inserted.linnaNimi, ' | rahvaarv: ',inserted.rahvaarv, ' | id: ', inserted.linnId)
from inserted;

insert into linnad(linnaNimi,rahvaarv)
values('test6', 10200);
select * from linnad;
select * from logi;

--DELETE TRIGGER
create trigger linnaKustutamine
on linnad
for delete
as
insert into logi(kuupaev,andmed)
select 
getdate(), 
concat('kustutatud linn: ', deleted.linnaNimi, ' | rahvaarv: ', deleted.rahvaarv, ' | id: ', deleted.linnId)
from deleted;

delete from linnad where linnId=4;

select * from linnad;
select * from logi;

--UPDATE TRIGGER
create trigger linnaUuendamine
on linnad
for update
as
insert into logi(kuupaev,andmed)
select 
getdate(), 
concat('vana linna andmed: ', d.linnaNimi, ' | rahvaarv: ', d.rahvaarv, ' | id: ', d.linnId, 
' uued linna andmed: ', i.linnaNimi, ' | rahvaarv: ', i.rahvaarv, ' | id: ', i.linnId)
from deleted d inner join inserted i 
on d.linnId=i.linnId;
drop trigger linnaUuendamine
--kontrollimiseks uuendame linna andmed
select * from linnad
update linnad set linnaNimi='Tapa uus4', rahvaarv=22
where linnId=6;
select * from linnad
select * from logi

--lisame kasutajaNimi logi tabelisse
alter table logi add kasutaja varchar(40);
