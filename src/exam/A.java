package exam;

public class A {
	public static void main(String[] args) {
		A a01 = new A();
		A a02 = new A();
		
		String s01 = new String("안녕");
		String s02 = new String("안녕");
		
		String s03 = "안녕";
		String s04 = "안녕";
		
		System.out.println(a01.hashCode());
		System.out.println(a02.hashCode());
		System.out.println(s01.hashCode());
		System.out.println(s02.hashCode());
		System.out.println(s03.hashCode());
		System.out.println(s04.hashCode());
		
		System.out.println(a01==a01);
		System.out.println(a01==a02);
		System.out.println(s01==s02);
		System.out.println(s03==s04);
		System.out.println(s01==s04);
		
		System.out.println("a01.equals(a01) : "+a01.equals(a01));
		System.out.println("a01.equals(a02) : "+a01.equals(a02));
		System.out.println("s01.equals(s02) : "+s01.equals(s02));
		System.out.println("s01.equals(s04) : "+s01.equals(s04));
		System.out.println("s01.equals(s04) : "+s01.equals(s04));
		
		// ==연산자와 equals의 차이점은 객체 비교할 때는 같은 비교(object의 주소)를 하지만 String 타입을 비교할 때
		// String Class에서 object의 주소를 오버라이딩 하기 때문에 비교를 할 때 다르다고 나타나기 때문이다.
	}
}
