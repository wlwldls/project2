package com.spring.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class QnAVO {
	private Long rn;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String ptype;
	private String filename;
	private MultipartFile file;
	private Timestamp regdate;
	private Timestamp updatedate;
	
	public QnAVO() {
		
	}
}
