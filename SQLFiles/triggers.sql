CREATE OR REPLACE TRIGGER termin_update_trigger
    BEFORE INSERT OR UPDATE OR DELETE
    ON termin
    FOR EACH ROW
DECLARE
BEGIN
    IF INSERTING THEN
        -- Einfügeaktion: Protokolliere die Einfügeaktion
        INSERT INTO terminveränderung (details) VALUES ('Neuer Termin eingefügt - Termin ID: ' || :new.terminid);
        dbms_output.put_line('Neuer Termin eingefügt - Termin ID: ' || :new.terminid);
    ELSIF UPDATING THEN
        -- Update-Aktion: Protokolliere die Aktualisierung
        INSERT INTO terminveränderung (details) VALUES ('Termin aktualisiert - Termin ID: ' || :new.terminid);
        dbms_output.put_line('Termin aktualisiert - Termin ID: ' || :new.terminid);
    ELSIF DELETING THEN
        -- Löschaktion: Protokolliere die Löschung
        INSERT INTO terminveränderung (details) VALUES ('Termin gelöscht - Termin ID: ' || :old.terminid);
        dbms_output.put_line('Termin gelöscht - Termin ID: ' || :old.terminid);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER patient_update_trigger
    BEFORE UPDATE
    ON patient
    FOR EACH ROW
DECLARE
BEGIN
    IF :old.vname <> :new.vname OR
       :old.nname <> :new.nname OR
       :old.plz <> :new.plz OR
       :old.ort <> :new.ort OR
       :old.adresse <> :new.adresse OR
       :old.hausnr <> :new.hausnr OR
       :old.geb <> :new.geb THEN
        dbms_output.put_line('Patientendaten geändert - SVN: ' || :old.svn);
    END IF;
    IF :old.vname <> :new.vname THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.vname || ' zu ' || :new.vname);
        dbms_output.put_line('Veränderungen: Vorname ' || :old.vname || ' zu ' || :new.vname);
    END IF;

    IF :old.nname <> :new.nname THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.nname || ' zu ' || :new.nname);
        dbms_output.put_line('Veränderungen: Nachname ' || :old.nname || ' zu ' || :new.nname);
    END IF;

    IF :old.plz <> :new.plz THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.plz || ' zu ' || :new.plz);
        dbms_output.put_line('Veränderungen: PLZ ' || :old.plz || ' zu ' || :new.plz);
    END IF;

    IF :old.ort <> :new.ort THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.ort || ' zu ' || :new.ort);
        dbms_output.put_line('Veränderungen: Ort ' || :old.ort || ' zu ' || :new.ort);
    END IF;

    IF :old.adresse <> :new.adresse THEN
        INSERT INTO patientupdate (details)
        VALUES ('Veränderungen: Vorname ' || :old.adresse || ' zu ' || :new.adresse);
        dbms_output.put_line('Veränderungen: Adresse ' || :old.adresse || ' zu ' || :new.adresse);
    END IF;

    IF :old.hausnr <> :new.hausnr THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.hausnr || ' zu ' || :new.hausnr);
        dbms_output.put_line('Veränderungen: Hausnummer ' || :old.hausnr || ' zu ' || :new.hausnr);
    END IF;

    IF :old.geb <> :new.geb THEN
        INSERT INTO patientupdate (details) VALUES ('Veränderungen: Vorname ' || :old.geb || ' zu ' || :new.geb);
        dbms_output.put_line('Veränderungen: Geburtsdatum ' || TO_CHAR(:old.geb, 'DD.MM.YYYY') || ' zu ' ||
                             TO_CHAR(:new.geb, 'DD.MM.YYYY'));
    END IF;
END;
/

CREATE OR REPLACE TRIGGER error_logging_trigger
    AFTER SERVERERROR
    ON DATABASE
DECLARE
    v_error_code number         := SQLCODE; -- Fehlercode
    v_error_msg  varchar2(4000) := SQLERRM; -- Fehlermeldung
BEGIN
    -- Optional: Die Fehlermeldung in die Datenbankprotokolle (DBMS_OUTPUT) schreiben
    INSERT INTO fehler (details) VALUES ('Fehlercode: ' || v_error_code || ' Fehlermeldung: ' || v_error_msg);
    dbms_output.put_line('Fehlercode: ' || v_error_code);
    dbms_output.put_line('Fehlermeldung: ' || v_error_msg);
    dbms_output.put_line(CURRENT_TIMESTAMP);
END;
/