package com.edu.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*
 * JDBC 4단계 
 * 1. 클라이언트 메모리에 드라이버를 로딩
 * 	   이때 드라이버 정보의 압축파일(~~.jar)이 default 클래스 패스로 잡혀져 있어야 한다.
 * 	  ext 디렉토리 기억!!
 * 
 * 	  Class.forName("드라이버 이름");
 * 
 * 2. DB Server와 연결
 * 
 * 3. PreparedStatement 객체를 생성
 * 	  PreparedStatement ps = conn.prepareStatement(sql);
 * 
 * 4. Query문 실행
 */
public class DBConnectionTest1 {
	public DBConnectionTest1() {
		try {
			// 1. 드라이버 로딩...
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로딩 성공");

			// 2. DB Servcer와 연결
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
			Connection conn = DriverManager.getConnection(url, "hr", "hr");
			System.out.println("DB Server 연결 성공");
			
			// 3. PreparedStatement 객체 생성
			/*
			 * create table custom(
			 * 	id number(10) primary key;
			 * name varchar2(20),
			 * addr varchar2(30));
			 */
			/*String query = "INSERT INTO custom (id, name, addr) values (?, ?, ?)";
			PreparedStatement st = conn.prepareStatement(query);
			System.out.println("3. PreparedStatement 생성...");
			
			// 4. ?에 대한 값을 바인딩하고 쿼리문 실행
			st.setInt(1, 3); // 첫 번째가 0이 아니고 1임
			st.setString(2,  "구자경");
			st.setString(3,  "신림동");
			System.out.println(st.executeUpdate() + " row INSERT ok!");*/
			
			//delete... 333에 해당하는 구자경을 삭제
			/*String query = "Delete from custom where id = ?";
			PreparedStatement st = conn.prepareStatement(query);
			System.out.println("3. PreparedStatement 생성...");
			
			// 4. ?에 대한 값을 바인딩하고 쿼리문 실행
			st.setInt(1, 3);
			System.out.println(st.executeUpdate() + " row DELETE	 ok!");*/
			
			//update
			/*String query = "Update custom set name = ?, addr = ? where id = ?";
			PreparedStatement st = conn.prepareStatement(query);
			System.out.println("3. PreparedStatement 생성...");
			
			// 4. ?에 대한 값을 바인딩하고 쿼리문 실행
			st.setString(1, "염미정");
			st.setString(2, "산포시");
			st.setInt(3, 1);
			System.out.println(st.executeUpdate() + " row Update	 ok!");*/
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			System.out.println("DB Server 연결 실패");
		}
	}

	public static void main(String[] args) {
		new DBConnectionTest1();
	}
}
