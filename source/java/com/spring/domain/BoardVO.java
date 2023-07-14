package com.spring.domain;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private Long rn;
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private String impcheck;
	private Timestamp regdate;
	private Timestamp updatedate;
	private List<BoardAttachVO> attachList;
	
	public BoardVO() {
		
	}
}
