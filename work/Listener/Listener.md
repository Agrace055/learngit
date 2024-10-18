## 2. Listener

1. **类设计**: 创建一个 `RequestLoggingListener` 类，实现 `javax.servlet.ServletRequestListener` 接口，用于处理请求的日志记录。
2. **记录内容**: 需记录以下请求信息：
   - 请求时间
   - 客户端 IP 地址
   - 请求方法（GET, POST 等）
   - 请求 URI
   - 查询字符串（如果有）
   - User-Agent 信息
   - 请求处理时间（从请求开始到结束的时间）
3. **日志记录格式**: 日志应简洁易读，方便后期的分析和问题排查。
4. **测试 Servlet**: 实现一个简单的 `TestServlet`，用于生成请求，验证日志记录功能是否正常工作。
