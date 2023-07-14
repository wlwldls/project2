package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class RecordVO {
	private String schoolname;
	private String grade;
	private String stdnum;
	private String username;
	private String userid;
	private String notice;
	private Timestamp regdate;
	private Timestamp updatdate;
}
