
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.bank.Bank;

public aspect Logger {
	final String ruta = "src/";
	String date = (new SimpleDateFormat("HH:mm:ss;dd/MM/yyyy")).format( new Date() );
	
    pointcut success() : call(* createUser*(..) );
    pointcut moneyTransaction() : call(* Bank.moneyMake*(..) );
    pointcut moneyWithdrawal() : call(* Bank.moneyWit*(..) );

    after() : success() {
    	
    	createFile("User created");
    	System.out.println("**** User created ****");
    
    }

    after() : moneyTransaction() {
    	
    	createFile("Transaccion de dinero");
    	System.out.println("Transaccion de dinero " + date);
    }
    
    after() : moneyWithdrawal() {
    	
    	createFile("Retiro de dinero ");
    	System.out.println("Transaccion de dinero " + date);
    	
    }
    
    private void createFile(String transaction) {
		File fileLog = new File(ruta + "log.txt");
		if(!fileLog.exists()) {
			BufferedWriter bw = null;
			try {
				bw = new BufferedWriter(new FileWriter(fileLog));
				bw.write(transaction + " " + date);
				bw.newLine();
				bw.flush();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else {
			BufferedWriter bw = null;
			try {
				bw = new BufferedWriter(new FileWriter(fileLog, true));
				bw.append(transaction + " " + date);
				bw.newLine();				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		}			
	}
    
}
