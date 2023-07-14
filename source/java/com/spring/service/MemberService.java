package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.domain.AuthVO;
import com.spring.domain.MemberVO;
import com.spring.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberService {
	@Setter(onMethod_=@Autowired)
	private MemberMapper memberMapper;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	
	public void insertMember(MemberVO vo) {
		vo.setUserpwd(encoder.encode(vo.getUserpwd()));
		memberMapper.insertMember(vo);
	}
	
	public int checkuserid(String userid){
		MemberVO mvo = memberMapper.selectMemberByParam(userid);
		if(mvo == null) {
			return 1;
		}else {
			return 0;
		}
	}
	
	public AuthVO authenticate(MemberVO vo) throws Exception{
		String userid = vo.getUserid();
		MemberVO mvo = memberMapper.selectMemberByUserid(userid);
		AuthVO avo = new AuthVO();
		if(mvo == null) {
			throw new Exception("nonuser");
		}
		if(!encoder.matches(vo.getUserpwd(), mvo.getUserpwd())){
			throw new Exception("nomatch");
		}
		avo.setSchoolname(mvo.getSchoolname());
		avo.setGrade(mvo.getGrade());
		avo.setClassnum(mvo.getClassnum());
		avo.setStdnum(mvo.getStdnum());
		avo.setUsername(mvo.getUsername());
		avo.setUserid(mvo.getUserid());
		avo.setMemcheck(mvo.getMemcheck());
		return avo;
	}
	
	public void modifymember(MemberVO vo) {
		vo.setUserpwd(encoder.encode(vo.getUserpwd()));
		memberMapper.modifymember(vo);
	}
}
