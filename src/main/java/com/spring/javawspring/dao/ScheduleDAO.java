package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.ScheduleVO;

public interface ScheduleDAO {

	public ArrayList<ScheduleVO> getScheduleList(@Param("mid") String mid,@Param("ym") String ym);

	public ArrayList<ScheduleVO> getScheduleMenu(@Param("mid") String mid, @Param("ymd") String ymd);

	public int setScheduleInputOk(@Param("vo") ScheduleVO vo);

	public int setScheduleUpdateOk(@Param("vo") ScheduleVO vo);
	
}
