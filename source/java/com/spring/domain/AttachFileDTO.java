package com.spring.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String filename;
	private String uploadpath;
	private String uuid;
	private boolean image;
}
