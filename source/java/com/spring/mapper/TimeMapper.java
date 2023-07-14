package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.domain.TimetblVO;

public interface TimeMapper {
	public List<TimetblVO> getTimetbl(@Param("schoolname") String schoolname, 
			@Param("grade") String grade, @Param("classnum") String classnum);
}
