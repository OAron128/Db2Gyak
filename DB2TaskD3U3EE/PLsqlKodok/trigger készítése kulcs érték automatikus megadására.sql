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

futtatás: (csak egyet csináltam, mert azonos a felépítésük a többivel)

declare 
    x number;
    y number;
    z number;
    q number;
begin
    select count(*) into x from fogyasztok where fogyaszto_id = 11;
    dbms_output.put_line('az id 11: ' || x);
    select count(*) into y from fogyasztok where fogyaszto_diakigazolvany = 9991110002;
    dbms_output.put_line('a diakig 999111002: ' || y);
    select count(*) into z from fogyasztok where fogyaszto_diakigazolvany = 9991110002;
    dbms_output.put_line('a diakig 998111002: ' || z);
    select count(*) into q from fogyasztok where fogyaszto_diakigazolvany = 9991110002;
    dbms_output.put_line('a diakig 997111002: ' || q);
end;


delete from fogyasztok where fogyaszto_diakigazolvany = 9991110002;
delete from fogyasztok where fogyaszto_diakigazolvany = 9981110002;
delete from fogyasztok where fogyaszto_diakigazolvany = 9971110002;
insert into fogyasztok values (11, 'szulonev', 'gyermeknev', 'foglalkozas', 9991110002);
insert into fogyasztok values (11, 'szulonev', 'gyermeknev', 'foglalkozas', 9971110002);
insert into fogyasztok values (11, 'szulonev', 'gyermeknev', 'foglalkozas', 9981110002);

