package com.spring.domain;

import lombok.Data;

@Data
public class TimetblVO {
	private Integer timenum;
	private String time;
	private String monday;
	private String tuesday;
	private String wednesday;
	private String thursday;
	private String friday;
	private String saturday;
	private String schoolname;
	private String grade;
	private String classnum;
	private String userid;
	private String username;
	
	public TimetblVO() {
		
	}
}
