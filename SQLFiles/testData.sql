INSERT INTO arztpraxis (praxisid, plz, ort, adresse, hausnr)
VALUES (1, '12345', 'Sample City 1', 'Sample Street 1', '1A');

INSERT INTO arztpraxis (praxisid, plz, ort, adresse, hausnr)
VALUES (2, '54321', 'Sample City 2', 'Sample Street 2', '2B');

INSERT INTO arzttyp (typid, name, beschreibung)
VALUES (1, 'Allergist', 'Specializes in allergies');

INSERT INTO arzttyp (typid, name, beschreibung)
VALUES (2, 'Cardiologist', 'Specializes in heart conditions');

INSERT INTO arzt (arztid, vname, nname, titel, arzttypfk, praxisfk)
VALUES (1, 'John', 'Doe', 'Dr.', 1, 1);

INSERT INTO arzt (arztid, vname, nname, titel, arzttypfk, praxisfk)
VALUES (2, 'Jane', 'Smith', 'Dr.', 2, 2);

INSERT INTO patient (svn, vname, nname, plz, ort, adresse, hausnr, geb)
VALUES ('P123456', 'Alice', 'Johnson', '54321', 'Sample City 2', 'Sample Street 3', '3C',
        TO_DATE('1990-05-15', 'yyyy-mm-dd'));

INSERT INTO patient (svn, vname, nname, plz, ort, adresse, hausnr, geb)
VALUES ('P789012', 'Bob', 'Williams', '12345', 'Sample City 1', 'Sample Street 4', '4D',
        TO_DATE('1985-10-20', 'yyyy-mm-dd'));

INSERT INTO termin (terminid, datum, uhrzeit, dauer, patientfk, arztfk)
VALUES (1, TO_DATE('2023-09-28', 'yyyy-mm-dd'), TO_TIMESTAMP('10:00:00', 'HH24:MI:SS'), 30, 'P123456', 1);

INSERT INTO termin (terminid, datum, uhrzeit, dauer, patientfk, arztfk)
VALUES (2, TO_DATE('2023-09-29', 'yyyy-mm-dd'), TO_TIMESTAMP('11:00:00', 'HH24:MI:SS'), 45, 'P789012', 2);

INSERT INTO diagnose (diagnoseid, name, beschreibung, terminfk)
VALUES (1, 'Allergy', 'Patient has an allergy.', 1);

INSERT INTO diagnose (diagnoseid, name, beschreibung, terminfk)
VALUES (2, 'Hypertension', 'Patient has high blood pressure.', 2);

INSERT INTO rezept (rezeptid, verschreibung, ausstellungsdatum, preis, patientfk)
VALUES (1, 'Antihistamine', TO_DATE('2023-09-28', 'yyyy-mm-dd'), 25.00, 'P123456');

INSERT INTO rezept (rezeptid, verschreibung, ausstellungsdatum, preis, patientfk)
VALUES (2, 'Beta-blockers', TO_DATE('2023-09-29', 'yyyy-mm-dd'), 30.00, 'P789012');

INSERT INTO behandlung (behandlungsid, behandlungsart, rezeptfk, diagnosefk)
VALUES (1, 'Medication', 1, 1);

INSERT INTO behandlung (behandlungsid, behandlungsart, rezeptfk, diagnosefk)
VALUES (2, 'Medication', 2, 2);

COMMIT;
--SET SERVEROUTPUT ON;

DECLARE
    insertedRecord VARCHAR2(20); -- Verwenden Sie VARCHAR2 mit einer geeigneten Länge
BEGIN
    -- Call the InsertPatientRecord function with appropriate arguments
    insertedRecord := ARZTPRAXIS.InsertPatientRecord(
            '123456789', -- Example Sozialversicherungsnummer
            'Max', -- Vorname
            'Mustermann', -- Nachname
            '12345', -- PLZ
            'Musterstadt', -- Ort
            'Musterstraße', -- Adresse
            '42', -- Hausnummer
            TO_DATE('01-01-1980', 'DD-MM-YYYY') -- Geburtsdatum
        );

    -- Convert BOOLEAN to a string and print the result
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(insertedRecord));
END;
COMMIT;
/