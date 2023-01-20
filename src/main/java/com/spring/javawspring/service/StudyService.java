package com.spring.javawspring.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawspring.vo.GuestVO;
import com.spring.javawspring.vo.MemberVO;
import com.spring.javawspring.vo.TransactionVO;
import com.spring.javawspring.vo.KakaoAddressVO;

public interface StudyService {

	public String[] getCityStringArr(String dodo);

	public ArrayList<String> getCityArrayListArr(String dodo);

	public GuestVO getGuestMid(String mid);

	public ArrayList<GuestVO> getGuestNames(String mid);

	public ArrayList<GuestVO> getGuestSearch(String search, String searchString);

	public ArrayList<MemberVO> getEmailList();

	public int fileUpload(MultipartFile fName);

	public void getCalendar();

	public String qrCreate(String mid, String moveFlag, String realPath);

	public String qrCreateDB(String mid, String nickName, String bigo, String realPath);

	public String getQrCodeDB(String idx);

	public KakaoAddressVO getKakaoAddressName(String address);

	public void setKakaoAddressName(KakaoAddressVO vo);

	public ArrayList<KakaoAddressVO> getKakaoAddressNameList();

	public void kakaoEx2DeletePost(String address);

	public void setTransInput1(TransactionVO vo);

	public void setTransInput2(TransactionVO vo);

	public ArrayList<TransactionVO> getTransactionList();

	public void setTransInput(TransactionVO vo);

}
