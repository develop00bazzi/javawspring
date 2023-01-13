package com.spring.javawspring.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.spring.javawspring.common.JavawspringProvide;
import com.spring.javawspring.dao.MemberDAO;
import com.spring.javawspring.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickNameCheck(String nickName) {
		return memberDAO.getMemberNickNameCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MultipartFile fName, MemberVO vo) {
		
//		업로드된 사진을 서버 파일 시스템에 저장 처리.
		
		int res=0;
		
		try {
			String oFileName=fName.getOriginalFilename();
			
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpg");
			}
			else {
				UUID uid=UUID.randomUUID();
				
				String saveFileName=uid+"_"+oFileName;
				
				JavawspringProvide ps =new JavawspringProvide();
				
				ps.writeFile(fName, saveFileName, "member");
				vo.setPhoto(saveFileName);
			}
			memberDAO.setMemberJoinOk(vo);
			res=1;
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;		
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		
//		오늘 날짜 편집
		
		Date now=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String strNow=sdf.format(now);
		
//		오늘 처음 방문한 경우라면 오늘 방문카운트(todayCnt)를 0으로 초기화한다.
		
		if(!vo.getLastDate().substring(0,10).equals(strNow)) {
//			memberDAO.setTodayCntUpdate(vo.getMid());
			vo.setTodayCnt(0);
		}
		
		int todayCnt=vo.getTodayCnt()+1;
		
		int nowTodayPoint=0; 
		
		if(vo.getTodayCnt()>5) {
			nowTodayPoint=vo.getPoint();
		}
		else {			
			nowTodayPoint=vo.getPoint()+10;
		}
		
//		오늘 재방문이라면 '총 방문수', '오늘 방문수', '포인트' 누적 처리
		
		memberDAO.setMemTotalUpdate(vo.getMid(),nowTodayPoint, todayCnt);
	}

	@Override
	public int getMemberTotRecCnt() {
		
		return memberDAO.getMemberTotRecCnt();
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize) {
		
		return memberDAO.getMemberList(startIndexNo, pageSize);
	}

	@Override
	public int getMemberSearchTotRecCnt(String search, String searchString) {
		
		return memberDAO.getMemberSearchTotRecCnt(search, searchString);
	}

	@Override
	public ArrayList<MemberVO> getMemberSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		
		return memberDAO.getMemberSearchList(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public ArrayList<MemberVO> getMemberMidSearch(String email) {
		
		return memberDAO.getMemberMidSearch(email);
	}

	@Override
	public void setMemberDeleteOk(String mid) {
		memberDAO.setMemberDeleteOk(mid);
	}

	@Override
	public int getMemberTotRecCnt2(String search, String searchString) {
		
		return memberDAO.getMemberTotRecCnt2(search, searchString);
	}

	@Override
	public ArrayList<MemberVO> getMemberList2(int startIndexNo, int pageSize, String search, String searchString) {
		// TODO Auto-generated method stub
		return memberDAO.getMemberList2(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	@Override
	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo, String oldFName, String mid) {
		int res=0;
		JavawspringProvide ps =new JavawspringProvide();
		
		try {
			String oFileName=fName.getOriginalFilename();
			
			if(!oFileName.equals("")) {
				if(!oFileName.equals(oldFName)&&!vo.getPhoto().equals("noimage.jpg")) {
					ps.deleteFile(oldFName, "member");
				}
				UUID uid=UUID.randomUUID();
				String saveFileName=uid+"_"+oFileName;
				ps.writeFile(fName, saveFileName, "member");
				vo.setPhoto(saveFileName);
			}
			
			memberDAO.setMemberUpdateOk(vo, mid);
			res=1;
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;		
	}
}
