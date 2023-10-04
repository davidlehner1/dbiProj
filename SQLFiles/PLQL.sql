-- Create the package specification
CREATE OR REPLACE PACKAGE praxis_management_pkg AS
    -- Übersichtsberichte
    FUNCTION generatepracticeoverviewreport RETURN varchar2;

    -- Terminvereinbarung
    FUNCTION scheduleappointment(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_termin_datum IN date,
        p_termin_uhrzeit IN timestamp,
        p_termin_dauer IN number
    ) RETURN varchar2;

    -- Verfolgung medizinischer Leistungen
    PROCEDURE recordmedicalservice(
        p_termin_id IN number,
        p_diagnose_name IN varchar2,
        p_diagnose_beschreibung IN varchar2,
        p_behandlung_art IN varchar2,
        p_rezept_id IN number DEFAULT NULL
    );

END praxis_management_pkg;
/

-- Create the package body
CREATE OR REPLACE PACKAGE BODY praxis_management_pkg AS

    -- Übersichtsberichte
    FUNCTION generatepracticeoverviewreport RETURN varchar2 AS
        v_report clob;
    BEGIN
        -- Initialize the report
        v_report := 'Praxis Übersichtsbericht' || CHR(10) || CHR(10);

        -- Patientendemografie
        v_report := v_report || 'Patientendemografie:' || CHR(10);
        SELECT COUNT(*) INTO v_report FROM patient;
        v_report := v_report || 'Gesamtzahl der Patienten: ' || v_report || CHR(10);

        -- Umsatz
        v_report := v_report || CHR(10) || 'Umsatz:' || CHR(10);
        SELECT SUM(preis) INTO v_report FROM rezept;
        v_report := v_report || 'Gesamtumsatz: ' || v_report || CHR(10);

        -- Häufige Diagnosen
        v_report := v_report || CHR(10) || 'Häufige Diagnosen:' || CHR(10);
        FOR r IN (
            SELECT name, COUNT(*) AS häufigkeit
            FROM diagnose
            GROUP BY name
            ORDER BY häufigkeit DESC
            )
            LOOP
                v_report := v_report || r.name || ': ' || r.häufigkeit || ' Mal' || CHR(10);
            END LOOP;

        -- Leistung der Ärzte
        v_report := v_report || CHR(10) || 'Leistung der Ärzte:' || CHR(10);
        FOR r IN (
            SELECT a.vname || ' ' || a.nname AS arztname, COUNT(*) AS terminanzahl
            FROM arzt a
                     JOIN termin t ON a.arztid = t.arztfk
            GROUP BY a.vname, a.nname
            ORDER BY terminanzahl DESC
            )
            LOOP
                v_report := v_report || r.arztname || ': ' || r.terminanzahl || ' Termine' || CHR(10);
            END LOOP;

        -- Return the report
        RETURN v_report;
    END generatepracticeoverviewreport;

    FUNCTION scheduleappointment(
        p_patient_svn IN varchar2,
        p_arzt_id IN number,
        p_termin_datum IN date,
        p_termin_uhrzeit IN timestamp,
        p_termin_dauer IN number
    ) RETURN varchar2 AS
        v_patient_exists   number;
        v_arzt_exists      number;
        v_next_appointment timestamp;
        v_message          varchar2(100);
    BEGIN
        -- Überprüfen, ob der Patient existiert, wenn nicht, anlegen
        SELECT COUNT(*) INTO v_patient_exists FROM patient WHERE svn = p_patient_svn;

        IF v_patient_exists = 0 THEN
            -- Patient anlegen
            INSERT INTO patient (svn, vname, nname, plz, ort, adresse, hausnr, geb)
            VALUES (p_patient_svn, 'auto_generated', 'auto_generated', 0000, 'auto', 'auto_generated', 0, '10.01.1990');
        END IF;

        -- Überprüfen, ob der Arzt existiert
        SELECT COUNT(*) INTO v_arzt_exists FROM arzt WHERE arztid = p_arzt_id;

        IF v_arzt_exists = 0 THEN
            v_message := 'Arzt mit ID ' || p_arzt_id || ' existiert nicht.';
            RETURN v_message;
        END IF;

        -- Überprüfen der Verfügbarkeit des Arztes
        SELECT MIN(uhrzeit)
        INTO v_next_appointment
        FROM termin
        WHERE arztfk = p_arzt_id
          AND datum = p_termin_datum
          AND (
                (uhrzeit >= p_termin_uhrzeit AND uhrzeit < (p_termin_uhrzeit + (p_termin_dauer / 1440))) OR
                ((uhrzeit + (dauer / 1440)) > p_termin_uhrzeit AND
                 (uhrzeit + (dauer / 1440)) <= (p_termin_uhrzeit + (p_termin_dauer / 1440)))
            );

        IF v_next_appointment IS NOT NULL THEN
            v_message := 'Der Arzt hat bereits einen Termin um ' || TO_CHAR(v_next_appointment, 'HH24:MI') || ' Uhr.';
            RETURN v_message;
        END IF;

        -- Termin anlegen
        INSERT INTO termin (terminid, datum, uhrzeit, dauer, patientfk, arztfk)
        VALUES ((SELECT NVL(MAX(terminid), 0) + 1 FROM termin),
                p_termin_datum,
                p_termin_uhrzeit,
                p_termin_dauer,
                p_patient_svn,
                p_arzt_id);

        COMMIT;

        v_message := 'Termin erfolgreich geplant.';
        RETURN v_message;
    EXCEPTION
        WHEN OTHERS THEN
            v_message := 'Fehler: ' || SQLERRM;
            RETURN v_message;
    END scheduleappointment;


-- Verfolgung medizinischer Leistungen
    PROCEDURE recordmedicalservice(
        p_termin_id IN number,
        p_diagnose_name IN varchar2,
        p_diagnose_beschreibung IN varchar2,
        p_behandlung_art IN varchar2,
        p_rezept_id IN number DEFAULT NULL
    ) AS
        v_diagnose_id   number;
        v_behandlung_id number;
    BEGIN
        SELECT NVL(MAX(diagnoseid) + 1, 1) INTO v_diagnose_id FROM diagnose;
        SELECT NVL(MAX(behandlungsid) + 1, 1) INTO v_behandlung_id FROM behandlung;

        INSERT INTO diagnose VALUES (v_diagnose_id, p_diagnose_name, p_diagnose_beschreibung, p_termin_id);
        INSERT INTO behandlung VALUES (v_behandlung_id, p_behandlung_art, p_rezept_id, v_diagnose_id);

        COMMIT;
    END recordmedicalservice;

END praxis_management_pkg;
/

-- Test the procedures/functions
DECLARE
    report_text   varchar2(4000);
    schedule_text varchar2(4000);
BEGIN
    -- Test GeneratePracticeOverviewReport
    report_text := praxis_management_pkg.generatepracticeoverviewreport;
    dbms_output.put_line(report_text);

    -- Test ScheduleAppointment
    schedule_text := praxis_management_pkg.scheduleappointment('P123456', 1, TO_DATE('2023-10-04', 'yyyy-mm-dd'),
                                                               TO_TIMESTAMP('12:30:00', 'HH24:MI:SS'), 30);
    dbms_output.put_line(schedule_text);

    -- Test RecordMedicalService
    praxis_management_pkg.recordmedicalservice(1, 'Leukämie', '1. Stadium', 'Vorläufige Diagnose');
    dbms_output.put_line('Medical service recorded successfully.');
    COMMIT;
END;
/
