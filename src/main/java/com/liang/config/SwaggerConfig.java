package com.liang.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author maliang
 * @create 2020-07-15 10:34
 *
 * 整合到ssm需要加 @EnableWebMvc、@ComponentScan(basePackages = {"com.liang.controller" })
 */
@Configuration
@EnableSwagger2
@EnableWebMvc
@ComponentScan(basePackages = {"com.liang.controller" })
public class SwaggerConfig {
    @Bean
    Docket docket() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.liang.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("南生论坛 Restful API 文档")
                .description("提供【南生论坛 Restful API 文档】，给想使用该论坛接口的前端童鞋测试，可以根据其开发一套你们自己的前端界面")
                .termsOfServiceUrl("https://github.com/maliangnansheng/bbs-ssm")
                .version("2.8.2")
                .contact(new Contact("马亮南生",
                        "https://github.com/maliangnansheng/bbs-ssm",
                        "924818949@qq.com"))
                .build();
    }
}
