package exam;

public class A {
	public static void main(String[] args) {
		A a01 = new A();
		A a02 = new A();
		
		String s01 = new String("�ȳ�");
		String s02 = new String("�ȳ�");
		
		String s03 = "�ȳ�";
		String s04 = "�ȳ�";
		
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
		
		// ==�����ڿ� equals�� �������� ��ü ���� ���� ���� ��(object�� �ּ�)�� ������ String Ÿ���� ���� ��
		// String Class���� object�� �ּҸ� �������̵� �ϱ� ������ �񱳸� �� �� �ٸ��ٰ� ��Ÿ���� �����̴�.
	}
}
