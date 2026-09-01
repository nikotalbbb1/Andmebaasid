use kordamineIKT25;
CREATE table opilane(
opilaneID int primary key identity(1,1),
nimi varchar(20),
isikukood char(11),
ryhmId int)

create table ryhm(
ryhmId int primary key identity(1,1),
ryhmNimi char(10) unique,
opilasteArv int)

-- välisvõti - foreign key
alter table opilane add foreign key (ryhmId) references ryhm(ryhmId)

-- tabeli kustutamine
drop table ....;

--õiguste määramine varem tehtud kasutajale
grant select to Nikita;
grant insert on opilane to Nikita;

deny delete to Nikita;
