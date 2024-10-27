package org.example;


import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpServletRequest;

import java.util.Date;

@WebListener("/test")
public class RequestLoggingListener implements ServletRequestListener {

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest req = (HttpServletRequest) sre.getServletRequest();
        // 记录请求开始时间
        long startTime = System.currentTimeMillis();
        req.setAttribute("startTime", startTime);

        // 记录请求的基本信息
        log("Request started at " + new Date() + ", IP: " + req.getRemoteAddr() +
                ", Method: " + req.getMethod() + ", URI: " + req.getRequestURI() +
                ", Query String: " + req.getQueryString() +
                ", User-Agent: " + req.getHeader("User-Agent"));
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        HttpServletRequest req = (HttpServletRequest) sre.getServletRequest();
        // 获取请求开始时间
        long startTime = (long) req.getAttribute("startTime");
        // 计算请求处理时间
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        // 记录请求处理时间
        log("Request completed in " + duration + " ms.");
    }

    private void log(String message) {
        System.out.println(message); // 这里可以替换为更复杂的日志框架，如 Log4J 或 SLF4J
    }
}

