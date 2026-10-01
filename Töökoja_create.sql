-- Created by Redgate Data Modeler (https://datamodeler.redgate-platform.com)
-- Last modification date: 2026-10-01 09:11:46.576

-- tables
-- Table: Ladu
CREATE TABLE Ladu (
    laduID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    aadress varchar(40)  NOT NULL,
    CONSTRAINT Ladu_pk PRIMARY KEY  (laduID)
);

-- Table: LaduVaruosa
CREATE TABLE LaduVaruosa (
    laduvaruosa int  NOT NULL IDENTITY,
    kogus int  NOT NULL,
    laduID int  NOT NULL,
    varuosaID int  NOT NULL,
    CONSTRAINT LaduVaruosa_pk PRIMARY KEY  (laduvaruosa)
);

-- Table: TarneVaruosa
CREATE TABLE TarneVaruosa (
    TarneVaruosaID int  NOT NULL IDENTITY,
    hind int  NOT NULL,
    tarnijaID int  NOT NULL,
    varuosaID int  NOT NULL,
    CONSTRAINT TarneVaruosa_pk PRIMARY KEY  (TarneVaruosaID)
);

-- Table: Tootaja
CREATE TABLE Tootaja (
    tootajaID int  NOT NULL IDENTITY,
    nimi varchar(30)  NOT NULL,
    isikukood char(11)  NOT NULL,
    telefon char(12)  NOT NULL,
    aadress varchar(50)  NOT NULL,
    CONSTRAINT Tootaja_pk PRIMARY KEY  (tootajaID)
);

-- Table: Varuosa
CREATE TABLE Varuosa (
    varuosaID int  NOT NULL IDENTITY,
    nimetus varchar(30)  NOT NULL,
    tootja varchar(30)  NOT NULL,
    hind int  NOT NULL,
    looseis varchar(30)  NOT NULL,
    CONSTRAINT Varuosa_pk PRIMARY KEY  (varuosaID)
);

-- Table: Varuosaremondis
CREATE TABLE Varuosaremondis (
    varuosaremondisID int  NOT NULL IDENTITY,
    kogus int  NOT NULL,
    laduvaruosa int  NOT NULL,
    remonditoo int  NOT NULL,
    CONSTRAINT Varuosaremondis_pk PRIMARY KEY  (varuosaremondisID)
);

-- Table: amet
CREATE TABLE amet (
    ametID int  NOT NULL,
    nimetus varchar(30)  NOT NULL,
    kirjeldus text  NOT NULL,
    CONSTRAINT amet_pk PRIMARY KEY  (ametID)
);

-- Table: ametimaaratus
CREATE TABLE ametimaaratus (
    ametimaaratus int  NOT NULL IDENTITY,
    alguskuupaev int  NOT NULL,
    tootajaID int  NOT NULL,
    ametID int  NOT NULL,
    CONSTRAINT ametimaaratus_pk PRIMARY KEY  (ametimaaratus)
);

-- Table: auto
CREATE TABLE auto (
    registreerimisnumber int  NOT NULL IDENTITY,
    mark varchar(30)  NOT NULL,
    mudel varchar(30)  NOT NULL,
    valmistamisaasta int  NOT NULL,
    labisoit int  NOT NULL,
    CONSTRAINT auto_pk PRIMARY KEY  (registreerimisnumber)
);

-- Table: kategooria
CREATE TABLE kategooria (
    kategooriaID int  NOT NULL IDENTITY,
    kategooria varchar(30)  NOT NULL,
    kirjeldus text  NOT NULL,
    kestvus int  NOT NULL,
    CONSTRAINT kategooria_pk PRIMARY KEY  (kategooriaID)
);

-- Table: kliendiarve
CREATE TABLE kliendiarve (
    kliendiarve int  NOT NULL IDENTITY,
    kuupaev int  NOT NULL,
    maksamistahtaeg date  NOT NULL,
    status varchar(30)  NOT NULL,
    varuosaremondisID int  NOT NULL,
    CONSTRAINT kliendiarve_pk PRIMARY KEY  (kliendiarve)
);

-- Table: kliendiauto
CREATE TABLE kliendiauto (
    kliendiautoID int  NOT NULL IDENTITY,
    klientID int  NOT NULL,
    registreerimisnumber int  NOT NULL,
    CONSTRAINT kliendiauto_pk PRIMARY KEY  (kliendiautoID)
);

-- Table: klient
CREATE TABLE klient (
    klientID int  NOT NULL IDENTITY,
    nimi varchar(30)  NOT NULL,
    telefon char(12)  NOT NULL,
    epost varchar(50)  NOT NULL,
    CONSTRAINT klient_pk PRIMARY KEY  (klientID)
);

-- Table: remonditoo
CREATE TABLE remonditoo (
    remonditoo int  NOT NULL IDENTITY,
    kuupaev int  NOT NULL,
    kirjeldus int  NOT NULL,
    kategooriaID int  NOT NULL,
    tootajaID int  NOT NULL,
    CONSTRAINT remonditoo_pk PRIMARY KEY  (remonditoo)
);

-- Table: tarnija
CREATE TABLE tarnija (
    tarnijaID int  NOT NULL,
    nimetus varchar(30)  NOT NULL,
    kontakt char(12)  NOT NULL,
    aadress varchar(50)  NOT NULL,
    CONSTRAINT tarnija_pk PRIMARY KEY  (tarnijaID)
);

-- Table: tootajaremondis
CREATE TABLE tootajaremondis (
    tootajaremondisID int  NOT NULL IDENTITY,
    status varchar(30)  NOT NULL,
    remonditoo int  NOT NULL,
    tootajaID int  NOT NULL,
    CONSTRAINT tootajaremondis_pk PRIMARY KEY  (tootajaremondisID)
);

-- foreign keys
-- Reference: LaduVaruosa_Ladu (table: LaduVaruosa)
ALTER TABLE LaduVaruosa ADD CONSTRAINT LaduVaruosa_Ladu
    FOREIGN KEY (laduID)
    REFERENCES Ladu (laduID);

-- Reference: LaduVaruosa_Varuosa (table: LaduVaruosa)
ALTER TABLE LaduVaruosa ADD CONSTRAINT LaduVaruosa_Varuosa
    FOREIGN KEY (varuosaID)
    REFERENCES Varuosa (varuosaID);

-- Reference: TarneVaruosa_Varuosa (table: TarneVaruosa)
ALTER TABLE TarneVaruosa ADD CONSTRAINT TarneVaruosa_Varuosa
    FOREIGN KEY (varuosaID)
    REFERENCES Varuosa (varuosaID);

-- Reference: TarneVaruosa_tarnija (table: TarneVaruosa)
ALTER TABLE TarneVaruosa ADD CONSTRAINT TarneVaruosa_tarnija
    FOREIGN KEY (tarnijaID)
    REFERENCES tarnija (tarnijaID);

-- Reference: Tootaja (table: tootajaremondis)
ALTER TABLE tootajaremondis ADD CONSTRAINT Tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES Tootaja (tootajaID);

-- Reference: Varuosaremondis_LaduVaruosa (table: Varuosaremondis)
ALTER TABLE Varuosaremondis ADD CONSTRAINT Varuosaremondis_LaduVaruosa
    FOREIGN KEY (laduvaruosa)
    REFERENCES LaduVaruosa (laduvaruosa);

-- Reference: Varuosaremondis_remonditoo (table: Varuosaremondis)
ALTER TABLE Varuosaremondis ADD CONSTRAINT Varuosaremondis_remonditoo
    FOREIGN KEY (remonditoo)
    REFERENCES remonditoo (remonditoo);

-- Reference: ametimaaratus_Tootaja (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT ametimaaratus_Tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES Tootaja (tootajaID);

-- Reference: ametimaaratus_amet (table: ametimaaratus)
ALTER TABLE ametimaaratus ADD CONSTRAINT ametimaaratus_amet
    FOREIGN KEY (ametID)
    REFERENCES amet (ametID);

-- Reference: kliendiarve_Varuosaremondis (table: kliendiarve)
ALTER TABLE kliendiarve ADD CONSTRAINT kliendiarve_Varuosaremondis
    FOREIGN KEY (varuosaremondisID)
    REFERENCES Varuosaremondis (varuosaremondisID);

-- Reference: kliendiauto_auto (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT kliendiauto_auto
    FOREIGN KEY (registreerimisnumber)
    REFERENCES auto (registreerimisnumber);

-- Reference: kliendiauto_klient (table: kliendiauto)
ALTER TABLE kliendiauto ADD CONSTRAINT kliendiauto_klient
    FOREIGN KEY (klientID)
    REFERENCES klient (klientID);

-- Reference: remonditoo_Tootaja (table: remonditoo)
ALTER TABLE remonditoo ADD CONSTRAINT remonditoo_Tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES Tootaja (tootajaID);

-- Reference: remonditoo_kategooria (table: remonditoo)
ALTER TABLE remonditoo ADD CONSTRAINT remonditoo_kategooria
    FOREIGN KEY (kategooriaID)
    REFERENCES kategooria (kategooriaID);

-- Reference: tootajaremondis_remonditoo (table: tootajaremondis)
ALTER TABLE tootajaremondis ADD CONSTRAINT tootajaremondis_remonditoo
    FOREIGN KEY (remonditoo)
    REFERENCES remonditoo (remonditoo);

-- End of file.

