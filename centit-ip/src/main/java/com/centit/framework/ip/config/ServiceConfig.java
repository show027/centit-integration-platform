package com.centit.framework.ip.config;

import com.centit.framework.components.impl.NotificationCenterImpl;
import com.centit.framework.components.impl.TextOperationLogWriterImpl;
import com.centit.framework.jdbc.config.JdbcConfig;
import com.centit.framework.model.adapter.NotificationCenter;
import com.centit.framework.model.adapter.OperationLogWriter;
import com.centit.framework.config.SpringSecurityCasConfig;
import com.centit.framework.config.SpringSecurityDaoConfig;
import com.centit.framework.system.config.SystemBeanConfig;
import org.springframework.context.annotation.*;

/**
 * Created by codefan on 17-7-18.
 */
@Configuration
@ComponentScan(basePackages = "com.centit",
        excludeFilters = @ComponentScan.Filter(value = org.springframework.stereotype.Controller.class))
@Import({SystemBeanConfig.class,
        SpringSecurityCasConfig.class,
        SpringSecurityDaoConfig.class,
        JdbcConfig.class})
public class ServiceConfig {

    @Bean
    public NotificationCenter notificationCenter() {
        NotificationCenterImpl notificationCenter = new NotificationCenterImpl();
        notificationCenter.initDummyMsgSenders();
        //notificationCenter.registerMessageSender("innerMsg",innerMessageManager);
        return notificationCenter;
    }

    @Bean
    @Lazy(value = false)
    public OperationLogWriter operationLogWriter() {
        TextOperationLogWriterImpl  operationLog =  new TextOperationLogWriterImpl();
        operationLog.init();
        return operationLog;
    }

    @Bean
    public InstantiationServiceBeanPostProcessor instantiationServiceBeanPostProcessor() {
        return new InstantiationServiceBeanPostProcessor();
    }

}
