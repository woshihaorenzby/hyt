package com.xuri.util;

import java.io.*;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;
@Component
public class FileUtil {
	/**
	* @Title: getExtensionName
	* @Description: TODO(Java文件操作 获取文件扩展名)
	* @param @param filename
	*/
	public static String getExtensionName(String filename) { 
		if ((filename != null) && (filename.length() > 0)) {
			int dot = filename.lastIndexOf('.');
			if ((dot >-1) && (dot < (filename.length() - 1))) {
				return filename.substring(dot + 1);
			}
		}
		return filename;
	}
	/**
	* @Title: getFileNameNoEx
	* @Description: TODO(Java文件操作 获取不带扩展名的文件名)
	* @param @param filename
	*/
	public static String getFileNameNoEx(String filename) {
		if ((filename != null) && (filename.length() > 0)) {
			int dot = filename.lastIndexOf('.');
			if ((dot >-1) && (dot < (filename.length()))) {
				return filename.substring(0, dot);
			}
		}
		return filename;
	}
	
	public static String appUploadImg(File file) {
		try{
			InputStream is = new FileInputStream(file);
			String path = "file/img/" + DateUtil.getRecentDate("yyyyMM") + "/";
			String realpath = ServletActionContext.getServletContext().getRealPath(path);
			File upfile = new File(realpath);      
			if(!upfile.exists()){
				upfile.mkdir();    
			}
	        String curTime = DateUtil.getRecentDate("yyyyMMddHHmmssS");
	        String photo = realpath + "/" + curTime + ".png";
			File f = new File(photo);
			FileOutputStream fos = new FileOutputStream(f);
	        int hasRead = 0;
	        byte[] buf = new byte[1024];
	        while((hasRead = is.read(buf)) > 0){
	            fos.write(buf, 0, hasRead);
	        }
	        fos.close();
	        is.close();
	        return path + curTime + ".png";
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	public static String appUploadImgSmall(File file) {
		try{
			if (file == null)
				return "";
			InputStream is = new FileInputStream(file);
			String path = "/file/img/" + DateUtil.getRecentDate("yyyyMM") + "/";
			String realpath = ServletActionContext.getServletContext().getRealPath(path);
			File upfile = new File(realpath);      
			if(!upfile.exists()){
				upfile.mkdir();    
			}
	        String curTime = DateUtil.getRecentDate("yyyyMMddHHmmssS");
	        String photo = realpath + "/" + curTime + ".png";
			File f = new File(photo);
			FileOutputStream fos = new FileOutputStream(f);
	        int hasRead = 0;
	        byte[] buf = new byte[1024];
	        while((hasRead = is.read(buf)) > 0){
	            fos.write(buf, 0, hasRead);
	        }
	        fos.close();
	        is.close();
	        //缩略图
	        String smallFile = realpath + "/" + curTime + "sm.png";
	        File originalImage = new File(photo);
			byte[] bytes = ImageUtils.resize(ImageIO.read(originalImage), 100, 1f, true);
			FileOutputStream out = new FileOutputStream(new File(smallFile));
			out.write(bytes);
			out.close();
	        //String imagesize = toSmaillImg(photo, realpath + "/" + curTime + "sm.png");
	        return path + curTime + ".png" + "|" + path + curTime + "sm.png" + "|"+ImageIO.read(new File(smallFile)).getWidth()+"|"+ImageIO.read(new File(smallFile)).getHeight();
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	
	public static void writeTxt(String path, String content) {
        File f = new File(path);
        FileReader fr;
        BufferedReader br;
        FileWriter fw;
        BufferedWriter bw;
        StringBuffer sb = new StringBuffer();
        try {
            fw = new FileWriter(f);// 初始化输出流
            bw = new BufferedWriter(fw);// 初始化输出字符流
            bw.write(content);// 写文件
            bw.flush();
            bw.close();
            fw.close();
             
            fr = new FileReader(f);// 初始化输入流
            br = new BufferedReader(fr);// 初始化输入字符流
            sb.append(br.readLine().toString());// 按行读文件
            br.close();
            fr.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	public List<String[]> readExcel(File excel) {

		// Map<Integer, Object> map = new LinkedHashMap<Integer, Object>();//
		// 导入行
		Workbook workbook = null;
		List<String[]> list = new ArrayList<String[]>();
		try {
			workbook = this.getWorkbook(excel);
			if (workbook != null) {
				// 读取excel1（sheet从0开始）
				Sheet sheet = workbook.getSheetAt(0);
				int firstRowIndex = sheet.getFirstRowNum();
				int lastRowIndex = sheet.getLastRowNum();
				// 读取首行 即,表头
				Row firstRow = sheet.getRow(1);
				// for (int i = firstRow.getFirstCellNum() + 2; i <=
				// firstRow.getLastCellNum(); i++) {
				// Cell cell = firstRow.getCell(i);
				// Integer rowValue = i;
				// String cellValue = this.getCellValue(cell, true);
				// map.put(rowValue, cellValue);
				// }
				// 读取数据行
				for (int rowIndex = firstRowIndex + 1; rowIndex <= lastRowIndex; rowIndex++) {
					Row currentRow = sheet.getRow(rowIndex);// 当前行
					if (currentRow != null) {
						int firstColumnIndex = firstRow.getFirstCellNum(); // 首列
						int lastColumnIndex = firstRow.getLastCellNum();// 最后一列
						String[] str = new String[lastColumnIndex - firstColumnIndex];
						boolean ret = false;
						for (int columnIndex = firstColumnIndex; columnIndex < lastColumnIndex; columnIndex++) {
							Cell currentCell = currentRow.getCell(columnIndex);// 当前单元格
							String currentCellValue = this.getCellValueByz(currentCell, true);// 当前单元格的值
							if (StringUtils.isNotBlank(currentCellValue)) {
								str[columnIndex] = currentCellValue;
								ret = true;
							}
						}
						if (str != null && ret) {
							list.add(str);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("请使用模板编辑导入");
		}
		return list;

	}
	/**
	 * 读取excel时创建workbook
	 *
	 * @param excel
	 * @return
	 * @throws IOException
	 */
	private Workbook getWorkbook(File excel) throws IOException, InvalidFormatException {
//		FileInputStream fis= new FileInputStream(excel);
		return WorkbookFactory.create(excel);
	}

	/**、
	 *
	 * @param cell
	 * @param treatAsStr
	 * @return
	 */
	private String getCellValueByz(Cell cell, boolean treatAsStr) {
		if (cell == null) {
			return "";
		}
		if (treatAsStr) {
			// 虽然excel中设置的都是文本，但是数字文本还被读错，如“1”取成“1.0”
			if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC){
				String format = "";
				if(HSSFDateUtil.isCellDateFormatted(cell)){
					//用于转化为日期格式
					Date d = cell.getDateCellValue();
					DateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					format = formater.format(d);
				}else{
					// 用于格式化数字，只保留数字的整数部分
					DecimalFormat df = new DecimalFormat("########.####");
					format = df.format(cell.getNumericCellValue());
				}
				return String.valueOf(format);
			}else {
				cell.setCellType(Cell.CELL_TYPE_STRING);
			}
		}
		if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(cell.getBooleanCellValue());
		} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			return String.valueOf(cell.getDateCellValue());
		} else {
			return String.valueOf(cell.getStringCellValue());
		}
	}
}