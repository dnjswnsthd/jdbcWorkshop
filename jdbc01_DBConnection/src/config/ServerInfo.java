package config;
/*
 * 인터페이스의 구성 요소는
 * public abstract 추상메소드
 * public static final 상수값
 */
public interface ServerInfo {
	String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	String SERVER_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	String USER = "hr";
	String PASS = "hr";
}
