BEGIN
INSERT INTO SZEKHELY VALUES (1,1027,’Budapest’,’Varga köz’,18);
INSERT INTO SZEKHELY VALUES (2,1025,’Budapest’,’Kossuth utca’,7);
INSERT INTO SZEKHELY VALUES (3,3531,’Miskolc’,’Bársony út’,2);
INSERT INTO SZEKHELY VALUES (4,102,’Pest’,’Pestőfi utca’,30);
INSERT INTO SZEKHELY VALUES (5,1027,’Buda’,’Pákász utca’,8);
INSERT INTO SZEKHELY VALUES (6,3000,’Füzesabony’,’Mihály köz’,9);
END;

BEGIN
INSERT INTO FOGYASZTOK VALUES (1,’Bánfi Orsolya’,’Kovács Péter’,’Asztalos’,7417175879);
INSERT INTO FOGYASZTOK VALUES (2, Tóth József’,’Tóth Miklós’,’Programozó’,7417175880);
INSERT INTO FOGYASZTOK VALUES (3, ’Braskó Áron’,’Braskó Anett’,’Orvos’,7417175130);
INSERT INTO FOGYASZTOK VALUES (4, ’Bánfi Orsolya’,’Kovács Norbert, ’Programozó’,7417175672);
INSERT INTO FOGYASZTOK VALUES (5, ’Kossuth Lajos’,’Kossuth János’,’Kohász’,7417175249);
INSERT INTO FOGYASZTOK VALUES (6, ’Szent István’,’Szent Árpád’,’Bányász’,7417175159);
END;

BEGIN
INSERT INTO CEG VALUES (1,’Logiscool’, TO_DATE (’20080521’, ’YYYYMMDD’),1 ,4);
INSERT INTO CEG VALUES (2,’WoodenSchool’, TO_DATE (’20200118’, ’YYYYMMDD’),2 ,1);
INSERT INTO CEG VALUES (3,’Debreceni Egyetem Private School’, TO_DATE (’20121231’, ’YYYYMMDD’),3 ,3);
INSERT INTO CEG VALUES (4,’Codecool’, TO_DATE (’20100509’, ’YYYYMMDD’),4 ,2);
INSERT INTO CEG VALUES (5,’MinerLiner’, TO_DATE (’19980520’, ’YYYYMMDD’),5 ,6);
INSERT INTO CEG VALUES (6,’Miskolci Egyetem Kohászat’, TO_DATE (’19751021’, ’YYYYMMDD’),6 ,5);
END;
