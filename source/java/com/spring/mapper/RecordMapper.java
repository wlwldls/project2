package com.spring.mapper;

import java.util.List;

import com.spring.domain.AuthVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.RecordVO;

public interface RecordMapper {
	public List<MemberVO> getListWithPaging(AuthVO vo);
	
	public int getTotalCount(AuthVO vo);
	
	public RecordVO getRecord(String userid);
}
