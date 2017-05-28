package exam;

public class AutoBoxing2 {

	public static void main(String[] args) {
		
		System.out.println("ff");
		int s = 2;
		System.out.println("ff");
		int arr[] = {4,2,1,8,9,5,3};
		
			for(int i=1;i<7;i++){
				if(arr[i-1]>arr[i]){
					int a = arr[i];
					arr[i] = arr[i-1];
					arr[i-1] = a;
				}
			}
			
			for(int i=0;i<7;i++){
				System.out.print(arr[i]+" ");
			}
			System.out.println();
		}

	



}

