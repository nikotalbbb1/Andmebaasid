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
andmed text,
kasutaja varchar(30));

create table maakonnad(
maakondId int primary key identity(1,1),
maakondNimi varchar(25) unique);

--foreign key tabelis linnad
alter table linnad add maakondId int;
select*from linnad

alter table linnad add constraint fk_maakond
foreign key (maakondId) references maakonnad(maakondId)
--täidame tabelit
insert into maakonnad
values('Harjumaa'),('Pärnumaa'), ('Virumaa');
select * from maakonnad

insert into linnad(linnaNimi,rahvaarv,maakondId)
Values('Tallinn',600000,1),('Rakvere',50000,3);

select*from linnad,maakonnad where linnad.maakondId=maakonnad.maakondId
--inner join
select * from linnad inner join maakonnad on linnad.maakondId=maakonnad.maakondId;

--Triger mis jälgib kaks seostatud tabelit 
create trigger linnaLisamine
on linnad
for insert
as
insert into logi(kuupaev,andmed,kasutaja)
select 
getdate(), 
CONCAT('lisatud linn :', inserted.linnaNimi, ',', inserted.rahvaarv, ',', m.maakondNimi),
SYSTEM_USER
from inserted inner join maakonnad m on inserted.maakondId=m.maakondId;
drop trigger linnaLisamine

--kontrollimiseks tuleb lisada uus linn tabelisse linnad
insert into linnad(linnaNimi,rahvaarv,maakondId)
Values('Pärnu',603000,2);
select * from linnad;
select * from logi;
--triger mis jälgib andmete kustutamine seoutud tabelite põhjal
create trigger linnaKustutamine
on linnad
for delete
as
insert into logi(kuupaev,andmed,kasutaja)
select 
getdate(), 
CONCAT('kustutatud linn : ', deleted.linnaNimi, ',', deleted.rahvaarv, ',', m.maakondNimi),
SYSTEM_USER
from deleted inner join maakonnad m on deleted.maakondId=m.maakondId;

drop trigger linnaKustutamine

delete from linnad where linnId=2;
select * from linnad;
select * from logi;

delete from logi

--trigger, mis jälgib andmete uuendamine kahes tabelis
create trigger linnaUuendamine
on linnad
for update
as
insert into logi(kuupaev,andmed,kasutaja)
select 
getdate(), 
CONCAT('vana linna andmed : ', deleted.linnaNimi, ',', deleted.rahvaarv, ',', m1.maakondNimi,
' || uue linna andmed : ', inserted.linnaNimi, ',', inserted.rahvaarv, ',', m2.maakondNimi),
SYSTEM_USER
from deleted
inner join inserted on deleted.linnId=inserted.linnId
inner join maakonnad m2 on inserted.maakondId=m2.maakondId
inner join maakonnad m1 on deleted.maakondId=m1.maakondId;


select * from linnad
select * from maakonnad
update linnad set maakondId=1, linnaNimi='test' where linnId=3;
select * from linnad
select * from logi
