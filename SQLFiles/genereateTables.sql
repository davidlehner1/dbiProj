CREATE TABLE arztpraxis
(
    praxisid number(20)    NOT NULL,
    plz      varchar2(10)  NOT NULL,
    ort      varchar2(255) NOT NULL,
    adresse  varchar2(255) NOT NULL,
    hausnr   varchar2(10)  NOT NULL,
    CONSTRAINT pk_arztpraxis PRIMARY KEY (praxisid)
);

CREATE TABLE arzttyp
(
    typid        number(20)    NOT NULL,
    name         varchar2(255) NOT NULL,
    beschreibung varchar2(255) NOT NULL,
    CONSTRAINT pk_arzttyp PRIMARY KEY (typid)
);

CREATE TABLE arzt
(
    arztid    number(20)    NOT NULL,
    vname     varchar2(255) NOT NULL,
    nname     varchar2(255) NOT NULL,
    titel     varchar2(50)  NOT NULL,
    arzttypfk number(20)    NOT NULL,
    praxisfk  number(20)    NOT NULL,
    CONSTRAINT pk_arzt PRIMARY KEY (arztid),
    CONSTRAINT fk_arzt_arzttyp FOREIGN KEY (arzttypfk) REFERENCES arzttyp (typid),
    CONSTRAINT fk_arzt_praxis FOREIGN KEY (praxisfk) REFERENCES arztpraxis (praxisid)
);

CREATE TABLE patient
(
    svn     varchar2(20)  NOT NULL,
    vname   varchar2(255) NOT NULL,
    nname   varchar2(255) NOT NULL,
    plz     varchar2(10)  NOT NULL,
    ort     varchar2(255) NOT NULL,
    adresse varchar2(255) NOT NULL,
    hausnr  varchar2(10)  NOT NULL,
    geb     date          NOT NULL,
    CONSTRAINT pk_patient PRIMARY KEY (svn)
);

CREATE TABLE termin
(
    terminid  number(20)   NOT NULL,
    datum     date         NOT NULL,
    uhrzeit   timestamp    NOT NULL,
    dauer     number(20)   NOT NULL,
    patientfk varchar2(20) NOT NULL,
    arztfk    number(20)   NOT NULL,
    CONSTRAINT pk_termin PRIMARY KEY (terminid),
    CONSTRAINT fk_termin_patient FOREIGN KEY (patientfk) REFERENCES patient (svn),
    CONSTRAINT fk_termin_arzt FOREIGN KEY (arztfk) REFERENCES arzt (arztid)
);

CREATE TABLE diagnose
(
    diagnoseid   number(20)    NOT NULL,
    name         varchar2(255) NOT NULL,
    beschreibung varchar2(255) NOT NULL,
    terminfk     number(20)    NOT NULL,
    CONSTRAINT pk_diagnose PRIMARY KEY (diagnoseid),
    CONSTRAINT fk_diagnose_termin FOREIGN KEY (terminfk) REFERENCES termin (terminid)
);

CREATE TABLE rezept
(
    rezeptid          number(20)     NOT NULL,
    verschreibung     varchar2(255)  NOT NULL,
    ausstellungsdatum date           NOT NULL,
    preis             decimal(10, 2) NOT NULL,
    patientfk         varchar2(20)   NOT NULL,
    CONSTRAINT pk_rezept PRIMARY KEY (rezeptid),
    CONSTRAINT fk_rezept_patient FOREIGN KEY (patientfk) REFERENCES patient (svn)
);

CREATE TABLE behandlung
(
    behandlungsid  number(20)    NOT NULL,
    behandlungsart varchar2(255) NOT NULL,
    rezeptfk       number(20)    NOT NULL,
    diagnosefk     number(20)    NOT NULL,
    CONSTRAINT pk_behandlung PRIMARY KEY (behandlungsid),
    CONSTRAINT fk_behandlung_rezept FOREIGN KEY (rezeptfk) REFERENCES rezept (rezeptid),
    CONSTRAINT fk_behandlung_diagnose FOREIGN KEY (diagnosefk) REFERENCES diagnose (diagnoseid)
);

CREATE TABLE terminveränderung
(
    details varchar2(300) NOT NULL
);

CREATE TABLE patientUpdate
(
    details varchar2(300) NOT NULL
);

CREATE TABLE fehler
(
    details varchar2(1000) NOT NULL
);
