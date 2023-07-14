package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.AuthVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.RecordVO;
import com.spring.mapper.RecordMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class RecordService {
	@Setter(onMethod_=@Autowired)
	private RecordMapper recordMapper;
	
	public List<MemberVO> getList(AuthVO vo){
		return recordMapper.getListWithPaging(vo);
	}
	
	public int getTotal(AuthVO vo, Criteria criteria) {
		return recordMapper.getTotalCount(vo);
	}
	
	public RecordVO get(MemberVO vo) {
		return recordMapper.getRecord(vo.getUserid());
	}
}
