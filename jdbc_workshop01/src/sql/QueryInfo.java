package sql;

public interface QueryInfo {
	String insertQuery = "INSERT INTO customer (ssn, name, address) values (?, ?, ?)";
	String updateQuery = "UPDATE customer SET name = ?, address = ? where ssn = ?";
	String deleteQuery = "DELETE FROM customer WHERE ssn = ?";
	String selectQuery = "SELECT ssn, name, address FROM customer";
}
