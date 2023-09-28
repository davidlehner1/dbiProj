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