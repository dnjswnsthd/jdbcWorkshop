package com.edu.broker.vo;

public class Trade {
	private int tradeCode;
	private long ssn;
	private String stockName;
	private int stockQuantity;
	private double tradePrice;

	public Trade(int tradeCode, long ssn, String stockName, int stockQuantity, double tradePrice) {
		super();
		this.tradeCode = tradeCode;
		this.ssn = ssn;
		this.stockName = stockName;
		this.stockQuantity = stockQuantity;
		this.tradePrice = tradePrice;
	}

	public int getTradeCode() {
		return tradeCode;
	}

	public void setTradeCode(int tradeCode) {
		this.tradeCode = tradeCode;
	}

	public long getSsn() {
		return ssn;
	}

	public void setSsn(long ssn) {
		this.ssn = ssn;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public double getTradePrice() {
		return tradePrice;
	}

	public void setTradePrice(double tradePrice) {
		this.tradePrice = tradePrice;
	}

	@Override
	public String toString() {
		return "Trade [tradeCode=" + tradeCode + ", ssn=" + ssn + ", stockName=" + stockName + ", stockQuantity="
				+ stockQuantity + ", tradePrice=" + tradePrice + "]";
	}

}
