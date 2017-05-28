package subject1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.StandardWatchEventKinds;
import java.nio.file.WatchEvent;
import java.nio.file.WatchKey;
import java.nio.file.WatchService;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;


public class CsvReader {
	
	private static BlockingQueue<Integer> queue = new ArrayBlockingQueue<Integer>(3);

    public static void main(String[] args) {  
        
          
        Producer p1 = new Producer(queue);  p1.start();  
        
        Consumer c1 = new Consumer("1", queue); c1.start();  
        //Consumer c2 = new Consumer("2", queue); c2.start();  
        //Consumer c3 = new Consumer("3", queue); c3.start();  
    }  
      
    // 생산자. - 무언가를 열심히 만들어 낸다.  
    static class Producer extends Thread {  
        private BlockingQueue<Integer> queue;  
          
        public Producer(BlockingQueue<Integer> queue) {  
            this.queue = queue;  
        }  
          
        public void run() {  
        	FileSystem fs = FileSystems.getDefault();
			Path watchPath = fs.getPath("C:/Users/WORK/Desktop/target/");
	        WatchService watchService = null;
	        Path path = null;
			String filename = "";
			
            while(true) {  
    				// 파일 감지 영역			
    				
    				try {
    					watchService = fs.newWatchService();
    					watchPath.register(watchService,
					             StandardWatchEventKinds.ENTRY_CREATE);
    				} catch (IOException e) {
    					e.printStackTrace();
    				}
    		        while (true) {
    		               try {		                    
    		                     WatchKey changeKey = watchService.take();		                    
    		                     List<WatchEvent<?>> watchEvents = changeKey.pollEvents();
    		                     for (WatchEvent<?> watchEvent : watchEvents) {
    		                            @SuppressWarnings("unchecked")
										WatchEvent<Path> pathEvent = (WatchEvent<Path>) watchEvent;
    		                            path = pathEvent.context();
    		                            WatchEvent.Kind<Path> eventKind = pathEvent.kind();
    		                            System.out.println(watchEvents.size());
    		                            System.out.println(eventKind + " for path: " + path);
    		                            //filename = path;
    		                            if(watchEvents.size()!=0){
    		                            	File csv = new File("C:/Users/WORK/Downloads/test/" + path);
    	    		    		   			Bean bean = null;
    	    		    		   			List<Bean> lists = new ArrayList<Bean>();
    	    		    		   			try {
    	    		    		   				FileReader fr = new FileReader(csv);
    	    		    		   				BufferedReader br = new BufferedReader(fr);
    	    		    		   				String list = "";
    	    		    		   				
    	    		    		   				while((list = br.readLine())!=null){
    	    		    		   					System.out.println(list);
    	    		    		   				}
    	    		    		   				}catch (IOException e){
    	    		    		   				}
    		                            }
    		                      }
    		                     changeKey.reset(); 
    		                     	
    		                     
    		               } catch (InterruptedException e) {
    		                     e.printStackTrace();
    		               }
    		            
    		        }
    	            
    		       // queue.put(e);
                /*try {  
                    Thread.sleep(new Random().nextInt(500));  
                    // 수정사항 - offer에서 put으로 변경
                    // 데이터를 넣고 나면 알아서 notify시켜 준다. 
                    queue.put(i++); 
                } catch (InterruptedException e) {  
                    e.printStackTrace();  
                }  */
            }
            }  
        }  
    }  
      
      
    // 소비자.. 생산해 낸 것을 열심히 사용하자.  
    class Consumer extends Thread {  
        private BlockingQueue<Integer> queue;  
        private String name;  
        public Consumer(String name, BlockingQueue<Integer> queue) {  
            this.name = name;  
            this.queue = queue;  
        }  
          
        public void run() {  
            while ( true ) {  
                try {  
                    // queue에 data가 없으면 알아서 wait하고 있다.  
                    Integer index = queue.take();  
                    System.err.println("Consumer : " + name + "\tIndex : " + index);  
                } catch (InterruptedException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
    
    

	
	/*class Producer implements Runnable{
		private BlockingQueue queue;
		Producer(BlockingQueue q) {
			queue = q;
		}
		@Override
		public void run() {
			while(true){
				// 파일 감지 영역				
				FileSystem fs = FileSystems.getDefault();
				Path watchPath = fs.getPath("C:/Users/WORK/Desktop/target/");
		        WatchService watchService = null;
				try {
					watchService = fs.newWatchService();
				} catch (IOException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				}
		        try {
					watchPath.register(watchService,
					             StandardWatchEventKinds.ENTRY_CREATE);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
		        while (true) {
		               try {		                    
		                     WatchKey changeKey = watchService.take();		                    
		                     List<WatchEvent<?>> watchEvents = changeKey.pollEvents();
		                     for (WatchEvent<?> watchEvent : watchEvents) {
		                            // Ours are all Path type events:
		                            WatchEvent<Path> pathEvent = (WatchEvent<Path>) watchEvent;
		                            Path path = pathEvent.context();
		                            WatchEvent.Kind<Path> eventKind = pathEvent.kind();
		                            System.out.println(eventKind + " for path: " + path);
		                      }
		                     changeKey.reset(); 
		               } catch (InterruptedException e) {
		                     e.printStackTrace();
		               }
		        }
				
				WatchService watchService = FileSystems.getDefault().newWatchService();
				 final Path path = Paths.get("C:/Users/WORK/Desktop/target/");
				 path.register(watchService, StandardWatchEventKinds.ENTRY_CREATE);
				watchService.close();
				queue.put();
			}
		}
	}
	
	class Consumer implements Runnable{
		private BlockingQueue queue;
		Consumer(BlockingQueue q) {
			queue = q;
		}
		@Override
		public void run() {
			
		}
	}*/
	
	/*public static void main(String[] args) {
		BlockingQueue q = new 
	     Producer p = new Producer(q);
	     Consumer c1 = new Consumer(q);
	     Consumer c2 = new Consumer(q);
	     new Thread(p).start();
	     new Thread(c1).start();
	     new Thread(c2).start();*/
	
		/*File csv = new File("C://Users/WORK/Downloads/test/data1.csv");
		Bean bean = null;
		List<Bean> lists = new ArrayList<Bean>();
		try {
			FileReader fr = new FileReader(csv);
			BufferedReader br = new BufferedReader(fr);
			String list = "";
			
			while((list = br.readLine())!=null){
				bean = new Bean();
				try{
					Integer.parseInt(list.split(",")[0]);
				for (int i = 0; i < list.split(",").length; i++) {
					if(list.split(",")[i].equals(list.split(",")[0])){
						bean.setId(Integer.parseInt(list.split(",")[i]));
						bean.setName("");
						bean.setParentid(0);
					}else if(list.split(",")[i].equals(list.split(",")[1])){
						bean.setName(list.split(",")[i]);
						bean.setParentid(0);
					}else if(list.split(",")[i].equals(list.split(",")[2])){
						bean.setParentid(Integer.parseInt(list.split(",")[2]));
					}
				}
					lists.add(bean);
				}catch(NumberFormatException e){
					
				}
				
			}
			
			
			int some = 0;
			for (Bean be : lists) {
				System.out.println(be.toString());
			}
			System.out.println("============================================");
			Sorter ser = new Sorter();
			ser.compare(lists);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e2){
			e2.printStackTrace();
		}
	}*/
	
    }
    
	
