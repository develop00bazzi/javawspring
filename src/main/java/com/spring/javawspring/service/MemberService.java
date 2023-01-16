package com.spring.javawspring.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickNameCheck(String nickName);

	public int setMemberJoinOk(MultipartFile fName, MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public int getMemberTotRecCnt();

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize);

	public int getMemberSearchTotRecCnt(String search, String searchString);

	public ArrayList<MemberVO> getMemberSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public ArrayList<MemberVO> getMemberMidSearch(String email);

	public void setMemberDeleteOk(String mid);

	public int getMemberTotRecCnt2(String search, String searchString);

	public ArrayList<MemberVO> getMemberList2(int startIndexNo, int pageSize, String search, String searchString);

	public void setMemberPwdUpdate(String mid, String pwd);

	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo, String oldFName, String mid);

	public MemberVO getmemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email);

	public void setMemberUserDelCheck(String mid);
}
