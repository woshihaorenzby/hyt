package com.xuri.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public abstract class BaseAction extends ActionSupport implements ServletRequestAware, ServletResponseAware{
	private static final long serialVersionUID = -3459165284441573679L;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	
	public String getParameter(String name) {
		return (null==this.request.getParameter(name))?null:this.request.getParameter(name);
	}
	/**
	 * 取得HttpRequest中Attribute的简化函数.
	 */
	public Object getRequestAttribute(String name) {
		return request.getAttribute(name);
	}
	/**
	 * 取得HttpSession中Attribute的简化函数.
	 */
	public Object getSessionAttribute(String name) {
		 return this.getSession().getAttribute(name);
	}
	/**
	 * 取得HttpSession的简化函数.
	 */
	public HttpSession getSession() {
		return request.getSession();
	}
	//-------自动生成----------//
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
		
	}
	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
		
	}
}
