package com.spring.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.domain.MemberVO;
import com.spring.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequestMapping("/check/*")
@AllArgsConstructor
@Log4j2
public class IdCheckController {
	private MemberService memberService;
	
	@PostMapping(value="/idcheck", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> idcheck(@RequestBody MemberVO vo){
		String userid = vo.getUserid();
		int idcheckBoolean = memberService.checkuserid(userid);
		return idcheckBoolean == 1 ? new ResponseEntity<>("true", HttpStatus.OK)
				: new ResponseEntity<>("false", HttpStatus.OK);
	}
}
