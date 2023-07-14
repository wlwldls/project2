package com.spring.mapper;

import java.util.List;

import com.spring.domain.Criteria;
import com.spring.domain.QnAVO;

public interface QnAMapper {
	public void insertBoard(QnAVO vo);
	
	public List<QnAVO> getList();
	
	public QnAVO read(int bno);
	
	public void modifyboard(QnAVO vo);
	
	public void removeboard(int bno);
	
	public List<QnAVO> getListWithPaging(Criteria criteria);
	
	public int getTotalCount(Criteria criteria);
}
