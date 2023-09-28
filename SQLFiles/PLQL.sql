-- Create the package specification
CREATE OR REPLACE PACKAGE praxis_management_pkg AS
   -- Übersichtsberichte
   FUNCTION GeneratePracticeOverviewReport RETURN VARCHAR2;

   -- Terminvereinbarung
   PROCEDURE ScheduleAppointment(
      p_patient_svn      IN VARCHAR2,
      p_arzt_id          IN NUMBER,
      p_termin_datum     IN DATE,
      p_termin_uhrzeit   IN TIMESTAMP,
      p_termin_dauer     IN NUMBER
   );

   -- Verfolgung medizinischer Leistungen
   PROCEDURE RecordMedicalService(
      p_patient_svn        IN VARCHAR2,
      p_arzt_id            IN NUMBER,
      p_diagnose_id        IN NUMBER,
      p_rezept_id          IN NUMBER,
      p_behandlungsid      IN NUMBER,
      p_behandlungsart     IN VARCHAR2
   );

END praxis_management_pkg;
/

-- Create the package body
CREATE OR REPLACE PACKAGE BODY praxis_management_pkg AS

   -- Übersichtsberichte
   FUNCTION GeneratePracticeOverviewReport RETURN VARCHAR2 AS
      report VARCHAR2(4000);
   BEGIN
      -- (Implementation as before)
      report := 'Sample Übersichtsbericht';
      RETURN report;
   END GeneratePracticeOverviewReport;

   -- Terminvereinbarung
   PROCEDURE ScheduleAppointment(
      p_patient_svn      IN VARCHAR2,
      p_arzt_id          IN NUMBER,
      p_termin_datum     IN DATE,
      p_termin_uhrzeit   IN TIMESTAMP,
      p_termin_dauer     IN NUMBER
   ) AS
   BEGIN
      -- (Implementation as before)
      INSERT INTO termin (patientfk, arztfk, datum, uhrzeit, dauer)
      VALUES (p_patient_svn, p_arzt_id, p_termin_datum, p_termin_uhrzeit, p_termin_dauer);
      COMMIT;
   END ScheduleAppointment;

   -- Verfolgung medizinischer Leistungen
   PROCEDURE RecordMedicalService(
      p_patient_svn        IN VARCHAR2,
      p_arzt_id            IN NUMBER,
      p_diagnose_id        IN NUMBER,
      p_rezept_id          IN NUMBER,
      p_behandlungsid      IN NUMBER,
      p_behandlungsart     IN VARCHAR2
   ) AS
   BEGIN
      -- (Implementation as before)
      INSERT INTO diagnose (diagnoseid, terminfk) VALUES (p_diagnose_id, p_behandlungsid);
      INSERT INTO rezept (rezeptid, patientfk) VALUES (p_rezept_id, p_patient_svn);
      INSERT INTO behandlung (behandlungsid, behandlungsart, rezeptfk, diagnosefk)
      VALUES (p_behandlungsid, p_behandlungsart, p_rezept_id, p_diagnose_id);
      COMMIT;
   END RecordMedicalService;

END praxis_management_pkg;
/

-- Test the procedures/functions
DECLARE
   report_text VARCHAR2(4000);
BEGIN
   -- Test GeneratePracticeOverviewReport
   report_text := praxis_management_pkg.GeneratePracticeOverviewReport;
   DBMS_OUTPUT.PUT_LINE(report_text);

   -- Test ScheduleAppointment
   praxis_management_pkg.ScheduleAppointment('1234567890', 1, SYSDATE, TO_TIMESTAMP('2023-09-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 30);
   DBMS_OUTPUT.PUT_LINE('Appointment scheduled successfully.');

   -- Test RecordMedicalService
   praxis_management_pkg.RecordMedicalService('1234567890', 1, 1, 1, 1, 'Checkup');
   DBMS_OUTPUT.PUT_LINE('Medical service recorded successfully.');

   COMMIT;
END;
/
