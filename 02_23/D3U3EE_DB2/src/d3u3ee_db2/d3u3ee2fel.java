package d3u3ee_db2;

public class d3u3ee2fel {

	public static void main(String[] args) {
		
	}
	
	
	public void DriverReg() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Sikeres driver feltöltés!\n");
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

}
