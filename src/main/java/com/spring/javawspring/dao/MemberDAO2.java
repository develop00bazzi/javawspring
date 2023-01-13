package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.MemberVO;

public interface MemberDAO2 {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickNameCheck(@Param("nickName")String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemTotalUpdate(@Param("mid") String mid,@Param("nowTodayPoint") int nowTodayPoint,@Param("todayCnt") int todayCnt);

	public int getMemberTotRecCnt();

	public ArrayList<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getMemberSearchTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<MemberVO> getMemberSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<MemberVO> getMemberMidSearch(@Param("email") String email);

	public void setMemberDeleteOk(@Param("mid") String mid);
	
}
