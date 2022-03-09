package d3u3eedb2;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.CallableStatement;
import java.sql.Connection;

public class kapcsolat {

	static Connection conn = null;
	static Statement s;
	static PreparedStatement ps;
	static Scanner sc;
	static String user;
	static ResultSet rs;   //eredménylekérdezés?
	static CallableStatement  cs;  //hívási rész
	public static void main(String[] args) {

		DriverReg();
		Connect();
		StatikusTablaLetrehozas();

		// LeKapcs();

	}

	public static void DriverReg() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Sikeres driver regisztrálás\n");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void Connect() {
		String url = "jdbc:oracle:thin:@193.6.5.58:1521:XE";
		String user = "H22_d3u3ee";
		String pwd = "D3U3EE";
		try {
			conn = (Connection) DriverManager.getConnection(url, user, pwd);
			System.out.println("Sikeres kapcsolódás\n");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void LeKapcs() {
		if (conn != null) {
			try {
				conn.close();
				System.out.println("Sikeres lekapcsolódás\n");
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	// 1 feladat auto és tulaj tábla létrehozása
	public static void StatikusTablaLetrehozas() {
		String sqlp_auto = "CREATE TABLE auto(rsz char(6) primary key, "
				+ "tipus char(10) not null, szin char(10) default 'feher',"
				+ "evjarat number(4), ar number(8) CHECK(ar>0))";

		String sqlp_tulaj = "CREATE TABLE tulaj(id number(3) primary key, "
				+ "nev char(20) not null, cim char(20), szuldatum date)";

		if (conn != null) {
			try {
				s = conn.createStatement();
				s.execute(sqlp_auto);
				System.out.println("Autó tábla létrejött\n");
				s.execute(sqlp_tulaj);
				System.out.println("Tulajdonos tábla létrejött\n");
				s.close(); // erõforrás felszabadítása
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	// 2. feladat
	public static void StatikusTablaModositas() {
		if (conn != null) {
			try {
				String sqlp = "ALTER TALE auto ADD(tulaj_id REFERENCES tulaj)";
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				System.out.println("Auto tábla módosítva\n");
				s.close();
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	// 3. feladat
	public static void StatikusAdatfelvitel() {
		if (conn != null) {
			String sqlp_tul = "INSERT INTO tulaj VALUES(1, 'Tóth Máté', "
					+ " ' Miskolc', to_date('1980.05.12', 'yyyy.mm.dd'))";

			String[] sqlp = { "INSERT INTO auto VALUES('aaa111','opel','piros',2014,1650000,1)",
					"INSERT INTO auto VALUES('bbb222','mazda',null,2016,2800000,1)",
					"INSERT INTO auto VALUES(rsz, tipus, evjarat, ar) VALUES ('ccc333','ford',2009,1500000)" };
			try {
				s = conn.createStatement();
				s.execute(sqlp_tul);
				System.out.println("Tulaj felvéve\n");
				s.close();
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
			for (int i = 0; i < sqlp.length; i++) {
				try {
					s = conn.createStatement();
					s.executeUpdate(sqlp[i]);
					System.out.println("Autó felvéve\n");
					s.close();
				} catch (Exception ex) {
					System.err.println(ex.getMessage());
				}
			}

		}
	}
	//4. feladat
	public static void DinamikusAdatFelvetel() {
		if(conn != null) {
			//Az SQL parancsban a ? helyére kweülnek a paraméterek
			String sqlp ="INSERT INTO auto(rsz, tipus, szin, evjarat, ar, tulaj_id)"+"VALUES (?, ?, ?, ?, ?, ?)";
			
			System.out.println("Kérem a rendszámot: " );
			String rsz = sc.next().trim();
			
			System.out.println("Kérem a típust: ");
			String tipus= sc.next().trim();
			
			System.out.println("Kérem adja meg a színt: ");
			String szin =sc.next().trim();
			
			System.out.println("Kérem adja meg az évjáratot: ");
			int evjarat = sc.nextInt();
			
			System.out.println("Kérem adja meg az árat: ");
			float ar = sc.nextFloat();
			
			System.out.println("Kérem a tulajdonos azonosítóját: ");
			int tulaj_id = sc.nextInt();
			try {
				ps = conn.prepareStatement(sqlp);
				ps.setString(1, rsz);
				ps.setString(2, tipus);
				ps.setString(3, szin);
				ps.setInt(4, evjarat);
				ps.setFloat(5, ar);
				ps.setInt(6, tulaj_id);
				ps.executeUpdate();
				System.out.println("Autó felvétele\n");
			}catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	//5. feladat
	public static void DinamikusTorles() {
		System.out.println("Törlendõ autó: ");
		String rsz = sc.next();
		//Az sql parancsban a ? helyére kerülnek a paraméterek
		String sqlp ="DELETE FROM"+user+".AUTO"+"WHERE rsz=?";
		if(conn != null) {
			try {
				ps = conn.prepareStatement(sqlp);
				ps.setString(1, rsz);
				ps.executeUpdate();
				ps.close();
				System.out.println(rsz +"rendszámú autó törölve\n");
			} catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	public static void StatikusAdatTorles() {
		System.out.println("Törlendõ autó: ");
		String rsz= sc.next();
		String sqlp = "DELETE FROM auto WHERE rsz LIKE '"+rsz+"'";
		if(conn!= null) {
			try {
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				s.close();
				System.out.println(rsz+" rendszámú autó törölve!\n");
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
		
	}
	//6. feladat
	public static void StatikusLekerdezes() {
		if(conn!= null) {
			String sqlp = "SELECT * FROM auto";
			System.out.println("Rendszám Típus Szín Évjárat Ár Tulaj");
			System.out.println("--------------------------------------");
			try {
				s = conn.createStatement();
				s.executeQuery(sqlp);
				rs = s.getResultSet();
				while(rs.next()) {
					String rsz = rs.getString("rsz");
					String tipus = rs.getString("tipus");
					String szin = rs.getString("szin");
					int evjarat = rs.getInt("evjarat");
					int ar= rs.getInt("ar");
					int tulaj_id = rs.getInt("tulaj_id");
					System.out.println(rsz+"\t\t"+tipus+"\t"+szin+"\t"+evjarat+"\t"+ar+"\t"+tulaj_id);
				}
				rs.close();
			}catch(Exception ex) {
					System.err.println(ex.getMessage());
			}
		}
	}
	
	//7. feladat
	public static void ModosithatoKurzor() {
		System.out.println("Szín: ");
		String szin = sc.next().trim();
		String sqlp ="SELECT ar FROM auto WHERE szin = '"+szin+"'";
		if(conn !=null) {
			try {
				s = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sqlp);
				while(rs.next()) {
					int regiar = rs.getInt("ar");
					rs.updateInt("ar", (regiar*2));
					rs.updateRow();
				}
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
				
			}
		}
	}
	
	//8. feladat
	public static void InEljárásHivas() {
		if(conn != null) {
			try {
				String sqlp = " CREATE or replace procedure arcsokkent"+"(kor IN number) is" + "begin"+ "update auto set ar=ar*0.9 where"+ "to_char(sysdate,'yyyy')-evjarat > kor;"+ "end;";
				System.out.println("Kor: ");
				int kor = sc.nextInt();
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				System.out.println("Függvény létrejött\n");
				cs = conn.prepareCall("{call arcsokkent(?)}");
				cs.setInt(1, kor);
				cs.execute();
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	//9. feladat
	public static void OutjarasHivas() {
		if (conn!= null) {
			try {
				String sqlp= "create or replace procedure atlagar "+ "(sz IN char, atl OUT number) is " + "begin"+ "select avg(ar) into atl from auto where szin=sz; "+"end;";
				System.out.println("Szín: ");
				String szin= sc.next();
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				System.out.println("Eljárás létrejött\n");
				cs = conn.prepareCall("{call atlagar(?, ?)}");
				cs.setString(1, szin);
				cs.registerOutParameter(2, java.sql.Types.FLOAT);
				cs.execute();
				float atlag = cs.getFloat(2);
				System.out.println(szin+ "autók átlagára: "+ atlag+ "\n");
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	public static void FuggvenyHivas() {
		if(conn!= null) {
			try {
				String sqlp = "create or replace function atlagarfv "+"atl number(10,2); "+ "begin"+ "select avg(ar) into atl from auto where szin=sz; "+"return atl; "+ "end;";
				System.out.println("Szín: ");
				String szin= sc.next();
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				System.out.println("Függvény létrejött\n");
				cs = conn.prepareCall("{? = call atlagarfv(?)}");
				cs.registerOutParameter(1, java.sql.Types.FLOAT);
				cs.setString(2, szin);
				cs.execute();
				float atlag = cs.getFloat(1);
				System.out.println(szin+" autók átlagára: "+atlag + "\n");
			}catch(Exception ex) {
				System.err.append(ex.getMessage());
			}
		}
	}
	
	//10. feladat
	
	public static void DinamikusTableTorles() {
		String sqlp = "create or replace procedure tablatorles(nev IN char) is "+ "begin"+ "execute immediate 'drop table' || nev; " +"end;";
		System.out.println("Törlendõ tábla: ");
		String name = sc.next().trim();
		if( conn != null) {
			try {
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				cs = conn.prepareCall("{call tablatorles(?)}");
				cs.setString(1, name);
				cs.execute();
				System.out.println("tábla törölve\n");
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	//11. feladat
	public static void DinamikusModositas() {
		if(conn != null) {
			String sqlp = "update auto1 set ar=ar-?";
			System.out.println("Mennyivel csökkentsük az árat? ");
			int arcsokk = sc.nextInt();
			try {
				conn.setAutoCommit(false);
				try {
					ps = conn.prepareStatement(sqlp);
					ps.setInt(1, arcsokk);
					ps.executeUpdate();
					conn.commit();
					System.out.println("Módosítás megtörtént\n");
				}catch( Exception e) {
					System.err.println(e.getMessage());
					conn.rollback();
					System.out.println("Módosítás visszavonva\n");
				}
				conn.setAutoCommit(true);
			}catch(Exception ex) {
				System.err.print(ex.getMessage());
			}
		}
	}
}
