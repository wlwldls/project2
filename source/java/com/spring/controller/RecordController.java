package com.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.AuthVO;
import com.spring.domain.MemberVO;
import com.spring.domain.RecordVO;
import com.spring.service.RecordService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/record/*")
@AllArgsConstructor
@Log4j2
public class RecordController {
	@Setter(onMethod_=@Autowired)
	private RecordService recordService;
	
	@GetMapping("/list")
	public String getList(HttpSession session, Model model) {
		AuthVO avo = (AuthVO) session.getAttribute("auth");
		Map<String, Object> map = new HashMap<>();
		List<MemberVO> list = new ArrayList<>();
		List<String> rCheck = new ArrayList<>();
		list = recordService.getList(avo);
		for(int i=0; i<list.size(); i++) {
			if(recordService.get(list.get(i)) == null) {
				rCheck.add(i, "0");
			}else {
				rCheck.add(i, "1");
			}
		}
		map.put("list", list);
		map.put("rcheck", rCheck);
		model.addAttribute("map", map);
		return "/record/listForm";
	}
	
	@GetMapping("/get")
	public String get(HttpSession session, Model model) {
		AuthVO avo = (AuthVO) session.getAttribute("auth");
		String userid = avo.getUserid();
		MemberVO mvo = new MemberVO();
		mvo.setUserid(userid);
		RecordVO rvo = recordService.get(mvo);
		model.addAttribute("rvo", rvo);
		return "/record/readForm";
	}
}
