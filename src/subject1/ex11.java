package subject1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ex11 {
	public static void main(String[] args) {
		File csv = new File("C://Users/WORK/Downloads/test/data1.csv");
		Bean bean = null;
		List<Bean> lists = new ArrayList<Bean>();
		try {
			FileReader fr = new FileReader(csv);
			BufferedReader br = new BufferedReader(fr);
			String list = "";

			while ((list = br.readLine()) != null) {
				bean = new Bean();
				int id = 0;
				int name = 1;
				int parentId = 2;
				try {
					Integer.parseInt(list.split(",")[0]);
					for (int i = 0; i < list.split(",").length; i++) {
						if (list.split(",")[i].equals(list.split(",")[id])) {
							bean.setId(Integer.parseInt(list.split(",")[i]));
							bean.setName("");
							bean.setParentid(0);
							if(bean.getId()==0&&bean.getParentid()==0){
								bean.setParentid(-1);
							}
						} else if (list.split(",")[i].equals(list.split(",")[name])) {
							bean.setName(list.split(",")[i]);
							bean.setParentid(0);
							if(bean.getId()==0&&bean.getParentid()==0){
								bean.setParentid(-1);
							}
						} else if (list.split(",")[i].equals(list.split(",")[parentId])) {
							bean.setParentid(Integer.parseInt(list.split(",")[parentId]));
							if(bean.getId()==0&&bean.getParentid()==0){
								bean.setParentid(-1);
							}
						}
					}
					lists.add(bean);
				} catch (NumberFormatException e) {

				}

			}
			Collections.sort(lists, new SortName());
			Collections.sort(lists, new SortPI());

			lists.set(0, new Bean());
			
			
			for (Bean bean2 : lists) {
				System.out.println(bean2);
				
			}

		}catch(

	FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
}
