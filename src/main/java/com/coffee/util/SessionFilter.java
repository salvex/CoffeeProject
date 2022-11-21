package com.coffee.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class SessionFilter
 */
@WebFilter(
		filterName = "SessionFilter", 
		urlPatterns = { 
				"/User",
				"/User/Info",
				"/User/Credit",
				"/User/Connect",
				"/User/Disconnect"
		})
public class SessionFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public SessionFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String uri = req.getRequestURI();
		
		HttpSession session = req.getSession(false);
		
		System.out.println(session);
		
		if(session == null || (session.getAttribute("user") == null)) {
			if(uri.endsWith("Info") || uri.endsWith("Credit") || uri.endsWith("Connect") || uri.endsWith("Disconnect") ) {
				res.sendRedirect("../index.jsp");
				System.out.println("protected by session2");
			} else {
				res.sendRedirect("index.jsp");
				System.out.println("protected by session");
			}
		} else {
			System.out.println("pass session");
			res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
	        res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
	        res.setDateHeader("Expires", 0);
			chain.doFilter(request, response);
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
