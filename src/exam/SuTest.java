package exam;

public class SuTest {
	
	char[] ch = null;
	char[] eng = new char[27];
	char[] cha = null;
	String result = "";
	
	public static void main(String[] args) {
		SuTest st = new SuTest();
		String a = st.func1("sky");
		String b = st.func2(a);
		
		System.out.println(a);
		System.out.println(b);
	}
	
	int a = 0;
	
	public String func1(String str){
		ch = str.toCharArray();
		cha = new char[ch.length];
		result = "";
		
		for (int i = 1; i < eng.length; i++) {
			eng[i] = (char) (97+i-1);
		}
		
		for (int i = 0; i < ch.length; i++) {
			int[] n = new int[ch.length];
			
			if(ch[i]>=97){
				n[i] = (ch[i]-97+1+(i+1))%26;
			}else{
				n[i] = (97-ch[i]+1+(i+1))%26;
			}
			
			if(n[i]!=0){
				cha[i] = (char) eng[n[i]];
			}else{
				cha[i] = eng[(eng.length-1)];
			}
			result += cha[i];
		}
		return result;
	}
	
	public String func2(String str){
		
		ch = str.toCharArray();
		
		cha = new char[ch.length] ;
		result = "";
		
		for (int i = 1; i < eng.length; i++) {
			eng[i] = (char) (97+i-1);
		}
		
		for (int i = 0; i < ch.length; i++) {
			int[] n = new int[ch.length];
			if(ch[i]>=(97-1)){
				if((ch[i]-(97-1))-(i+1)<=0){
					n[i] = ((ch[i]-(97-1))-(i+1) + 26) % 26;
				}else{
					n[i] = ((ch[i]-(97-1))-(i+1)) % 26;
				}
			}else{
				if(((97-1))-ch[i]-(i+1)<=0){
					n[i] = (((97-1)-ch[i])-(i+1) + 26) % 26;
				}else{
					n[i] = (((97-1)-ch[i])-(i+1)) % 26;
				}
			}
			
			if(n[i]!=0){
				cha[i] = eng[n[i]];
			}else{
				cha[i] = eng[eng.length-1];
			}
			result += cha[i];
		}
		
		return result;
	}		
}
