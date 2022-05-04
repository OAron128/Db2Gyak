create table Naplo (muvelet char(50), datum date, felhasznalo char(20));


create or replace trigger irszellnaplo before UPDATE of szekhely_irsz on SZEKHELY FOR EACH ROW
declare
maxirsz  number;
minirsz number;
msg char(50) := concat(:old.szekhely_irsz, ' Módosítva lett a Székhely irányítószáma.');
BEGIN
maxirsz :=10000;
minirsz := 999;
    if (:new.szekhely_irsz not between minirsz and maxirsz ) then
        :new.szekhely_irsz := :old.szekhely_irsz;
        insert into naplo values(msg, sysdate, user);
    end if; 
end;

futtatások:
update SZEKHELY set szekhely_irsz=3531 where szekhely_id=10;

select * from SZEKHELY where szekhely_id=2;

SELECT * from naplo;






create or replace trigger diakigellnaplo before UPDATE ON FOGYASZTOK FOR EACH ROW
declare
maxdiak  number;
mindiak number;
msg char(50) := concat(:old.fogyaszto_diakigazolvany, ' Módosítva lett a fogyasztó diákja.');
BEGIN
maxdiak  :=10000000000;
mindiak := 999999999;
    if (:new.fogyaszto_diakigazolvany not between mindiak and maxdiak ) then
        :new.fogyaszto_diakigazolvany := :old.fogyaszto_diakigazolvany;
        insert into naplo values(msg, sysdate, user);
    end if; 
end;

futtatások:
update FOGYASZTOK set fogyaszto_diakigazolvany =12345678 where fogyaszto_id =2;

select * from fogyasztok where fogyaszto_id =2;

SELECT * from naplo;






create or replace trigger CheckEvCegNaplo before update of alapitasiev on CEG for each row
declare
msg char(50) := concat(:old.alapitasiev, ' Módosítva lett a Cég Dátuma.');
begin

    if :new.alapitasiev > sysdate then 
        :new.alapitasiev := sysdate;
        insert into naplo values(msg, sysdate, user);
    end if;
end;

futtatások:
UPDATE CEG SET alapitasiev = TO_DATE('20330101','YYYYMMDD')WHERE cid=3;

SELECT * FROM CEG FROM cid=3;

select * from naplo;