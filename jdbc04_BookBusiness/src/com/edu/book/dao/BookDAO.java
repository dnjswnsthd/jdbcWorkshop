package com.edu.book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.book.exception.BookNotFoundException;
import com.edu.book.exception.DuplicateISBNException;
import com.edu.book.exception.InvalidInputException;
import com.edu.book.exception.PublisherNotFoundException;
import com.edu.book.vo.Book;

public interface BookDAO {
	// 공통적인 기능의 Template
	Connection getConnect() throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps) throws SQLException;

	void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException;

	// COUNT()
	int isExists(String isbn, Connection conn) throws SQLException;
	// boolean
	boolean isExistsPublisher(String isbn, Connection conn) throws SQLException;

	// 비지니스 로직 기능 Template
	void registerBook(Book vo) throws SQLException, DuplicateISBNException;

	void deleteBook(String isbn) throws SQLException, BookNotFoundException;

	Book findByIsbn(String isbn) throws SQLException;

	// LIKE 연산자 사용
	Book findByTitle(String title) throws SQLException;

	ArrayList<Book> findByWriter(String writer) throws SQLException;

	ArrayList<Book> findByPublisher(String publish) throws SQLException;
	// 비교 연산자 OR BETWEEN
	ArrayList<Book> findByPrice(int min, int max) throws SQLException, InvalidInputException;
	// 숫자 함수
	void discountBook(int per, String publish) throws SQLException, PublisherNotFoundException;

	ArrayList<Book> findAllBook() throws SQLException;

}
