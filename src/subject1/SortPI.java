package subject1;

import java.util.Comparator;

public class SortPI implements Comparator<Bean>{

	@Override
	public int compare(Bean o1, Bean o2) {
		int result = o1.getParentid() - o2.getParentid();
		
		return result;
	}
}


