package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Criteria;
import com.spring.domain.QnAVO;
import com.spring.mapper.QnAMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class QnAService {
	@Setter(onMethod_=@Autowired)
	private QnAMapper qnaMapper;
	
	public void register(QnAVO vo) {
		qnaMapper.insertBoard(vo);
	}
	
//	public List<BoardVO> getList(){ 
//		return boardMapper.getList(); 
//	}
	
	public List<QnAVO> getList(Criteria criteria){
		return qnaMapper.getListWithPaging(criteria);
	}
	
	public int getTotal(Criteria criteria) {
		return qnaMapper.getTotalCount(criteria);
	}
	
	public QnAVO get(QnAVO vo) {
		return qnaMapper.read(vo.getBno());
	}
	
	public void modifyboard(QnAVO vo) {
		qnaMapper.modifyboard(vo);
	}
	
	public void removeboard(QnAVO vo) {
		int bno = vo.getBno();
		qnaMapper.removeboard(bno);
	}
}
