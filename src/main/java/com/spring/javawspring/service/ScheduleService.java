package com.spring.javawspring.service;

import java.util.ArrayList;

import com.spring.javawspring.vo.ScheduleVO;

public interface ScheduleService {

	public void getSchedule();

	public ArrayList<ScheduleVO> getScheduleMenu(String mid, String ymd);

	public int setScheduleInputOk(ScheduleVO vo);

	public int setScheduleUpdateOk(ScheduleVO vo);

}
