# Spring 注解

## Spring Boot注解
* @ResponseBody:
  * 该注解用于将Controller的方法返回的对象，通过适当的HttpMessageConverter转换为指定格式后，写入到Response对象的body数据区
* @RequestBody:
  * 该注解用于读取Request请求的body部分数据，使用系统默认配置的HttpMessageConverter进行解析，然后把相应的数据绑定到要返回的对象上
  * 再把HttpMessageConverter返回的对象数据绑定到 controller中方法的参数上
* @RequestMapping:处理请求地址映射，用于方法和类上
  * 类：表示类中的所有响应请求的方法都是以该地址作为父路径
  * 方法：表示在类的父路径下追加方法上注解中的地址将会访问到该方法
* @RestController: @ResponseBody + @Controller
