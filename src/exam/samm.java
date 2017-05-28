package exam;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import subject1.Bean;
import subject1.SortName;
import subject1.SortPI;

public class samm {

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

			//for (int parentIndex = lists.size() ; 1 < parentIndex; parentIndex--) {
			//for (int parentIndex = 0; parentIndex+1 < lists.size(); parentIndex++) {
			
			Bean save = new Bean();
			
			for (int superIndex = 0; superIndex < lists.size()-1; superIndex++) { 
				for (int parentIndex = 1; parentIndex < lists.size(); parentIndex++) {
					try {
						int sNextIndex = superIndex+1;//superIndex의 다음 index
								/*1.작동 전 superIndex	: Bean [id=0, name=[Root], parentid=-1, sort=0]
								  1.작동 전 superIndex+1	: Bean [id=1, name=boot, parentid=0, sort=0]
								  1.작동 전 parentIndex	: Bean [id=2, name=etc, parentid=0, sort=0]
								  2.작동 후 superIndex	: Bean [id=0, name=[Root], parentid=-1, sort=0]
								  2.작동 후 superIndex+1	: Bean [id=2, name=etc, parentid=0, sort=0]
								  2.작동 후 parentIndex	: Bean [id=1, name=boot, parentid=0, sort=0]*/
							System.out.println("1.작동 전 superIndex\t: "+lists.get(superIndex));
							System.out.println("1.작동 전 sNextIndex\t: "+lists.get(superIndex+1));
							System.out.println("1.작동 전 parentIndex\t: "+lists.get(parentIndex));
						if(lists.get(superIndex).getId()==lists.get(parentIndex).getParentid()){
							if(lists.get(sNextIndex).getParentid()!=lists.get(parentIndex).getParentid()){
								
								save = lists.get(sNextIndex);
								lists.set(sNextIndex, lists.get(parentIndex));
								lists.set(parentIndex, save);
							}
								
						}
						
							System.out.println("2.작동 후 superIndex\t: "+lists.get(superIndex));
							System.out.println("2.작동 후 sNextIndex\t: "+lists.get(superIndex+1));
							System.out.println("2.작동 후 parentIndex\t: "+lists.get(parentIndex));
								
							System.out.println(
									"실행 결과 : " + "1차 : "+(lists.get(superIndex).getId()==lists.get(parentIndex).getParentid()) +" 2차 : " +(lists.get(superIndex).getId()==lists.get(parentIndex).getParentid())
											+ "부모 id : " + lists.get(superIndex).getId() + " / " + "("
											+ lists.get(parentIndex).getId() + ")"
											+ lists.get(parentIndex).getParentid() + " : 자식 id");
							System.out.println(lists);
					} catch (ArrayIndexOutOfBoundsException e) {

					} catch (IndexOutOfBoundsException e2) {

					}
				}
			}
			
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
