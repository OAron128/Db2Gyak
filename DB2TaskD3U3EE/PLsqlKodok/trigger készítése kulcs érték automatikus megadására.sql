create sequence szekhely_szekvencia;


create or replace trigger szekhely_on_beszur before INSERT ON SZEKHELY FOR EACH ROW
BEGIN
    SELECT szekhely_szekvencia.nextval into :new.szekhely_id from dual;
end;




create sequence fogyasztok_szekvencia;

create or replace trigger fogyasztok_on_beszur before INSERT ON FOGYASZTOK FOR EACH ROW
BEGIN
    SELECT fogyasztok_szekvencia.nextval into :new.fogyaszto_id from dual;
end;




create sequence ceg_szekvencia1;

create or replace trigger ceg_on_beszur before INSERT ON CEG FOR EACH ROW
BEGIN
    SELECT ceg_szekvencia1.nextval into :new.cid from dual;
end;

