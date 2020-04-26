package com.xuri.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;
import javax.swing.ImageIcon;

/**
* @ClassName: ImageUtils
* @Description: TODO(图片缩略图)
* @author: 王东
* @date: 2015-11-9 下午2:23:09
*/
public class ImageUtils {
	public static byte[] resize(BufferedImage srcBufferedImage, int targetWidth) throws IOException {
		return resize(srcBufferedImage, targetWidth, 1f, false);
	}

	public static byte[] resize(BufferedImage srcBufferedImage, int targetWidth, boolean square) throws IOException {
		return resize(srcBufferedImage, targetWidth, square);
	}

	public static byte[] resize(BufferedImage srcBufferedImage, int targetWidth, float quality, boolean square) throws IOException {
		if (quality > 1) {
			throw new IllegalArgumentException("Quality has to be between 0 and 1");
		}
		if (square) {
			// 正方形，需要提前进行裁剪
			int width = srcBufferedImage.getWidth();
			int height = srcBufferedImage.getHeight();
			if (width > height) {
				int x = (width - height) / 2;
				srcBufferedImage = srcBufferedImage.getSubimage(x, 0, height, height);
			} else if (width < height) {
				int y = (height - width) / 2;
				srcBufferedImage = srcBufferedImage.getSubimage(0, y, width, width);
			}
		}

		Image resizedImage = null;
		int iWidth = srcBufferedImage.getWidth();
		int iHeight = srcBufferedImage.getHeight();

		if (iWidth > iHeight) {
			resizedImage = srcBufferedImage.getScaledInstance(targetWidth, (targetWidth * iHeight) / iWidth, Image.SCALE_SMOOTH);
		} else {
			resizedImage = srcBufferedImage.getScaledInstance((targetWidth * iWidth) / iHeight, targetWidth, Image.SCALE_SMOOTH);
		}

		// This code ensures that all the pixels in the image are loaded.
		Image temp = new ImageIcon(resizedImage).getImage();

		// Create the buffered image.
		BufferedImage bufferedImage = new BufferedImage(temp.getWidth(null), temp.getHeight(null), BufferedImage.TYPE_INT_RGB);

		// Copy image to buffered image.
		Graphics g = bufferedImage.createGraphics();

		// Clear background and paint the image.
		g.setColor(Color.white);
		g.fillRect(0, 0, temp.getWidth(null), temp.getHeight(null));
		g.drawImage(temp, 0, 0, null);
		g.dispose();

		// Soften.
		float softenFactor = 0.05f;
		float[] softenArray = { 0, softenFactor, 0, softenFactor, 1 - (softenFactor * 4), softenFactor, 0, softenFactor, 0 };
		Kernel kernel = new Kernel(3, 3, softenArray);
		ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
		bufferedImage = cOp.filter(bufferedImage, null);

		// Write the jpeg to a file.

		// Encodes image as a JPEG data stream
		// JPEGImageEncoder encoder = JPEGCodeca
		// .createJPEGEncoder(byteArrayOutputStream);
		//
		// JPEGEncodeParam param = encoder
		// .getDefaultJPEGEncodeParam(bufferedImage);
		//
		// param.setQuality(quality, true);
		//
		// encoder.setJPEGEncodeParam(param);
		// encoder.encode(bufferedImage);

		ImageWriter writer = ImageIO.getImageWritersByFormatName("jpeg").next();
		ImageWriteParam param = writer.getDefaultWriteParam();
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(1.0F); // Highest quality
		// Write the JPEG to our ByteArray stream
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		ImageOutputStream imageOutputStream = ImageIO .createImageOutputStream(byteArrayOutputStream);
		writer.setOutput(imageOutputStream);
		writer.write(null, new IIOImage(bufferedImage, null, null), param);
		return byteArrayOutputStream.toByteArray();
	}
	
	/*
	 * 根据尺寸图片居中裁剪
	 */
	 public static void cutCenterImage(String src,String dest,int w,int h) throws IOException{ 
		 Iterator iterator = ImageIO.getImageReadersByFormatName("jpg"); 
         ImageReader reader = (ImageReader)iterator.next(); 
         InputStream in=new FileInputStream(src);
         ImageInputStream iis = ImageIO.createImageInputStream(in); 
         reader.setInput(iis, true); 
         ImageReadParam param = reader.getDefaultReadParam(); 
         int imageIndex = 0; 
         Rectangle rect = new Rectangle((reader.getWidth(imageIndex)-w)/2, (reader.getHeight(imageIndex)-h)/2, w, h);  
         param.setSourceRegion(rect); 
         BufferedImage bi = reader.read(0,param);   
         ImageIO.write(bi, "jpg", new File(dest));           
  
	 }
	/*
	 * 图片裁剪二分之一
	 */
	 public static void cutHalfImage(String src,String dest) throws IOException{ 
		 Iterator iterator = ImageIO.getImageReadersByFormatName("jpg"); 
         ImageReader reader = (ImageReader)iterator.next(); 
         InputStream in=new FileInputStream(src);
         ImageInputStream iis = ImageIO.createImageInputStream(in); 
         reader.setInput(iis, true); 
         ImageReadParam param = reader.getDefaultReadParam(); 
         int imageIndex = 0; 
         int width = reader.getWidth(imageIndex)/2; 
         int height = reader.getHeight(imageIndex)/2; 
         Rectangle rect = new Rectangle(width/2, height/2, width, height); 
         param.setSourceRegion(rect); 
         BufferedImage bi = reader.read(0,param);   
         ImageIO.write(bi, "jpg", new File(dest));   
	 }
	/*
	 * 图片裁剪通用接口
	 */

    public static void cutImage(String src,String dest,int x,int y,int w,int h) throws IOException{ 
		Iterator iterator = ImageIO.getImageReadersByFormatName("jpg");
		ImageReader reader = (ImageReader) iterator.next();
		InputStream in = new FileInputStream(src);
		ImageInputStream iis = ImageIO.createImageInputStream(in);
		reader.setInput(iis, true);
		ImageReadParam param = reader.getDefaultReadParam();
		Rectangle rect = new Rectangle(x, y, w, h);
		param.setSourceRegion(rect);
		BufferedImage bi = reader.read(0, param);
		ImageIO.write(bi, "jpg", new File(dest));
		bi.flush();
		iis.close();
		in.close();
    }
    /*
     * 图片缩放
     */
    public static void zoomImage(String src,String dest,int w,int h) throws Exception {
		double wr=0,hr=0;
		File srcFile = new File(src);
		File destFile = new File(dest);
		BufferedImage bufImg = ImageIO.read(srcFile);
		Image Itemp = bufImg.getScaledInstance(w, h, bufImg.SCALE_SMOOTH);
		wr=w*1.0/bufImg.getWidth();
		hr=h*1.0 / bufImg.getHeight();
		AffineTransformOp ato = new AffineTransformOp(AffineTransform.getScaleInstance(wr, hr), null);
		Itemp = ato.filter(bufImg, null);
		try {
			ImageIO.write((BufferedImage) Itemp,dest.substring(dest.lastIndexOf(".")+1), destFile);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
	// Example usage
	public static void main(String[] args) throws IOException {
		File originalImage = new File("C:\\1.png");
		byte[] bytes = resize(ImageIO.read(originalImage), 800, 1f, false);
		FileOutputStream out = new FileOutputStream(new File("C:\\2.png"));
		out.write(bytes);
		out.close();
		System.out.println("Ok");
	}
}
