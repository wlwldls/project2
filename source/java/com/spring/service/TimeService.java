package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.TimetblVO;
import com.spring.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class TimeService {
	@Setter(onMethod_=@Autowired)
	private TimeMapper timeMapper;
	
	public List<TimetblVO> getTimetbl(String schoolname, String grade, String classnum){
		return timeMapper.getTimetbl(schoolname, grade, classnum);
	}
}
