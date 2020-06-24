# 解决Spring boot admin + Swagger 后Swagger UI页面无法显示问题
> 参考许多资料，推测Spring Boot Admin 内部拦截了Swagger的静态资源。

* 创建一个WebConfig.java（名字可自定义）
```Java
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("swagger-ui.html")
                .addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");
    }

}
```
> 项目中没有加入security/shiro, 如果加入了安全验证，需要开放对应资源。

**参考资料**
* [spring boot admin导致swagger-ui.html无法访问的解决办法](https://blog.csdn.net/javajxz008/article/details/89361584)
* [精通SpringBoot——第三篇：详解WebMvcConfigurer接口](https://yq.aliyun.com/articles/617307)
