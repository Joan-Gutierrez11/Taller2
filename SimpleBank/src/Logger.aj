import java.io.BufferedWriter;
import java.io.File;
import java.nio.file.Files;
import java.util.Calendar;

public aspect Logger {
	 File file = new File("log.txt");
	 Calendar cal = Calendar.getInstance();
	
	private void saveLog(String transactionType) {
	    	
	    	String date;
	    	
	    	try(BufferedWriter br = Files
	    		.newBufferedWriter(logFile, StandardOpenOption.APPEND) ) {
	    		
	    		date = (new SimpleDateFormat("HH:mm:ss;dd/MM/yyyy")).format( new Date() );
	    		br.append( String.format("\n%s;%s", 
	    			transactionType.replace(" ", "_"), date) );
	
	    		System.out.println( String.format(
	    			"** %s: %s **", transactionType, date) );
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace(); }
	    	
	}
}
