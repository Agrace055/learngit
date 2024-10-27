package org.example;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@WebFilter("/*")
public class LoginFilter implements Filter {

    // 定义排除列表，包含无需登录即可访问的路径
    private static final List<String> excludedPaths = Arrays.asList("/login", "/register", "/public");

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化方法，过滤器启动时调用。可以在此进行资源初始化。
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 获取当前请求路径
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // 检查当前请求路径是否在排除列表中
        if (isExcludedPath(path)) {
            // 如果是登录页面、注册页面或公共资源，允许请求通过
            chain.doFilter(request, response);
            return;
        }

        // 获取 session 对象
        HttpSession session = httpRequest.getSession(false);

        // 检查 session 中是否存在 "user" 属性，表示用户已登录
        if (session != null && session.getAttribute("user") != null) {
            // 用户已登录，允许请求继续
            chain.doFilter(request, response);
        } else {
            // 用户未登录，重定向到登录页面
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // 过滤器销毁时调用。可以在此进行资源清理。
    }

    private boolean isExcludedPath(String path) {
        return excludedPaths.stream().anyMatch(path::startsWith);
    }
}
