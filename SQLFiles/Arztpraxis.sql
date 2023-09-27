create or replace PACKAGE ARZTPRAXIS AS

    /*ALLE PARAMETER NUR ALS SAMPLE CODE*/

    FUNCTION InsertPatientRecord(svn varchar2,
                                 vname varchar2,
                                 nname varchar2,
                                 plz varchar2,
                                 ort varchar2,
                                 adresse varchar2,
                                 hausnr varchar2,
                                 geb date) return varchar2;

    PROCEDURE GeneratePracticeOverviewReport(PraxisID NUMBER);

    PROCEDURE ScheduleAppointment(SVN number, datum DATE);

    PROCEDURE RecordMedicalService(SVN number, datum DATE);

    FUNCTION GetPatientDemographicsStatistics(PraxisID NUMBER) return number;

    FUNCTION GetCommonDiagnosesStatistics(PraxisID NUMBER) return number;

    FUNCTION GetDoctorPerformanceStatistics(ArztID number) return number;

END ARZTPRAXIS;

CREATE OR REPLACE
    PACKAGE BODY ARZTPRAXIS AS

    FUNCTION InsertPatientRecord(
        svn varchar2, vname varchar2, nname varchar2, plz varchar2, ort varchar2,
        adresse varchar2, hausnr varchar2, geb date)
        return varchar2 AS
        p_count number;
    BEGIN
        -- Prüfen, ob der Patient bereits in der Datenbank existiert
        SELECT COUNT(SVN)
        INTO p_count
        FROM PATIENT
        WHERE SVN = svn;

        -- Wenn der Patient nicht existiert, fügen Sie ihn hinzu
        IF p_count = 0 THEN
            INSERT INTO PATIENT (SVN, VNAME, NNAME, PLZ, ORT, ADRESSE, HAUSNR, GEB)
            VALUES (svn, vname, nname, plz, ort, adresse, hausnr, geb);
            COMMIT; -- Bestätigen Sie die Transaktion
            RETURN 'TRUE'; -- Erfolgreich eingefügt
        ELSE
            RETURN 'FALSE'; -- Patient existiert bereits
            COMMIT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; -- Bei Fehlern Transaktion rückgängig machen
            RETURN 'FALSE'; -- Fehler bei der Einfügung
    END InsertPatientRecord;

    PROCEDURE GeneratePracticeOverviewReport(PraxisID NUMBER) AS
    BEGIN
        -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.GeneratePracticeOverviewReport erforderlich
        NULL;
    END GeneratePracticeOverviewReport;

    PROCEDURE ScheduleAppointment(SVN number, datum DATE) AS
    BEGIN
        -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.RecordMedicalService erforderlich
        NULL;
    END ScheduleAppointment;

    PROCEDURE RecordMedicalService(SVN number, datum DATE) AS
    BEGIN
        -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.RecordMedicalService erforderlich
        NULL;
    END RecordMedicalService;

    FUNCTION GetPatientDemographicsStatistics(PraxisID NUMBER) return number AS
    BEGIN
        -- TODO: Implementierung für FUNCTION ARZTPRAXIS.GetPatientDemographicsStatistics erforderlich
        RETURN NULL;
    END GetPatientDemographicsStatistics;

    FUNCTION GetCommonDiagnosesStatistics(PraxisID NUMBER) return number AS
    BEGIN
        -- TODO: Implementierung für FUNCTION ARZTPRAXIS.GetCommonDiagnosesStatistics erforderlich
        RETURN NULL;
    END GetCommonDiagnosesStatistics;

    FUNCTION GetDoctorPerformanceStatistics(ArztID number) return number AS
    BEGIN
        -- TODO: Implementierung für FUNCTION ARZTPRAXIS.GetDoctorPerformanceStatistics erforderlich
        RETURN NULL;
    END GetDoctorPerformanceStatistics;

END ARZTPRAXIS;