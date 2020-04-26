package com.xuri.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/** 
* @ClassName: HtmlTemplate 
* @Description: TODO(生成html文件) 
* @author: 王东
* @date: 2015-7-24 上午12:14:27
* 
*/
public class HtmlTemplate {
	
	/**
	* @Title: createShareHtml
	* @Description: TODO(生成共享的html文件)
	* @author：王东
	* @param @param path 服务器路径
	* @param @param htmlContent html内容
	* @param @param type 类型
	* @param @return
	* @date 2015-7-24 上午12:14:48
	*/
	public static String createShareHtml(String path, String htmlContent, String type){
		try{
			path=path.replace("\\","/");
			String businessUrl = "file/sharePage/" + new SimpleDateFormat("yyyyMM").format(new Date()) + "/"+ new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+".html";
			File file=new File(path+businessUrl);      
			if(file.exists()){
	//			判断文件目录的存在          
	//			System.out.println("文件夹存在！");          
				if(file.isDirectory()){
	//				判断文件的存在性                      
	//				System.out.println("文件存在！");                  
				}else{
	//				创建文件             
	//				System.out.println("文件不存在，创建文件成功！");    
					file.createNewFile();              
				}      
			}else{          
	//			System.out.println("文件夹不存在！");       
	//			System.out.println("创建文件夹成功！");     
				File file2=new File(file.getParent());          
				file2.mkdirs();                  
				if(file.isDirectory()){                      
	//				System.out.println("文件存在！");                 
				}else{                  
	//				创建文件             
	//			 	System.out.println("文件不存在，创建文件成功！"); 
					file.createNewFile();                
				}     
			}
			BufferedWriter writer = new BufferedWriter(new FileWriter(new File(path+businessUrl),true));
			writer.append(htmlContent);
			writer.close();
			return businessUrl;
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
}
