package com.edu.jdbc.exception;

// 있는 사람 또 추가할때 발생하는 예외 클래스...
public class RecordNotFoundException extends Exception {
	public RecordNotFoundException() {
		this("This is RecordNotFoundException...");
	}

	public RecordNotFoundException(String message) {
		super(message);
	}
}
