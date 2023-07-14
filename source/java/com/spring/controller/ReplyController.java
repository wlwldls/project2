package com.spring.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.spring.domain.Criteria;
import com.spring.domain.ReplyPageDTO;
import com.spring.domain.ReplyVO;
import com.spring.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequestMapping("/replies/*")
@AllArgsConstructor
@Log4j2
public class ReplyController {
	private ReplyService replyService;
	
	@GetMapping(value = "/pages/{bno}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno){
		List<ReplyVO> list = replyService.getList(bno);
		log.info("list:" + list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping(value="/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyPageDTO> getListWithPaging(@PathVariable("bno") Long bno,
			@PathVariable("page") int page){
		Criteria criteria = new Criteria(page, 10);
		ReplyPageDTO dto = replyService.getListWithPaging(criteria, bno);
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@PostMapping(value="/new", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		log.info("ReplyVO: " + vo);
		int registerCount = replyService.register(vo);
		log.info("REPLY REGISTER COUNT: " + registerCount);
		return registerCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/get/{rno}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
				MediaType.APPLICATION_XML_VALUE	})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		ReplyVO vo = replyService.get(rno);
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	@PatchMapping(value="/update", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> update(@RequestBody ReplyVO vo){
		int updateCount = replyService.modify(vo);
		return updateCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/delete/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@PathVariable("rno") Long rno){
		int deleteCount = replyService.remove(rno);
		return deleteCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/cnt", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getReplyCnt(
			@RequestParam(value="list[]") List<Long> list){
		JsonObject jobj = new JsonObject();
		for(Long bno : list) {
			jobj.addProperty(String.valueOf(bno), replyService.getReplyCnt(bno));
		}
		return new ResponseEntity<>(jobj.toString(), HttpStatus.OK);
	}
}
