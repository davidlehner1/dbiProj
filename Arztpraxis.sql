CREATE OR REPLACE
    PACKAGE ARZTPRAXIS AS

    /*ALLE PARAMETER NUR ALS SAMPLE CODE*/

    FUNCTION InsertPatientRecord(SVN number) return BOOLEAN;

    PROCEDURE GeneratePracticeOverviewReport(PraxisID NUMBER);

    PROCEDURE ScheduleAppointment(SVN number, datum DATE);

    PROCEDURE RecordMedicalService(SVN number, datum DATE);

    FUNCTION GetPatientDemographicsStatistics(PraxisID NUMBER) return number;

    FUNCTION GetCommonDiagnosesStatistics(PraxisID NUMBER) return number;

    FUNCTION GetDoctorPerformanceStatistics (ArztID number) return number;

END ARZTPRAXIS;

CREATE OR REPLACE
PACKAGE BODY ARZTPRAXIS AS

  FUNCTION InsertPatientRecord(SVN number) return BOOLEAN AS
  BEGIN
    -- TODO: Implementierung für FUNCTION ARZTPRAXIS.InsertPatientRecord erforderlich
    RETURN NULL;
  END InsertPatientRecord;

  PROCEDURE GeneratePracticeOverviewReport(PraxisID NUMBER) AS
  BEGIN
    -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.GeneratePracticeOverviewReport erforderlich
    NULL;
  END GeneratePracticeOverviewReport;

  PROCEDURE ScheduleAppointment(SVN number, datum DATE) AS
  BEGIN
    -- TODO: Implementierung für PROCEDURE ARZTPRAXIS.ScheduleAppointment erforderlich
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

  FUNCTION GetDoctorPerformanceStatistics (ArztID number) return number AS
  BEGIN
    -- TODO: Implementierung für FUNCTION ARZTPRAXIS.GetDoctorPerformanceStatistics erforderlich
    RETURN NULL;
  END GetDoctorPerformanceStatistics;

END ARZTPRAXIS;