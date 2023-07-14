package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.domain.MemberVO;

public interface MemberMapper {
	public void insertMember(MemberVO vo);
	
	public MemberVO selectMemberByUserid(String userid);
	
	public MemberVO selectMemberByParam(String userid);
	
	public void modifymember(MemberVO vo);
}
