package broker.twotier.vo;
/*
 * 주식을 보유하는 고객에 대한 정보를 담는 클래스...
 * 고객 == 주식을 보유하지 않는 고객 + 현재 주식을 보유하고 있는 고객
 */

import java.util.Vector;

public class CustomerRec {
	private String ssn;
	private String name; // 컬럼명은 cust_name
	private String address;

	// 추가...
	private Vector<SharesRec> portfolio;

	public CustomerRec() {
		super();
	}

	public CustomerRec(String ssn, String name, String address) {
		super();
		this.ssn = ssn;
		this.name = name;
		this.address = address;
	}

	public CustomerRec(String ssn, String name, String address, Vector<SharesRec> portfolio) {
		super();
		this.ssn = ssn;
		this.name = name;
		this.address = address;
		this.portfolio = portfolio;
	}

	public String getSsn() {
		return ssn;
	}

	public void setSsn(String ssn) {
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

	public Vector<SharesRec> getPortfolio() {
		return portfolio;
	}

	public void setPortfolio(Vector<SharesRec> portfolio) {
		this.portfolio = portfolio;
	}

	@Override
	public String toString() {
		return "CustomerRec [ssn=" + ssn + ", name=" + name + ", address=" + address + ", portfolio=" + portfolio + "]";
	}

}
