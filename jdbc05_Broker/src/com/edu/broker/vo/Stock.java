package com.edu.broker.vo;

public class Stock {
	private String stockName;
	private double currentPrice;

	public Stock(String stockName, double currentPrice) {
		super();
		this.stockName = stockName;
		this.currentPrice = currentPrice;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public double getCurrentPrice() {
		return currentPrice;
	}

	public void setCurrentPrice(double currentPrice) {
		this.currentPrice = currentPrice;
	}

	@Override
	public String toString() {
		return "Stock [stockName=" + stockName + ", currentPrice=" + currentPrice + "]";
	}

}
