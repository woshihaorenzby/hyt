package com.xuri.system.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LogonInterceptor extends AbstractInterceptor { 
	private static final long serialVersionUID = -8095523333527107156L;

	@Override 
	public String intercept(ActionInvocation invocation) {
		try{
			String method = invocation.getProxy().getMethod();
			ActionContext ac = invocation.getInvocationContext();
//			ac.getSession().put("id", "3");
//			ac.getSession().put("userId", "3");
			String id = (String)ac.getSession().get("id");
			String userId = (String)ac.getSession().get("userId");
			if(userId == null && !method.startsWith("app") && !method.startsWith("wx") && !method.equals("showLogin") && !method.equals("login") && !method.equals("list")){
				return "showLogin";
			}
			if(id == null) {

			}
			String a = invocation.invoke();
			return a;
		}catch(Exception e){
			e.printStackTrace();
			return "login"; 
		}
	}
}
