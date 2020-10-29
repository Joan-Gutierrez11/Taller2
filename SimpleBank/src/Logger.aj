
import java.io.BufferedWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.bank.Bank;

public aspect Logger {

	private static final Path logFile = Paths.get("Log.txt");
	
    pointcut success() : call(* create*(..) );
    pointcut moneyTransaction() : call(* Bank.moneyMake*(..) );
    pointcut moneyWithdrawal() : call(* Bank.moneyWit*(..) );

    after() : success() {
    
    	saveLog("User created");
    	System.out.println("**** User created ****");
    
    }

    after() : moneyTransaction() {
    	
    	saveLog("Realizar transaccion");
    	
    }
    
    after() : moneyWithdrawal() {
    	
    	saveLog("Retirar dinero");
    	
    }
    
    private void saveLog(String transactionType) {
    	
    	String date;
    	
    	try( BufferedWriter br = Files
    		.newBufferedWriter(logFile, StandardOpenOption.APPEND) ) {
    		
    		date = (new SimpleDateFormat("HH:mm:ss;dd/MM/yyyy")).format( new Date() );
    		br.append( String.format("\n%s;%s", 
    			transactionType.replace(" ", "_"), date) );

    		System.out.println( String.format(
    			"**** %s: %s ****", transactionType, date) );
    		
    	} catch (Exception e) {
    		e.printStackTrace(); }
    	
    }
    
}
