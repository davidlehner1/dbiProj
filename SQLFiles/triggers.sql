CREATE OR REPLACE TRIGGER termin_update_trigger
BEFORE INSERT OR UPDATE OR DELETE ON termin
FOR EACH ROW
DECLARE
BEGIN
    IF INSERTING THEN
        -- Einfügeaktion: Protokolliere die Einfügeaktion
        DBMS_OUTPUT.PUT_LINE('Neuer Termin eingefügt - Termin ID: ' || :NEW.terminid);
    ELSIF UPDATING THEN
        -- Update-Aktion: Protokolliere die Aktualisierung
        DBMS_OUTPUT.PUT_LINE('Termin aktualisiert - Termin ID: ' || :NEW.terminid);
    ELSIF DELETING THEN
        -- Löschaktion: Protokolliere die Löschung
        DBMS_OUTPUT.PUT_LINE('Termin gelöscht - Termin ID: ' || :OLD.terminid);
    END IF;
END;
/

-- Trigger erstellen
CREATE OR REPLACE TRIGGER patient_update_trigger
BEFORE UPDATE ON patient
FOR EACH ROW
DECLARE
BEGIN
    IF :OLD.vname <> :NEW.vname OR
       :OLD.nname <> :NEW.nname OR
       :OLD.plz <> :NEW.plz OR
       :OLD.ort <> :NEW.ort OR
       :OLD.adresse <> :NEW.adresse OR
       :OLD.hausnr <> :NEW.hausnr OR
       :OLD.geb <> :NEW.geb THEN
        DBMS_OUTPUT.PUT_LINE('Patientendaten geändert - SVN: ' || :OLD.svn);
    END IF;
        IF :OLD.vname <> :NEW.vname THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Vorname ' || :OLD.vname || ' zu ' || :NEW.vname);
    END IF;

    IF :OLD.nname <> :NEW.nname THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Nachname ' || :OLD.nname || ' zu ' || :NEW.nname);
    END IF;

    IF :OLD.plz <> :NEW.plz THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: PLZ ' || :OLD.plz || ' zu ' || :NEW.plz);
    END IF;

    IF :OLD.ort <> :NEW.ort THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Ort ' || :OLD.ort || ' zu ' || :NEW.ort);
    END IF;

    IF :OLD.adresse <> :NEW.adresse THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Adresse ' || :OLD.adresse || ' zu ' || :NEW.adresse);
    END IF;

    IF :OLD.hausnr <> :NEW.hausnr THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Hausnummer ' || :OLD.hausnr || ' zu ' || :NEW.hausnr);
    END IF;

    IF :OLD.geb <> :NEW.geb THEN
        DBMS_OUTPUT.PUT_LINE('Veränderungen: Geburtsdatum ' || TO_CHAR(:OLD.geb, 'DD.MM.YYYY') || ' zu ' || TO_CHAR(:NEW.geb, 'DD.MM.YYYY'));
    END IF;
END;
/

CREATE OR REPLACE TRIGGER error_logging_trigger
AFTER SERVERERROR ON DATABASE
DECLARE
    v_error_code NUMBER := SQLCODE;          -- Fehlercode
    v_error_msg  VARCHAR2(4000) := SQLERRM;  -- Fehlermeldung
BEGIN
    -- Optional: Die Fehlermeldung in die Datenbankprotokolle (DBMS_OUTPUT) schreiben
    DBMS_OUTPUT.PUT_LINE('Fehlercode: ' || v_error_code);
    DBMS_OUTPUT.PUT_LINE('Fehlermeldung: ' || v_error_msg);
    DBMS_OUTPUT.PUT_LINE(CURRENT_TIMESTAMP);
END;
/