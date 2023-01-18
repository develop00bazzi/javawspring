package com.spring.javawspring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.MemberVO;
import com.spring.javawspring.vo.KakaoAddressVO;

public interface StudyDAO {

	public GuestVO getGuestMid(@Param("name") String mid);

	public ArrayList<GuestVO> getGuestNames(@Param("name") String mid);

	public ArrayList<GuestVO> getGuestSearch(@Param("search")String search, @Param("searchString") String searchString);

	public ArrayList<MemberVO> getEmailList();

	public void setQrCodeDB(@Param("strUid") String strUid, @Param("qrCodeName") String qrCodeName, @Param("bigo") String bigo);

	public String getQrCodeDB(@Param("idx") String idx);

	public KakaoAddressVO getKakaoAddressName(@Param("address") String address);

	public void setKakaoAddressName(@Param("vo") KakaoAddressVO vo);

	public ArrayList<KakaoAddressVO> getKakaoAddressNameList();

	public void kakaoEx2DeletePost(@Param("address") String address);

}
