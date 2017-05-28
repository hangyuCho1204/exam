package exam;

public class SubTest {
	public static void main(String[] args) {
		SubTest sub = new SubTest();
		sub.func(354);
	}
	public int func (int su){
		String str = Integer.toString(su);
		char[] ch = str.toCharArray();
		int result = 0;
		int i = 0;
		int imsi = 0;
		while(true){
			if(i<=str.length()-1){
				imsi = (ch[i]-49+1);
			}
			result += imsi;
			i++;
			if(i>=str.length()){
					if(1==(int)(Math.log10(result)+1)){
						break;
						}
					String restr = Integer.toString(result);
					char[] a = restr.toCharArray();
					imsi=0;
					result=0;
					for (int j = 0; j < a.length; j++) {
						imsi += (a[j]-49+1);
					}
				}
			}
		System.out.println(result);
		return result;
	}
}