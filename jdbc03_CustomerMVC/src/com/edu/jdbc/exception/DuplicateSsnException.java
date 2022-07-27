package com.edu.jdbc.exception;

// 있는 사람 또 추가할때 발생하는 예외 클래스...
public class DuplicateSsnException extends Exception {
	public DuplicateSsnException() {
		this("This is DuplicateSsnException...");
	}

	public DuplicateSsnException(String message) {
		super(message);
	}
}
