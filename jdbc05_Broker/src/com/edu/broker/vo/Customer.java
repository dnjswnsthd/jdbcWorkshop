package com.edu.broker.vo;

public class Customer {
	private long ssn;
	private String name;
	private String address;
	public static final String BASE_NAME = "누구니";
	public static final String BASE_ADDR = "어디살어";

	public Customer(int ssn) {
		this(ssn, BASE_NAME, BASE_ADDR);
	}
	
	public Customer(long ssn, String name, String address) {
		super();
		this.ssn = ssn;
		this.name = name;
		this.address = address;
	}

	public long getSsn() {
		return ssn;
	}

	public void setSsn(long ssn) {
		this.ssn = ssn;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Customer [ssn=" + ssn + ", name=" + name + ", address=" + address + "]";
	}

}
