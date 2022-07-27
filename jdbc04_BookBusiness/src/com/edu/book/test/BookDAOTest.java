package com.edu.book.test;

import java.sql.SQLException;

import com.edu.book.dao.impl.BookDAOImpl;
import com.edu.book.vo.Book;

public class BookDAOTest {
	public static void main(String[] args) {
		BookDAOImpl dao = BookDAOImpl.getInstance();
		Book book = new Book("7G7", "스프링부트", "나가타", "한빛", 33000);
		String isbn = "6F6";
		try {
			
			/*
			// Book 추가
			dao.registerBook(book);
			// Book 삭제 
			dao.deleteBook(isbn); 
			 // Isbn으로 검색
			System.out.println(dao.findByIsbn("5E5"));
			// Title LIKE 검색
			System.out.println(dao.findByTitle("모두의 데이타"));
			// 저자 검색 
			for (Book b : dao.findByWriter("나가타")) System.out.println(b); 
			// 출판사 검색
			for (Book b : dao.findByPublisher("동아")) System.out.println(b);
			// 가격 범위로 검색
			for (Book b : dao.findByPrice(60000, 50000)) System.out.println(b);
			// 출판사별로 할인
			dao.discountBook(10, "으아아악");
			*/
			// 전체 책 검색
			for (Book b : dao.findAllBook()) System.out.println(b);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}/* catch (DuplicateISBNException e) {
			System.out.println(e.getMessage());
		} catch (BookNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (InvalidInputException e) {
			System.out.println(e.getMessage());
		}catch (PublisherNotFoundException e){
			System.out.println(e.getMessage());
		}*/
	}
}
