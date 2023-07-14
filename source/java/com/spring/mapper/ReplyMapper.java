package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.domain.Criteria;
import com.spring.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO vo);
	
	public List<ReplyVO> getList(Long bno);
	
	public List<ReplyVO> getListWithPaging(@Param("criteria")Criteria criteria, @Param("bno")Long bno);
	
	public int getTotalCount(Long bno);
}
