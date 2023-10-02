CREATE OR REPLACE PACKAGE arztpraxis AS

    /*ALLE PARAMETER NUR ALS SAMPLE CODE*/

    FUNCTION insertpatientrecord(svn varchar2,
                                 vname varchar2,
                                 nname varchar2,
                                 plz varchar2,
                                 ort varchar2,
                                 adresse varchar2,
                                 hausnr varchar2,
                                 geb date) RETURN varchar2;

    PROCEDURE generatepracticeoverviewreport(praxisid number);

    PROCEDURE scheduleappointment(svn number, datum date);

    PROCEDURE recordmedicalservice(svn number, datum date);

END arztpraxis;

CREATE OR REPLACE
    PACKAGE BODY arztpraxis AS

    FUNCTION insertpatientrecord(
        svn varchar2, vname varchar2, nname varchar2, plz varchar2, ort varchar2,
        adresse varchar2, hausnr varchar2, geb date)
        RETURN varchar2 AS
        p_count number;
    BEGIN
        -- Prüfen, ob der Patient bereits in der Datenbank existiert
        SELECT COUNT(svn)
        INTO p_count
        FROM patient
        WHERE svn = svn;

        -- Wenn der Patient nicht existiert, fügen Sie ihn hinzu
        IF p_count = 0 THEN
            INSERT INTO patient (svn, vname, nname, plz, ort, adresse, hausnr, geb)
            VALUES (svn, vname, nname, plz, ort, adresse, hausnr, geb);
            COMMIT; -- Bestätigen Sie die Transaktion
            RETURN 'TRUE'; -- Erfolgreich eingefügt
        ELSE
            COMMIT;
            RETURN 'FALSE'; -- Patient existiert bereits
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; -- Bei Fehlern Transaktion rückgängig machen
            RETURN 'FALSE'; -- Fehler bei der Einfügung
    END insertpatientrecord;

    PROCEDURE generatepracticeoverviewreport(praxisid number) AS
        diagnose_name varchar2(20);
        diagnose_id   number;
        behandlung    boolean;
    BEGIN

        SELECT name INTO diagnose_name FROM diagnose;
        dbms_output.put_line(diagnose_name);
    END generatepracticeoverviewreport;

    PROCEDURE
        scheduleappointment(svn number, datum date) AS
    BEGIN
        -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.RecordMedicalService erforderlich
        NULL;
    END scheduleappointment;

    PROCEDURE
        recordmedicalservice(svn number, datum date) AS
    BEGIN
        -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.RecordMedicalService erforderlich
        NULL;
    END recordmedicalservice;

END arztpraxis;