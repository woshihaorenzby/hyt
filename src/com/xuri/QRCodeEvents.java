package com.xuri;

import java.io.File;
import java.util.Hashtable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

public class QRCodeEvents {
	public static void main(String []args)throws Exception{   
        String text = "http://www.baidu.com";   
        int width = 300;   
        int height = 300;   
        String format = "png";   
        Hashtable hints= new Hashtable();   
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");   
         BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height,hints);   
         File outputFile = new File("D://new.png");   
         MatrixToImageWriter.writeToFile(deleteWhite(bitMatrix), format, outputFile);   
         
		 
    }   
	public static BitMatrix deleteWhite(BitMatrix matrix){  
	    int[] rec = matrix.getEnclosingRectangle();  
	    int resWidth = rec[2] + 1;  
	    int resHeight = rec[3] + 1;  
	  
	    BitMatrix resMatrix = new BitMatrix(resWidth, resHeight);  
	    resMatrix.clear();  
	    for (int i = 0; i < resWidth; i++) {  
	        for (int j = 0; j < resHeight; j++) {  
	            if (matrix.get(i + rec[0], j + rec[1]))  
	                resMatrix.set(i, j);  
	        }  
	    }  
	    return resMatrix;  
	} 
}
