package com.spring.javawspring.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawspring.vo.PdsVO;

public interface PdsService {

	public int getSearchTotRecCnt(String part, String search, String searchString);

	public ArrayList<PdsVO> getPdsList(int startIndexNo, int pageSize, String part, String search, String searchString);

	public void setPdsInput(MultipartHttpServletRequest file, PdsVO vo);

	public void setPdsDownNum(int idx);

	public PdsVO getPdsContent(int idx);

	public void setPdsDelete(PdsVO vo);
	
}
