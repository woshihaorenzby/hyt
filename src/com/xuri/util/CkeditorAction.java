package com.xuri.util;

import java.io.File;
import java.io.PrintWriter;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;


public class CkeditorAction extends BaseAction{
	private static final long serialVersionUID = 3537749671301523924L;
	
	private String uploadContentType;
	private String uploadFileName;
	private String CKEditorFuncNum;
	private String CKEditor;
	private String langCode;
	private File upload;
	
	public String uploadImgFile() {
		try{
			String curTime = DateUtil.getRecentDate("yyyyMMddHHmmss");
			String pathge = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathge+"/";
			String strPath = ServletActionContext.getServletContext().getRealPath("/file/ckeditorImg");
			File path = new File(strPath);
			if(!path.exists()){
				path.mkdirs();
			}
			/*InputStream is = new FileInputStream(this.upload);
			OutputStream os = new FileOutputStream(new File(strPath + File.separator + curTime + ".jpg"));
			byte[] buffer = new byte[1024*1024];
			while (is.read(buffer) > 0) {
				os.write(buffer);
			}
			if (is != null) {
				is.close();
			}
			if (os != null) {
				os.close();
			}*/
			if (upload != null) {
	            File savefile = new File(new File(strPath), curTime + ".jpg");
	            if (!savefile.getParentFile().exists())
	            	savefile.getParentFile().mkdirs();
	            FileUtils.copyFile(upload, savefile);
	        }
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			
			out.write("<script  type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("+this.CKEditorFuncNum+", '"+basePath+"file/ckeditorImg/" + curTime + ".jpg"+"', '');</script>");
			return Action.NONE;
		}catch(Exception e){
			System.out.println(e.toString());
		}
		return Action.NONE;
	}
	
	public String getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}
	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
	}
	public String getCKEditor() {
		return CKEditor;
	}
	public void setCKEditor(String cKEditor) {
		CKEditor = cKEditor;
	}
	public String getLangCode() {
		return langCode;
	}
	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}