package com.edu.book.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.edu.book.dao.BookDAO;
import com.edu.book.exception.BookNotFoundException;
import com.edu.book.exception.DuplicateISBNException;
import com.edu.book.exception.InvalidInputException;
import com.edu.book.exception.PublisherNotFoundException;
import com.edu.book.vo.Book;

import config.ServerInfo;

public class BookDAOImpl implements BookDAO {
	private static BookDAOImpl dao = new BookDAOImpl();

	private BookDAOImpl() {
	}

	public static BookDAOImpl getInstance() {
		return dao;
	}

	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.SERVER_URL, ServerInfo.USER, ServerInfo.PASS);
		System.out.println("DB Server Connection.......");
		return conn;
	}

	@Override
	public void closeAll(Connection conn, PreparedStatement ps) throws SQLException {
		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();
	}

	@Override
	public void closeAll(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException {
		if (rs != null)
			rs.close();
		closeAll(conn, ps);
	}

	@Override
	public int isExists(String isbn, Connection conn) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) cnt FROM book WHERE isbn = ?";
		ps = conn.prepareStatement(query);
		ps.setString(1, isbn);
		rs = ps.executeQuery();
		rs.next();

		return rs.getInt("cnt");
	}

	@Override
	public boolean isExistsPublisher(String publish, Connection conn) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "SELECT isbn FROM book WHERE publisher = ?";
		ps = conn.prepareStatement(query);
		ps.setString(1, publish);
		rs = ps.executeQuery();

		return rs.next();
	}

	@Override
	public void registerBook(Book book) throws SQLException, DuplicateISBNException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (isExists(book.getIsbn(), conn) == 0) {
				String query = "INSERT INTO book(isbn, title, author, publisher, price) values (?, ?, ?, ?, ?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, book.getIsbn());
				ps.setString(2, book.getTitle());
				ps.setString(3, book.getWriter());
				ps.setString(4, book.getPublisher());
				ps.setInt(5, book.getPrice());
				System.out.println(ps.executeUpdate() + "명 추가 완료되었습니다.");
			} else {
				throw new DuplicateISBNException(
						"########InvalidInputException######## \n" + book.getIsbn() + "는 이미 있는 ISBN 번호를 입력하셨습니다.");
			}
		} finally {
			closeAll(conn, ps);
		}
	}

	@Override
	public void deleteBook(String isbn) throws SQLException, BookNotFoundException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (isExists(isbn, conn) == 1) {
				String query = "DELETE FROM BOOK WHERE isbn = ?";
				ps = conn.prepareStatement(query);
				ps.setString(1, isbn);
				System.out.println(ps.executeUpdate() + "입력하신 " + isbn + " 책은 삭제되었습니다.");
			} else {
				throw new BookNotFoundException(
						"########InvalidInputException######## \n" + "입력하신 " + isbn + "이 없어서 삭제할 수 없습니다.");
			}
		} finally {
			closeAll(conn, ps);
		}
	}

	@Override
	public Book findByIsbn(String isbn) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Book book = null;
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book WHERE isbn = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, isbn);
			rs = ps.executeQuery();
			if (rs.next()) {
				book = new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price"));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return book;
	}

	@Override
	public Book findByTitle(String title) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Book book = null;
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book WHERE title LIKE ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, "%" + title + "%");
			rs = ps.executeQuery();
			if (rs.next()) {
				book = new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price"));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return book;
	}

	@Override
	public ArrayList<Book> findByWriter(String writer) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Book> books = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book WHERE author =? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, writer);
			rs = ps.executeQuery();
			while (rs.next()) {
				books.add(new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price")));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return books;
	}

	@Override
	public ArrayList<Book> findByPublisher(String publish) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Book> books = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book WHERE publisher =? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, publish);
			rs = ps.executeQuery();
			while (rs.next()) {
				books.add(new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price")));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return books;
	}

	@Override
	public ArrayList<Book> findByPrice(int min, int max) throws SQLException, InvalidInputException {
		if (min > max) throw new InvalidInputException("########InvalidInputException######## \nmin값이 max보다 작아야합니다.");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Book> books = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book WHERE price BETWEEN ? and ? ";
			ps = conn.prepareStatement(query);
			ps.setInt(1, min);
			ps.setInt(2, max);
			rs = ps.executeQuery();
			while (rs.next()) {
				books.add(new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price")));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return books;
	}

	@Override
	public void discountBook(int per, String publish) throws SQLException, PublisherNotFoundException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = getConnect();
			if (isExistsPublisher(publish, conn)) {
				String query = "UPDATE book SET price = ROUND(price * ?) WHERE publisher = ?";
				ps = conn.prepareStatement(query);
				ps.setDouble(1, (100 - per) * 0.01);
				ps.setString(2, publish);
				System.out.println(
						ps.executeUpdate() + "입력하신 " + publish + "의 책들은" + per + "%" + "만큼 할인된 금액으로 업데이트 되었습니다.");
			}else {
				throw new PublisherNotFoundException("########InvalidInputException######## \n" + "입력하신 " + publish + "이 없어서 삭제할 수 없습니다.");
			}
		} finally {
			closeAll(conn, ps);
		}
	}

	@Override
	public ArrayList<Book> findAllBook() throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Book> books = new ArrayList<>();
		try {
			conn = getConnect();
			String query = "SELECT isbn, title, author, publisher, price FROM book ";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				books.add(new Book(rs.getString("isbn"), rs.getString("title"), rs.getString("author"),
						rs.getString("publisher"), rs.getInt("price")));
			}
		} finally {
			closeAll(conn, ps, rs);
		}
		return books;
	}

}
