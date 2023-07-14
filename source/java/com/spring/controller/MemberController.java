package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.AuthVO;
import com.spring.domain.MemberVO;
import com.spring.domain.ReplyVO;
import com.spring.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j2
public class MemberController {
	
	@Setter(onMethod_=@Autowired)
	private MemberService memberService;
	
	@GetMapping("/signup")
	public String signupForm() {
		
		return "/member/signupForm";
	}
	
	@PostMapping("/signup")
	public String singupSubmit(@RequestParam(value="username")String username, @RequestParam(value="userid")String userid, 
			@RequestParam(value="userpwd")String userpwd, @RequestParam(value="rrnum")String rrnum, 
			@RequestParam(value="addr1")String addr1, @RequestParam(value="addr2")String addr2, 
			@RequestParam(value="addr3")String addr3, @RequestParam(value="addr4")String addr4,
			@RequestParam(value="agree")String agree, @RequestParam(value="emailid")String emailid, 
			@RequestParam(value="emailname")String emailname, @RequestParam(value="mobile1")String mobile1,
			@RequestParam(value="mobile2")String mobile2, @RequestParam(value="mobile3")String mobile3, 
			@RequestParam(value="memcheck")String memcheck, @RequestParam(value="schoolname")String schoolname, 
			@RequestParam(value="grade")String grade, @RequestParam(value="classnum")String classnum,
			@RequestParam(value="stdnum")String stdnum){
		log.info("emailname: " + emailname);
		MemberVO vo = new MemberVO();
		vo.setUsername(username);
		vo.setUserid(userid);
		vo.setUserpwd(userpwd);
		vo.setRrnum(rrnum);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setAddr3(addr3);
		vo.setAddr4(addr4);
		vo.setAgree(agree);
		vo.setEmail(emailid=="" || emailname==""? " " : (emailid+"@"+emailname));
		vo.setMobile1(mobile1.equals("custom")? " " : mobile1);
		vo.setMobile2(mobile2=="" || mobile3==""? " " : (mobile2+mobile3));
		vo.setMemcheck(memcheck);
		vo.setSchoolname(schoolname);
		vo.setGrade(grade);
		vo.setClassnum(classnum);
		vo.setStdnum(stdnum==""? " " : stdnum);
		memberService.insertMember(vo);
		return "redirect:/member/login";
	}
	
	@GetMapping("/idcheck")
	public String idCheckForm() {
		
		return "/member/idCheckForm";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		
		return "/member/loginForm";
	}
	
	@PostMapping("/login")
	public String loginSubmit(MemberVO vo, HttpSession session, RedirectAttributes rttr, Model model){
		try {
			AuthVO avo = memberService.authenticate(vo);
			session.setAttribute("auth", avo);
			String userURI = (String)session.getAttribute("userURI");
			if(userURI != null) {
				session.removeAttribute("userURI");
				return "redirect:" + userURI;
			}else {
				return "redirect:/";
			}
		}catch(Exception e){
			rttr.addFlashAttribute("error", e.getMessage());
			rttr.addFlashAttribute("memberVO", vo);
			return "redirect:/member/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.removeAttribute("auth");
		rttr.addFlashAttribute("logoutmsg", "logout");
		return "redirect:/";
	}
	
	@GetMapping("/modify")
	public String modifyForm() {
		return "/member/modifyForm";
	}
	
	@PostMapping("/modify")
	public String modifymember(@RequestParam(value="username")String username, @RequestParam(value="userid")String userid, 
			@RequestParam(value="userpwd")String userpwd, @RequestParam(value="rrnum")String rrnum, 
			@RequestParam(value="addr1")String addr1, @RequestParam(value="addr2")String addr2, 
			@RequestParam(value="addr3")String addr3, @RequestParam(value="addr4")String addr4, 
			@RequestParam(value="agree")String agree, @RequestParam(value="emailid")String emailid, 
			@RequestParam(value="emailname")String emailname, @RequestParam(value="mobile1")String mobile1,
			@RequestParam(value="mobile2")String mobile2, @RequestParam(value="mobile3")String mobile3, 
			@RequestParam(value="memcheck")String memcheck, @RequestParam(value="schoolname")String schoolname, 
			@RequestParam(value="grade")String grade, @RequestParam(value="classnum")String classnum,
			@RequestParam(value="stdnum")String stdnum, HttpSession session) {
		MemberVO vo = new MemberVO();
		vo.setUsername(username);
		vo.setUserid(userid);
		vo.setUserpwd(userpwd);
		vo.setRrnum(rrnum);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setAddr3(addr3);
		vo.setAddr4(addr4);
		vo.setAgree(agree);
		vo.setEmail(emailid=="" || emailname==""? " " : (emailid+"@"+emailname));
		vo.setMobile1(mobile1.equals("custom")? " " : mobile1);
		vo.setMobile2(mobile2=="" || mobile3==""? " " : (mobile2+mobile3));
		vo.setMemcheck(memcheck);
		vo.setSchoolname(schoolname);
		vo.setGrade(grade);
		vo.setClassnum(classnum);
		vo.setStdnum(stdnum==""? " " : stdnum);
		memberService.modifymember(vo);
		session.removeAttribute("auth");
		return "redirect:/member/login";
	}
}
