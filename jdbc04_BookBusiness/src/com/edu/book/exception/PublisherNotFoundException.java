package com.edu.book.exception;

public class PublisherNotFoundException extends Exception{
	public PublisherNotFoundException() {
		this("PublisherNotFoundException....");
	}
	public PublisherNotFoundException(String message) {
		super(message); //sysout(e.getMessage());
	}
}
