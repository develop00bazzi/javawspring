package com.spring.javawspring.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawspring.dao.GuestDAO;
import com.spring.javawspring.dao.MemberDAO;

@Service
public class PageProcess {
	
	@Autowired
	GuestDAO guestDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
//	내가 만든 방식
	
	public PageVO pageNation(int pag, int pageSize, int totRecCnt) {
		
		PageVO vo=new PageVO();
		
		int totPage=(totRecCnt%pageSize)==0? totRecCnt/pageSize: (totRecCnt/pageSize)+1;
		int startIndexNo=(pag-1)*pageSize;
		int curScrStartNo=totRecCnt-startIndexNo;
		
		int blockSize=3;
		int curBlock=(pag-1)/blockSize;
		int lastBlock=(totPage-1)/blockSize;
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		
		return vo;
	}

//	선생님 방식 처리
	
	public PageVO getTotRecCnt(int pag, int pageSize, String section, String part, String searchString) {
			
		PageVO pageVO=new PageVO();
		
		int totRecCnt=0;
		
		if(section.equals("member")) {
			totRecCnt=memberDAO.getMemberTotRecCnt();
		}
		else if(section.equals("guest")) {
			totRecCnt=guestDAO.getGuestTotRecCnt();
		}
		int totPage=(totRecCnt%pageSize)==0? totRecCnt/pageSize: (totRecCnt/pageSize)+1;
		int startIndexNo=(pag-1)*pageSize;
		int curScrStartNo=totRecCnt-startIndexNo;
		
		int blockSize=3;
		int curBlock=(pag-1)/blockSize;
		int lastBlock=(totPage-1)/blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		
		return pageVO;
	}

	
	
	
}
