DROP TABLE behandlung;
DROP TABLE rezept;
DROP TABLE diagnose;
DROP TABLE termin;
DROP TABLE patient;
DROP TABLE arzt;
DROP TABLE arzttyp;
DROP TABLE arztpraxis;

CREATE TABLE arztpraxis
(
    praxisid number PRIMARY KEY,
    plz      varchar2(10),
    ort      varchar2(255),
    adresse  varchar2(255),
    hausnr   varchar2(10)
);

CREATE TABLE arzttyp
(
    typid        number PRIMARY KEY,
    name         varchar2(255),
    beschreibung varchar2(255)
);

CREATE TABLE arzt
(
    arztid    number PRIMARY KEY,
    vname     varchar2(255),
    nname     varchar2(255),
    titel     varchar2(50),
    arzttypfk number REFERENCES arzttyp(typid),
    praxisfk  number REFERENCES arztpraxis(praxisid)
);

CREATE TABLE patient
(
    svn     varchar2(20) PRIMARY KEY,
    vname   varchar2(255),
    nname   varchar2(255),
    plz     varchar2(10),
    ort     varchar2(255),
    adresse varchar2(255),
    hausnr  varchar2(10),
    geb     date
);

CREATE TABLE termin
(
    terminid  number PRIMARY KEY,
    datum     date,
    uhrzeit   number,
    dauer     number,
    patientfk varchar2(20) REFERENCES patient(svn),
    arztfk    number REFERENCES arzt(arztid)
);

CREATE TABLE diagnose
(
    diagnoseid   number PRIMARY KEY,
    name         varchar2(255),
    beschreibung varchar2(255)
);

CREATE TABLE rezept
(
    rezeptid          number PRIMARY KEY,
    verschreibung     varchar2(255),
    ausstellungsdatum date,
    preis             decimal(10, 2),
    patientfk         varchar2(20) REFERENCES patient(svn)
);

CREATE TABLE behandlung
(
    behandlungsid  number PRIMARY KEY,
    rezeptfk       number REFERENCES rezept(rezeptid),
    diagnosefk     number REFERENCES diagnose(diagnoseid),
    behandlungsart varchar2(255)
);
