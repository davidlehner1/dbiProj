CREATE OR REPLACE
PACKAGE ARZTPRAXIS AS

FUNCTION InsertPatientRecord(SVN number) return BOOLEAN;

PROCEDURE GeneratePracticeOverviewReport(PraxisID NUMBER);

FUNCTION ScheduleAppointment(SVN number, datum DATE) RETURN BOOLEAN;



END ARZTPRAXIS;