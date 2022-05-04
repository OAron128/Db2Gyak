create or replace package SZEKHELY_cs as 
	procedure ModSZ(szidbe int, irszbe int);
	function KerV(szidbe in int) return char;
end SZEKHELY_cs;
create or replace package body SZEKHELY_cs as
	procedure ModSZ(szidbe int, irszbe int) as
	begin
		update SZEKHELY set szekhely_irsz = irszbe where szekhely_id = szidbe;
	end;
	function KerV(szidbe in int) return char as szvaros char(25);
	begin
		select szekhely_varos into szvaros from  SZEKHELY where szekhely_id = szidbe;
		return szvaros;
	end;
end SZEKHELY_cs;


futtatások:
begin
SZEKHELY_cs.ModSZ(10,3531);
end;

select SZEKHELY_cs.KerV(10) from dual;



create or replace package FOGYASZTOK_cs as
	procedure ModF(fidbe int, diakbe int);
	function KerSZ(fidbe int) return char;
end FOGYASZTOK_cs;

create or replace package body FOGYASZTOK_cs as
	procedure ModF(fidbe int, diakbe int) as
	begin
		update FOGYASZTOK set fogyaszto_diakigazolvany = diakbe where fogyaszto_id = fidbe;
	end;
	function KerSZ(fidbe int) return char as sznev char(30);
	begin
		select fogyaszto_szulonev into sznev from FOGYASZTOK where fogyaszto_id = fidbe;
		return sznev; 
	end;


futtatások:
begin
FOGYASZTOK_cs.ModF(10,3531);
end;

select FOGYASZTOK_cs.KerSZ(10) from dual;



create or replace package body CEG_cs as
	procedure ModD(cidbe int, datumbe char) as
	begin
		update CEG set alapitasiev = TO_DATE(datumbe,'YYYYMMDD') where cid = cidbe;
	end;
	function KerN(cidbe in int) return char as cnev char (35);
	begin
		select nev into cnev from CEG where cid = cidbe;
		return cnev;
	end;
end CEG_cs;

futtatások:
begin
CEG_cs.ModD(2,'20020205');
end;
select CEG_cs.KerN(2) from dual;


