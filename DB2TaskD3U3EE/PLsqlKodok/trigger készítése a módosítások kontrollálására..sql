create or replace trigger irszell before UPDATE of szekhely_irsz on SZEKHELY FOR EACH ROW
declare
maxirsz  number;
minirsz number;
BEGIN
maxirsz :=10000;
minirsz := 999;
    if (:new.szekhely_irsz not between minirsz and maxirsz ) then
        :new.szekhely_irsz := :old.szekhely_irsz;
    end if; 
end;

futtatások;
update SZEKHELY set szekhely_irsz =3531 where szekhely_id =3;
update SZEKHELY set szekhely_irsz =00 where szekhely_id =3;

select * from SZEKHELY where szekhely_id =3;



create or replace trigger diakigell before UPDATE ON FOGYASZTOK FOR EACH ROW
declare
maxdiak  number;
mindiak number;
BEGIN
maxdiak  :=10000000000;
mindiak := 999999999;
    if (:new.fogyaszto_diakigazolvany not between mindiak and maxdiak ) then
        :new.fogyaszto_diakigazolvany := :old.fogyaszto_diakigazolvany;
    end if; 
end;

futtatások:
update FOGYASZTOK set fogyaszto_diakigazolvany =12345678 where fogyaszto_id =2;
update FOGYASZTOK set fogyaszto_diakigazolvany =00 where fogyaszto_id =2;

select * from fogyasztok where fogyaszto_id =2;





create or replace trigger CheckEvCeg before update of alapitasiev on CEG for each row
begin
    if :new.alapitasiev > sysdate then 
        :new.alapitasiev := sysdate;
    end if;
end;

futtatások:
UPDATE CEG SET alapitasiev = to_date('20330205','YYYYMMDD') where cid = 2;

select * from ceg where cid = 2;
