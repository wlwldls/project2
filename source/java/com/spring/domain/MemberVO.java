package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private String schoolname;
	private String grade;
	private String classnum;
	private String stdnum;
	private String username;
	private String rrnum;
	private String agree;
	private String mobile1;
	private String mobile2;
	private String userid;
	private String userpwd;
	private String memcheck;
	private Timestamp signupdate;
	private Timestamp updatedate;
	private String email;
	private String addr1;
	private String addr2;
	private String addr3;
	private String addr4;
	
	public MemberVO() {
		
	}
}
