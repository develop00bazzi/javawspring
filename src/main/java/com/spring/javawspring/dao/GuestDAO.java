package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.GuestVO;

public interface GuestDAO {

	public ArrayList<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setGuestInput(@Param("vo") GuestVO vo);

	public int getGuestTotRecCnt();

	public void setGuestDelete(@Param("idx") int idx);

	public GuestVO getGuestContent(@Param("idx") int idx);

	public void setGuestUpdateOk(@Param("vo") GuestVO vo);

}
