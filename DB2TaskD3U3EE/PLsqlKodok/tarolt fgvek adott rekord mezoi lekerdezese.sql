create or replace function szekhely_irsznov (varosbe in char, ert in int) return number as
	cursor cur_a is select * from SZEKHELY where szekhely_varos = varosbe 
	for update of szekhely_irsz;
	db number :=0;
begin
	for cv in cur_a loop
		update SZEKHELY set szekhely_irsz = cv.szekhely_irsz*(1+ert/100) where current of cur_a;
	db:= db+1;
	end loop;
	return db;
end;


futtatás:
declare
x NUMBER(6):=0;
begin
x:=szekhely_irsznov('Eger',10);
dbms_output.put_line(x);
end;


create or replace procedure szekhely_irsznovim (varosbe in char, ert in int) is db number:=0; 
begin
for cv in (select * from SZEKHELY where szekhely_varos = varosbe) loop 
dbms_output.put_line('In: '||cv.szekhely_varos||'-'||cv.szekhely_irsz||'-'||cv.szekhely_id); 
update SZEKHELY set szekhely_irsz=cv.szekhely_irsz*(1+ert/100) where SZEKHELY.szekhely_id = cv.szekhely_id; 
select * into cv from SZEKHELY where szekhely_id = cv.szekhely_id; 
dbms_output.put_line('Out: '||cv.szekhely_varos||'-'||cv.szekhely_irsz||'-'||cv.szekhely_id); 
db:=db+1;
end loop;
dbms_output.put_line('Árváltozás: '||db);
end;

futtatás:
Begin
szekhely_irsznovim('Miskolc',10);
end;


create procedure FogyInSzakmaLista3 (szakma in char) is cursor cur_a is select * from FOGYASZTOK where fogyaszto_foglalkozas = szakma;
	a cur_a%rowtype;
begin
	open cur_a;
	loop
		fetch cur_a into a;
		exit when cur_a%notfound;
		dbms_output.put_line('Szakma amit a gyermek tanul: '|| a.fogyaszto_foglalkozas || 'Gyermek neve: '|| a.fogyaszto_gyermek);
	end loop;
	close cur_a;
end;


futtatás
begin
FogyInSzakmaLista3('Programozó');
end;

create or replace procedure IndexAlapjanKiir (index1 in int, index2 in int)as 
    cursor cur is select * from CEG where cid >= index1 and cid <= index2;
    cv cur%rowtype;
begin
	open cur;
	fetch cur into cv;
	if cur%notfound then
	    dbms_output.put_line('Nincs találat!');
    else
        dbms_output.put_line('Cégneve:'  || cv.nev  || ' Alapítás dátuma: '|| cv.alapitasiev || ' index :' || cv.cid);
        loop
	        fetch cur into cv; 
            exit when cur%notfound; 
            dbms_output.put_line('Cégneve: ' || cv.nev  || ' Alapítás dátuma: '|| cv.alapitasiev || ' index :' || cv.cid);
        end loop;
    end if;
    close cur;
end; 

futtatás:
begin 
IndexAlapjanKiir(2,8);
end;



