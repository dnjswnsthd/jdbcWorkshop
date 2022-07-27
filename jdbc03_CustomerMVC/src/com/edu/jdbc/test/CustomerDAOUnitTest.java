package com.edu.jdbc.test;

import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.jdbc.dao.impl.CustomerDAOImpl;
import com.edu.jdbc.vo.Customer;

public class CustomerDAOUnitTest {
	public static void main(String[] args) {
		CustomerDAOImpl dao = CustomerDAOImpl.getInstance();
		
		Customer cust = new Customer(4444, "가나마", "세종시");
		int ssn = 2222;
		ArrayList<Customer> al;
		try {
//			dao.registerCustomer(cust);
//			dao.removeCustomer(ssn);
//			dao.updateCustomer(cust);
//			System.out.println(dao.getCustomer(ssn));
			al = dao.getCustomer();
			for(Customer c : al) System.out.println(c);;
//			al = dao.getCustomer("미이국");
//			for(Customer c : al) System.out.println(c);;
//			System.out.println(dao.getCountByaddress("세종시"));
		} /*catch (DuplicateSsnException e) {
			System.out.println(e.getMessage());
		} *//*catch (RecordNotFoundException e) {
			System.out.println(e.getMessage());
		} */catch (SQLException e) {
			System.out.println("연결 실패...");
		}
	}
}
