package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.domain.AuthVO;
import com.spring.domain.TimetblVO;
import com.spring.service.TimeService;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Controller
@RequestMapping("/time/*")
@AllArgsConstructor
public class TimeController {
	@Setter(onMethod_=@Autowired)
	private TimeService timeService;
	
	@GetMapping("/timetbl")
	public String timetblForm(HttpSession session, Model model) {
		AuthVO avo = (AuthVO) session.getAttribute("auth");
		String schoolname = avo.getSchoolname();
		String grade = avo.getGrade();
		String classnum = avo.getClassnum();
		List<TimetblVO> list = new ArrayList<TimetblVO>();
		list = timeService.getTimetbl(schoolname, grade, classnum);
		model.addAttribute("timelist", list);
		return "/timetbl/timetblForm";
	}
}
