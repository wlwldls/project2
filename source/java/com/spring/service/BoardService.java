package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.mapper.BoardAttachMapper;
import com.spring.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardService {
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	public void register(BoardVO vo) {
		boardMapper.insertBoard(vo);
		
		List<BoardAttachVO> list = vo.getAttachList();
		if(list == null || list.isEmpty()) {
			return;
		}
		
		for(BoardAttachVO attach : list) {
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		}
	}
	
//	public List<BoardVO> getList(){ 
//		return boardMapper.getList(); 
//	}
	
	public List<BoardVO> getList(Criteria criteria){
		return boardMapper.getListWithPaging(criteria);
	}
	
	public int getTotal(Criteria criteria) {
		return boardMapper.getTotalCount(criteria);
	}
	
	public BoardVO get(BoardVO vo) {
		return boardMapper.read(vo.getBno());
	}
	
	public boolean modifyboard(BoardVO board) {
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = boardMapper.modifyboard(board) == 1;
		List<BoardAttachVO> list = board.getAttachList();
		if(modifyResult && list != null) {
			for(BoardAttachVO vo : list) {
				vo.setBno(board.getBno());
				attachMapper.insert(vo);
			}
		}
		return modifyResult;
	}
	
	public boolean removeboard(BoardVO vo) {
		long bno = vo.getBno();
		return boardMapper.removeboard(bno) == 1;
	}
	
	public List<BoardAttachVO> getAttachList(Long bno){
		return attachMapper.findByBno(bno);
	}
}
