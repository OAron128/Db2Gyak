create or replace procedure BeszurSzekhely(szid in number, irsz in number, szekhely_varos in char, szekhely_utca in char, hazszam in number) as
    x number;
begin
select count(*) into x from SZEKHELY where szekhely_id = szid;
    if x > 0 then
        dbms_output.put_line('Már létezik ezzel az ID-val egy székhely!');
    else
        insert into SZEKHELY values (szid, irsz, szekhely_varos, szekhely_utca, hazszam);
        dbms_output.put_line('Egy sor beszúrva a Székhely táblába!');
    end if;

end;

futtatás:
BEGIN
SELECT BeszurSzekhely(10, 3532, 'Eger','Kálmán tér', 46) FROM SZEKHELY;
END;


create or replace procedure BeszurFogyasztok(fid in number, sznev in char, gynev in char, ffoglalkozas in char, diakig in number) as
    x number;
begin
select count(*) into x from FOGYASZTOK where fogyaszto_id = fid;
    if x > 0 then
        dbms_output.put_line('Már létezik ezzel az ID-val egy fogyasztó!');
    else
        select count(*) into x from FOGYASZTOK where fogyaszto_diakigazolvany = diakig;
        if x > 0 then
            dbms_output.put_line('Már létezik ezzel az igazolványszámmal egy fogyasztó!');

        else
            insert into FOGYASZTOK values (fid, sznev, gynev, ffoglalkozas, diakig);
        dbms_output.put_line('Egy sor beszúrva a fogyasztók táblába!');
        end if;
    end if;
end;

futtatás:
Begin
BeszurFogyasztok(10,'Tóth Péter','Tóth Annamária','Programozó',74171758794);
end;


create or replace procedure BeszurCeg(cegid in number, cnev in char, datum in date, szekid in number, fogyid in number) as
    x number;
begin
    select count(*) into x from CEG where cid = cegid;
    if x > 0 then
        dbms_output.put_line('Már létezik ezzel az ID-val egy cég!');
    else
        select count(*) into x from CEG where sz_id = szekid;
        if x > 0 then
            dbms_output.put_line('Már létezik a cég ezzel a székhely id-val');
        else
            select count(*) into x from CEG where f_id = fogyid;
             if x < 1 then
                dbms_output.put_line('Nem létezik ez a fogyasztó id a cégnél!');
             else
                insert into CEG values (cegid, cnev, datum, szekid, fogyid);
                dbms_output.put_line('Egy sor beszúrva a cég táblába!');
            end if;
        end if;
    end if;
end;

futtatás
begin
BeszurCeg(7,'Dumaszínház',TO_DATE('20000612','YYYMMDD'),10,3);
end;

