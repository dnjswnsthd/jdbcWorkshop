package com.edu.broker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.broker.exception.DuplicateSSNException;
import com.edu.broker.exception.LessStockException;
import com.edu.broker.exception.NotFoundCustomerException;
import com.edu.broker.vo.Customer;
import com.edu.broker.vo.Stock;
import com.edu.broker.vo.Trade;

public interface BrokerDAO {
	// 공통적인 기능의 Template
	Connection getConnect() throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps) throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException;
	
	boolean isExists(long ssn, Connection conn) throws SQLException;
	// 고객 추가
	void addCustomer(long ssn, String name, String addresss) throws SQLException, DuplicateSSNException;
	// 고객 삭제
	void delCustomer(long ssn) throws SQLException, NotFoundCustomerException;
	// 고객 정보 수정
	void fixCustomer(long ssn, String name, String address) throws SQLException, NotFoundCustomerException;
	// 주식 구매
	void buyStock() throws SQLException;
	// 주식 판매 (가진 수량보다 많이 팔려고 할 때 LessStockException)
	void sellStock() throws SQLException, LessStockException;
	// 고객 리스트 Return
	ArrayList <Customer> getCustomer() throws SQLException;
	// 주식 리스트 Return
	ArrayList <Stock> getStock() throws SQLException;
	// 보유중인 주식 리스트 Return
	ArrayList <Trade> getTrade() throws SQLException;
}
