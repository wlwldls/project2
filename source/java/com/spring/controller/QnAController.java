package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.PageDTO;
import com.spring.domain.QnAVO;
import com.spring.service.QnAService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/qna/*")
@AllArgsConstructor
@Log4j2
public class QnAController {
	@Setter(onMethod_=@Autowired)
	private QnAService qnaService;
	
	@GetMapping("/register")
	public String registerForm() {
		return "/qna/registerForm";
	}
	
	@PostMapping("/register")
	public String register(QnAVO vo, RedirectAttributes rttr) throws IOException{
		String fileName=null;
		MultipartFile uploadFile = vo.getFile();
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=originalFileName; //+"."+ext;
			uploadFile.transferTo(new File("D:\\tmp\\" + fileName));
		}else {
			fileName="파일없음";
			boolean filecheck = false;
			rttr.addFlashAttribute("filecheck", filecheck);
		}
		vo.setFilename(fileName);
		qnaService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		return "redirect:/qna/list";
	}
	
	@GetMapping("/list")
	public String getList(Criteria criteria, Model model) {
		List<QnAVO> list = new ArrayList<QnAVO>();
		list = qnaService.getList(criteria);
		model.addAttribute("list", list);
		int total = qnaService.getTotal(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		log.info(list + "total: " + total);
		return "/qna/listForm";
	}
	
	@GetMapping("/get")
	public String get(QnAVO vo, Criteria criteria, Model model) {
		QnAVO bvo = qnaService.get(vo);
		model.addAttribute("get", bvo);
		return "/qna/readForm";
	}
	
	@GetMapping("/modify")
	public String modifyForm(QnAVO vo, Criteria criteria, Model model) {
		QnAVO bvo = qnaService.get(vo);
		model.addAttribute("get", bvo);
		return "/qna/modifyForm";
	}
	
	@PostMapping("/modify")
	public String modifyBoard(QnAVO vo, Criteria criteria, RedirectAttributes rttr,  Model model) throws IOException{
		String fileName=null;
		MultipartFile uploadFile = vo.getFile();
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			//String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			//UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=originalFileName; //+"."+ext;
			uploadFile.transferTo(new File("D:\\tmp\\" + fileName));
		}else {
			fileName="파일없음";
			boolean filecheck = false;
			rttr.addFlashAttribute("filecheck", filecheck);
		}
		vo.setFilename(fileName);
		qnaService.modifyboard(vo);
		rttr.addFlashAttribute("result", "success");
		return "redirect:/qna/list";
	}
	
	@PostMapping("/remove")
	public String removeBoard(QnAVO vo, Criteria criteria, RedirectAttributes rttr) {
		qnaService.removeboard(vo);
		rttr.addFlashAttribute("result", "success");
		return "redirect:/qna/list";
	}
}
