-- Create the package specification
CREATE OR REPLACE PACKAGE praxis_management_pkg AS
    -- Übersichtsberichte
    FUNCTION generatepracticeoverviewreport RETURN varchar2;

    -- Terminvereinbarung
    PROCEDURE scheduleappointment(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_termin_datum IN date,
        p_termin_uhrzeit IN timestamp,
        p_termin_dauer IN number
    );

    -- Verfolgung medizinischer Leistungen
    PROCEDURE recordmedicalservice(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_diagnose_id IN number,
        p_rezept_id IN number,
        p_behandlungsid IN number,
        p_behandlungsart IN varchar2
    );

END praxis_management_pkg;
/

-- Create the package body
CREATE OR REPLACE PACKAGE BODY praxis_management_pkg AS

    -- Übersichtsberichte
    FUNCTION generatepracticeoverviewreport RETURN varchar2 AS
        report varchar2(4000);
    BEGIN
        -- (Implementation as before)
        report := 'Sample Übersichtsbericht';
        RETURN report;
    END generatepracticeoverviewreport;

    -- Terminvereinbarung
    PROCEDURE scheduleappointment(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_termin_datum IN date,
        p_termin_uhrzeit IN timestamp,
        p_termin_dauer IN number
    ) AS
        DECLARE
                p_terminid number(20);
    BEGIN
        -- (Implementation as before)
        SELECT MAX(terminid) + 1 INTO p_terminid FROM termin;
        INSERT INTO termin (terminid, datum, uhrzeit, dauer, patientfk, arztfk)
        VALUES (p_terminid, p_termin_datum, p_termin_uhrzeit, p_termin_dauer, p_patient_svn, p_arzt_id);
        COMMIT;
    END scheduleappointment;

    -- Verfolgung medizinischer Leistungen
    PROCEDURE recordmedicalservice(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_diagnose_id IN number,
        p_rezept_id IN number,
        p_behandlungsid IN number,
        p_behandlungsart IN varchar2
    ) AS
    BEGIN
        -- (Implementation as before)
        INSERT INTO diagnose (diagnoseid, terminfk) VALUES (p_diagnose_id, p_behandlungsid);
        INSERT INTO rezept (rezeptid, patientfk) VALUES (p_rezept_id, p_patient_svn);
        INSERT INTO behandlung (behandlungsid, behandlungsart, rezeptfk, diagnosefk)
        VALUES (p_behandlungsid, p_behandlungsart, p_rezept_id, p_diagnose_id);
        COMMIT;
    END recordmedicalservice;

END praxis_management_pkg;
/

-- Test the procedures/functions
DECLARE
    report_text varchar2(4000);
BEGIN
    -- Test GeneratePracticeOverviewReport
    report_text := praxis_management_pkg.generatepracticeoverviewreport;
    dbms_output.put_line(report_text);

    -- Test ScheduleAppointment
    praxis_management_pkg.scheduleappointment('P123456', 1, TO_DATE('2023-09-29', 'yyyy-mm-dd'), TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'), 30);
    dbms_output.put_line('Appointment scheduled successfully.');

    -- Test RecordMedicalService
    praxis_management_pkg.recordmedicalservice('1234567890', 1, 1, 1, 1, 'Checkup');
    dbms_output.put_line('Medical service recorded successfully.');

    COMMIT;
END;
/
