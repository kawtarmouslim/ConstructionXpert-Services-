package authentifecation;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        String action = req.getServletPath();
        if( "/seConnecter".equals(action) || "/login.jsp".equals(action)){
            filterChain.doFilter(servletRequest, servletResponse);
        } else{
            Object isLoggedObj = req.getSession().getAttribute("isLoggedIn");
            if(isLoggedObj != null){
                boolean isLoggedIn = (Boolean) isLoggedObj;
                if(isLoggedIn){
                    filterChain.doFilter(servletRequest, servletResponse);
                    return;
                }
            }


            resp.sendRedirect("seConnecter");
        }
    }
}
