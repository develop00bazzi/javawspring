package com.spring.javawspring.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;

public class BoardDAOTest {

	@Test
	public void testGetBoardList() {
		BoardDAO dao=new BoardDAO() {
			
			@Override
			public void setUnClickLike(int idx) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setReadNumPlus(int idx) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setLevelOrderPlusUpdate(BoardReplyVO replyVO) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setDbLikeDelete(int partIdx, String mid, String part) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setDbLike(int partIdx, String mid, String part) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setClickLike(int idx) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setBoardUpdateOk(BoardVO vo) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setBoardReplyUpdate(BoardReplyVO vo) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setBoardReplyInput2(BoardReplyVO replyVO) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public int setBoardReplyInput(BoardReplyVO replyVO) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public int setBoardReplyDeleteOk(int idx) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public int setBoardInput(BoardVO vo) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public void setBoardGoodInfor(int partIdx, String part, String mid) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setBoardDeleteOk(int idx) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public int getSearchTotRecCnt(String search, String searchString) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public ArrayList<BoardVO> getPrevNext(int idx) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public ArrayList<BoardVO> getNewBoardList() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public String getMaxLevelOrder(int boardIdx) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public List<BoardReplyVO> getBoardReply(int idx) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public GoodVO getBoardGoodCheck(int partIdx, String part, String mid) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public BoardVO getBoardContent(int idx) {
				// TODO Auto-generated method stub
				return null;
			}
		};
		
		List<BoardVO> vos=dao.getBoardList(0, 10, null, null);
		
		System.out.println("vos: "+vos);
		
		
	}

}
