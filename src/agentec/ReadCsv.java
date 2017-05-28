package agentec;

import java.io.File;
import java.io.FileReader;

public class ReadCsv {
	public static void main(String[] args) {
		ReadCsv rc = new ReadCsv();
		System.out.println(rc.file);
	}
	//"C:/Users/WORK/Downloads/test/data1.csv"
	//C:/Users/WORK/Desktop/target/
	public ReadCsv() {}
	final String path = "C:/Users/WORK/Downloads/test/data1.csv";
	File file = new File(path);
	FileReader fr = new FileReader(file);
}