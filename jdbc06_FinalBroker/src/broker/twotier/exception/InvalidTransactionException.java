package broker.twotier.exception;

public class InvalidTransactionException extends Exception {
	public InvalidTransactionException() {
		this("InvalidTransactionException....");
	}

	public InvalidTransactionException(String message) {
		super(message); // sysout(e.getMessage());
	}
}