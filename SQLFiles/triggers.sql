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