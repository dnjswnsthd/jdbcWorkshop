package broker.twotier.exception;

public class DuplicateSSNException extends Exception {
	public DuplicateSSNException() {
		this("DuplicateSSNException....");
	}

	public DuplicateSSNException(String message) {
		super(message); // sysout(e.getMessage());
	}
}
