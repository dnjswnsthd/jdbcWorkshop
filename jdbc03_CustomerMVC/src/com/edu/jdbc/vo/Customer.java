package com.edu.jdbc.vo;

public class Customer {
	private int ssn;
	private String custName;
	private String address;
	public static final String BASE_NAME = "아무개";
	public static final String BASE_ADDR = "일광";
	
	public Customer(int ssn, String custName, String address) {
		super();
		this.ssn = ssn;
		this.custName = custName;
		this.address = address;
	}	

	public Customer(int ssn) {
		this(ssn, BASE_NAME, BASE_ADDR);
	}

	public int getSsn() {
		return ssn;
	}

	public void setSsn(int ssn) {
		this.ssn = ssn;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Override
	public String toString() {
		return "Customer [ssn=" + ssn + ", custName=" + custName + ", address=" + address + "]";
	}

}
