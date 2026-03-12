--SELECT kahe tabeli põhjal
create database select2tabeliIvanov;
use select2tabeliIvanov;
--laps/loom tabelid
CREATE TABLE laps(
    lapsID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    pikkus smallint,
    synniaasta int null,
    synnilinn varchar(15)
    );
CREATE TABLE loom(
    loomID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    kaal smallint,
    lapsID int,
    FOREIGN KEY (lapsID) REFERENCES laps(lapsID)  
   );
   --Laps loomine
   insert into laps(nimi, pikkus, synniaasta, synnilinn)
   values ('Kirill', 156, 2005, 'Tallinn'),
   ('Nikita', 166, 2005, 'Tallinn'),
   ('Oleg', 125, 2010, 'Tallinn'),
   ('Leena', 156, 2005, 'Tallinn'),
   ('Nikita', 126, 2002, 'Tartu');
   select * from laps
   --Loom loomine
   insert into loom(nimi, kaal, lapsID)
   values('kass', 5, 1),('koer', 2, 2),('papagoi', 4,3),('kass2',3,4),('koer2',1,5);
   select * from loom

   --Alias-nimede kasutamine
select l.nimi,l.kaal from loom as l;
--sisemine ühendamine
select * from laps, loom; --nii ei tohi kirjutada, sest 1 tabeli kirjed korrutakse 2. tabeli kirjaga
--õige päring
select * from laps as lp, loom as l
where l.lapsID=lp.lapsID;

--kitsendame päring
select lp.nimi,l.nimi,l.kaal,lp.synniaasta
from laps as lp, loom as l
where l.lapsID=lp.lapsID;

--INNER JOIN ühendamine
select * from laps inner join loom
on loom.lapsID=laps.lapsID;

--left join -- näitab kõike lapsed isegi kui puudub looms
select * from laps left join loom
on loom.lapsID=laps.lapsID;

--cross join
select * from laps cross join loom

create table varjupaik(
varjupaik_id int primary key identity(1,1),
koht varchar(50),
firma varchar(50));

alter table loom add varjupaik_id int;
alter table loom add constraint fk_varjupaik 
foreign key(varjupaik_id)references varjupaik(varjupaik_id);

insert  into varjupaik(koht, firma)
values('Paljassare','Varjupaikade MTÜ');
SELECT * FROM varjupaik;
UPDATE loom set varjupaik_id=1;
select * from loom;

--select 3/mitme tabelite põhjal
select lp.nimi,l.nimi,v.koht
from laps as lp, loom as l, varjupaik as v
where l.lapsID=lp.lapsID and v.varjupaik_id=v.varjupaik_id;

--sama inner joiniga
select lp.nimi,l.nimi,v.koht
from laps as lp inner join loom as l
on l.lapsID=lp.lapsID  inner join varjupaik as v
on v.varjupaik_id=v.varjupaik_id;
