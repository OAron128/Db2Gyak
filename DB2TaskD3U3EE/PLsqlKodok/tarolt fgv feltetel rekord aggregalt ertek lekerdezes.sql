CREATE OR REPLACE FUNCTION CegIDKeres (cegazonosito IN NUMBER) RETURN CHAR AS x number;
vi char(100) :='Nem létező azonosító!';
y char(40);
BEGIN
	SELECT COUNT(*) INTO x FROM CEG WHERE cid = cegazonosito;
	IF x >= 1 THEN
		SELECT nev INTO y FROM CEG WHERE cid = cegazonosito;
		vi :='A talált cég neve: '|| y;
    END IF;
RETURN vi;
END;

futtatás:
SELECT CegIDKeres(1) from dual;

create or replace procedure del_SZid (idbe in number) as db number;
 h_roszid exception; 
begin 
select count(*) into db from SZEKHELY where szekhely_id = idbe; 
if db=0 then raise h_roszid; 
else 
delete from SZEKHELY where szekhely_id = idbe; 
end if; 
exception 
when h_roszid then dbms_output.put_line('Hibás rendszám'); 
end;

futtatás:
begin
del_szid(1);
end;


CREATE OR REPLACE FUNCTION FogyDiakKeres (fogyid IN NUMBER) RETURN CHAR AS x number;
idvalasz char(100) :='Nem létező azonosító!';
ig number(10);

BEGIN
	SELECT COUNT(*) INTO x FROM FOGYASZTOK WHERE fogyaszto_id = fogyid;
	IF x >= 1 THEN
		SELECT fogyaszto_diakigazolvany INTO ig FROM FOGYASZTOK WHERE fogyaszto_id = fogyid;
		idvalasz :='A talált cég neve: '|| ig;
    END IF;
RETURN idvalasz;
END;

futtatás
select FogyDiakKeres(4) from dual;

