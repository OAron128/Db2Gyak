CREATE OR REPLACE PROCEDURE FOGYASZTODiakMod (fogyid in number, diakig in number) as x number;
BEGIN
    SELECT COUNT(*) INTO x FROM FOGYASZTOK WHERE fogyaszto_id = fogyid;
    if x < 1 THEN
        DBMS_OUTPUT.PUT_LINE('Nem létezik ezzel az ID-val a Fogyasztó!');
    else
        UPDATE FOGYASZTOK SET fogyaszto_diakigazolvany = diakig where fogyaszto_id = fogyid;
         DBMS_OUTPUT.PUT_LINE('Sikeres Update');
    end if;
end;


futtatás:
BEGIN
FOGYASZTODiakMod(1, 7417175879);
END;


CREATE OR REPLACE PROCEDURE SZEKHELYirszMod (szekid in number, irszmod in number) as x number;
BEGIN
    SELECT COUNT(*) INTO x FROM SZEKHELY WHERE szekhely_id = szekid;
    if x < 1 THEN
        DBMS_OUTPUT.PUT_LINE('Nem létezik ezzel az ID-val a Székhely!');
    else
        UPDATE SZEKHELY SET szekhely_irsz = irszmod where szekhely_id = szekid;
         DBMS_OUTPUT.PUT_LINE('Sikeres update a székhely táblán');
    end if;
end;


futtatás:
Begin
SZEKHELYirszMod(1,1023);
end;



CREATE OR REPLACE PROCEDURE CEGszidfidMod (cegid in number, szid in number, fid in number) 
as x number;
BEGIN
    SELECT COUNT(*) INTO x FROM CEG WHERE cid = cegid;
    if x < 1 THEN
        DBMS_OUTPUT.PUT_LINE('Nem létezik ezzel az ID-val a CÉG!');
    else
        UPDATE CEG SET f_id = fid where cid = cegid ;
            UPDATE CEG SET sz_id = szid where cid = cegid;
        DBMS_OUTPUT.PUT_LINE('Sikeres update a cég táblán');
    end if;
end;

futtatás
begin
CEGszidfidMod(1,1,1);
end;

