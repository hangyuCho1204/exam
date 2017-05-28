package subject1;

import java.util.Comparator;

public class SortName implements Comparator<Bean>{

	@Override
	public int compare(Bean o1, Bean o2) {
		int result = o1.getName().compareTo(o2.getName());
		
		return result;
	}
}


