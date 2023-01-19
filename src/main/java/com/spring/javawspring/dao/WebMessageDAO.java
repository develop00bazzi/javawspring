package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.WebMessageVO;

public interface WebMessageDAO {

	public WebMessageVO getWmMessageOne(@Param("idx") int idx, @Param("mid") String mid, @Param("mFlag") int mFlag);

	public int getWmMessageListCnt(@Param("mid") String mid, @Param("mSw") int mSw);

	public ArrayList<WebMessageVO> getWmMessageList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("mSw") int mSw);

	public void setWmInputOk(@Param("vo") WebMessageVO vo);

	public void setWmUpdate(@Param("idx") int idx, @Param("mid") String mid);

	public void wmDeleteCheck(@Param("idx") int idx, @Param("mFlag") int mFlag);

	public void setWmDeleteAll(@Param("mid") String mid);
	
}
