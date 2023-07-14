package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.PageDTO;
import com.spring.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j2
public class BoardController {
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	
	public void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		for(BoardAttachVO attachVO : attachList) {
			try {
				Path file = Paths.get("C:\\upload\\" + attachVO.getUploadpath()+
					"\\" + attachVO.getUuid()+"_"+attachVO.getFilename());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attachVO.getUploadpath()+
							"\\s_" + attachVO.getUuid() + "_" + attachVO.getFilename());
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		}
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "/board/registerForm";
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public String getList(Criteria criteria, Model model) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = boardService.getList(criteria);
		model.addAttribute("list", list);
		int total = boardService.getTotal(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		log.info(list + "total: " + total);
		return "/board/listForm";
	}
	
	@GetMapping("/get")
	public String get(BoardVO vo, Criteria criteria, Model model) {
		BoardVO bvo = boardService.get(vo);
		model.addAttribute("get", bvo);
		return "/board/readForm";
	}
	
	@GetMapping("/modify")
	public String modifyForm(BoardVO vo, Criteria criteria, Model model) {
		BoardVO bvo = boardService.get(vo);
		model.addAttribute("get", bvo);
		return "/board/modifyForm";
	}
	
	@PostMapping("/modify")
	public String modifyBoard(BoardVO vo, Criteria criteria, RedirectAttributes rttr,  Model model) {
		if(boardService.modifyboard(vo)) {
				rttr.addFlashAttribute("result", "success");
			}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String removeBoard(BoardVO vo, Criteria criteria, RedirectAttributes rttr) {
		List<BoardAttachVO> attachList = boardService.getAttachList(vo.getBno());
		if(boardService.removeboard(vo)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
//		rttr.addAttribute("pageNum", criteria.getPageNum());
//		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/list";
	}
	
	@GetMapping(value="/getAttachList/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(@PathVariable("bno") Long bno){
		return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/getAttachListOnList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> getAttachList(
			@RequestParam(value="list[]") List<Long> list){
		Map<Long, List<BoardAttachVO>> map = new HashMap<Long, List<BoardAttachVO>>();
		for(Long bno : list) {
			map.put(bno, boardService.getAttachList(bno));
		}
		String gson = new Gson().toJson(map, HashMap.class);
		return new ResponseEntity<>(gson, HttpStatus.OK);
	}
}
