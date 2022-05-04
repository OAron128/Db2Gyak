CREATE OR REPLACE PROCEDURE Del_fogy (fogynev in char) as db number;
h_nev exception;
begin
select count(*) into db from FOGYASZTOK where fogyaszto_gyermek = fogynev;
if db=0 then raise h_nev;
else delete from FOGYASZTOK where fogyaszto_gyermek = fogynev;
end if;
exception
when h_nev then dbms_output.put_line(’Hibás Név’);
end;


futtatás:
BEGIN
Del_fogy('Kovács János');
END;



CREATE OR REPLACE PROCEDURE Del_szek (szekid in number) as db number;
h_irsz exception;
hiv_sor exception;
begin
select count(*) into db from SZEKHELY where szekhely_id = szekid;
if db=0 then raise h_irsz;
else
    select count(*) into db from CEG where sz_id = szekid;
    if db > 0 then raise hiv_sor;
    else delete from SZEKHELY where szekhely_id = szekid;
    end if;
end if;
exception
when h_irsz then dbms_output.put_line('Hibás Székhely ID');
when hiv_sor then dbms_output.put_line('Erre a sorra történt hivatkozás a cég táblában, nem lehet törölni!');
end;


futtatás:
Begin
Del_szek(11);
end;



CREATE OR REPLACE PROCEDURE Del_ceg (cegid in number) as db number;
h_datum exception;
begin
select count(*) into db from CEG where cid = cegid;
if db=0 then raise h_datum;
else
    delete from CEG where cid = cegid;
end if;
exception
when h_datum then dbms_output.put_line('Hibás Cég ID');
end;


futtatás
begin
Del_ceg(1);
end;

