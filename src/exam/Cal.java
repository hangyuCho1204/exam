package exam;

public class Cal {
	
	public static void main(String[] args) {
		Cal a = new Cal();
		
		//2016/01/01 ±İ¿äÀÏ
		System.out.println(a.check(2016));
		System.out.println("result2 : " + a.check2(2016));
		int b = a.check(2016);
		int c = a.check2(2016);
		System.out.println((c-b)%7);
	}
	
	public int check(int year){
		
		if(year % 4 == 0 || year % 100 != 0 && year % 400 == 0){
			return 366;
		}else{
			return 365;
		}
	}
	
	public int check2(int year){
		int newYear = 0;
		for (int i = 1; i <= year; i++) {
			
			if(i % 4 == 0 || i % 100 != 0 && i % 400 == 0){
				newYear += 366;
			}else{
				newYear += 365;
			}
		}
		return newYear;
	}
}
