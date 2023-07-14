package com.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.UrlPathHelper;

public class AuthCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		if(session !=null) {
			Object auth = session.getAttribute("auth");
			if(auth != null) {
				return true;
			}
		}
		String userURI = new UrlPathHelper().getPathWithinApplication(request);
		String queryString = request.getQueryString();
		if(queryString != null && !queryString.isEmpty()) {
			userURI += "?" + queryString;
		}
		if(session != null) {
			session.setAttribute("userURI", userURI);
		}
		response.sendRedirect(request.getContextPath()+ "/member/login");
		return false;
	}
}
