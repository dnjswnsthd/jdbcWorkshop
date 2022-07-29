package broker.twotier.exception;

public class RecordNotFoundException extends Exception {
	public RecordNotFoundException() {
		this("RecordNotFoundException....");
	}

	public RecordNotFoundException(String message) {
		super(message); // sysout(e.getMessage());
	}
}