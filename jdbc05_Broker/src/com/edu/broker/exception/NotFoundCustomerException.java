package com.edu.broker.exception;

public class NotFoundCustomerException extends Exception {
	public NotFoundCustomerException() {
		this("NotFoundCustomerException....");
	}

	public NotFoundCustomerException(String message) {
		super(message); //sysout(e.getMessage());
	}
}
