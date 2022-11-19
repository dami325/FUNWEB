package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//JDBC 를 활용한 애플리케이션 개발 시 DB 접근 관련 작업 등을 수행하는 용도의 클래스 정의
// => DB 접속, DB 자원반환(해제), 커밋 또는 롤백 드으이 작업 수행

public class JdbcUtil {
			
		public static Connection getConnection() {
			Connection con =null;
			
			String driver = "com.mysql.cj.jdbc.Driver"; // 드라이버 클래스
			String url = "jdbc:mysql://localhost:3306/dami"; // DB 접속 정보
			String user = "root"; // 계정명
			String password = "1234"; // 패스워드

			try {
				Class.forName(driver);

				con = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				
				System.out.println("드라이버 로드 실패! - " + e.getMessage());
				e.printStackTrace();
			} catch (SQLException e) {
				System.out.println("DB 연결 실패!- " + e.getMessage());
				e.printStackTrace();
			}
			
			
			return con;
		}
		
		
		
		
		public static void close(Connection con) {
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		public static void close(PreparedStatement pstmt) {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		public static void close(ResultSet rs) {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	
}
