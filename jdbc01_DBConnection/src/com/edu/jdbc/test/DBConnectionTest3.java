package com.edu.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*
 * Test2의 문제점은
 * 1. 서버 정보가 프로그램에 하드코딩 되어져 있다. ==> public static final 상수
 * 2. Connection을 열어서 사용한 후 close를 안하고있다... => finally 구문
 */
public class DBConnectionTest3 {
	// Meta Data(모듈화해서 딴데 빼면 소스를 안건드리고 유지보수가 가능)
	public static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	public static final String SERVER_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	public static final String USER = "hr";
	public static final String PASS = "hr";
	
	public DBConnectionTest3() throws ClassNotFoundException, SQLException {
		// 로컬변수로 일단 선언...
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// 1. 드라이버 로딩...
			Class.forName(DRIVER_NAME);
			System.out.println("드라이버 로딩 성공");

			// 2. DB Server와 연결
			conn = DriverManager.getConnection(SERVER_URL, USER, PASS);// 무슨일이 있어도 닫아줘야한다.
			System.out.println("DB Server 연결 성공");

			// 3. PreparedStatement 객체 생성
			String query = "SELECT id, name, addr FROM custom";
			ps = conn.prepareStatement(query);
			System.out.println("PreparedStatement 생성...");

			// 4. 바인딩, 쿼리문 실행
			rs = ps.executeQuery();
			while (rs.next()) {
				System.out.println("ID : " + rs.getInt("id") 
								+ "\t NAME : " + rs.getString("name") 
								+ "\t Addr : " + rs.getString("addr"));
			}
		} finally {
			// 연 순서의 역으로 닫아준다.
			rs.close();
			ps.close();
			conn.close();
			
		}
	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		new DBConnectionTest3();
	}
}
