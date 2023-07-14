package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AuthVO {
	private String schoolname;
	private String grade;
	private String classnum;
	private String stdnum;
	private String userid;
	private String username;
	private String memcheck;
	
	public AuthVO() {
		
	}
}
