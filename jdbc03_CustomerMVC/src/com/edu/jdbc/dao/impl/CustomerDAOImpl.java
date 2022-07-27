package com.edu.jdbc.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.jdbc.dao.CustomerDAO;
import com.edu.jdbc.exception.DuplicateSsnException;
import com.edu.jdbc.exception.RecordNotFoundException;
import com.edu.jdbc.vo.Customer;

import config.ServerInfo;

public class CustomerDAOImpl implements CustomerDAO {
	private static CustomerDAOImpl dao = new CustomerDAOImpl();

	private CustomerDAOImpl() {
		System.out.println("Singltone Patter......Creating...");
	}

	public static CustomerDAOImpl getInstance() {
		return dao;
	}

	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.SERVER_URL, ServerInfo.USER, ServerInfo.PASS);
		System.out.println("DB Server Connection.......");
		return conn;
	}

	@Override
	public void closeAll(Connection conn, PreparedStatement ps) throws SQLException {
		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();
	}

	@Override
	public void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException {
		if (rs != null)
			rs.close();
		closeAll(conn, ps);
	}

	// ssn으로 중복 체크 중복인 경우 false 중복이 아닌 경우 true를 반환
	private boolean existSsnCustomer(int ssn, Connection conn) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;

		String query = "Select ssn from customer where ssn = ?";
		ps = conn.prepareStatement(query);
		ps.setInt(1, ssn);
		rs = ps.executeQuery();

		return rs.next();
	}

	// 중복 체크 이후 Customer을 추가 한다. (중복시 DuplicateSsnException이 발생한다.)
	@Override
	public void registerCustomer(Customer cust) throws SQLException, DuplicateSsnException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (!existSsnCustomer(cust.getSsn(), conn)) {
				String query = "INSERT INTO customer(ssn, cust_name, address) values (?, ?, ?)";
				ps = conn.prepareStatement(query);
				ps.setInt(1, cust.getSsn());
				ps.setString(2, cust.getCustName());
				ps.setString(3, cust.getAddress());
				System.out.println(ps.executeUpdate() + "명 추가 완료되었습니다.");
			} else {
				throw new DuplicateSsnException(cust.getSsn() + "는 이미 있는 유저입니다.");
			}
		} finally {
			closeAll(conn, ps);
		}
	}
	
	// 존재 유무를 확인한 후 Customer을 삭제한다.
	@Override
	public void removeCustomer(int ssn) throws SQLException, RecordNotFoundException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (existSsnCustomer(ssn, conn)) {
				String query = "DELETE FROM customer WHERE ssn = ?";
				ps = conn.prepareStatement(query);
				ps.setInt(1, ssn);
				System.out.println(ps.executeUpdate() + "명 삭제 되었습니다.");
			} else {
				throw new RecordNotFoundException(ssn + "이 없어서 삭제 실패");
			}

		} finally {
			closeAll(conn, ps);
		}
	}
	
	// 존재유무를 확인 후 Customer의 정보를 수정한다.
	@Override
	public void updateCustomer(Customer cust) throws SQLException, RecordNotFoundException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (existSsnCustomer(cust.getSsn(), conn)) {
				String query = "UPDATE customer SET cust_name = ?, address = ? where ssn = ?";
				ps = conn.prepareStatement(query);
				ps.setString(1, cust.getCustName());
				ps.setString(2, cust.getAddress());
				ps.setInt(3, cust.getSsn());
				System.out.println(ps.executeUpdate() + "명 업데이트 되었습니다.");
			} else {
				throw new RecordNotFoundException(cust.getSsn() + "이 없어서 수정 실패");
			}

		} finally {
			closeAll(conn, ps);
		}
	}

	// ssn으로 조회한 Customer를 반환한다.
	@Override
	public Customer getCustomer(int ssn) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Customer cust = null;
		try {
			conn = getConnect();
			String query = "SELECT ssn, cust_name, address FROM customer WHERE ssn = ?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, ssn);
			rs = ps.executeQuery();
			if(rs.next())
				cust = new Customer(rs.getInt("ssn"), rs.getString("cust_name"), rs.getString("address"));
		} finally {
			closeAll(conn, ps, rs);
		}
		return cust;
	}
	
	// Customer를 list에 담아 모두 반환
	@Override
	public ArrayList<Customer> getCustomer() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Customer cust = null;
		ArrayList<Customer> al = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT ssn, cust_name, address FROM customer";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				cust = new Customer(rs.getInt("ssn"), rs.getString("cust_name"), rs.getString("address"));
				al.add(cust);
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return al;
	}
	
	// 입력된 주소와 동일한 주소를 가진 Customer를 list에 담아 반환
	@Override
	public ArrayList<Customer> getCustomer(String address) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Customer cust = null;
		ArrayList<Customer> al = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT ssn, cust_name, address FROM customer where address = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, address);
			rs = ps.executeQuery();
			while (rs.next()) {
				cust = new Customer(rs.getInt("ssn"), rs.getString("cust_name"), rs.getString("address"));
				al.add(cust);
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return al;
	}
	
	// 입력된 주소와 동일한 주소를 가진 Customer의 명 수를 반환
	@Override
	public int getCountByaddress(String address) throws SQLException {
		ArrayList<Customer> al = null;
		al = getCustomer(address);
		return al.size();
	}
}
