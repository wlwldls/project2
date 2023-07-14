package com.spring.aop;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Aspect
@Component
public class FunctionAdvice {
	//@Before("execution(* com.spring.service.BoardService.*(..))")
	@Before("execution(* com.spring.service.RecordService.get(..))")
	public void boardBefore() {
		log.info("================boardBefore=================");
	}
}
