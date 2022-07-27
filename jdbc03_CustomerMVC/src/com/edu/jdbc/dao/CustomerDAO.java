package com.edu.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.jdbc.exception.DuplicateSsnException;
import com.edu.jdbc.exception.RecordNotFoundException;
import com.edu.jdbc.vo.Customer;

public interface CustomerDAO {
	// 공통적인 기능의 Template
	Connection getConnect() throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps) throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException;

	// Business Logic Template.
	void registerCustomer(Customer cust) throws SQLException, DuplicateSsnException;

	void removeCustomer(int ssn) throws SQLException, RecordNotFoundException;

	void updateCustomer(Customer cust) throws SQLException, RecordNotFoundException;

	Customer getCustomer(int ssn) throws SQLException;

	ArrayList<Customer> getCustomer() throws SQLException;
	
	ArrayList<Customer> getCustomer(String address) throws SQLException;
	
	int getCountByaddress(String address) throws SQLException;
}
