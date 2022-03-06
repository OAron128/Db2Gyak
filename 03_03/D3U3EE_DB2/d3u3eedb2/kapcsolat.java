package d3u3eedb2;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.Connection;

public class kapcsolat {

	static Connection conn = null;
	static Statement s;
	static PreparedStatement ps;
	static Scanner sc;
	static String user;
	static ResultSet rs;   //eredm�nylek�rdez�s?
	public static void main(String[] args) {

		DriverReg();
		Connect();
		StatikusTablaLetrehozas();

		// LeKapcs();

	}

	public static void DriverReg() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Sikeres driver regisztr�l�s\n");
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
			System.out.println("Sikeres kapcsol�d�s\n");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void LeKapcs() {
		if (conn != null) {
			try {
				conn.close();
				System.out.println("Sikeres lekapcsol�d�s\n");
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	// 1 feladat auto �s tulaj t�bla l�trehoz�sa
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
				System.out.println("Aut� t�bla l�trej�tt\n");
				s.execute(sqlp_tulaj);
				System.out.println("Tulajdonos t�bla l�trej�tt\n");
				s.close(); // er�forr�s felszabad�t�sa
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
				System.out.println("Auto t�bla m�dos�tva\n");
				s.close();
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}

	// 3. feladat
	public static void StatikusAdatfelvitel() {
		if (conn != null) {
			String sqlp_tul = "INSERT INTO tulaj VALUES(1, 'T�th M�t�', "
					+ " ' Miskolc', to_date('1980.05.12', 'yyyy.mm.dd'))";

			String[] sqlp = { "INSERT INTO auto VALUES('aaa111','opel','piros',2014,1650000,1)",
					"INSERT INTO auto VALUES('bbb222','mazda',null,2016,2800000,1)",
					"INSERT INTO auto VALUES(rsz, tipus, evjarat, ar) VALUES ('ccc333','ford',2009,1500000)" };
			try {
				s = conn.createStatement();
				s.execute(sqlp_tul);
				System.out.println("Tulaj felv�ve\n");
				s.close();
			} catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
			for (int i = 0; i < sqlp.length; i++) {
				try {
					s = conn.createStatement();
					s.executeUpdate(sqlp[i]);
					System.out.println("Aut� felv�ve\n");
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
			//Az SQL parancsban a ? hely�re kwe�lnek a param�terek
			String sqlp ="INSERT INTO auto(rsz, tipus, szin, evjarat, ar, tulaj_id)"+"VALUES (?, ?, ?, ?, ?, ?)";
			
			System.out.println("K�rem a rendsz�mot: " );
			String rsz = sc.next().trim();
			
			System.out.println("K�rem a t�pust: ");
			String tipus= sc.next().trim();
			
			System.out.println("K�rem adja meg a sz�nt: ");
			String szin =sc.next().trim();
			
			System.out.println("K�rem adja meg az �vj�ratot: ");
			int evjarat = sc.nextInt();
			
			System.out.println("K�rem adja meg az �rat: ");
			float ar = sc.nextFloat();
			
			System.out.println("K�rem a tulajdonos azonos�t�j�t: ");
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
				System.out.println("Aut� felv�tele\n");
			}catch (Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	//5. feladat
	public static void DinamikusTorles() {
		System.out.println("T�rlend� aut�: ");
		String rsz = sc.next();
		//Az sql parancsban a ? hely�re ker�lnek a param�terek
		String sqlp ="DELETE FROM"+user+".AUTO"+"WHERE rsz=?";
		if(conn != null) {
			try {
				ps = conn.prepareStatement(sqlp);
				ps.setString(1, rsz);
				ps.executeUpdate();
				ps.close();
				System.out.println(rsz +"rendsz�m� aut� t�r�lve\n");
			} catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
	}
	
	public static void StatikusAdatTorles() {
		System.out.println("T�rlend� aut�: ");
		String rsz= sc.next();
		String sqlp = "DELETE FROM auto WHERE rsz LIKE '"+rsz+"'";
		if(conn!= null) {
			try {
				s = conn.createStatement();
				s.executeUpdate(sqlp);
				s.close();
				System.out.println(rsz+" rendsz�m� aut� t�r�lve!\n");
			}catch(Exception ex) {
				System.err.println(ex.getMessage());
			}
		}
		
	}
	//6. feladat
	public static void StatikusLekerdezes() {
		if(conn!= null) {
			String sqlp = "SELECT * FROM auto";
			System.out.println("Rendsz�m T�pus Sz�n �vj�rat �r Tulaj");
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
	static public void ModosithatoKurzor() {
		System.out.println("Sz�n: ");
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
}
