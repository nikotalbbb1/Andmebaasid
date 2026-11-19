create database transaktionIvanov
use transaktionIvanov

CREATE TABLE konto (
    konto_id INT PRIMARY KEY,
    omanik   VARCHAR(50)   NOT NULL,
    saldo    DECIMAL(10,2) NOT NULL CHECK (saldo >= 0)
);

INSERT INTO konto (konto_id, omanik, saldo) VALUES
    (1, 'Mari', 500.00),
    (2, 'Jaan', 200.00),
    (3, 'Liis',  50.00);

select * from konto

--alustame transaktsiooni
BEGIN TRANSACTION;

UPDATE konto SET saldo = saldo - 100 WHERE konto_id = 1;  -- Mari
UPDATE konto SET saldo = saldo + 100 WHERE konto_id = 2;  -- Jaan


SELECT * FROM konto;

--tagasi võitmine
ROLLBACK;
SELECT * FROM konto;
--kustutamis transaktsioon: kogemata kustutame kõik kontod
--unustamise WHERE kirjutama
begin TRANSACTION;

DELETE FROM konto;            -- viga: WHERE puudub!
SELECT COUNT(*) as kontodeArv_enne FROM konto;   -- tulemus 0, kuid ainult meie ühenduses

ROLLBACK;

SELECT COUNT(*) as kontodeArv_parast FROM konto;   -- tulemus 3, kõik read on alles

select * from konto;

--uuendamis transaktsioon
begin TRANSACTION;

INSERT INTO konto (konto_id, omanik, saldo) VALUES (4, 'Peeter', 300.00);
SAVE transaction parast_lisamist;

UPDATE konto SET saldo = 0;   -- viga: nullis kõik kontod

ROLLBACK transaction parast_lisamist;   -- UPDATE tühistatud, INSERT alles

COMMIT;                       -- Peetri konto salvestatakse

-- kehtib järgmisele transaktsioonile
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
begin TRANSACTION;
SELECT saldo FROM konto WHERE konto_id = 1;
COMMIT;

BEGIN TRANSACTION;
UPDATE konto SET saldo = saldo - 300
WHERE konto_id = 1;
--read uncommitted
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
begin TRANSACTION;
SELECT saldo FROM konto WHERE konto_id = 1;
COMMIT;

rollback;
select saldo from konto where konto_id = 1;

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE konto SET saldo = saldo - 1000 WHERE konto_id = 3;  -- viga
    UPDATE konto SET saldo = saldo + 1000 WHERE konto_id = 1;

    COMMIT TRANSACTION;
    PRINT 'Ülekanne õnnestus';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT 'Ülekanne tühistati: ' + ERROR_MESSAGE();
END CATCH;
