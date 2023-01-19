package com.spring.javawspring.service;

import java.util.ArrayList;

import com.spring.javawspring.vo.WebMessageVO;

public interface WebMessageService {

	public WebMessageVO getWmMessageOne(int idx, String mid, int mFlag, String receiveSw);

	public int getWmMessageListCnt(String mid, int mSw);

	public ArrayList<WebMessageVO> getWmMessageList(int startIndexNo, int pageSize, String mid, int mSw);

	public void setWmInputOk(WebMessageVO vo);

	public void wmDeleteCheck(int idx, int mFlag);

	public void setWmDeleteAll(String mid);

	
}
