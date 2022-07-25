package com.edu.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.ServerInfo;
import sql.QueryInfo;
/*
 CREATE TABLE CUSTOMER(
SSN NUMBER(13) PRIMARY KEY,
NAME VARCHAR2(10),
ADDRESS VARCHAR2(50));
 */
public class CustomerJDBCTest {
	public CustomerJDBCTest() throws ClassNotFoundException, SQLException {
		// 로컬변수로 일단 선언...
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// 1. 드라이버 로딩...
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("드라이버 로딩 성공");

			// 2. DB Server와 연결
			conn = DriverManager.getConnection(ServerInfo.SERVER_URL, ServerInfo.USER, ServerInfo.PASS);// 무슨일이 있어도 닫아줘야한다.
			System.out.println("DB Server 연결 성공");

			// 3. PreparedStatement 객체 생성 //4. 바인딩, 쿼리문 실행
			/*
			 * Insert
			ps = conn.prepareStatement(QueryInfo.insertQuery);
			ps.setLong(1, 9601231234567l);
			ps.setString(2,  "송원준");
			ps.setString(3,  "금정구");
			System.out.println(ps.executeUpdate() + " row INSERT ok!");
			*/
			
			/* 
			 * update
			ps = conn.prepareStatement(QueryInfo.updateQuery);
			ps.setString(1, "송원준2");
			ps.setString(2,  "금정구2");
			ps.setLong(3,  9601231234567l);
			System.out.println(ps.executeUpdate() + " row UPDATE ok!");			
			*/
			
			/*
			 * delete
			ps = conn.prepareStatement(QueryInfo.deleteQuery);
			ps.setLong(1,  9601231234567l);
			System.out.println(ps.executeUpdate() + " row DELETE ok!");
			*/
			
			//select
			ps = conn.prepareStatement(QueryInfo.selectQuery);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				System.out.println("SSN : " + rs.getLong("ssn") 
								+ "\t NAME : " + rs.getString("name") 
								+ "\t Addr : " + rs.getString("address"));
			}
			
			
		} finally {
			// 연 순서의 역으로 닫아준다.
			rs.close();
			ps.close();
			conn.close();
			
		}
	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		new CustomerJDBCTest();
	}
}