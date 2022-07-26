package com.edu.jdbc.test;

import java.sql.SQLException;

import com.edu.jdbc.dao.CustomerDAO;

import config.ServerInfo;

public class SimpleCustomerDAOTest1 {
	public static void main(String[] args) {
		CustomerDAO dao = new CustomerDAO();

		try {
			//dao.addCustomer(444, "James", "NY");
			
			//dao.deleteCustomer(333);
			
			//dao.updateCustomer(444, "제임스", "청학동");
			
			dao.printAllCustomer();
		} catch (SQLException e) {
			System.out.println("연결 실패...");
		}
	}

	// static initialization block... main보다 더 먼저 돈다.
	static {
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("드라이버 로딩 성공...");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패...");
		}
	}
}
