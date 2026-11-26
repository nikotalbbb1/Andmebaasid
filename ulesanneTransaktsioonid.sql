CREATE TABLE tblArveldusarve (
    KontoId INT PRIMARY KEY IDENTITY(1,1),
    KliendiNr INT,
    Omanik VARCHAR(30),
    Saldo DECIMAL(10,2) CHECK (Saldo > 0)
);

CREATE TABLE tblHoiusarve (
    KontoId INT PRIMARY KEY IDENTITY(1,1),
    KliendiNr INT,
    Omanik VARCHAR(30),
    Saldo DECIMAL(10,2) CHECK (Saldo > 0)
);


insert into tblArveldusarve(KliendiNr,Omanik,Saldo)
values(201, 'Mari Maasikas', 500.00)

insert into tblHoiusarve(KliendiNr,Omanik,Saldo)
values(201, 'Mari Maasikas', 1000.00)

select * from tblArveldusarve
select * from tblHoiusarve

alter procedure spUlekanne
as
begin
begin try
begin transaction
update tblArveldusarve set Saldo = Saldo - 1000 where KliendiNr = 201
update tblHoiusarve set Saldo = Saldo + 1000 where KliendiNr = 201
commit transaction
print 'Ülekanne õnnestus';
end try
begin catch
if @@TRANCOUNT < 0
rollback transaction;
print 'Ülekanne ebaõnnestus';
end catch;
end;

drop procedure spUlekanne
