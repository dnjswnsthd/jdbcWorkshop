package com.edu.broker.exception;

public class LessStockException extends Exception {
	public LessStockException() {
		this("LessStockException....");
	}

	public LessStockException(String message) {
		super(message); //sysout(e.getMessage());
	}
}
