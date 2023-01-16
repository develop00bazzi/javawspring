package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.MemberVO;

public interface MemberDAO {

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

	public int getMemberTotRecCnt2(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<MemberVO> getMemberList2(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setMemberUpdateOk(@Param("vo") MemberVO vo, @Param("mid") String mid);

	public MemberVO getmemberNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setMemberUserDelCheck(@Param("mid") String mid);
	
}
